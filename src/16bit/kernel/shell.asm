; INT 16h AH=00h - read keystroke		

; Returns
; AH = Scan code of the key pressed down	
; AL = ASCII character of the button pressed

start_shell:
	pusha
	mov bx, ENTERMSG
	call pprint_string

get_input:
	mov di, USERINPUT

key_loop:
	xor ax, ax	; zero out ax for int 16h
	int 0x16	; read keyboard press

	mov ah, 0x0e	; set BIOS teletype
	cmp al, 0xd	; check for enter key press
	je run_cmd	; if enter was press, run user entered string as cmd
	
	int 0x10	; print user entered ascii
	mov [di], al	; store user entered ascii in USERINPUT
	inc di		; move ptr di to the next byte in USERINPUT
	jmp key_loop	; loop back to read the next user entered char

read_cmd:
	mov byte [di], 0	; null terminate the user entered string
	mov al, [USERINPUT]

run_cmd:
	mov byte [di], 0
	mov al, [USERINPUT]
	cmp al, "p"
	je print
	cmp al, "q"
	je return
	jmp get_input

print:
	mov bx, SOMESTRING
	call pprint_string
	call print_registers
	jmp get_input

return: 
	popa
	ret

ENTERMSG: db "You have entered the shell!!", 0
SOMESTRING: db "Hello from kernel!!!", 0
USERINPUT: db "", 0

