.code32
.globl _start
.struct 4
MyStruct:
MyStruct.x:
.space 2
MyStruct.y:
.space 2
MyStruct_size = . - MyStruct

.bss
my_obj:
    .space MyStruct_size

.text
_start:
    mov $my_obj, %edi
    movw $0, MyStruct.x(%edi)
    movw $0, MyStruct.y(%edi)
    mov $1, %eax
    mov $MyStruct_size, %ebx
    int $0x80
