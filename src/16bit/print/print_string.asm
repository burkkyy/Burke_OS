; For printing strings, the pointer to the string in mem will be in BX
pprint_string:
	call print_new_line

print_string:
	pusha

print_loop:
	mov al, [bx]
	cmp al, 0
	je end_print
	
	mov ah, 0x0e
	int 0x10

	inc bx
	jmp print_loop

end_print:
	popa
	ret

print_new_line:
	pusha
	mov ah, 0x0e
	
	; print new line
	mov al, 0xA
	int 0x10

	; print carrige return
	mov al, 0xD
	int 0x10
	
	; return
	popa
	ret

