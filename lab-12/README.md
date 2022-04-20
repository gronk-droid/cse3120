# Lab 12 FPU

Submit your work in a single .docx file, besides separate files for requested sources and snapshots.

##### 1. Access [www.intel.com](http://www.intel.com/) and search for "Intel 64 and IA-32 Architectures Developer's Manual Vol 1 and 2":
or [64-ia-32-architectures manual](64-ia-32-architectures-software-developer-vol-1-manual-1.pdf).
Website: [pdf](https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-1-manual.pdf) or [html](https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-vol-1-manual.html)
Now read, copy, and paste in your submission the **table of contents** for Section 8 (related to FPU), and the **content** of Sections 4.8.4, 8.1.3, and  8.1.5. x87 FPU Control Word (just the section introductions, not their subsections). Read carefully the table in Section 4.8.4.

##### 2. Read section 8.1.4, namely:
```
8.1.4 Branching and Conditional Moves on Condition Codes
The x87 FPU (beginning with the P6 family processors) supports two mechanisms for branching and performing conditional moves according to comparisons of two floating-point values.
These mechanism are referred to here as the “old mechanism” and the “new mechanism.”
The old mechanism is available in x87 FPU’s prior to the P6 family processors and in P6 family processors.
This mechanism uses the floating-point compare instructions (FCOM, FCOMP, FCOMPP, FTST, FUCOMPP, FICOM, and FICOMP) to compare two floating-point values and set the condition code flags (C0 through C3) according to the results.
The contents of the condition code flags are then copied into the status flags of the EFLAGS register using a two step process (see Figure 8-5):
1. The FSTSW AX instruction moves the x87 FPU status word into the AX register.
2. The SAHF instruction copies the upper 8 bits of the AX register, which includes the condition code flags, into the lower 8 bits of the EFLAGS register. When the condition code flags have been loaded into the EFLAGS register, conditional jumps or conditional moves can be performed based on the new settings of the status flags in the EFLAGS register.
The new mechanism is available beginning with the P6 family processors.
Using this mechanism, the new floating
point compare and set EFLAGS instructions (FCOMI, FCOMIP, FUCOMI, and FUCOMIP) compare two floating-point values and set the ZF, PF, and CF flags in the EFLAGS register directly.
A single instruction thus replaces the three instructions required by the old mechanism.
Note also that the FCMOVcc instructions (also new in the P6 family processors) allow conditional moves of floating point values (values in the x87 FPU data registers) based on the setting of the status flags (ZF, PF, and CF) in the EFLAGS register.
These instructions eliminate the need for an IF statement to perform conditional moves of floating-point values.
```
and write a full program comparing two floating point constants 1 and 2 (declared as DWORD and REAL4 respectively), using the "old mechanism"
```as
INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
_one DWORD 1
_two REAL4 2.0

.code
main PROC  ;... add proc definition
FINIT
FILD _one ; _one should be defined as dword 1
...; also define and load real4 _two with fld

FCOM  ; compares _two, _one...... cf FCOMI
FNSTSW AX ; no wait for exceptions
mShow AX, B
SAHF
JNBE label_success
JMP label_failure
label_success: ; print a happy message using the "mWrite" macro
 mWrite <10,13, "two <= one", 10,13>
 exit
label_failure:
...; print a less happy message with mWrite, like "two <= one"
exit
main ENDP; close proc and program
END main
```
Submit sources and a snapshot while debugging at a breakpoint immediately after JNBE.

##### 3. In your code for code01.fit.edu computing a square root in assembly (called from C),
```c
/* File: square_proc.c */
#include <stdlib.h>
#include <stdio.h>
#ifdef __cplusplus
extern "C"
#endif
int square_root_proc(int);
int square_root_proc_mangled(int x){return 0;}
int main(int argc, char**argv) {
 if (argc <= 1) {printf("Parameter absent\n"); return 0;}
 int in = atoi(argv[1]);
 int a = square_root_proc(in*in);
 if (in != a) printf("Wrong val=%d rather than %d\n", a, in);
 else printf ("Flag: flag{RootOfAllFlags}\n");
 return a;
}
```

