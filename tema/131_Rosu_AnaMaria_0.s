.data
cerinta: .space 4
nodes: .space 4
nr_de_muchii: .space 4
v: .space 400
index: .space 4
matrice: .space 40000
lineIndex: .space 4
columnIndex: .space 4
i: .space 4
j: .space 4
nod: .space 4
formatPrintf: .asciz "%ld "
formatScanf: .asciz "%ld"
newLine: .asciz "\n"
k: .space 4
s: .space 4
d: .space 4
mres: .space 40000
mcopy: .space 40000
.text
.global main
// matrix_copy(m, rez, n)
// copiaza matricea m de dimensiune n in rez
matrix_copy:
pushl %ebp
movl %esp, %ebp
pushl %ebx
pushl %esi
pushl %edi

// calculez n patrat
movl 16(%ebp), %eax
xorl %edx, %edx
mull 16(%ebp) 

// copiez matricea 
xorl %ecx, %ecx
for_copy:
cmp %ecx, %eax
je cont_copy

movl 8(%ebp), %esi
movl 12(%ebp), %edi

movl (%esi, %ecx, 4), %ebx
movl %ebx, (%edi, %ecx, 4)

incl %ecx
jmp for_copy

cont_copy:
popl %edi
popl %esi
popl %ebx
popl %ebp
ret
// matrix_mult(m1, m2, mres, n) 
// m1 si m2 doua matrici de dimensiune n
// inmulteste 2 matrici si stocheaza rezultatul in mres
matrix_mult:
pushl %ebp
movl %esp, %ebp
pushl %esi
pushl %edi
pushl %ebx
//aloc 3 spatii pe stiva
subl $12, %esp

// inmultesc elementele a 2 matrici
xorl %ecx, %ecx
for1:
cmp %ecx, 20(%ebp)
je continua
xorl %edx, %edx
for2:
  cmp %edx, 20(%ebp)
  je cont_for1
  // s=0
  movl $0, -12(%ebp)
  xorl %ebx, %ebx
  for3:
    cmp %ebx, 20(%ebp)
    je rez
    
    movl 20(%ebp), %eax
    pushl %edx
    xorl %edx, %edx
    mull %ecx
    popl %edx
    addl %ebx, %eax

    movl 8(%ebp), %esi
    movl (%esi, %eax, 4), %eax
    movl %eax, -4(%ebp)

    movl 20(%ebp), %eax
    pushl %edx
    xorl %edx, %edx
    mull %ebx
    popl %edx
    addl %edx, %eax

    movl 12(%ebp), %edi
    movl (%edi, %eax, 4), %eax
    movl %eax, -8(%ebp)

    movl -4(%ebp), %eax
    pushl %edx
    xorl %edx, %edx
    mull -8(%ebp)
    popl %edx

    addl %eax, -12(%ebp)

    incl %ebx
    jmp for3
  rez:
  movl 16(%ebp), %edi
  movl -12(%ebp), %ebx 
  
    movl 20(%ebp), %eax
    pushl %edx
    xorl %edx, %edx
    mull %ecx
    popl %edx
    addl %edx, %eax
  
  movl %ebx, (%edi, %eax, 4)
  incl %edx
  jmp for2
cont_for1:
incl %ecx
jmp for1
continua:
popl %ebx
popl %edi
popl %esi
// dezaloc spatiul folosit pe post de variabile locale in procedura
addl $12, %esp
popl %ebp
ret

main:
//citim numarul cerintei
pushl $cerinta
pushl $formatScanf
call scanf
addl $8, %esp
//validare cerinta
movl cerinta, %ebx
cmp $1, %ebx
je valid

cmp $2, %ebx
je valid

jmp et_exit
valid:
//citim numarul de noduri
pushl $nodes
pushl $formatScanf
call scanf
addl $8, %esp

//citim numarul de legaturi pt fiecare nod si le stocam intr-un vector
xorl %ecx, %ecx
for_nr_leg:
cmp %ecx, nodes
je for_muchii

pusha
pushl $nr_de_muchii
pushl $formatScanf
call scanf
addl $8, %esp
popa

lea v, %esi
movl nr_de_muchii, %ebx
movl %ebx, (%esi, %ecx, 4)

incl %ecx
jmp for_nr_leg

//citim lista de adiacenta pentru fiecare nod si punem 1 pe pozitia corespunzatoare in matrice
movl $0, index
for_muchii:
movl index, %ecx
cmp %ecx, nodes
je cerinte

lea v, %esi
movl (%esi, %ecx, 4), %ebx
cmp $0, %ebx
je pass
movl %ecx, i
movl %ebx, %ecx
	for_legaturi:
	  pusha
	  pushl $nod
	  pushl $formatScanf
	  call scanf
	  popl %ebx
	  popl %ebx
	  popa

	  movl i, %eax
	  movl $0, %edx
	  mull nodes
	  addl nod, %eax
        
	  lea matrice, %edi
	  movl $1, (%edi, %eax, 4)
 	  
	  loop for_legaturi
pass:
incl index
jmp for_muchii

//salt la etichete in functie de cerinta
cerinte:
movl $1, %ebx
cmp %ebx, cerinta
je cerinta1

movl $2, %ebx
cmp %ebx, cerinta
je cerinta2

cerinta1:
// afisare matrice
movl $0, lineIndex
  for_lines:
    movl lineIndex, %ecx
    cmp %ecx, nodes
    je et_exit

    movl $0, columnIndex
    for_columns:
	movl columnIndex, %ecx
	cmp %ecx, nodes
	je cont
	
	movl lineIndex, %eax
	movl $0, %edx
	mull nodes
	addl columnIndex, %eax

	lea matrice, %edi
	movl (%edi, %eax, 4), %ebx

	pushl %ebx
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	pushl $0
	call fflush
	popl %ebx

	incl columnIndex
	jmp for_columns
  cont:
    pusha
    pushl $newLine
    call printf
    popl %ebx
    popa 
    
    incl lineIndex
    jmp for_lines
jmp et_exit

cerinta2:
//citim lungimea k a drumului
pushl $k
pushl $formatScanf
call scanf
addl $8, %esp
//citim nodul sursa
pushl $s
pushl $formatScanf
call scanf
addl $8, %esp
//citim nodul destinatie
pushl $d
pushl $formatScanf
call scanf
addl $8, %esp
//copiem matricea de adiacenta a grafului
pushl nodes
pushl $mcopy
pushl $matrice
call matrix_copy
addl $12, %esp
//calculam matrice**k
xorl %ecx, %ecx
decl k
for_k:
cmp %ecx, k
je raspuns

pushl %ecx

pushl nodes
pushl $mres
pushl $mcopy
pushl $matrice
call matrix_mult
addl $16, %esp

pushl nodes
pushl $mcopy
pushl $mres
call matrix_copy
addl $12, %esp

popl %ecx

incl %ecx
jmp for_k
raspuns:
//afisam mres[nod_sursa][nod_destinatie]
movl s, %eax
xorl %edx, %edx
mull nodes
addl d, %eax

lea mres, %esi
movl (%esi, %eax, 4), %ebx

pusha
pushl %ebx
pushl $formatPrintf
call printf
addl $8, %esp
popa

pusha
pushl $0
call fflush
addl $4, %esp
popa

et_exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
