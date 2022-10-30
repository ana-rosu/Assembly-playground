.data
str: .ascii "1234"
x: .byte 97

.text
.globl main

main:
	movl $4, %eax
	movl $1, %ebx
	movl $str, %ecx
	movl $5, %edx
	int $0x80

mov $1, %eax
mov $0, %ebx
int $0x80
