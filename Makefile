WORKDIR=$(shell pwd)

entry_point:
	echo "16bit? 32bit? all?"

build/16bit/os.bin: bin/16bit/bootsector.bin bin/16bit/kernel.bin bin/16bit/file_table.bin
	mkdir -p build/16bit/
	cat $^ > $@

bin/16bit/bootsector.bin: src/16bit/bootsector/bootsector.asm
	mkdir -p bin/16bit/
	nasm -i $(WORKDIR)/src/16bit/bootsector/ $^ -f bin -o $(WORKDIR)/$@

bin/16bit/kernel.bin: src/16bit/kernel/kernel.asm
	mkdir -p bin/16bit/
	nasm -i $(WORKDIR)/src/16bit/kernel/ $^ -f bin -o $(WORKDIR)/$@

bin/16bit/file_table.bin: src/16bit/filesystem/file_table.asm
	mkdir -p bin/16bit/
	nasm -i $(WORKDIR)/src/16bit/filesystem/ $^ -f bin -o $(WORKDIR)/$@

16bit_dump: build/16bit/os.bin
	mkdir -p dump/$@/
	xxd $^ > dump/$@/$@.txt
	ndisasm -b 32 $^ > dump/$@/$@.dis

build/32bit/os.bin: bin/32bit/bootsector.bin
	mkdir -p build/32bit/
	cat $^ > $@

bin/32bit/bootsector.bin: src/32bit/boot/bootsector.asm
	mkdir -p bin/32bit/
	nasm -i $(WORKDIR)/src/32bit/boot/ $^ -f bin -o $(WORKDIR)/$@

32bit_dump: build/32bit/os.bin
	mkdir -p dump/$@/
	xxd $^ > dump/$@/$@.txt
	ndisasm -b 32 $^ > dump/$@/$@.dis

.PHONY: 16bit
16bit: build/16bit/os.bin 16bit_dump

.PHONY: 16bit_run
16bit_run: 16bit
	qemu-system-x86_64 -drive format=raw,file=build/16bit/os.bin,index=0,if=floppy

.PHONY: 32bit
32bit: build/32bit/os.bin 32bit_dump

.PHONY: 32bit_run
32bit_run: 32bit 
	qemu-system-x86_64 -drive format=raw,file=build/32bit/os.bin,index=0,if=floppy

.PHONY: clean
clean:
	rm -r bin build dump

.PHONY: all
all: 16bit 32bit

