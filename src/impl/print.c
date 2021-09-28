#include "screen.h"

// Yes, I have create my own char data type
struct Char {
	uint8_t character;
	uint8_t color;
};

// Formula for calculating mem pos of char in video buffer: col# + #_OF_COLS * row#
struct Char* buffer = (struct Char*) VIDEO_ADDRESS;
size_t col = 0;  // Store current col pos
size_t row = 0;  // Store current row pos
uint8_t color = PRINT_COLOR_WHITE | PRINT_COLOR_BLACK << 4;

void clear_row(size_t row) {
	struct Char empty = (struct Char){
		character: ' ',
		color: color,
	};

	for (size_t col = 0; col < NUM_COLS; col++){
		buffer[col + NUM_COLS * row] = empty;
	}
}

void print_clear() {
	for (size_t i = 0; i < NUM_ROWS; i ++){ 
		clear_row(i); 
	}
}

void print_new_line() {
	col = 0;

	if (row < NUM_ROWS - 1) {
		row++;
		return;
	}

	for (size_t row = 1; row < NUM_ROWS; row++) {
		for (size_t col = 0; col < NUM_COLS; col++) {
			struct Char character = buffer[col + NUM_COLS * row];
			buffer[col + NUM_COLS * (row - 1)] = character;
		}
	}

	clear_row(NUM_COLS - 1);
}

void print_char(char character) {
	// First check if the char is a new line char
	if (character == '\n') {
		print_new_line();
		return;
	}

	// Check if we have room to print a char in our current column pos
	if (col > NUM_COLS) {
		print_new_line();
	}
	
	// Set the appropriate buffer pos equal to the char we wish to print
	buffer[col + NUM_COLS * row] = (struct Char){
		character: (uint8_t) character,
		color: color,
	};
	
	// increment the current col pos as our char is occupying it
	col++;
}

void print_string(char* string) {
	for (size_t i = 0; 1; i++) {
		char character = (uint8_t) string[i];
		if (character == '\0') { return; }
		print_char(character);
	}
}

void print_set_color(uint8_t foreground, uint8_t background) {
	color = foreground + (background << 4);
}

