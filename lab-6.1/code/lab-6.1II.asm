INCLUDE Irvine32.inc
.data
A SDWORD 6
B SDWORD 7
N SDWORD 9
D SDWORD 0
.code
main PROC
    mov eax, A
    mov ebx, B
    mov ecx, N
    mov edx, D ; D

    ; while N > 0
    ;  if N != 3 AND (N < A OR N > B)
    ;   N = N - 2
    ;  else
    ;   N = N - 1
    ;  D = D + N
    ; end while


startwhile:
    ;while N > 0
    cmp ecx, 0
    jle endwhile

    ;if N != 3
    cmp ecx, 3
    je elseIfBlock

    ; AND
    ; (N < A)
    cmp ecx, eax
    jl beginningIfBlock


    ; OR
    ; (N > B)
    cmp ecx, ebx
    ja beginningIfBlock
    cmp ecx, ebx
    jbe elseIfBlock

beginningIfBlock:
    ;N = N - 2
    sub ecx, 2
    mov N, ecx
    jmp endIfBlock

;else
elseIfBlock:
    ;N = N - 1
    dec ecx
    mov N, ecx
    jmp endIfBlock


endIfBlock:
    ;D = D + N
    add D, ecx
    mov edx, D
    jmp startwhile
    ; mov 0, edx

;end while
endwhile:
    invoke ExitProcess, 0

main ENDP
end main
