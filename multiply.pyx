cimport numpy as np
import numpy as np

from libc.string cimport memcpy
from libc.stdlib cimport free

np.import_array()

cdef extern from "multiply.h":
    double* multiply_c(size_t n, const double *in_array, double factor)

def multiply(np.ndarray[double] in_array not None, double factor):
    cdef np.ndarray[double, mode='c'] rv = np.PyArray_EMPTY(in_array.ndim, in_array.shape, np.NPY_DOUBLE, False)

    cdef double* rv_c = multiply_c(in_array.size, <double*> np.PyArray_DATA(in_array), factor)
    memcpy(np.PyArray_DATA(rv), rv_c, sizeof(double) * in_array.size)
    free(rv_c)
    return rv


