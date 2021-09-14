[bits 32]
[extern main]	; Define calling point. Must have same names a kernel.c main function
call main	; Calls the C funcion, the linker will do the mem stuff for us
jmp $

