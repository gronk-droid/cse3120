#include <stdio.h>
#include <stdint.h>
int main() {
 char* str = "String Tested";
 char* pos;
 uint64_t msr = 0;
asm volatile ( "rdtsc\n\t"    // Returns the time in EDX:EAX.
        "movq %%rdx, %0"   
        : "=r" (msr)
        :
        : "rdx", "rax");
printf("msr: %llx\n", msr);
}
