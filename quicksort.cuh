#include <stdio.h>
#include <stdint.h>

void swap(uint64_t* a, uint64_t* b); // Forward declaration

uint64_t partition(uint64_t arr[], uint64_t low, uint64_t high) {
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

void swap(uint64_t* a, uint64_t* b) { // Modified swap function
    uint64_t temp = *a;
    *a = *b;
    *b = temp;
}

void quicksort(uint64_t arr[], uint64_t low, uint64_t high) {
    if (low < high) {
        uint64_t pi = partition(arr, low, high);

        quicksort(arr, low, pi - 1);
        quicksort(arr, pi + 1, high);
    }
}