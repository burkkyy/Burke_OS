; This is the bootloader for the kernel 
[org 0x7c00]

mov bx, 0x1000
mov es, bx
xor bx, bx

call disk_load

mov ax, 0x1000
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ss, ax

jmp 0x1000:0

%include "print/print_string.asm"
%include "print/print_hex.asm"
%include "disk_loader.asm"

times 510 - ($ - $$) db 0	; padding so this file is exactly 512 bits
dw 0xaa55	; magic number, so BIOS knows this sector is bootable

