; Demonstrate the AddTwo Procedure (AddTwo.asm)
; Demonstrates different procedure call protocols.
INCLUDE AddTwo.inc

.data
    word1 WORD 1234h
    word2 WORD 4111h
    sum DWORD ?

.code
main PROC PUBLIC

    ;call   Example1
    ;call   Example2

    movzx   eax,word1
    push    eax
    movzx   eax,word2
    push    eax
    call    AddTwo
    call    DumpRegs

    ; exit ; defined in irvine, but not in AddTwo.inc
    INVOKE ExitProcess, 0

main ENDP

END main
