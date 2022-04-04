; Library Test #1: Integer I/O   (TestLib1.asm)

; Tests the Clrscr, Crlf, DumpMem, ReadInt,
; SetTextColor, WaitMsg, WriteBin, WriteHex,
; and WriteString procedures.

INCLUDE Irvine32.inc
.data
x BYTE "X",0

.code
main PROC
; Set text color to yellow text on blue background:
    mov     eax,yellow + (blue * 16)
    call    SetTextColor
    call    Clrscr            ; clear the screen

    mov     DL, 15
    mov     DH, 60
    call    GoToXY

    mov     EDX, OFFSET x
    call    WriteString

    mov     DL, 29
    mov     DH, 0
    call    GoToXY

    call    WaitMsg

; Return console window to default colors.
    mov     eax,lightGray + (black * 16)
    call    SetTextColor
    call    Clrscr
    exit
main ENDP
END main
