.model flat

mLocate MACRO xval, yval
    IF xval LT 0
        EXITM
    ENDIF
    ;... ; reverse keywords' characters in the next three lines to get it right ;) and comment dots
    IF yval LT 0
        EXITM
    ENDIF
    ;.... ; up to here symbols are reversed ;)
    mov bx, 0    ; video page 0
    mov ah, 2    ; locate cursor
    mov dh, yval
    mov dl, xval

    IF IsDefined (RealMode)
        int 10h      ; call BIOS
    ENDIF
ENDM

.data
row BYTE 15
col BYTE 60
.code
main proc
    mLocate -2,20
    mLocate 10,20
    ; mLocate col,row

    mov eax, 0
    exit
main endp
end main
