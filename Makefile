WORKDIR=$(shell pwd)

build/os.bin: bin/bootsector.bin bin/kernel.bin
	mkdir -p build
	cat $^ > $@

bin/bootsector.bin: src/bootsector/bootsector.asm
	mkdir -p bin
	nasm -i $(WORKDIR)/src/bootsector/ $^ -f bin -o $(WORKDIR)/$@

bin/kernel.bin: src/kernel/kernel.asm
	mkdir -p bin
	nasm -i $(WORKDIR)/src/kernel/ $^ -f bin -o $(WORKDIR)/$@

.PHONY: run
run: build/os.bin
	qemu-system-x86_64 -drive format=raw,file=$^,index=0,if=floppy

.PHONY: dump
dump: build/os.bin
	mkdir -p dump
	xxd $^ > dump/$@.txt
	ndisasm -b 32 $^ > dump/$@.dis

.PHONY: clean
clean:
	rm -r bin
	rm -r build
	rm -r dump

