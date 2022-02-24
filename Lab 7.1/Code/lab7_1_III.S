.code32
.text
.globl main
.type  main, @function
.globl square_root_proc
.type  square_root_proc, @function
square_root_proc:
  push %ebx
  push %ecx
  push %edx
  xor %ecx, %ecx
  mov %eax, %ebx


  sqloop: 
  mov %ecx, %eax
  mul %eax
  cmp %ebx, %eax
  je quit
  inc %ecx
  jmp sqloop

  quit:
  mov %ecx, %eax
  pop %edx
  pop %ecx
  pop %ebx
  ret


main:
 mov $4, %eax
 call square_root_proc
 mov %eax, %ebx # exit code
 mov $1, %eax # exit syscall
 int $0x80
