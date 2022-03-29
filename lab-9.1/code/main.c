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
     "movq %%rdi, %0" /* move obtained position to parameter */
     : "=rm" (pos) /* string that descibes output parameters (store in var pos)(rm = register or memory) */
     : "g" (str) 
     : "rcx", "rdi", "rax", "cc" ); /* used registers by the code (value there before is no longer there) */
 printf("str: %p  pos: %p %c \n", str, pos, *pos);
}
