/*Fie x, y doua numere natruale salvate in memorie. Sa se scrie un program care calculeaza in
doua moduri (x/16) + (y × 16).Sa se adauge la final un pas pentru a verifica daca cele doua
valori calculate sunt egale. Daca da, sa se afiseze ”PASS”, altfel ”FAIL”.*/
.data
x: .long 48
y: .long 2
cat: .space 4
produs: .space 4
rezultat1: .space 4
rezultat2: .space 4
sir1: .asciz "PASS\n"
sir2: .asciz "FAIL\n"
.text
.globl main
main:
//primul mod - operatii aritmetice
  mov $0, %edx
  mov $16, %ebx
  
  mov x, %eax
  div %ebx
  mov %eax, cat

  mov y, %eax
  mul %ebx
  mov %eax, produs

  mov cat, %eax
  add produs, %eax
  mov %eax, rezultat1

//al doilea mod - operatii de shift
  shr $4, x
  shl $4, y
  mov x, %eax
  add y, %eax
  mov %eax, rezultat2
et:
//verific daca 2 variabile sunt egale
  mov rezultat1, %eax
  cmp rezultat2, %eax
  je egale
  jne diferite
egale:
  mov $4, %eax
  mov $1, %ebx
  mov $sir1, %ecx
  mov $6, %edx
  int $0x80
  jmp exit
diferite:
  mov $4, %eax
  mov $1, %ebx
  mov $sir2, %ecx
  mov $6, %edx
  int $0x80
exit:
  mov $1, %eax
  mov $0, %ebx
  int $0x80
