//long n=7
//char s[7]="Hello\n"
//char t[7]
//for (long i=0;i<n;i++)
//    t[i]=s[i]
//for(long i=n-1;i>=0;i--)
//    t[i]=s[i]
.data
n: .long 6
s: .asciz "Hello\n"
t: .space 6
.text
.globl main
main:
mov $s, %esi
mov $t, %edi
mov n, %ecx

et_loop:
mov $ecx, %edx
dec %edx
movb (%esi, %edx, 1), %eax
movb $al, (%edi, %edx,1)
loop et_loop 

mov $4, %eax
mov $1, %ebx
mov $t, %ecx
mov $7, %edx
int $0x80 
exit:
mov $1, %eax
xor %ebx, %ebx
int $0x80
