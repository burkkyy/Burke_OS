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
call pprint_string

; call start_shell

; mov bx, RETURNED_MSG
; call pprint_string

call find_file

call start_shell

mov bx, RETURNED_MSG
call pprint_string

cli
hlt

%include "../print/print_string.asm"
%include "../print/print_hex.asm"
%include "../print/print_registers.asm"
%include "shell.asm"
%include "../filesystem/read_file_table.asm"

KERNEL_LOAD_MSG: db "Kernel loaded!", 0
RETURNED_MSG: db "You have returned form the shell!", 0

times 1024 - ($ - $$) db 0	; padding to make file 512 bits long

