.data
a: .space 4
formatScanf: .asciz "%ld"
formatPrintf: .asciz "%ld "
index: .space 4
.text
.globl main
main:
//citim nr de la tastatura
pushl $a
pushl $formatScanf
call scanf
popl %ebx
popl %ebx
// simulam for(long index = 1; index <= a; index++){
//            if(a % index == 0)
//              print("%ld", &index)
//}
movl $1, index

et_for:
movl index, %ecx
cmp a, %ecx
jg et_exit

movl a, %eax
movl $0, %edx
divl %ecx
cmp $0, %edx
je afisare
cont:
incl index
jmp et_for

afisare:
pushl index
pushl $formatPrintf
call printf
popl %ebx
popl %ebx

pushl $0
call fflush
popl %ebx

jmp cont
et_exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
