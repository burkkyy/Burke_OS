; This file is a 'kernel' loaded from the bootsector
; set video mode
mov ah, 0x0
mov al, 0x1
int 0x10
 
; Set color/palette
mov ah, 0xB
mov bh, 0x0
mov bl, 0x1
int 0x10
 
; Test print_string
mov bx, KERNEL_LOAD_MSG
call print_string
 
call print_new_line
 
; Test print_hex
mov dx, 0xFACE
call print_hex
 
call print_new_line
 
jmp $

%include "../bootsector/print/print_string.asm"
%include "../bootsector/print/print_hex.asm"

KERNEL_LOAD_MSG: db "Kernel loaded!", 0

times 512 - ($ - $$) db 0	; padding to make file 512 bits long

