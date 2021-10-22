#include "math.h"

long pow(int x, int n) {
	if (n == 0) { return 1; }
	long temp = x;
	for (int i = 0; i < n - 1; i++){ temp *= x; }
	return temp;
}
