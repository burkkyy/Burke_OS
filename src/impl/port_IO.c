/*
port_IO.c is used for sending/reading data from 
data ports by using x86 instructions 'in' and 'out'

-- Size --
char: 1 byte
short: 2 byte

-- Range -- 
char: -128 to 127
short: -32768 to 32767
unsigned char: 0 to 255
unsigned short: 0 to 65535

-- x86 data port read/write example --
mov dx, 0x3f2		; Must use DX to store port address
in al, dx 		; Read contents of port ( i.e. DOR ) to AL
or al, 00001000 b 	; Switch on the motor bit
out dx, al 		; Update DOR of the device.
*/

unsigned char port_byte_in(unsigned short port) {
	/*
	A useful C wrapper func that reads a byte from 
	a specified port.

	"=a" (result) : put AL register in variable RESULT when finished
	"d" (port) : load EDX with port
	*/
	unsigned char result;
	__asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
	return result;
}

void port_byte_out(unsigned short port, unsigned char data) {
	/*
	"a" (data) : load EAX with data
	"d" (port) : load EDX with port
	*/
	__asm__("out %%al, %%dx" : :"a" (data), "d" (port));
}

unsigned short port_word_in(unsigned short port) {
	unsigned short result;
	__asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
	return result;
}

void port_word_out(unsigned short port, unsigned short data) {
	__asm__("out %%ax, %%dx" : :"a" (data), "d" (port));
}

