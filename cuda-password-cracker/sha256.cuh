/*
 * sha256.cuh CUDA Implementation of SHA256 Hashing    
 *
 * Date: 12 June 2019
 * Revision: 1
 * 
 * Based on the public domain Reference Implementation in C, by
 * Brad Conte, original code here:
 *
 * https://github.com/B-Con/crypto-algorithms
 *
 * This file is released into the Public Domain.
 */


#ifndef SHA256_H
#define SHA256_H
#include "config.h"
extern "C" __global__ void crack_password(BYTE* hashed_password, BYTE* cracked_password);
extern "C" __global__ void cuda_single_sha256_global(BYTE *out, BYTE *in, WORD inlen);
#endif
