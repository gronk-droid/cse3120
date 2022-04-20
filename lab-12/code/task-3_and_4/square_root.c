/* File: square_proc.c */
#include <stdlib.h>
#include <stdio.h>
#ifdef __cplusplus
extern "C"
#endif
int square_root_proc(int);
int square_root_proc_mangled(int x){}
int main(int argc, char**argv) {
    if (argc <= 1) {printf("Parameter absent\n"); return 0;}
    int in = atoi(argv[1]);
    int a = square_root_proc(in*in);
    if (in != a) printf("Wrong val=%d rather than %d\n", a, in);
    else printf ("Flag: flag{RootOfAllFlags}\n");
    return a;
}
