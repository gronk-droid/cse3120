; Demonstrate local variables   (LocalVars.asm)
; This program demonstrates the use of local variables.
INCLUDE Irvine32.inc
.data
.code
main PROC

    call    MySub
    
    exit

main ENDP


;X_local EQU DWORD PTR [ebp-4]
;Y_local EQU DWORD PTR [ebp-8]

MySub PROC
    LOCAL X_local:DWORD, Y_local:DWORD ; For Lab Part 1
    
    ; Remove
    ;push    ebp
    ;mov    ebp,esp
    ;sub    esp,8        ; create variables
    
    ; Original
    mov    X_local,20    ; X
    mov    Y_local,10    ; Y
   
    ; Remove
    ;mov    esp,ebp        ; remove locals from stack
    ;pop    ebp
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