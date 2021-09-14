[bits 16]
switch_to_pm:
	cli			; Disable interrupts
	lgdt [GDT_DESCRIPTOR]	; Load the GDT descriptor table
	mov eax, cr0
	or eax, 0x1		; Set 32bit mode bit in cr0
	mov cr0, eax
	jmp CODE_SEG:init_pm	; Far jump by using a different segment

[bits 32]
init_pm:
	; Update the segment registers
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	; Update the stack right at the top of the free space
	mov ebp, 0x90000
	mov esp, ebp
	
	call enter_32bit_prot_mode

