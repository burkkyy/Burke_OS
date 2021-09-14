WORKDIR=$(shell pwd)

do: build/16bit/os.bin dump

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

dump: build/16bit/os.bin
	mkdir -p $@
	xxd $^ > $@/$@.txt
	ndisasm -b 32 $^ > $@/$@.dis

.PHONY: 16bit
16bit: do
	qemu-system-x86_64 -drive format=raw,file=build/16bit/os.bin,index=0,if=floppy

.PHONY: run
run: do
	qemu-system-x86_64 -drive format=raw,file=build/16bit/os.bin,index=0,if=floppy

.PHONY: clean
clean:
	rm -r bin build dump

