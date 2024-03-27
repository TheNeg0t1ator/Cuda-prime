#include <stdio.h>
#include <stdbool.h>
#include "quicksort.cuh"
#include <cuda_runtime.h>
__global__ void quicksort(uint64_t arr[][1000], uint64_t low, uint64_t high);

__global__ void generatePrimes(uint64_t limit, uint64_t* primes, int * count) {
    int i = blockIdx.x * blockDim.x + threadIdx.x + 2;
    int stride = blockDim.x * gridDim.x;
    
    while (i <= limit) {
        bool isPrimeResult = true;
        
        if (i <= 1) {
            isPrimeResult = false;
        } else {
            for (int j = 2; j * j <= i; j++) {
                if (i % j == 0) {
                    isPrimeResult = false;
                    break;
                }
            }
        }
        
        

        if (isPrimeResult) {
            int index = atomicAdd(count, 1);
            primes[index] = i;
        }
        
        i += stride;
    }
}

int main() { 
    const uint64_t limit = 100000000;
    int blockSize = 256;
    int gridSize = (limit - 2 + blockSize - 1) / blockSize;
    
    uint64_t * primes;
    int * count;
    cudaMallocManaged(&primes, limit * sizeof(uint64_t));
    cudaMallocManaged(&count, sizeof(int));
    *count = 0;
    
    generatePrimes<<<gridSize, blockSize>>>(limit, primes, count);
    cudaDeviceSynchronize();

    remove("output.txt");
    // Open the output file in append mode
    FILE* outputFile = fopen("output.txt", "a+");
    if (outputFile == NULL) {
        printf("Failed to open the output file.\n");
        return 1;
    }
    uint64_t size = *count;
    
    const int primesPerThread = 1000;
    const int numberOfThreads = limit/primesPerThread;

    uint64_t splitprimes[numberOfThreads][primesPerThread];

    for (int i = 0; i < numberOfThreads; i++) { 
        for (int j = 0; j < primesPerThread; j++) {// 1000 is the number of primes in a thread
            splitprimes[i][j] = primes[i * primesPerThread + j];       
        }
    }

    //todo sort the array in parallel
    quicksort_kernel<<<gridSize, blockSize>>>(splitprimes, 0, size - 1);
    // Print the prime numbers to the output file
    for (int i = 0; i < *count; i++) {
        fprintf(outputFile, "%lu\n", primes[i]);
    }
    
    // Close the output file
    fclose(outputFile);
    
    cudaFree(primes);
    cudaFree(count);

    return 0;
}
