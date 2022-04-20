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
     "movq %%rdi, %0 \n\t" /* this code puts string directly into the registers */
     "movq %%rcx, %1 \n\t"
     : "=m" (pos), "=rm" (tail) /* how many chars are left */
     : "D" (str),  "c" (strlen(str)) /* ecx has length */
     : "rax", "cc" );
 printf("str: %p  pos: %p %c tail=%lld\n", str, pos, *pos, tail);
} 
