.data
x: .long 23
formatString: .asciz "Numarul de afisat este: %ld"
.text
.global main
main:
// incarcam argumentele in ordinea inversa limbajului C
// pentru printf("Numarul de afisat este: %ld", x);
// incarcam x, apoi sirul de format
pushl x
pushl $formatString
//apelam functia printf
call printf
// pentru fiecare push facut, facem un pop
// alegand un registru pe care nu-l utilizam
popl %ebx
popl %ebx

pushl $0
call fflush
popl %ebx
exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
