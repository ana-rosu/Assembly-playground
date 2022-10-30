/*Fie x, y doua numere natruale salvate in memorie. Sa se scrie un program care calculeaza in
doua moduri (x/16) + (y × 16).*/
.data
x: .long 32
y: .long 2
cat: .space 4
produs: .space 4
rezultat: .space 4
.text
.globl main
main:
  mov x, %eax
  mov $16, %ebx
  div %ebx
  mov %eax, cat

  mov y, %eax
  mul %ebx
  mov %eax, produs

  mov cat, %eax
  add produs, %eax
  mov %eax, rezultat

  mov $1, %eax
  mov $0, %ebx
  int $0x80
