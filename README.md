# Assembly x86 - AT&T syntax

## Useful links:

- [System call numbers](https://github.com/opennetworklinux/linux-3.8.13/blob/master/arch/sh/include/uapi/asm/unistd_32.h)
- [x86 Assembly Guide](http://flint.cs.yale.edu/cs421/papers/x86-asm/asm.html)
- [AT&T assembly syntax and IA-32 instructions](https://gist.github.com/mishurov/6bcf04df329973c15044)

## Debugging
Executam
```
gcc -m32 program.s -o program
```
Pentru a putea face debug, vom utiliza gdb. Rulam in terminal
```
gdb program
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
<br/>
<br/>

> Pentru a inspecta valoarea stocata in variabilele declarate cu .space 4, putem
folosi tot debugger-ul gdb, executand la un pas:
```
print (long) nume_variabila
```
