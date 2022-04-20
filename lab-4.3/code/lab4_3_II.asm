.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data

source WORD "T","h","i","s"," ","i","s"," ","i","t",0
target DWORD LENGTHOF source DUP(?)
count EQU LENGTHOF source
.code
main PROC
 mov eax, 0
 mov esi, 0
 mov ecx, LENGTHOF source
L1:
 mov ax, source[esi * TYPE source]
 mov target[esi * TYPE target], eax
 inc esi
 loop L1


 invoke ExitProcess, 0
main ENDP
END main