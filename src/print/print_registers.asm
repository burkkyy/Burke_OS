; This file prints the values of all the registers to the screen
print_registers:
	pusha
	push dx	; used for hex printing so store its current value on the stack
	push bx	; used for string printing so store its current value on the stack

	mov bx, PLACEHOLDER
	call pprint_string
	mov dx, ax
	call print_hex

	mov byte [PLACEHOLDER], "b"
	call pprint_string
	pop bx
	mov dx, bx
	call print_hex
	
	mov bx, PLACEHOLDER

	mov byte [PLACEHOLDER], "c"
	call pprint_string
	mov dx, cx
	call print_hex

	mov byte [PLACEHOLDER], "d"
	call pprint_string
	pop dx
	call print_hex
	
	mov word [PLACEHOLDER], "si"
	call pprint_string
	mov dx, si
	call print_hex
	
	mov byte [PLACEHOLDER], "d"
	call pprint_string
	mov dx, di
	call print_hex
	
	mov word [PLACEHOLDER], "cs"
	call pprint_string
	mov dx, cs
	call print_hex
	
	mov byte [PLACEHOLDER], "d"
	call pprint_string
	mov dx, ds
	call print_hex
	
	mov byte [PLACEHOLDER], "e"
	call pprint_string
	mov dx, es
	call print_hex
	
	popa
	ret

PLACEHOLDER: db "ax = ", 0

