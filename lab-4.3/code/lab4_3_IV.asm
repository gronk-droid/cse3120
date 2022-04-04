.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data

source WORD "T","h","i","s"," ","i","s"," ","i","t",0
target WORD LENGTHOF source DUP(0)
;count EQU LENGTHOF source
count DWORD 0
.code
main PROC
 mov esi, 0
 mov ecx, LENGTHOF source
 mov ax, 0

L1: 
 mov count,ecx
 mov ecx,TYPE source
 jmp L2

L11:
 mov ecx,count
 loop L1
 jmp exit

L2:
 mov al, BYTE PTR source[esi]
 mov BYTE PTR target[esi], al
 inc esi
 loop L2
 jmp L11

exit:
 invoke ExitProcess, 0
main ENDP
END main