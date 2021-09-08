; This is the bootloader for the kernel 
[org 0x7c00]	; origin of boot code

; Setting up the 
mov bx, 0x1000
mov es, bx
xor bx, bx

call disk_load

; Reset segment registers
mov ax, 0x1000
mov ds, ax	; data segment
mov es, ax	; extra segment
mov fs, ax	; who cares
mov gs, ax	; who cares
mov ss, ax	; stack segment

jmp 0x1000:0x0	; jump to the loaded sector in memory

%include "../print/print_string.asm"
%include "../print/print_hex.asm"
%include "disk_loader.asm"

times 510 - ($ - $$) db 0	; padding so this file is exactly 512 bits
dw 0xaa55	; magic number, so BIOS knows this sector is bootable

