; This file prints to the screen in 32bit protected mode

VIDEO_MEMORY equ 0xb8000	; where video mem starts
WHITE_ON_BLACK equ 0x0f		; the color byte of each printed char

[bits 32]
print_string_pm:
	pusha
	mov edx, VIDEO_MEMORY

print_string_pm_loop:
	mov al, [ebx]	; [ebx] is the addr of our char
	mov ah, WHITE_ON_BLACK
	
	cmp al, 0	; check for null terminator
	je print_string_pm_done

	mov [edx], ax	; store char + attribute in video mem 
	inc ebx		; next char
	add edx, 2	; next video mem pos

	jmp print_string_pm_loop

print_string_pm_done:
	popa
	ret

