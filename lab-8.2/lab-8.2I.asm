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

AddTwo@8 PROC
; Adds two integers, returns sum in EAX.
; The RET instruction cleans up the stack.

    push ebp
    mov  ebp,esp
    mov  eax,[ebp + 12]       ; first parameter
    add  eax,[ebp + 8]        ; second parameter
    pop  ebp
    ret  8                ; clean up the stack
AddTwo@8 ENDP

END main
