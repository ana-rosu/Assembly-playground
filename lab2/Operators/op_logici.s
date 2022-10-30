.data
.text
.globl main

main:
mov $5, %eax /*stores 0101 in eax => 0x5*/
mov $2, %ebx /*stores 0010 in ebx => 0x2*/
test %ebx, %eax /*eax & ebx => 0101 & 0010 = 0000 = eax, ebx stays the same*/

mov $5, %eax /*stores 0101 in eax => 0x5*/
mov $2, %ebx /*stores 0010 in ebx => 0x2*/
and %ebx, %eax /*eax & ebx => 0101 & 0010 = 0000 =eax, ebx??????????*/

mov $4, %eax /*stores 0100 in eax => 2^2=4 => 0x4*/
and $1, %eax /*performs 0100 AND 0001 and saves 0000 in eax => 0 => 0x0*/
or  $1, %eax /*performs 0000 OR 0001 and saves 0001 in eax => 1 => 0x1*/
xor $1, %eax /*performs 0001 XOR 0001 and saves 0000 in eax => 0 => 0x0*/
not %eax /*performs NOT 0000 and saves 1111 in eax => 15 => 0xffffffff => -1*/

mov $1, %eax
mov $0, %ebx
int $0x80
