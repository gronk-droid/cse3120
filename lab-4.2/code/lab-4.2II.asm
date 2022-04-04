.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data

source WORD "T","h","i","s"," ","i","s"," ","i","t",0
target WORD LENGTHOF source DUP(?)
.code
main PROC
 mov edi, OFFSET target
 mov esi, OFFSET source
 mov ecx, LENGTHOF source
L1:
 mov eax, 0
 mov ax, [esi]
 mov [edi], eax
 add esi, TYPE source
 add edi, TYPE target
 loop L1


 invoke ExitProcess, 0
main ENDP
END main
