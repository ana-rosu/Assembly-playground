//Fie a, b, c trei numere salvate in memorie si min un spatiu alocat de 4 octeti.
// Sa se salveze in min cel mai mic numar dintre cele trei.
.data
a: .long 5
b: .long 6
c: .long 3
min: .space 4
.text
.globl main
main:
//minimul dintre a si b (min=a daca a<b sau min=b daca b<a)
mov b, %eax
cmp %eax, a
jb et
mov %eax, min
jmp et2

et:
mov a, %eax
mov %eax, min
jmp et2

et2:
//compara c cu min
mov c, %eax
cmp min, %eax
jb et3
jmp exit

et3:
mov %eax, min

exit:
mov $1, %eax
mov $0, %ebx
int $0x80
