; printing strings for 16bit code
; print_string takes BX as a pointer of the string to print
pprint_string:
	call print_new_line

print_string:
	pusha
	mov ah, 0x0e

print_loop:
	mov al, [bx]
	
	; check for null terminator
	cmp al, 0
	je end_print
	
	; BIOS print
	int 0x10
	
	; move BX to point to the next char a loop again
	inc bx
	jmp print_loop

end_print:
	popa
	ret

print_new_line:
	push ax
	mov ah, 0x0e

	; print new line char
	mov al, 0xA
	int 0x10

	; print carrige return char
	mov al, 0xD
	int 0x10

	; return
	pop ax
	ret

