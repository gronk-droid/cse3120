.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
.data
Rval SDWORD ?
Xval SDWORD 26
Yval SDWORD 30
Zval SDWORD 40
.code
main PROC
; INC and DEC
mov eax, 100000h
inc eax
dec eax

;...
; Expression: Rval = -Yval + (-Zval - Xval)
mov eax, Yval
neg Yval

mov ebx, Zval
neg Zval

sub ebx, Xval

add eax, ebx

mov Rval, eax
;...
; Zero flag example:
;...  ; ZF=1 ; by reaching 0
;...  ; ZF=1 ; by overflowing
mov eax, 1
sub eax, 1 ;puts eax to 0

mov al, 128
add al, 128 ; overflows to arrive at 0

; Sign flag example:
;...  ; SF=1 ; by reaching negative value
;...  ; SF=1 ; by overflowing to negative value
mov eax, 0
sub eax, 2; hit -2 by subracting from 0

mov al, 127
add al, 25 ; overflows to arrive at 0

; Carry flag example:
;...  ; CF=1
mov eax, 1111
add eax, 1 ; move to a new flag
; Overflow flag example:
mov ax, 127
add ax, 25

;...  ;OF=1 by rolling over maximum value
mov ax, 7fffh
add ax, 1
;...  ;OF=1 by rolling under minimum value
mov ax, 8000h
sub ax, 1


mov ax,7FF0h
add al,10h  ; a. CF=1  SF=0  ZF=1  OF=0
add ah,2    ; a. CF=0  SF=1  ZF=0  OF=1
add ax,3    ; a. CF=0  SF=1  ZF=0  OF=0


INVOKE ExitProcess,0
main ENDP
END main
