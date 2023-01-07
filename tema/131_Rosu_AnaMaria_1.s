.data
cerinta: .space 4
nodes: .space 4
nr_de_muchii: .space 4
v: .space 4
dimensiuneV: .space 4
index: .space 4
nod_i: .space 4
nod_j: .space 4
matrice: .space 4
mcopy: .space 4
mres: .space 4
dimensiune: .space 4
k: .space 4
s: .space 4
d: .space 4
formatPrintf: .asciz "%ld"
formatScanf: .asciz "%ld"
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
cmp $3, %ebx
je valid
jmp et_exit
valid:
//citim numarul de noduri
pushl $nodes
pushl $formatScanf
call scanf
addl $8, %esp

//calculez dimensiunea vectorului in bytes -> n long-uri
movl $4, %eax
xorl %edx, %edx
mull nodes
movl %eax, dimensiuneV

// aloc spatiul pentru vectorul folosit dinamic
movl $192, %eax
movl $0, %ebx
movl dimensiuneV, %ecx   
movl $0x3, %edx          
movl $0x22, %esi         
movl $-1, %edi           
movl $0, %ebp
int $0x80

movl %eax, v

//calculez dimensiunea matricii in bytes
// %eax = n * n * 4 ->  n * n long-uri
movl nodes, %eax
xorl %edx, %edx
mull nodes
movl $4, %ebx
mull %ebx
movl %eax, dimensiune

// 192 este codul pentru apelul de sistem mmap2
movl $192, %eax
// pun valoarea NULL pt a lasa kernelul sa aleaga adresa la care sa creeze maparea in asa fel incat sa nu intre in conflict cu alte mapari existente
movl $0, %ebx
// pun dimensiune = n * n * 4, reprezentand numarul de bytes pe care sa ii mapeze
movl dimensiune, %ecx
// pun 0x3 -> codul pentru a permite acces read-write: folosesc inclusive-or PROT_READ | PROT_WRITE
movl $0x3, %edx
// specific natura maparii: MAP_PRIVATE | MAP_ANON -> pentru a aloca o zona distincta de memorie al carei continut este initializat cu 0, fara a fi conectata la un fisier -> in acest fel obtin PRIVATE ANONYMOUS MAPPING
movl $0x22, %esi
// din moment ce am folosit MAP_ANON, este ignorat argumentul fd (file descriptor), insa prin conventie, pun -1
movl $-1, %edi
// din nou, pentru ca am folosit MAP_ANON, argumentul offset este ignorat, trebuie sa fie 0
movl $0, %ebp
int $0x80

movl %eax, matrice

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

movl v, %esi
movl nr_de_muchii, %ebx
movl %ebx, (%esi, %ecx, 4)

incl %ecx
jmp for_nr_leg

//citim lista de adiacenta pentru fiecare nod si punem 1 pe pozitia corespunzatoare in matrice
movl $0, index
for_muchii:
movl index, %ecx
cmp %ecx, nodes
je cerinta3

movl v, %esi
movl (%esi, %ecx, 4), %ebx
cmp $0, %ebx
je pass
movl %ecx, nod_i
movl %ebx, %ecx
	for_legaturi:
	  pusha
	  pushl $nod_j
	  pushl $formatScanf
	  call scanf
	  addl $8, %esp
	  popa

	  movl nod_i, %eax
	  xorl %edx, %edx
	  mull nodes
	  addl nod_j, %eax
        
          movl matrice, %edi
	  movl $1, (%edi, %eax, 4)
 	  
	  loop for_legaturi
pass:
incl index
jmp for_muchii

cerinta3:
//citim lungimea k a drumului
pusha
pushl $k
pushl $formatScanf
call scanf
addl $8, %esp
popa
//citim nodul sursa
pusha
pushl $s
pushl $formatScanf
call scanf
addl $8, %esp
popa
//citim nodul destinatie
pusha
pushl $d
pushl $formatScanf
call scanf
addl $8, %esp
popa
//aloc dinamic inca 2 matrici
//mcopy
movl $192, %eax
movl $0, %ebx
movl dimensiune, %ecx   
movl $0x3, %edx          
movl $0x22, %esi         
movl $-1, %edi           
movl $0, %ebp
int $0x80

movl %eax, mcopy

//mres
movl $192, %eax
movl $0, %ebx
movl dimensiune, %ecx    
movl $0x3, %edx          
movl $0x22, %esi         
movl $-1, %edi           
movl $0, %ebp
int $0x80

movl %eax, mres

//copiem matricea de adiacenta a grafului
pushl nodes
pushl mcopy
pushl matrice
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
pushl mres
pushl mcopy
pushl matrice
call matrix_mult
addl $16, %esp

pushl nodes
pushl mcopy
pushl mres
call matrix_copy
addl $12, %esp

popl %ecx

incl %ecx
jmp for_k
raspuns:
movl %eax, %esi
//afisam mres[nod_sursa][nod_destinatie]
movl s, %eax
xorl %edx, %edx
mull nodes
addl d, %eax

movl mres, %esi
movl (%esi, %eax, 4), %ebx


pushl %ebx
pushl $formatPrintf
call printf
addl $8, %esp

pushl $0
call fflush
addl $4, %esp

unmap:
movl $91, %eax
movl v, %ebx
movl nodes, %ecx
int $0x80
  
movl $91, %eax
movl matrice, %ebx
movl dimensiune, %ecx
int $0x80

movl $91, %eax
movl mcopy, %ebx
movl dimensiune, %ecx
int $0x80

movl $91, %eax
movl mres, %ebx
movl dimensiune, %ecx
int $0x80

et_exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
