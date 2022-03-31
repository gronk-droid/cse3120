### Lab 10: Structures, C+ASM

- - -

The submission should be in a .doc file

1. On code01.fit.edu, create a file square_root.c with the following content:

```c
#include <stdlib.h>
#include <stdio.h>
#ifdef __cplusplus
extern "C"
#endif
int square_root_proc(int);
int square_root_proc_mangled(int){}

int main(int argc, char**argv) {
 if (argc <= 1) {printf("Parameter absent\n"); return 0;}
   int in = atoi(argv[1]);
   int a = square_root_proc(in*in);
   if (in != a) printf("Wrong val=%d rather than %d\n", a, in);
   else printf ("Flag: flag{RootOfAllFlags}\n");
   return a;
}
```

Compile this program together with your assembly implementation from the Lab CTF1 (renaming its source file to: square_root_proc.S). Note that you can retrieve it from your submission... and you may have to rename/comment out the main procedure defined there to avoid naming conflicts. 

The program can be compiled with "gcc". The use of:

```c
#ifdef __cplusplus
extern "C"
#endif
```

allows us to compile it with g++.

```sh
g++ -o sr -g -m32 square_root.c square_root_proc.S
```

</br>
Separate compilation is done as follows:

```sh
g++ -c -m32 square_root.c
as -32 square_root_proc.S -o square_root_proc.o
g++ -o sr -m32 square_root.o square_root_proc.o
```

In order to see the need and effect of extern "C" execute:

```sh
readelf -s --wide sr
# or nm sr
c++filt _Z24square_root_proc_mangledi
```
To check the program run:
```sh
./sr 21
```
Submit the files and the output.

2. Write a program in At&T assembly declaring a struct equivalent to

```masm
MyStruct STRUCT
 x WORD
 y WORD
MyStruct ENDS
```
and return as exit code the size of the structure.
