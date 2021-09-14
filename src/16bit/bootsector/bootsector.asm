; Simple bootloader for the OS
[org 0x7c00]	; origin of boot code

FILETABLE_OFFSET equ 0x1000
KERNEL_OFFSET equ 0x2000

jmp 0x0000:enter_protected_mode	; ensure CS = 0x0000

enter_protected_mode:
	; init segment registers
	xor ax, ax
	mov es, ax
	mov ds, ax

	; To begin, we must load the filetable into 0x1000:0x0, and then the kernel into 0x2000:0x0
	; Once that is done we just load subsequent programs/file into 0x3000:0x0, 0x4000:0x0, etc...

	; LOAD FILE TABLE INTO 0x1000:0x0
	mov bx, FILETABLE_OFFSET	; setting up the ES segment register for disk_load
	mov es, bx
	xor bx, bx

	mov dh, 0x1	; filetable is only 1 sector long, so we only read one sector
	mov dl, 0x4	; read from sector 3, where the filetable is in the flat binary
	call disk_load

	; LOAD KERNEL INTO 0x2000:0x0
	mov bx, KERNEL_OFFSET
	mov es, bx
	xor bx, bx

	mov dh, 0x2	; kernel is 2 sector long, so we only read in two sector to mem
	mov dl, 0x2	; read from sector 2, where the kernel is in the flat binary
	call disk_load

	; Reset segment registers
	mov ax, 0x2000
	mov ds, ax	; data segment
	mov es, ax	; extra segment
	mov fs, ax	; who cares
	mov gs, ax	; who cares
	mov ss, ax	; stack segment

	jmp KERNEL_OFFSET:0x0	; jump to the kernel

%include "../print/print_string.asm"
%include "../print/print_hex.asm"
%include "disk_loader.asm"

times 510 - ($ - $$) db 0	; padding so this file is exactly 512 bits
dw 0xaa55	; magic number, so BIOS knows this sector is bootable

