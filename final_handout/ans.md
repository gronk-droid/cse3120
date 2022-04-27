THIS TEST IS NOT GRADED. IS JUST FOR YOUR PRACTICE!

Midterm II Exam Prep – CSE3120 Computer Architecture and Assembly Programming

Spring 2022 -- Instructor: Marius Silaghi (Florida Tech)

Name/ID:

1. (12.6.1..1) Given the binary floating-point value 1101.01101, how can it be expressed as a sum of decimal fractions?

>1101.01101 = 13/1 + 1/4 + 1/8 + 1/32

2. (12.6.1..3) Given the binary value 11011.01011, what is its normalized value?

>11011.01011 = 1.101101011 X 24

3. (12.6.1..5) What are the two types of NaNs?

>Quiet NaN and Signaling NaN

4. (12.6.1..6) What is the largest data type permitted by the FLD instruction, and how many bits does it contain?

>REAL10 80 bits

5. (12.6.1..7) How is the FSTP instruction different from FST?

>It pops ST(0) off the stack.

6. (12.6.1..10) How is the FISUB instruction different from FSUB?

>FISUB converts the source operand from integer to floating-point.

7. (12.6.1..13) Which field in the FPU control word lets you change the processor&#39;s rounding mode?

>`FILD`

8. (12.6.2..10) Write instructions that implement the following C code:
```c
int B = 7;
double N = 7.1;
double P = sqrt(N) + B;
```
code:
```c
.data

B DWORD 7

N REAL8 7.1

P REAL8 ?

.code
    fld N
    fsqrt
    fiadd B
    fst P
```

9. (13.6..1) When a procedure written in assembly language is called by a high-level language program, must the calling program and the procedure use the same memory model?

>The memory model determines whether near or far calls are made. A near call pushes only the 16-bit offset of the return address on the stack. A far call pushes a 32-bit segment/offset address on the stack.

10. (13.6..3) Does a language&#39;s calling convention include the preservation of certain registers by procedures?

>Yes, many languages specify that EBP (BP), ESI (SI), and EDI (DI) must be preserved across procedure calls.

11. (13.6..4) Can both the EVEN and ALIGN directives be used in inline assembly code? (Y/N)

>Yes

12. (13.6..6) Can variables be defined with both the DW and the DUP operator in inline assembly code? (Y/N)

>No

13. (13.6..8) Rather than using the OFFSET operator, is there another way to move a variable&#39;s offset into an index register?

>Use the LEA instruction.

14. (13.6..11) What is a valid assembly language PROTO declaration for the standard C printf() function

>`printf PROTO C, pString:PTR BYTE, args:VARARG.`

15. (13.6..13) What is the purpose of the &quot;C&quot; specifier in the extern declaration in procedures called from C++?

>To prevent the decoration (altering) of external procedure names by the C++ compiler. Name decoration (also called name mangling) is done by programming languages that permit function overloading, which permits multiple functions to have the same name.

16. (8.10.1..4) How is the LEA instruction more powerful than the OFFSET instruction?

>LEA can return the offset of an indirect operand; it is particularly useful for obtaining the offset of a stack parameter.

17. (9.9.1..1) Which Direction flag setting causes index registers to move backward through memory when executing string primitives?

>1 (set)

18. (9.9.1..2) When a repeat prefix is used with STOSW, what value is added to or subtracted from the index register?

>2 is added to the index register

19. (9.9.1..3) In what way is the CMPS instruction ambiguous?

>Regardless of which operands are used, CMPS still compares the contents of memory pointed to by ESI to the memory pointed to by EDI.

20. (9.9.1..4) When the Direction flag is clear and SCASB has found a matching character, where does EDI point?

>1 byte beyond the matching character.

21. (9.9.1..5) When scanning an array for the first occurrence of a particular character, which repeat prefix would be best?

>REPNE (REPNZ).

22. (10.7.1..2) Assume the following structure has been defined:
```as
RentalInvoice STRUCT
    invoiceNum BYTE 5 DUP (&#39; &#39;)
    dailyPrice WORD ?
    daysRented WORD ?
RENTALInvoice ENDS
```
State whether or not each of the following declarations is valid:
```c
1. rentals RentalInvoice \&lt;\&gt;
2. RentalInvoice rentals \&lt;\&gt;
3. march RentalInvoice \&lt;&#39;12345&#39;,10,0\&gt;
4. RentalInvoice \&lt;,10,0\&gt;
5. current RentalInvoice \&lt;,15,0,0\&gt;
```
 Answers
```
1. Yes
2. No
3. Yes
4. Yes
5. No
```
23. (10.7.12..2) Write a statement that retrieved the wHour field of a SYSTEMTIME structure.
```c
.data
    time SYSTEMTIME \&lt;\&gt;s
.code
    mov ax, time.wHour
```
24. (8.10.2..2) Create a procedure named AddThree that receives three integer parameters and calculates and returns their sum in the EAX register. Before returning, the sum should be computed and temporarily stored in a local variable on the stack! It earns 0 points if it is not compiling and working correctly.
```c
AddThree PROC
    ; modeled after the AddTwo procedure
    push ebp
    mov ebp,esp
    mov eax,[ebp + 16]
    add eax,[ebp + 12]
    add eax,[ebp + 8]
    pop ebp
    ret 12
AddThree ENDP
```
25. (9.10..3) Str\_remove Procedure

Write a procedure named Str\_remove that removes n characters from a null terminated string. Pass a pointer to the position in the string where the characters are to be removed. Pass an integer specifying the number of characters to remove. (use a rep prefix somewhere in the removing process. It earns 0 points if it is not compiling and working correctly). The following code, for example, shows how to remove &quot;xxxx&quot; from target:
```c
.data
    target BYTE &quot;abcxxxxdefghijklmop&quot;,0
.code
    INVOKE Str\_remove, ADDR [target+3], 4
```


26. (7.9.2..7) Write a sequence of instructions that shift three memory bytes to the right by 1 bit position., seeing the 3 bytes a one 3-byte big endian number… The shift should be &quot;logical shift&quot;, assuming the bytes are a big endian representation of a 3 bytes number. Use the following test data:
```c
byteArray BYTE 81h,20h,33h
.code
    shr byteArray+2,1
    re byteArray+1,1
    rer byteArray, 1
```
27. (7.9.2..2) Suppose the instruction set contained no rotate instructions. Show how you would use SHR and a conditional jump instruction to rotate the contents of the AL register 1 bit to the right.
```c
shr al, 1 ; shift AL into Carry flag
jnc next ; Carry flag set?
or al, 80h ; yes: set highest bit
next: ; no: do nothing
```
28. (7.9.2…3) Write a logical shift instruction that multiplies the contents of EAX by 16.
```c
shl eax, 4
```
29. (7.9.2..5) Write a single rotate instruction that exchanges the high and low halves of the DL register.
```c
ror d1, 4 ; (or: rol d1,4)
```
30. (7.9.2..6) Write a single SHLD instruction that shifts the highest bit of the AX register into the lowest bit position of DX and shifts DX one bit to the left.
```c
shld dx, ax, 1
```
31. (8.10.1..6) What advantages might the C calling convention have over the STDCALL calling convention?

>The C calling convention allows for variable-length parameter lists.

32. (7.9.2..12) Implement the following C expression in assembly language, using 32-bit signed operands:

```c
val1 = (val2 / val3) * (val1 + val2)
```

code:
```c
mov eax, val2
cdq ; extend EAX into EDX
idiv val3 ; EAX = quotient
mov ebx, val1
add ebx, val2
imul ebx
mov val1,eax ; lower 32 bits of product
```
