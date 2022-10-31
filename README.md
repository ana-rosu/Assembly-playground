# Assembly x86 - AT&T syntax

## Useful Theory
Links:

- [System call numbers](https://github.com/opennetworklinux/linux-3.8.13/blob/master/arch/sh/include/uapi/asm/unistd_32.h)
- http://flint.cs.yale.edu/cs421/papers/x86-asm/asm.html
- https://gist.github.com/mishurov/6bcf04df329973c15044

```
print (long) nume_variabila
```
Executam
```
gcc -m32 program2.asm -o program2
```
Pentru a putea face debug, vom utiliza gdb. Rulam in terminal
```
gdb program2
```
Punem un breakpoint la adresa de intrare in program, si anume la main:
```
b main
```
Rulam programul
```
run
```
Iar acum, vom executa succesiv
```
i r
stepi
```
Pentru a inspecta valoarea stocata in variabilele declarate cu .space 4, putem
folosi tot debugger-ul gdb, executand la un pas:
