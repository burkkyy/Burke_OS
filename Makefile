WORKDIR = $(shell pwd)
CC = /home/caleb/Documents/toolchains/i386-elf-11.1.0-Linux-x86_64/bin/i386-elf-gcc
LINKER = /home/caleb/Documents/toolchains/i386-elf-11.1.0-Linux-x86_64/bin/i386-elf-ld

all: build/os.bin dump

dump: build/os.bin
	mkdir -p dump/
	xxd $^ > dump/$@.txt
	ndisasm -b 32 $^ > dump/$@.dis

build/os.bin: bin/bootloader.bin bin/kernel.bin
	mkdir -p build/
	cat $^ > $@

bin/bootloader.bin: src/bootloader/bootsector.asm
	mkdir -p bin/
	nasm -i $(WORKDIR)/src/bootloader/ $^ -f bin -o $(WORKDIR)/$@

bin/kernel.bin: obj/kernel_entry.o obj/kernel.o
	mkdir -p bin/
	$(LINKER) -Ttext 0x1000 $^ --oformat binary -o $@
	# idk why it no work
	# dd if=/dev/null of=$@ bs=1 count=1 seek=512

obj/kernel.o: src/kernel/kernel.c
	mkdir -p obj/
	$(CC) -ffreestanding -c $^ -o $@

obj/kernel_entry.o: src/kernel/kernel_entry.asm
	mkdir -p obj/
	nasm -i $(WORKDIR)/src/kernel/ $^ -f elf -o $(WORKDIR)/$@
	
.PHONY: run
run: all
	# qemu-system-i386 -drive format=raw,file=build/os.bin,index=0,if=floppy
	qemu-system-i386 -fda build/os.bin

.PHONY: clean
clean:
	rm -r bin build dump obj
# dd if=/dev/null of=filename bs=1 count=1 seek=512

