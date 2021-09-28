CC = /home/caleb/Documents/toolchains/i386-elf-11.1.0-Linux-x86_64/bin/i386-elf-gcc
LINKER = /home/caleb/Documents/toolchains/i386-elf-11.1.0-Linux-x86_64/bin/i386-elf-ld

kernel_source_files := $(shell find src/kernel -name *.c)
kernel_object_files := $(patsubst src/kernel/%.c, obj/kernel/%.o, $(kernel_source_files))

c_source_files := $(shell find src/impl -name *.c)
c_object_files := $(patsubst src/impl/%.c, obj/impl/%.o, $(c_source_files))

build/os.bin: bin/bootloader.bin bin/kernel.bin
	mkdir -p $(dir $@) && \
	cat $^ > $@

bin/bootloader.bin: src/boot/bootsector.asm
	mkdir -p $(dir $@) && \
	nasm -i $(dir $<) $^ -f bin -o $@

bin/kernel.bin: obj/kernel_entry.o $(kernel_object_files) $(c_object_files)
	mkdir -p $(dir $@) && \
	$(LINKER) -Ttext 0x1000 $^ --oformat binary -o $@
	# dd if=/dev/null of=$@ bs=1 count=1 seek=512

obj/kernel_entry.o: src/kernel/kernel_entry.asm
	mkdir -p $(dir $@) && \
	nasm -i $(dir $<) $^ -f elf -o $@

$(kernel_object_files): obj/kernel/%.o : src/kernel/%.c
	mkdir -p $(dir $@) && \
	$(CC) -c -I src/intf -ffreestanding $(patsubst obj/kernel/%.o, src/kernel/%.c, $@) -o $@

$(c_object_files): obj/impl/%.o : src/impl/%.c
	mkdir -p $(dir $@) && \
	$(CC) -c -I src/intf -ffreestanding $(patsubst obj/impl/%.o, src/impl/%.c, $@) -o $@

.PHONY: run
run: build/os.bin
	qemu-system-i386 -drive format=raw,file=build/os.bin,index=0,if=floppy

.PHONY: clean
clean:
	rm -r bin obj build

