.data
x: .space 4 
// nu stim momentan valoarea citita, dar stim cat ocupa
formatString1: .asciz "%ld"
formatString2: .asciz "Numarul introdus de la tastatura este %ld\n"
.text
.global main
main:
// incarcam in stiva NU x, ci ADRESA lui x
// adica nu x, ci £x
pushl $x
// incarcam adresa formatului
pushl $formatString1
call scanf
// descarcam ce am incarcat in stiva
popl %ebx
popl %ebx
//afisam
pushl x
pushl $formatString2
call printf
popl %ebx
popl %ebx

pushl $0
call fflush
popl %ebx
exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
