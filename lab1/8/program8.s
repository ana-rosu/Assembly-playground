.data
.text
.globl main

main:
movl $8, %eax
movl $2048, %ecx

et_exit:
mov $1, %eax
mov $0, %ebx
int $0x80
