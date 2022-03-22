## Lab 8.2 modules
CSE3120 | **Grant Butler**, **Tyler Zars**
- - -
Submit all your answers in a .docx file, as well as in separate files.

1. Take the model Project.sln Download [Project.sln](https://fit.instructure.com/courses/596910/files/44703771/download?wrap=1) (original when the site worked it was: [Project.sln](http://asmirvine.com/gettingStartedVS2017/Project32_VS2017.zip)) proposed by the Irvine book, and replace its current code with the code in the file Irvine\ch08\32bit\AddTwo.asm,  (Section 8.2.3) after deleting the unused procedures (Example_x, AddTwo_x):

```
; Demonstrate the AddTwo Procedure     (AddTwo.asm)
; Demonstrates different procedure call protocols.
INCLUDE Irvine32.inc

.data
word1 WORD 1234h
word2 WORD 4111h

.code
main PROC

    ;call    Example1
    ;call    Example2

    movzx    eax,word1
    push    eax
    movzx    eax,word2
    push    eax
    call    AddTwo
    call    DumpRegs

    exit

main ENDP

AddTwo PROC
; Adds two integers, returns sum in EAX.
; The RET instruction cleans up the stack.

    push ebp
    mov  ebp,esp
    mov  eax,[ebp + 12]       ; first parameter
    add  eax,[ebp + 8]        ; second parameter
    pop  ebp
    ret  8                ; clean up the stack
AddTwo ENDP

END main
```
Modify it by removing INCLUDE Irvine32.inc, and instead replacing it with your own .inc:
```
INCLUDE AddTwo.inc
```

Create AddTwo.inc adding an empty file to the project, and placing in it the usual 32 bit header:

```
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
```

The AddTwo.inc file should further set the option proc:private (see Section 8.5.1), adding appropriate comments

```
OPTION PROC:PRIVATE
```

and should define your procedure (can use PROTO from Section 8.4.4, or EXTERN from Section 8.5.2)

```
AddTwo PROTO
```

The file should also define a variable to hold the result, using EXTERNDEF (Section 8.5.3)

```
EXTERNDEF sum:DWORD
```

Modify your main program commenting out the code referring to Irvine.inc (DumpRegs and exit), replacing exit with a call to ExitProcess using INVOKE.

Modify the AddTwo procedure to save the result in variable "sum" before returning, and define the variable "sum" in the .data segment.

Since now the default for procedures is PRIVATE, you should declare the main procedure as public (Section 8.4.3):

```
main PROC PUBLIC
```

Your new version should compile... Test it and submit it, with a snapshot  of debugging it!

2. Now break your code into two .asm modules (by adding to the project two new file: main.asm for the main procedure and AddTwoProc.asm for the AddTwo procedure), each of them including in header your AddTwo.inc file.

```
INCLUDE AddTwo.inc
```

Each .asm file should specify the code in its own .code section.

The AddTwoProc.asm should end the code with "END".

The main.asm file should end with "END main" and should declare the main procedure as public (Section 8.4.3):

```
main PROC PUBLIC
```

Compile and submit the three files and a snapshot of a debugging session in the called procedure (in one .docx file).
