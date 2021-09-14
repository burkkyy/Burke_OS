# Burke_OS

Welcome to my first operating system! 
Currently it's only a flat binary that runs in 16bit protected mode, 
but I will eventually move up to 32bit real mode. 
Maybe even long mode.

To run the os, cd into src/bootsecter and run make.
Then either use bochs or qemu (qemu is highly recommended).

To use bochs:
run cmd bochs in src/bootsector

To use qemu:
run 'make run' in src/bootsector

TO DO:
	- Move to 32 bit real mode
	- Add a FAT filesystem
	- Add a working c cross-compilier (lmao)
	- Create a calculator app
	- Create a conways game of life simulator
	- Create some graphics display
	- Create a shell to pick which programs to run
	- Add a ext4 filesystem
	- Move to 64 bit long mode

