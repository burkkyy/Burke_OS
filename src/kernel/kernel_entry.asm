[bits 32]
[extern main]	; the linker will give us the mem locale of main
call main	; Exectue main, expect not to return
jmp $		; for whatever reason, halt cpu if we return from the kernel

