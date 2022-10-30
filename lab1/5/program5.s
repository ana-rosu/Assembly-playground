.data
x: .long 0x04030201
y: .long 0x08070605

.text
.global main
main:

mov x, %eax
mov y, %ah

mov $1, %eax
mov $0, %ebx
int $0x80
