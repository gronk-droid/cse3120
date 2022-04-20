Implement DAS with a procedure using other instructions. Write a main program that calls the myDAS procedure for the value "25" - "27" (packed BCD) (passed result in register al), and take the snapshot showing the result register after the return of myDAS. Submit the snapshot and the program. The myDAS' pseudocode is:
```
If (AL(lo) > 9) OR (AuxCarry = 1)

  AL = AL − 6;

  AuxCarry = 1;

Else

AuxCarry = 0;

Endif

If (AL > 9FH) or (Carry = 1)

  AL = AL − 60h;

  Carry = 1;

Else

  Carry = 0;

Endif
```

Sample framework with Linux gas (AT&T):
```
.code32
.global _start
_start:
mov $0x25, %al
sub $0x27, %al
call myDAS
mov %eax, %ebx
mov $1, %eax
int $0x80
myDAS:
# ... save/initialize registers
I1:  # test condition AL low nibble
T1:  # on then condition 1
E1:  # on else condition 1
I2:  # test condition high nibble
T2:  # on then condition 2
E2:  # on else condition 2
done:
# ... restore al, flags and used registers
 ret
```
compile with:
```
# as DAS.S --32 -o DAS.o ; ld DAS.o -m elf_i386 -o DAS; ./DAS; echo $? ; ./DAS; echo "obase=16;" $? | bc
```

The expected output here is: 98h, i.e. 152
# 152
 
Note: The result of the procedure should keep original flags except for CF and AF.

Hint:  Keep the original flags and AL in two registers or on stack, and modify them in that position, before setting them as actual flags and AL on return . The result is in AL. 

Hint: To extract the low nibble of AL into BL
```
movb %al, %bl
andb $0x0f, %bl
```
Hints: You can get the flags using wither "LAHF", or with
```
PUSHF
POP CX   (AT&T: popw %cx)
```
The carry flag is on bit position 0. The auxiliary flag is in bit position 4.
You set the auxiliary flag AF (assuming the flags are stored in CX) with
```
OR CL, 10h                      (AT&T: orb $0x10, %cl)
```
and you set the carry flag with
```
OR CL, 01h                    (AT&T: orb $01, %cl)
```
You reset the auxiliary flag AF (assuming the flags are stored in CX) with
```
AND CL, 0EFh             (AT&T: andb $0xef, %cl)
```
and you reset the carry flag with
```
AND CL, 0FEh              (AT&T: andb $0xfe, %cl)
```
You test the auxiliary flag AF (assuming the flags are stored in CX) with
```
TEST CL, 010h                (AT&T: testb $0x10, %cl)
JZ E1 
```
and you test the carry flag with
```
TEST CL, 01h                 (AT&T: testb $1, %cl)
JZ E2
```
You restore the flags including made changes with SAHF, or with:
```
push cx   (AT&T:  pushw %cx)
popf
```
