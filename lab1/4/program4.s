.data
str1: .ascii "abc"
str2: .ascii "1"

.text

.globl main
main:
	movl $4, %eax
	movl $1, %ebx
	movl $str1, %ecx
	movl $4, %edx
	int $0x80 

mov $1, %eax
mov $0, %ebx
int $0x80
