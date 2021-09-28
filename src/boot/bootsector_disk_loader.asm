; INT 13h AH=02h: Read Sectors From Drive
 
; Parameters
; AH    02h
; AL    Sectors To Read Count
; CH    Cylinder
; CL    Sector
; DH    Head
; DL    Drive
; ES:BX Buffer Address Pointer
 
; Results
; CF    Set On Error, Clear If No Error
; AH    Return Code
; AL    Actual Sectors Read Count
 
; Take DH as # of sectors to read and DL as starting sector
; Loads sectors continuously into mem at locale ES:BX
disk_load:
	pusha
	
	mov ah, 0x02
	mov al, dh
	mov ch, 0x00
	mov cl, 0x02
	mov dh, 0x00

	int 0x13
	jc disk_error

	popa
	ret

disk_error:
	mov bx, DISK_ERROR_MSG
	call print_string

	mov dx, ax
	call print_hex
	
	jmp $

DISK_ERROR_MSG: db "Error reading disk, error code ", 0

