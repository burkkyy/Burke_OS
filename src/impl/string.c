#include "math.h"
#include "string.h"

/* Testing Code
#include <stdio.h>
#include <math.h>

void byte_array(int num, char* buff, int size);
int len(int i);

int main() {
	int b = 123456789;
	int size = len(b);
	char a[size + 1];

	byte_array(b, a, size);
	printf("%d\n", b);
	printf("%s\n", a);
	printf("Done\n");
	return 0;
}
*/

// Get the # of digits in a int
int len(int i) {
	int count = 0;
	int num = i;

	do {
		num /= 10;
		count++;
	} while (num != 0);
	return count;
}

// Convert int to char array with null terminator
void byte_array(int num, char* buff) {
	int size = len(num);
	int b = num;

	// Itterate through the string and append the ASCII of the 'i' digit into the buff
	for (int i = 0; i < size; i++) {
		// for (int j = 0; j < i; j++){ b /= 10; }
		b /= powers_of_10[i];
		b %= 10;
		//b = (num % powers_of_10[i + 1]) / powers_of_10[i];
		buff[size - i - 1] = b + 48;
		b = num;
	}
	//buff[0] = num / powers_of_10[i] + 48;
}

