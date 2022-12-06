//Fie s un string salvat in memorie si t un spatiu alocat cu aceeasi numar de octeti.
// Sa se obtina in t inversul string-ului s si sa se afiseze pe ecran
.data
s: .asciz "Hello World\n"
t: .space 13
.text
.globl main
main:

exit:
mov $1, %eax
xor %ebx, %ebx
int $0x80
