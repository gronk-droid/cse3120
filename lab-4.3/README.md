The whole submission should be in one .docx file, and .txt files separately for the source, and png/jpg for the snapshots

I, Finalize task II from Lab 4,2

II. Finalize task III from Lab 4,2 

III. Modify the code at task II in Lab 4.2 to use a nested LOOP, the inner LOOP copying one byte at a time the two bytes of a WORD (based on a saved variable count as on page 125 and slides), and upload the code and a snapshot at the same situation as in task II.

IV. Loop instructions can only jump over 127 bytes. This can be alleviated with JMP instructions. Use JMP instructions to move the code of the inner loop of TASK III, just before the exit instruction. Submit the source and snapshot of the screen just before exit. In your program use the structure:

```
L1:
...
jmp L2:
L11:
LOOP L1:

jmp exit

L2:
...
LOOP L2:
jmp L11

exit:
```

Try other re-arrangements where label "L1:" is immediately after "loop L1", and the whole body of the external loop is either ahead of after this sequence.

 
V. OPTIONAL Using the 64 bit project from http://asmirvine.com/gettingStartedVS2015/index.htm#tutorial64 (Links to an external site.) .

Test the anomaly on page 129 (MOV instruction for 64-bit programming Section 4.6.1), by taking and uploading a snapshot displaying content of register RAX after the third mov instruction in the following program, and the last "and". Submit a copy of the source where you fill in what was the hexadecimal value of RAX after each instruction?

```
ExitProcess proto
.data
myDword DWORD 80808080h
myDword2 DWORD 70000000h
.code
main proc
 mov rax,0FFFFFFFFFFFFFFFFh
 mov al,BYTE PTR myDword   ; rax =
 mov rax,0FFFFFFFFFFFFFFFFh
 mov ax,WORD PTR myDword  ; rax =
 mov eax,myDword          ; rax =
 mov rax,0FFFFFFFFFFFFFFFFh
 mov eax,myDword2         ; rax =
 movsxd rax, myDword      ; rax =
 mov rax,0FFFFFFFFFFFFFFFFh
 and rax,80h              ; rax =
 mov rax,0FFFFFFFFFFFFFFFFh
 and rax,8080h            ; rax =
 mov rax,0FFFFFFFFFFFFFFFFh
 and rax,70808080h        ; rax =
 mov rax,0FFFFFFFFFFFFFFFFh
 and rax,80808080h        ; rax =
 mov ecx,0
 call ExitProcess
main endp
end
```
