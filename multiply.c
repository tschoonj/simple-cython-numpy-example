#include "multiply.h"
#include <stdlib.h>


double* multiply_c(size_t n, const double *in_array, double factor) {
	size_t i;
	double *rv = malloc(sizeof(double) * n);
	
	for (i = 0 ; i < n ; i++)
		rv[i] = in_array[i] * factor;
	return rv;
}
