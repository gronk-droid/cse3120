.data
hello:
    .string "Hello world!\n"

.text
.globl _main
_main:
    movl $4, %eax # write(1, hello, strlen(hello))
    movl $1, %ebx
    movl $hello, %ecx
    movl $13, %edx
    int  $0x80

    movl $1, %eax # exit(0)
    movl $0, %ebx
    int  $0x80
