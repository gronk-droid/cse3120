# Lab 13 CTF 2 (and more GDB)

This lab was introduced in class Tuesday at the end of Lab12.

Submit answers in a single .doc file, but also attach all source files and snapshots separately.

1. When sending an attack vector in a buffer overflow, one cannot assume  that addresses of local variables in memory, like ctrlWord, may correspond to a valid address. Take your 32 bit implementation of the square_root_proc at Lab 12, and modify it by dropping the ".comm ctrlWord" and by using instead of it a 4 bytes area on the stack.

As such, start your assembly square_root_proc by:

- subtracting 4 bytes from %esp to allocate space for ctrlWord as a local variable.
- Store the address of this local variable in a register using lea, e.g, %eax.
- Subsequently replace all occurrences of ctrlWord with the corresponding address on the stack:
    - use only addresses relative to %esp, like 0x4(%esp), and %eax, like (%eax), since you do not know the content of other registers like %ebp on the target.
    - Before returning (and before any of the nops at the end of the procedure), do not forget to remove the local variable space from the stack by adding 4 to %esp.

Sample modifications to the lab 12 are:
```c
square_root_proc:
    ...
    subl $4, %esp
    FINIT
    pushl %eax
    FILDL (%esp)
    lea 0x4(%esp), %eax
    FSTCW (%eax)
    ...
    popl %eax
    add $4, %esp
.rept 10
    nop
.endr
  ...
```

```sh
gcc -m32 -o sqf square_root.c square_root_proc.S
```

Test that it compiles and works.

```
./sqf 15
```

Upload the source

2. Use gdb on code01.fit.edu to trace your code.

compile the code with:

```bash
gcc -m32 -o sqf square_root.c square_root_proc.S
```

start debugging with:

```bash
gdb sqf
(gdb) info file
```
Symbols from "sqf".

Entry point: 0x8048370

```bash
(gdb) break *0x8048370
(gdb) break main
(gdb) break square_root_proc
(gdb) run 10
(gdb) disp /2i $pc
(gdb) si
```
go to main
```bash
(gdb) continue
```
go to square_root_proc
```bash
(gdb) c
(gdb) info reg
(gdb) info frame
(gdb) info breakpoint
```
if you login from a terminal that supports well layouts with gdb
```bash
(gdb) layout reg
```
now check the content of eax (should have the square of 10)
```bash
(gdb) layout next
```
should show disas
```bash
(gdb) si
(gdb) c
```
Repeat the above by pressing RETURN until the "orw" instruction is highlighted
rather than viewing using a variable ctrlWord as in the previous lab:
```bash
(gdb) p /t ctrlWord
```

do use the register that stores the address of the local variable
```bash
(gdb) x /t $eax
or
(gdb) p /t *$eax
or
(gdb) p /x $eax
- - -
-> 0xffffd268 (or some other value depending on OS version, like 0xffffc8c8)
(gdb) p /t *0xffffd268
```

possible display modes are: d decimal, x hex, t binary, f float, i instruction, c char

take a snapshot and upload it, with the source

3. Use the steps at Lab CTF 1 (continuation) to generate a file sqrt.bin of length 48 bytes based on your implementation of the square root based on FPU created at step 1 (pad with nop as appropriate, or remove non-essential instructions if the code is too long).

Compile the file as 32-bit code with:
```bash
gcc -m32 square_root_proc.S -c
```
Inspect the file with the command:
```bash
objdump -d square_root_proc.o
```
Dump the binary code section in an editable file "sqrt.txt" using:
```bash
objdump -s square_root_proc.o > sqrt.txt
```
edit with `nano sqrt.txt` to keep only the hexadecimal contents of the .text section with addresses, deleting the ascii representation at the right and headers, using:
```bash
objdump -s square_root_proc.o | cut -c 1-43 | tail -n +5 > sqrt.txt
```
Remove the final ret instruction (hexadecimal "c3"). Also delete the code for the function main.

Add "nop" instructions (hexadecimal "90") as needed up to 48 total bytes.

Verify that you have obtained the right CTF code using:
```bash
xxd -r sqrt.txt | hexdump
```
Upload the result "sqrt.txt" in the submission. Convert such code into binary using:
```bash
xxd -r sqrt.txt  >sqrt.bin
```
inspect that your binary has the desired code, using:
```bash
objdump  -D -b binary -Mintel,x86-32 -mi386 sqrt.bin
```

Follow the procedure from lab CTF 1 to capture a flag from port 2345, but use the following sock command. If you no longer have it, use:
```bash
wget http://cs.fit.edu/~msilaghi/sock-1.5.tgz
tar xzf sock-1.5.tgz
popd sock-1.5
./configure
make clean
make
cp ./sock ~/
popd
```
then:
```bash
ncat class-msilaghi-f1.fit.edu 2346 < ./sqrt.bin
```
Submit the flag, sqrt.bin, and the hexdump sqrt.txt of the sqrt.bin file submitted.

Why the implementation at Lab12 FPU would have failed to capture the flag, while the one in step 1 can succeed?
