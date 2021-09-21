GDT_START:
	; the GDT starts with a null 8-byte
	dd 0x0
	dd 0x0

; GDT for code segment. base = 0x00000000, length = 0xfffff
; for flags, refer to https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf, page 36
GDT_CODE:
	dw 0xffff
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0
  
; GDT for data segment. base and length identical to code segment
; some flags changed, refer to https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf, page 36
GDT_DATA:
	dw 0xffff
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0
  
GDT_END:
  
GDT_DESCRIPTOR:
	dw GDT_END - GDT_START - 1      ; size (16 bit), always one less of its true size
	dd GDT_START                    ; addr (32 bit)
  
; We define these constants so we can use them later
CODE_SEG equ GDT_CODE - GDT_START
DATA_SEG equ GDT_DATA - GDT_START

