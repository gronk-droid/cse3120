#; File: square_root_proc.S
.code32
.text
.globl __main
.type  __main, @function
.globl square_root_proc
.type  square_root_proc, @function
.comm ctrlWord , 4

square_root_proc:
    FINIT
    pushl %eax
    FILD (%esp)
    FSTCW ctrlWord
    orw $0b110000000000, ctrlWord   /* set RC = truncate */
    FLDCW ctrlWord
    FSQRT
    FISTP (%esp) /* could have used FISTTP */
    popl %eax

    # ... here append the code for restoring control register from ctrlWord

    andw    $0b110000000000, ctrlWord   # set rounding to default, Intel version, needs conversion to AT&T
    fldcw  ctrlWord                  # load control word
    ret

__main:
    mov $4, %eax
    call square_root_proc
    mov %eax, %ebx # exit code
    mov $1, %eax # exit syscall
    int $0x80
