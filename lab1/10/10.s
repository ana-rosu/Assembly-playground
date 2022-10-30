/*Fie s un spatiu alocat de 12 octeti. Folosind codul functiei read (vezi link-ul de mai sus unde
sunt listate apelurile de sistem si codurile asociate) si stiind ca regula de incarcare este aceeasi
ca in cazul functiei write, cititi in s de la tastatura (codul pentru stdin este 0) 12 caractere.
Afisati-l pe s. */
.data
  s: .space 12
.text
.globl main
main:
  mov $3, %eax
  mov $0, %ebx
  mov $s, %ecx
  mov $12, %edx
  int $0x80

  mov $4, %eax
  mov $1, %ebx
  mov $s, %ecx
  mov $12, %edx
  int $0x80

mov $1, %eax
mov $0, %ebx
int $0x80
