//Suma a 2 array-uri 
//Ex: v = [5,6,7] w = [10,20,30,40] r = [15.26.37.40]
.data
v: .long 5,6,7
n: .long 3
w: .long 10,20,30,40
m: .long 4
r: .space 30
.text
.globl main
main:
// %edi, %esi, %edx retin adresele de inceput ale array-urilor v, respectiv w, r
lea v, %edi
lea w, %esi
lea r, %edx
// %ecx este indexul initial
mov $0, %ecx
for:
mov $0, %eax
mov $0, %ebx
movl (%edi, %ecx, 4), %eax
movl (%esi, %ecx, 4), %ebx
add %eax, %ebx
movl %ebx, (%edx, %ecx, 4)
inc %ecx
cmp %ecx, m
jne for
exit:
mov $1, %eax
xor %ebx, %ebx
int $0x80
