WORKDIR=$(shell pwd)

build/os.bin: bin/bootsector.bin bin/kernel.bin
	mkdir -p build
	cat $^ > $@

bin/bootsector.bin: bootsector/bootsector.asm
	mkdir -p bin
	nasm -i $(WORKDIR)/bootsector/ $^ -f bin -o $(WORKDIR)/$@

bin/kernel.bin: kernel/kernel.asm
	mkdir -p bin
	nasm -i $(WORKDIR)/bootsector/ $^ -f bin -o $(WORKDIR)/$@

.PHONY: run
run: build/os.bin
	qemu-system-x86_64 -drive format=raw,file=$^,index=0,if=floppy

.PHONY: dump
dump.txt: build/os.bin
	xxd $^ > $@

.PHONY: clean
clean:
	rm -r bin
	rm -r build

