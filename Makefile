CC = /home/caleb/Documents/toolchains/i386-elf-11.1.0-Linux-x86_64/bin/i386-elf-gcc
LINKER = /home/caleb/Documents/toolchains/i386-elf-11.1.0-Linux-x86_64/bin/i386-elf-ld

c_source_files = $(wildcard src/kernel/*.c src/drivers/*.c src/impl/*.c)
c_object_files := $(patsubst src/%.c,obj/%.o,$(c_source_files))

build/os.bin: bin/bootloader.bin bin/kernel.bin
	@mkdir -p $(dir $@) && \
	cat $^ > $@

bin/bootloader.bin: src/boot/bootsector.asm
	@mkdir -p $(dir $@) && \
	nasm -i $(dir $<) $^ -f bin -o $@

bin/kernel.bin: obj/kernel_entry.o $(c_object_files)
	@mkdir -p $(dir $@) && \
	$(LINKER) -Ttext 0x1000 $^ --oformat binary -o $@

obj/kernel_entry.o: src/kernel/kernel_entry.asm
	@mkdir -p $(dir $@) && \
	nasm -i $(dir $<) $^ -f elf -o $@

$(c_object_files): $(c_source_files)
	@mkdir -p $(dir $@) && \
	$(CC) -c -I src/intf -ffreestanding $(patsubst obj/%.o,src/%.c,$@) -o $@

.PHONY: run
run: build/os.bin
	qemu-system-i386 -drive format=raw,file=build/os.bin,index=0,if=floppy

.PHONY: clean
clean:
	rm -r bin obj build

