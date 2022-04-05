INCLUDE Irvine32.inc

.data
MyStruct STRUCT
    field1 WORD ?
    field2 DWORD ?
MyStruct ENDS

var MyStruct <>

.code

main PROC
    mov eax, SIZEOF MyStruct.field2
    mov ebx, SIZEOF var.field2

exit
main ENDP
END main
