#include "kernel.cuh"
#include <stdio.h>

#define ARR_LEN 32

int main() {
    float *a_gpu, *b_gpu, *out_gpu, *a_cpu, *b_cpu, *out_cpu;

    a_cpu = (float *)malloc(sizeof(float) * ARR_LEN);
    b_cpu = (float *)malloc(sizeof(float) * ARR_LEN);
    for(int i = 0; i < ARR_LEN; i++) {
        a_cpu[i] = ((float)rand())/(float)(RAND_MAX/10);
        b_cpu[i] = ((float)rand())/(float)(RAND_MAX/10);
    }

    cudaMalloc(&a_gpu, sizeof(float)*ARR_LEN);
    cudaMalloc(&b_gpu, sizeof(float)*ARR_LEN);
    cudaMalloc(&out_gpu, sizeof(float)*ARR_LEN);
    cudaMemcpy(a_gpu, a_cpu, sizeof(float)*ARR_LEN, cudaMemcpyHostToDevice);
    cudaMemcpy(b_gpu, b_cpu, sizeof(float)*ARR_LEN, cudaMemcpyHostToDevice);

    int threads_x = 8;
    test_kernel<<<threads_x, ARR_LEN/threads_x + 1>>>(out_gpu, a_gpu, b_gpu, ARR_LEN);
    out_cpu = (float *)malloc(sizeof(float)*ARR_LEN);
    cudaMemcpy(out_cpu, out_gpu, sizeof(float)*ARR_LEN, cudaMemcpyDeviceToHost);   

    printf("%6s%6s%6s\n", "a", "b", "out");
    for(int i = 0; i < ARR_LEN; i++) {
        printf("%6.1f%6.1f%6.1f\n", a_cpu[i], b_cpu[i], out_cpu[i]);
    }
}