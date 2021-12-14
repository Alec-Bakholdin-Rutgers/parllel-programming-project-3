#include "password_cracker.cuh"


BYTE* get_hashed_password(const BYTE *in_cpu) {
    BYTE *out_cpu, *in_gpu, *out_gpu;
    cudaMalloc(&in_gpu, MAX_PASSWORD_LENGTH);
    cudaMemcpy(in_gpu, in_cpu, MAX_PASSWORD_LENGTH, cudaMemcpyHostToDevice);
    cudaMalloc(&out_gpu, SHA256_BLOCK_SIZE);
    cuda_single_sha256_global<<<1, 1>>>(out_gpu, in_gpu, MAX_PASSWORD_LENGTH);
    out_cpu = (BYTE*)malloc(SHA256_BLOCK_SIZE);
    cudaMemcpy(out_cpu, out_gpu, SHA256_BLOCK_SIZE, cudaMemcpyDeviceToHost);
    return out_cpu;
}

int main() {
    BYTE *cracked_pwd_gpu, *hashed_pwd_gpu, *hashed_pwd_cpu;
    cudaMalloc(&cracked_pwd_gpu, MAX_PASSWORD_LENGTH + 1);
    cudaMalloc(&hashed_pwd_gpu, SHA256_BLOCK_SIZE);
    hashed_pwd_cpu = get_hashed_password(PASSWORD_TO_HASH);
    cudaMemcpy(hashed_pwd_gpu, hashed_pwd_cpu, SHA256_BLOCK_SIZE, cudaMemcpyHostToDevice);


    unsigned long num_blocks = NUM_PASSWORDS/THREADS_PER_BLOCK/PASSWORDS_PER_THREAD;
    crack_password<<<num_blocks, THREADS_PER_BLOCK>>>(hashed_pwd_gpu, cracked_pwd_gpu);

    
    BYTE cracked_pwd_cpu[MAX_PASSWORD_LENGTH + 1];
    cudaMemcpy(cracked_pwd_cpu, cracked_pwd_gpu, MAX_PASSWORD_LENGTH + 1, cudaMemcpyDeviceToHost);
    printf("Decoded password: %s\n", cracked_pwd_cpu);

    return 0;
}