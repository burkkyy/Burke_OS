; This is the bootsector which loads the kernel into mem
[org 0x7c00]

KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl
mov bp, 0x9000
mov sp, bp

mov bx, REAL_MODE_MSG
call print_string
call print_new_line

call load_kernel
call switch_to_pm

jmp $

%include "print/bootsector_print_string.asm"
%include "print/bootsector_print_hex.asm"
%include "bootsector_disk_loader.asm"
%include "32bit/gdt.asm"
%include "print/32bit_print.asm"
%include "32bit/32bit_switch.asm"

[bits 16]
load_kernel:
	mov bx, LOAD_KERNEL_MSG
	call print_string
	call print_new_line

	mov bx, KERNEL_OFFSET
	mov dh, 2
	mov dl, [BOOT_DRIVE]
	call disk_load
	ret

[bits 32]
enter_pm:
	mov ebx, PROT_MODE_MSG
	call print_string_pm
	call KERNEL_OFFSET
	jmp $

BOOT_DRIVE: db 0
REAL_MODE_MSG: db "Entered 16bit real mode!", 0
PROT_MODE_MSG: db "Entered 32bit protected mode!", 0
LOAD_KERNEL_MSG: db "Loading kernel into memory!", 0

; Define magic number and pad this file to 512 bits
times 510 - ($ - $$) db 0
dw 0xaa55

