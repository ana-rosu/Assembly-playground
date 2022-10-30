;//interschimbarea a 2 valori din variabilele x si y, de tipul .long
.data
x: .long 15
y: .long 10
.text
.globl main

main:
movl x, %ecx
movl y, %edx
movl %ecx, %eax
movl %edx, %ecx
movl %eax, %edx
movl %edx, x
movl %ecx, y

mov $1, %eax
mov $0, %ebx
int $0x80
