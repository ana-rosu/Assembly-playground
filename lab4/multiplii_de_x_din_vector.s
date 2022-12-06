//se citesc de la tastatura un numar x, un numar n si apoi un vector cu n numere naturale
// Sa se stocheze in memorie si sa se afiseze doar acele nr din vector care sunt multiplii de x 
.data
x: .space 4
n: .space 4
v: .space 400
nr: .space 4
formatScanf: .asciz "%ld"
formatPrintf: .asciz "%ld "
.text
.globl main
main:
//citim x de la tastatura
pusha
pushl $x
pushl $formatScanf
call scanf
popl %ebx
popl %ebx
popa
//citim n de la tastatura
pusha
pushl $n
pushl $formatScanf
call scanf
popl %ebx
popl %ebx
popa

lea v, %edi
//citim n nr naturale
xorl %ecx, %ecx
for_citire:
cmp %ecx, n
je continua

pusha
pushl $nr
pushl $formatScanf
call scanf
popl %ebx
popl %ebx
popa
//stocam doar multiplii de x in v
movl nr, %eax
xorl %edx, %edx
divl x
cmp $0, %edx
jne pass
movl nr, %eax
movl %eax, (%edi, %ecx, 4)
pass:
incl %ecx
jmp for_citire

continua:
xorl %ecx, %ecx
for_afisare:
cmp %ecx, n
je exit

movl (%edi, %ecx, 4), %eax
movl %eax, nr

pusha
pushl nr
pushl $formatPrintf
call printf
popl %ebx
popl %ebx
popa

pusha
pushl $0
call fflush
popl %ebx
popa

incl %ecx
jmp for_afisare
exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
