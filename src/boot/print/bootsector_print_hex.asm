print_hex:
	pusha
	xor cx, cx

hex_loop:
	cmp cx, 4
	je hex_loop_end

	mov ax, dx
	and ax, 0x000f
	add al, 0x30
	cmp al, 0x39
	jle step2
	add al, 7

step2:
	mov bx, HEX_OUT + 5
	sub bx, cx
	mov [bx], al
	ror dx, 4

	add cx, 1
	jmp hex_loop

hex_loop_end:
	mov bx, HEX_OUT
	call print_string

	popa
	ret

HEX_OUT: db "0x0000", 0

