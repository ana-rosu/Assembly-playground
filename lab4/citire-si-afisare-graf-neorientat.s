.data
matrix: .space 100
columnIndex: .space 4
lineIndex: .space 4
n: .space 4
nrMuchii: .space 4
index: .space 4
left: .space 4
right: .space 4
formatScanf: .asciz "%ld"
formatPrintf: .asciz "%ld"
newLine: .asciz "\n"

.text

.globl main
main:
pushl $n
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

pushl $nrMuchii
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

movl $0, index
//simulam 
// for(long index=0; index < nrMuchii; index++){
//	scanf("%ld", &left)
//	scanf("%ld", &right)
//	matrix[left][right] = 1
//	matrix[right][left] = 1
//}
et_for:
movl index, %ecx
cmp %ecx, nrMuchii
je et_afis_matr

pushl $left
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

pushl $right
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

//matrix[left][right] = 1
movl left, %eax
movl $0, %edx
mull n
addl right, %eax
//%eax = left * n + right

lea matrix, %edi
movl $1, (%edi, %eax, 4)

//matrix[right][left] = 1
movl right, %eax
movl $0, %edx
mull n
addl left, %eax
//%eax = right * n + left

lea matrix, %edi
movl $1, (%edi, %eax, 4)

incl index
jmp et_for

et_afis_matr:
movl $0, lineIndex
  for_lines:
    movl lineIndex, %ecx
    cmp %ecx, n
    je et_exit
    
   movl $0, columnIndex
   for_columns:
	movl columnIndex, %ecx
	cmp %ecx, n
	je cont
	//afisez matrix[lineIndex][columnIndex]
	//indexul este lineIndex * n + columnIndex
	movl lineIndex, %eax
	movl $0, %edx
	mull n
	addl columnIndex, %eax

	lea matrix, %edi
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
movl $4, %eax
movl $1, %ebx
movl $newLine, %ecx
movl $2, %edx
int $0x80

incl lineIndex
jmp for_lines

et_exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
