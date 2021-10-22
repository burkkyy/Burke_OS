#include "math.h"
#include "string.h"

// Get the # of digits in a int
int len(int i) {
	int count = 0;
	unsigned int num = i;
	do { num /= 10; count++; }
	while (num != 0);
	return count;
}

// Convert int to char array with null terminator
void byte_array(unsigned int num, char* buff) {
	int size = len(num);
	unsigned int b = num;

	// Itterate append the ASCII of the 'i'th digit into the buff (char array)
	for (int i = 0; i < size; i++) {
		b /= powers_of_10[i];
		b %= 10;
		buff[size - i - 1] = b + 48;
		b = num;
		// Old method, it worked but slow
		// b = (num % powers_of_10[i + 1]) / powers_of_10[i];
	}
}

