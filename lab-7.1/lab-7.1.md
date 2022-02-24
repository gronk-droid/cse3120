# LAB 7.1
CTF problem SQUARE-ROOT

Help us get root!  Give me x386 code that will take the square root of a number. You may assume that the given number will be a perfect square. No floating point math is required. Your code should expect input in eax and return its result in eax. Your code must be EXACTLY 32 bytes (pad it with NOPs if it is shorter). Please provide input as raw bytes on the port 2345 of a virtual machine on the udrive machine code01.fit.edu, using the "sock" program that you can download from the shared files Link.

Also make sure you have installed on your computer an SSL client such as "putty".

https://www.putty.org/



At the end of this lab you should upload the all deliverables in one .docx file (BUT YOU HAVE TO ALSO UPLOAD ALL SOURCE FILES SEPARATELY!!!).

1. With Notepad create a file hello.S with the content of the program in the slide titled "Sample Hello World (ubuntu) 32bit" found in the AT&T set of slides. Copy the file in a folder cse3120 on your Udrive (alternatively you can copy in Windows and paste in PUTTY ssh open "nano" editor with right mouse click, or use putty sftp, in case you do not mount your udrive).

ssh on code01.fit.edu using PUTTY ssh. Change directory to your cse3120 folder. Compile and run the file using the instructions in the slides. Submit a snapshot of its execution result, and the source file.


2. Write in Visual Studio MASM assembly a program L07_01_sqrt.asm with a square_root proc equivalent to the following C function implementing integer square_root (in assembly, parameter and result are placed in eax, and all other registers are left as received):
```
int square_root_proc(int a) {
 int i = 0;
 for(i=0; ; i++)
   if (i*i == a)
    return i;
}
```
The code in MASM assembly will be something like:
```
; File: L07_01_sqrt.asm
; Florida Tech, CSE3120
; Instructor: Marius Silaghi
INCLUDE Irvine32.inc
;...
square_root_proc proc ; the value to square root is assumed received in EAX
 ; init some register <reg_i> with 0 (xor with itself), to represent variable i
 ;     note that <reg_i> should not be EAX, or EDX as those are used in multiplication
 ; move EAX into yet another register <reg_value>
 ;
 ; move the register <reg_i> into EAX
 ; multiply EAX with the register storing <reg_i>
 ; if the result is equal with <reg_value> jump out of the loop
 ; increment <reg_i> and jump to the EAX preparation with <reg_i>
 ; restore original values of registers <reg_i> <reg_value> EDX
 ; but first store for return in EAX the result (the value of <reg_i>)
 ; return
square_root_proc endp
main proc
 mov eax, 4
 call square_root_proc
  exit
main endp
end main
```
Note: if you really want to use "loop" in your implementation (which is not needed), you need to prepare ecx accordingly!

Run the code and submit a snapshot of it being debugged and outputting the right value when getting out of the procedure. Insert the code in your submission.

3. Translate the above procedure in AT&T syntax assembly, placing the procedure in a file "L07_01_sqrt.S". Make sure your implementation does not use variables, but only registers.

To do this, replace the .... dots in the following template (WITHOUT MODIFYING ANYTHING ELSE!!!) such that the code at label "square_root_proc" should be getting the parameter in register %eax, and then returning its square root also in %eax. Note that instructions push, pop, xor, mov, cmp, mul, imul (as they work on 32 bits operands) become pushl, popl, xorl, movl, cmpl, mull, imull. Constants are prefixed with '$' and registers with '%'.

Also, the order of operands (source destination) changes in AT&T syntax when

compared to Intel syntax, and line comments start with #.
```
# File: L07_01_sqrt.S
# Florida Tech, CSE3120
# Instructor: Marius Silaghi
.code32
.text
.globl main
.type  main, @function
.globl square_root_proc
.type  square_root_proc, @function
square_root_proc:
 ....
   ret
main:
 mov $4, %eax
 call square_root_proc
 mov %eax, %ebx # exit code
 mov $1, %eax # exit syscall
int $0x80
```

Test that it compiles with 'as', and upload the snapshot of the compilation result. If you encounter compilation issues, most likely you forgot to place a symbol $ in front of a constant, a % to a register, or a size qualifier after an instruction.

```
as -o sqrt.o --32 L07_01_sqrt.S
ld -o sqrt -m elf_i386  -e main sqrt.o
./sqrt; echo $?
```

Should output 2. If it does not output the right result, (until we study to use a Linux-based the debugger next time) most likely you forgot to swap parameters source <-> destination at some instruction. One may also debug

- by printing intermediary values using the int80 system call seen at Task 1.

- by exiting at debugged points with the tested value in the ebx

Insert this code in your submission.
