#include <stdint.h>
#include <stddef.h>

void swap(uint64_t * a, uint64_t * b) {
    uint64_t t = *a;
    *a = *b;
    *b = t;
}

uint64_t partition(uint64_t array[], uint64_t low, uint64_t high) {

    uint64_t pivot = array[high];
    uint64_t i = (low - 1);

    for (uint64_t j = low; j < high; j++) {
        if (array[j] <= pivot) {
            i++;
            swap(&array[i], &array[j]);
        }
    }

    swap(&array[i + 1], &array[high]);
    return (i + 1);
}

void quickSort(uint64_t array[], uint64_t low, uint64_t high) {
    if (low < high) {

        uint64_t pi = partition(array, low, high);

        quickSort(array, low, pi - 1);

        quickSort(array, pi + 1, high);
    }
}