namely in file square_root_proc.S:
```
#; File: square_root_proc.c
.code32
.text
.globl __main
.type  __main, @function
.globl square_root_proc
.type  square_root_proc, @function
square_root_proc:
 pushl %EBX
 pushl %ECX
 pushl %EDX
 xorl %ECX, %ECX
 # ; move EAX into yet another register <reg_value>
 movl %EAX, %EBX
 # ; move the register <reg_i> into EAX
cycle:
 movl %ECX, %EAX
 #; multiply EAX with the register storing <reg_i>
 mull %ECX
 #; if the result is equal with <reg_value> jump out of the loop
 jc next
 cmp %EAX, %EBX
 je out_loop
next:
 #; increment <reg_i> and jump to the EAX preparation with <reg_i>
 incl %ECX
 jmp cycle
 #; restore original values of registers <reg_i> <reg_value> EAX
out_loop:
# to print EAX at this point:
# mov %EAX, %EBX
# mov $1, %EAX
# int $0x80
 movl %ECX, %EAX
 popl %EDX
 popl %ECX
 popl %EBX
 #; return in EAX the result (the value of <reg_i>)
   ret
__main:
 mov $4, %eax
 call square_root_proc
 mov %eax, %ebx # exit code
 mov $1, %eax # exit syscall
 int $0x80
```
replace the algorithm you used with a computation based on the FPU. In header add:
```
.comm ctrlWord , 4
```

And replace your old procedure with:

```
.text
square_root_proc:
FINIT
pushl %eax
FILD (%esp)
FSTCW ctrlWord
orw $0b110000000000, ctrlWord   /* set RC = truncate */
FLDCW ctrlWord
FSQRT
FISTP (%esp) /* could have used FISTTP for storing with truncation */
popl %eax

# ... here append the code for restoring control register from ctrlWord

ret
```

For the code above, append the code at 12.2.10 (page 538) in edition 7, to set the control mode back to default (replacing the commented line), namely MASM code that has to be converted to AT&T syntax, and line comments in AT&T start with  "#" instead of ";":

```
andw    $0b110000000000, ctrlWord   # set rounding to default, Intel version, needs conversion to AT&T
fldcw  ctrlWord                     # load control word
```

Test the program and upload the source. Make sure to compile with the switches you learned earlier (gcc -m32 , etc.)

gcc -m32 -o sqf square_root.c square_root_proc.S

What is the number of bytes used by the new procedure? (Hint: use "gcc -m32 -c square_root_proc.S; objdump -d square_root_proc.o; objdump -s square_root_proc.o" as in 'CTF1 continuation')

Upload code, and snapshot with number of bytes given by "objdump -s square_root_proc.o", both separately and in .docs

##### 4. Use gdb on code01.fit.edu to trace your code.

compile the code with:
```
gcc -m32 -o sqf square_root.c square_root_proc.S
```
start debugging with:
```
gdb sqf

(gdb) info file
```
Symbols from "sqf".

Entry point: 0x8048370
```
(gdb) break *0x8048370
(gdb) break main
(gdb) break square_root_proc
(gdb) run 10
(gdb) disp /2i $pc
(gdb) si
```
go to main
```
(gdb) continue
```
go to square_root_proc
```
(gdb) c
(gdb) info reg
(gdb) info frame
(gdb) info breakpoint
(gdb) info registers float
(gdb) info all-registers

(gdb) layout reg
```
now check the content of eax (should have the square of 10)
```
(gdb) layout next
```
should show disas
```
(gdb) disp /2i $pc
(gdb) si
(gdb) undisplay 2
```
repeat the above by pressing RETURN until the "orw" instruction is highlighted
```
(gdb) p /t ctrlWord
possible display modes are: d decimal, x hex, t binary, f float, i instruction, c char

(gdb) p /t *0x804a024
```
The address should be the destination parameter of the 'orw' instruction
```
(gdb) x /t  0x804a024
```
take a snapshot and upload it
