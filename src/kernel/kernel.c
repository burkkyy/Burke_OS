/*
By Caleb Burke

This file is the main kernel for my operating system.
It handles everything. kernel_enter.asm looks for
the main() func and executes it
*/

#include "ports.h"
#include "screen.h"  // All of our cool printing functions
#include "math.h"
#include "string.h"

void main() {
	print_clear();
	print_set_color(PRINT_COLOR_YELLOW, PRINT_COLOR_BLACK);
	
	char c[0xF];
	for (int i = 0; i < 0xF; i++) { c[i] = '\0'; }
	
	//unsigned int number = 0x3B9AC9FF; // max val
	unsigned int number = 0xFFFFFFFF;
	byte_array(number, c);
	print_string(c);
	print_char('\n');

	print_string("--- TOP ---\n");
	for (int i = 0; i < 0x16; i++) {
		number -= 1;
		byte_array(number, c);
		print_string(c);
		print_char(0xA);
	}
	print_string("--- BOTTOM ---");

	/*
	port_byte_out(0x3d4, 14); //Requesting byte 14: high byte of cursor pos  
    	int position = port_byte_in(0x3d5); //Data is returned in VGA data register (0x3d5) 
	position = position << 8; //high byte 
	port_byte_out(0x3d4, 15); //requesting low byte 
	position += port_byte_in(0x3d5);
	*/
	
    	/* VGA 'cells' consist of the character and its control data
	e.g. 'white on black background', 'red text on white bg', etc */
    	// int offset_from_vga = position * 2;

    	/* Let's write on the current cursor position, we already know how to do that */
    	// char* vga = (char*) 0xb8000;
    	// vga[offset_from_vga] = 'X'; 
    	// vga[offset_from_vga + 1] = 0x0f; /* White text on black background */
}

