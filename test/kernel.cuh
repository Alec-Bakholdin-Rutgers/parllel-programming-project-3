#ifndef KERNEL_H
#define KERNEL_H
extern "C" __global__ void test_kernel(float *out, float *a, float *b, int n);
#endif