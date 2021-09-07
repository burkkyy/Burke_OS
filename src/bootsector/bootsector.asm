; The beginning of everything

mov ah, 0x0e
mov al, "X"
int 0x10

hlt

times 510 - ($ - $$) db 0	; padding so this file is exactly 512 bits (the size of each sector is 512 bits)
db 0xaa55	; magic number, so BIOS knows this sector is bootable

