/*
By Caleb Burke

This file is the main kernel for my operating system.
It handles everything. kernel_enter.asm looks for
the main() func and executes it
*/

#include "screen.h"  // All of our cool printing functions

void main() {
	print_clear();
	print_set_color(PRINT_COLOR_YELLOW, PRINT_COLOR_BLACK);
	for (int i = 0; i < 5; i++){
		print_string("Hello\n");
	}
}

