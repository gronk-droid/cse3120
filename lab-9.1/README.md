Submit as a .docx, besides sources.

 

1. Log in on code01.fit.edu using ssh (putty) and use a text editor such as nano to

type a file "main.c" that inlines the assembly code for searching the character 'T' in an input string, as follows:
```
#include <stdio.h>
#include <stdint.h>
int main() {
 char* str = "String Tested";
 char* pos;
 asm("cld \n\t" 
     "movq %1, %%rdi \n\t" 
     "movq $14, %%rcx \n\t"
     "movb $'T, %%al \n\t"  // $84
     "repne scasb \n\t"
     "decq %%rdi \n\t"
     "movq %%rdi, %0"
     : "=rm" (pos) 
     : "g" (str)
     : "rcx", "rdi", "rax", "cc" );
 printf("str: %p  pos: %p %c \n", str, pos, *pos);
}
```
Compile the program using:
```
gcc main.c
```
Execute it with
```
./a.out
```
and submit the output

2. Compile the program at step 1 using:
```
gcc -S main.c
```
And display it with
```
cat main.s
```
Identify the code generated for the inline assembly part. 

Submit the output.

 

Now note that by using more exact constraints the code may be simplified:
```
#include <stdio.h>
#include <stdint.h>
#include <string.h>
int main() {
char* str = "String Tested";
char* pos;
long int tail;
asm("cld \n\t"
     "movb $'T, %%al \n\t"
     "repne scasb \n\t"
     "decq %%rdi \n\t"
     "movq %%rdi, %0 \n\t"
     "movq %%rcx, %1 \n\t"
     : "=m" (pos), "=rm" (tail)
     : "D" (str),  "c" (strlen(str))
     : "rax", "cc" );
 printf("str: %p  pos: %p %c tail=%lld\n", str, pos, *pos, tail);
}
```
Run again:
```
gcc main.c
./a.out
gcc -S main.c
cat main.s
```
Note how we tighten the restriction on the output variable "pos", which is no longer allowed to be any general register, to avoid it being allocated to rcx and clobber the next operation. 

Identify the parameters to printf, knowing that the Linux C convention is: RDI, RSI, RDX, RCX, R8, R9, [XYZ]MM0-7 (unlike Windows where it is RCX, RDX, R8, R9).

 

3. Replace the inline assembly code in "main.c" at task 1 with the following code that prints the significant bits of the timestamp counter of the processor:
```
#include <stdint.h>
...
uint64_t msr = 0;
asm volatile ( "rdtsc\n\t"    // Returns the time in EDX:EAX.
        "movq %%rdx, %0"   
        : "=r" (msr)
        :
        : "rdx", "rax");
printf("msr: %llx\n", msr);
```
Compile and execute the obtained program, submitting the output.

4. Use inline assembly to compute
```
c=b+4a+10
```
using the LEA instruction
```
lea 10(%rax, %rdx, 4), %rax
```
where b=1000 and a=2000 are initialized in the C source. The C code should show the result to the screen.

I suggest using the next assembly string (to be completed with inputs and output constraints "=r"(c) for output and "r"(b), "r"(a) for inputs):
```
#include <stdio.h>
#include <stdint.h>

int main() {
 uint64_t c = 0, b = 1000, a = 2000;
 asm("lea 10(%1, %2, 4), %0\n"
    : ... //output constraints
    : ... // input constraints 
 );
 printf ("c=%lld\n", c);
}
```
Read the documentation at:

https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Extended-Asm (Links to an external site.) https://gcc.gnu.org/onlinedocs/gcc/Constraints.html#Constraints (Links to an external site.)

 

Note main constraints: 

r  register ("a" for "a" register, ..., "S" for SI, "D" for DI)

m memory

i immediate

g general_reg.memory.immediate

= output only (only at beginning)

+ read/write output (only at beginning)

, separate ordered multi-options

cc for clobbering flags ("memory" for clobbering memory)


Upload the C source, assembly output, and the execution output.

 

 