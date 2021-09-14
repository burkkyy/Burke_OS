; The bootloader for the 32 bit real mode kernel
[org 0x7c00]

KERNEL_OFFSET equ 0x2000
FILETABLE_OFFSET equ 0x1000

jmp 0x0000:entry_16bit_real_mode

[bits 16]
entry_16bit_real_mode:
	; init the segment registers
	xor ax, ax
	mov cs, ax
	mov ds, ax
	mov es, ax

	; init the stack base pointer
	mov bp, 0x9000
	mov sp, bp

	mov bx, REAL_MODE_MSG
	call pprint_string

%include "print/16bit_print.asm"
%include "print/16bit_print_hex.asm"

BOOT_DRIVE: db 0	; its a good idea to store it in mem because DL may get overwritten
REAL_MODE_MSG: db "Entered 16-bit real mode...", 0
PROT_MODE_MSG: db "Entered 32-bit protected mode...", 0
KERNEL_LOAD_MSG: db "Loading kernel into mem...", 0
KERNEL_RETURN_MSG: db "Returned from kernel???", 0	; we should nvm see this msg pop up xd

times 510 - ($ - $$) db 0	; padding so this file is exactly 512 bits (one sector)
dw 0xaa55			; magic number to make this sector bootable

