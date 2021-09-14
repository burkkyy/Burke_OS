; This file contains the file table for my OS
; Each entry in file table is 16 Bytes
; Byte		Use
; 0 - 9		File name ("data")
; 10 - 12	File Extension ("bin", "exe", "txt")
; 13		Starting sector
; 14		File size (# of sectors the file uses) - 0x00-0xFF = 0-255
;		max file size = 255*512 = 127.5 KB
;		max data file system can handle = 255*512*255 = 31.7 MB
; 15		Reserved for ';' char to indicated end of entry
;
; Ex entry: db "          ", "   ", 0x00, 0x00, ";"

db "bootsector", "bin", 0x01, 0x01, ";"
db "kernel    ", "bin", 0x02, 0x01, ";"
db "filetable ", "txt", 0x03, 0x01, ";"
db 0

; Sector padding
times 512 - ($ - $$) db 0

