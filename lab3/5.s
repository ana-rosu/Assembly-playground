//Cerinte.
//1. Intelegeti ce face acest program, justificand necesitatea registrului %eax.
//2. Rulati in gdb utilizand instructiunile
//gdb nume_program
//b etloop
//i r
//c
//Comanda c este utilizata pentru a continua debug-ul, astfel ca va sari mereu in
//eticheta etloop
//Cu i r putem vedea continutul memoriei, pentru a analiza valorile stocate
//in %edx
//3. Reusiti sa gasiti valoarea 50 pastrand doar acest breakpoint? Ce ar trebui
//modificat pentru putea gasi si %edx = 50?

.data
n: .long 5
v: .long 10, 20, 30, 40, 50
.text
.globl main
main:
lea v, %edi
mov n, %ecx
etloop:
mov n, %eax
sub %ecx, %eax
movl (%edi, %eax, 4), %edx
loop etloop
etexit:
mov $1, %eax
mov $0, %ebx
int $0x80
