ExitProcess proto
.data
myDword DWORD 80808080h
myDword2 DWORD 70000000h
.code
main proc
 mov rax,0FFFFFFFFFFFFFFFFh
 mov al,BYTE PTR myDword   ; rax = FFFFFFFFFFFFFF80
 mov rax,0FFFFFFFFFFFFFFFFh
 mov ax,WORD PTR myDword  ; rax = FFFFFFFFFFFF8080
 mov eax,myDword          ; rax = 0000000080808080
 mov rax,0FFFFFFFFFFFFFFFFh
 mov eax,myDword2         ; rax = 0000000070000000
 movsxd rax, myDword      ; rax = FFFFFFFF80808080
 mov rax,0FFFFFFFFFFFFFFFFh
 and rax,80h              ; rax = 0000000000000080
 mov rax,0FFFFFFFFFFFFFFFFh
 and rax,8080h            ; rax = 0000000000008080
 mov rax,0FFFFFFFFFFFFFFFFh
 and rax,80808080h        ; rax = FFFFFFFF80808080

 mov ecx,0
 call ExitProcess
main endp
end