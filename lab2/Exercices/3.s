//Sa se verifice daca un numar dat este prim (folositi ambele variante de structuri repetitive).
.data
x: .long 2
prim: .asciz "Numarul este prim!\n"
neprim: .asciz "Numarul nu este prim!\n"
stop: .space 4
.text
.globl main
main:
//daca x=0 sau x=1 atunci x nu e prim
mov x, %eax
cmp $2, %eax
jb nu
//altfel, daca x este par si diferit de 2, x nu e prim
and $1, %eax
cmp $0, %eax
je check2
jmp imparloop
check2:
mov x, %ebx
cmp $2,%ebx
je da
jmp nu

mov $3, %ecx
imparloop:
//daca x e impar si are divizori, x nu e prim
//d*d
mov %ecx, %eax
mul %ecx
mov %eax, stop

mov x, %eax
cmp %eax, stop
ja da /* if d*d>x -> exit loop la sfarsit deci n-a sarit la nu, deci nu are divizori, deci e prim*/

mov $0, %edx
div %ecx 
//%eax=catul, %edx=restul
cmp $0, %edx
je nu
add $2, %ecx
jmp imparloop 

da:
mov $4, %eax
mov $1, %ebx
mov $prim, %ecx
mov $20, %edx
int $0x80
jmp exit
nu:
mov $4, %eax
mov $1, %ebx
mov $neprim, %ecx
mov $23, %edx
int $0x80

exit:
mov $1, %eax
mov $0, %ebx
int $0x80
