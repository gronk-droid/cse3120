
INCLUDE Irvine32.inc
.data
spaces80 BYTE 80 DUP(" "), 0
buffer BYTE 81 DUP(?)
flip_buffer BYTE 81 DUP(?)

.code
main PROC
    ; Clrscr
    mov eax, white + (black * 16)
    call SetTextColor
    call Clrscr

    ; Gotoxy <to top start of console window>
    mov dx, 0*16 + 0
    call GotoXY

    ; SetTextColor  <blue background, yellow foreground>
    mov eax, yellow + (blue * 16)
    call SetTextColor

    ; WriteString <write 80 space characters>
    mov edx, OFFSET spaces80
    call WriteString

    ; Gotoxy <to top start of console window>
    mov dx, 0*16 + 0
    call GotoXY

    ; ReadString <read max 80 characters in prepared buffer>
    mov ecx, SIZEOF buffer - 1
    mov edx, OFFSET buffer
    call ReadString

    ;  <implement with jumps a loop of tests or xor bit to flip upper and lower cases>
    ;   <beware not to translate spaces to 0 string terminators>
    mov esi, OFFSET buffer
    mov edi, OFFSET flip_buffer

L1:
    mov al, [esi]
    test al, al
    jz endloop

    mov bl, al
    or bl, 20h
    cmp bl, 'a'
    jb next
    cmp bl, 'z'
    ja next
    xor al, 20h

next:
    mov [edi], al
    inc esi
    inc edi
    jmp L1

endloop:
    mov [edi], al

    ; Gotoxy <bottom start>
    mov dh, 29
    mov dl, 0
    call GotoXY

    ; SetTextColor <yellow background, blue foreground>
    mov eax, blue + (yellow * 16)
    call SetTextColor

    ; WriteString <write 80 space characters>
    mov edx, OFFSET spaces80
    call WriteString

    ; Gotoxy <bottom start: 29,0>
    mov dh, 29
    mov dl, 0
    call GotoXY

    ; WriteString <flipped string>
    mov edx, OFFSET flip_buffer
    call WriteString

    exit
main ENDP
END main
