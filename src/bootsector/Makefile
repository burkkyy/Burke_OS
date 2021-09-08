# This file needs some work
os.bin: bootsector.bin kernel.bin
	cat $^ > $@

bootsector.bin: bootsector.asm
	nasm $^ -f bin -o $@

kernel.bin: kernel.asm
	nasm $^ -f bin -o $@

dump.txt: OS.bin
	xxd $^ > $@

.PHONY: run
run: os.bin
	qemu-system-x86_64 -drive format=raw,file=$^,index=0,if=floppy

.PHONY: clean
clean:
	rm *.bin

