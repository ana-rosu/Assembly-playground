//n=5
//long v[5]={1,2,3,4,5}
//s=0
//for(long i=0;i<n;i++)
//s+=a[i]
.data
n: .long 5
v: .long 1,2,3,4,5
s: .long 0
.text
.globl main
main:
mov $v, %esi
mov $0, %ecx
 
et_loop:
cmp n, %ecx
je exit

mov (%esi, %ecx, 4), %eax
add %eax, s

inc %ecx
jmp et_loop

exit:
mov $1, %eax
xor %ebx, %ebx /* <=> mov $0, %ebx */
int $0x80

