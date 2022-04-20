.code32
.global _start
_start:
mov $0x25, %al
sub $0x27, %al
call myDAS
mov %eax, %ebx
mov $1, %eax
int $0x80
myDAS:
# ... save/initialize registers
push %ebx
push %ecx
pushf # Push flags
pop %ecx # Since we need to compare to the flags
I1:  # test condition AL low nibble
 movb %al, %bl
 andb $0x0f,%bl # Mask upper bits
 cmp $9, %bl
 ja T1
 test $0x10, %ecx # Test aux flag
 jz E1
T1:  # on then condition 1
 sub $6,%al
 orb $0x10, %cl # Set aux flag to 1
 jmp I2
E1:  # on else condition 1
 andb $0x0ef,%cl # All bits set except for the one we want
 jmp I2
I2:  # test condition high nibble
 cmp $0x9f,%al
 ja T2
 test $0x01,%ecx
 jz E2
T2:  # on then condition 2
 sub $0x60,%al
 orb $0x01,%cl
 jmp done
E2:  # on else condition 2
 andb $0xfe,%cl #set lowest bit
 jmp done
done:
# ... restore al, flags and used registers
 push %ecx
 popf  # Restore flags
 pop %ecx
 pop %ebx
 ret
