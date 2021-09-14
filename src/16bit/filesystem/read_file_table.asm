; takes BX as a pointer to a string which may be a find in the file table
; if the arg string is found to be in the filetable, then we will return
; CH as the index
find_file:
	pusha
	
	mov ax, 0x1000
	mov es, ax
	
	xor bx, bx
	xor cx, cx
	xor si, si

	mov bx, sample_string

fileread_loop:	
	mov dl, [ES:SI]
	mov byte [bx], dl

	inc bx
	inc cx
	inc si
	
	; cmp byte [bx], 0x0
	cmp cx, 0xA
	je next_entry
	jmp fileread_loop
	
next_entry:
	mov bx, sample_string
	call pprint_string

	xor cx, cx
	add si, 6
	
	cmp byte [ES:SI], 0x0
	je fileread_return

	jmp fileread_loop

fileread_return:
	popa
	ret

sample_string: db "1234567890", 0

