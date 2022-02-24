INCLUDE Irvine32.inc
.code
square_root_proc proc ; the value to square root is assumed received in EAX
    ; init some register <reg_i> with 0 (xor with itself), to represent variable i
    ;     note that <reg_i> should not be EAX, or EDX as those are used in multiplication
    ; move EAX into yet another register <reg_value>
    push ebx
    push ecx
    push edx
    xor ecx, ecx ; our i val for loop (set to 0)
    mov ebx, eax


sqloop:
    ; move the register <reg_i> into EAX
    mov eax, ecx
    ; multiply EAX with the register storing <reg_i>
    mul eax
    cmp eax, ebx
    je quit
    inc ecx
    jmp sqloop
    ; if the result is equal with <reg_value> jump out of the loop
    ; increment <reg_i> and jump to the EAX preparation with <reg_i>
    ; restore original values of registers <reg_i> <reg_value> EDX
    ; but first store for return in EAX the result (the value of <reg_i>)
    ; return

quit:
    mov eax, ecx
    pop edx
    pop ecx
    pop ebx
    ret
square_root_proc endp

main proc
 mov eax, 4
 call square_root_proc
  exit
main endp
end main
