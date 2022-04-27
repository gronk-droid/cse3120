#; File: square_root_proc.c
.code32
.text
.globl __main
.type  __main, @function
.globl square_root_proc
.type  square_root_proc, @function
square_root_proc:
subl $4, %esp
FINIT
pushl %eax
FILDL (%esp)
lea 0x4(%esp), %eax
FSTCW (%eax)
orw $0b110000000000, %eax   /* set RC = truncate */
#FLDCW %eax
FSQRT
FISTP (%esp) /* could have used FISTTP */

andw    $0b110000000000, %eax   # set rounding to default, Intel version, needs conversion to AT&T
   # fldcw  %eax                  # load control word
popl %eax
add $4, %esp
    ret

__main:
    mov $4, %eax
    call square_root_proc
    mov %eax, %ebx # exit code
    mov $1, %eax # exit syscall
    int $0x80
