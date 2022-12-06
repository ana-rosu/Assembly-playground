.data
	string: .space 100
	formatLitera: .asciz "%s"
	nrMari: .space 4
	litera: .space 4
	formatNrLitere: .asciz "\nIn string-ul dat am gasit %ld litere mari!\n"
.text
.global main

main:

	pushl $string
	call gets
	pop %ebx
	lea string, %esi
	xor %ecx, %ecx
	xor %ebx, %ebx              

parcurgere:

	mov (%esi, %ecx, 1), %al     
	movb $0, %ah                  
	cmp %ah, %al
	je etexit
	inc %ecx
verif1:
	mov $97, %dl
	cmp %dl, %al
	jge verif2
	inc %ebx
	jmp parcurgere
verif2:
	mov $122, %dl
	cmp %dl, %al
	jle afisare
	inc %ebx
	jmp parcurgere

afisare:

	xor %edx, %edx
	movb %al, litera
	pusha
	pushl $litera
	pushl $formatLitera
	call printf
	popl %ebx
	popl %ebx
	popa
	jmp parcurgere

etexit:

	mov %ebx, nrMari
	pushl nrMari
	pushl $formatNrLitere
	call printf
	popl %ebx
	popl %ebx

	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
