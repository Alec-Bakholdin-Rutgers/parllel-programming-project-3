#include "kernel.cuh"

extern "C" __global__ void test_kernel(float *out, float *a, float *b, int n) {
    int x_idx = threadIdx.x + blockIdx.x * blockDim.x;
    int y_idx = threadIdx.y + blockIdx.y * blockDim.y;
    int idx = x_idx + (gridDim.x * gridDim.y * y_idx);

    if(idx <= n) {
        out[idx] = a[idx] + b[idx];
    }
}
