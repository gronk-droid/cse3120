#include <stdio.h>
#include <stdint.h>

int main() {
 uint64_t c = 0, b = 1000, a = 2000;
 asm("lea 10(%1, %2, 4), %0\n"
    : "=r" (c) /* Result should go in var c */
    : "r" (b), "r" (a) /* input constraints */
 );
 printf ("c=%lld\n", c);
}
