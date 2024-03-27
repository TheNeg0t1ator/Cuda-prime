#include <stdio.h>
#include <stdint.h>

__device__ void swap(uint64_t* a, uint64_t* b); // Forward declaration

__device__ uint64_t partition(uint64_t arr[], uint64_t low, uint64_t high) {
    uint64_t pivot = arr[high];
    uint64_t i = low - 1;

    for (uint64_t j = low; j <= high - 1; j++) {
        if (arr[j] < pivot) {
            i++;
            swap(&arr[i], &arr[j]); // Pass pointers to swap function
        }
    }

    swap(&arr[i + 1], &arr[high]); // Pass pointers to swap function
    return i + 1;
}

__device__ void swap(uint64_t* a, uint64_t* b) { // Modified swap function
    uint64_t temp = *a;
    *a = *b;
    *b = temp;
}

__device__ void quicksort(uint64_t arr[][1000], uint64_t low, uint64_t high)

__global__ void quicksort_kernel(uint64_t arr[][1000], uint64_t low, uint64_t high) {
    int threadId = threadIdx.x;
    int gridSize = gridDim.x;
    uint64_t* threadArr = arr[threadId];

    if (threadId >= gridSize) {
        threadId -= gridSize;
        threadArr = arr[threadId];
    }

    if (low < high) {
        uint64_t pi = partition(threadArr, low, high);

        quicksort(arr, low, pi - 1);
        quicksort(arr, pi + 1, high);
    }
}



__device__ void quicksort(uint64_t arr[][1000], uint64_t low, uint64_t high) {
    int threadId = threadIdx.x;
    int gridSize = gridDim.x;
    uint64_t* threadArr = arr[threadId];

    if (threadId >= gridSize) {
        threadId -= gridSize;
        threadArr = arr[threadId];
    }

    if (low < high) {
        uint64_t pi = partition(threadArr, low, high);

        quicksort(arr, low, pi - 1);
        quicksort(arr, pi + 1, high);
    }
}