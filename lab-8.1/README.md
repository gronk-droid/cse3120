Upload a .docx file with the results for the following tasks, and also upload created source files and snapshots.

1. Load the MakeArray.asm program from the Irvine\ch08\32bit\ folder (also see book Section 8.2.7).

```
; (MakeArray.asm)

; This program creates an array on the local variables 
; area of the stack.

INCLUDE Irvine32.inc

.data
count = 100
array WORD count DUP(?)

.code
main PROC

    call    makeArray
    mov    eax,0

    exit

main ENDP


makeArray PROC
    push    ebp
    mov    ebp,esp
    sub    esp,32                ; myString is at EBP-32

    lea    esi,[ebp-32]        ; load address of myString
    mov    ecx,30                ; loop counter
L1:    mov    BYTE PTR [esi],'*'    ; fill one position
    inc    esi                    ; move to next
    loop    L1                ; continue until ECX = 0

    add    esp,32                ; remove the array (restore ESP)
    pop    ebp
    ret
makeArray ENDP

END main
 ```
Trace it and display the values of "esi" and "ebp" after the "lea" instruction, in a snapshot.

 

2. In the above program, replace the
```
"lea esi, [ebp-32]" 
```
instruction with a
```
"mov esi, ebp" 
```
and an
```
"add esi,-32" or "sub esi,32". 
```
Trace to test that you get the correct values in esi and ebp, after these instructions, to compare them with the first case. Report uploading a snapshot and modified source.

 

3. Load the LocalVars.asm from the Irvine\ch08\32bit\ folder and change the MySub procedure to use the LOCAL directive (Section 8.2.9). 
```
; Demonstrate local variables   (LocalVars.asm)
; This program demonstrates the use of local variables.
INCLUDE Irvine32.inc
.data
.code
main PROC

    call    MySub
    
    exit

main ENDP


X_local EQU DWORD PTR [ebp-4]
Y_local EQU DWORD PTR [ebp-8]

MySub PROC
    push    ebp
    mov    ebp,esp
    sub    esp,8        ; create variables
    mov    X_local,20    ; X
    mov    Y_local,10    ; Y
    mov    esp,ebp        ; remove locals from stack
    pop    ebp
    ret
MySub ENDP


END main

; ALTERNATE VERSION:

MySub PROC
    push    ebp
    mov    ebp,esp
    sub    esp,8                ; create variables
    mov    DWORD PTR [ebp-4],20    ; X
    mov    DWORD PTR [ebp-8],10    ; Y
    mov    esp,ebp                ; remove locals from stack
    pop    ebp
    ret
MySub ENDP
```
- Declare a single LOCAL directive introducing both X_local and Y_local in a single line

- You will need to comment the EQU declarations of X_local and Y_local as they conflict with the LOCAL directive.

- Also comment out the prefix and suffix instructions reserving and cleaning the frame manually (push epb....   and ... pop ebp), since LOCAL already does that

Trace the result and take a snapshot of the Disassemble window for the procedure. Mention any differences between the original implementation and the disassembled version. Upload  the source file, too.

 

4. Modify LocalVars.asm to use enter and leave instructions from Section 8.2.8, rather than either LOCAL or the manual frame management.

Trace the result comparing the MySub procedure in the disassemble window. Upload snapshot of the window, source, and mention differences.