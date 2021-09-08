; INT 13h AH=02h: Read Sectors From Drive

; Parameters
; AH	02h
; AL	Sectors To Read Count
; CH	Cylinder
; CL	Sector
; DH	Head
; DL	Drive
; ES:BX	Buffer Address Pointer

; Results
; CF	Set On Error, Clear If No Error
; AH	Return Code
; AL	Actual Sectors Read Count

disk_load:	; Takes AL as # of sectors to read, and loads it into ES:BS mem location from drive DL
	pusha
	push dx
	
	; old code
	; mov ah, 0x2	; int 0x13/ah=0x2, BIOS will read disk sectors into memory
	; mov al, 0x1	; # of sectors we want to read
	; mov ch, 0x0	; cylinder 0
	; mov cl, 0x2	; start at sector 2 (bootsector is sector 1)
	; mov dh, 0x0	; head 0
	; mov dl, 0x0

	; Cleaner code
	mov ax, 0x201
	mov cx, 2
	xor dx, dx

	int 0x13	; BIOS interrupts for disk functions
	jc disk_error	; check for carry bit
	
	pop dx
	cmp dh, al	; # of sectors read (dh) != # of sectors we wanted to read (al)
	je disk_error
	
	popa
	ret

disk_error:
	; print out error msg
	mov bx, DISK_ERROR_MSG
	call print_string

	; print out error code
	mov dx, ax
	call print_hex
	
	; 'hlt' the cpu (hlt doesnt work IDKKK)
	jmp $

DISK_ERROR_MSG: db "Error reading disk, error code ", 0

