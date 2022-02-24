# file hello_world.S
.p2align        4, 0x90         # 16 byte alignment, filled nops

.globl _start
_start:
    subq $8, %rsp
    leaq L_format(%rip), %rdi   # rdi = L_format + rip
    leaq L_HW(%rip), %rsi       # rsi = L_HW + ripz
    mov $0, %al
    callq printf
    add $8, %rsp

# The next three lines are the equivalent of the “exit”
# in the 64 bit MASM
    mov $60, %rax
    xor %edi, %edi
    syscall

L_format:
    .asciz "%s"
L_HW:
    .asciz "Hello World!\n"
