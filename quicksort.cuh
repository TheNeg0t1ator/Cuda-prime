#include <cstdint>

void swap(uint64_t& a, uint64_t& b) {
    uint64_t temp = a;
    a = b;
    b = temp;
}

int partition(uint64_t arr[], int low, int high) {
    uint64_t pivot = arr[high];
    int i = low - 1;

    for (int j = low; j <= high - 1; j++) {
        if (arr[j] < pivot) {
            i++;
            swap(arr[i], arr[j]);
        }
    }

    swap(arr[i + 1], arr[high]);
    return i + 1;
}

void quicksort(uint64_t arr[], int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);

        quicksort(arr, low, pi - 1);
        quicksort(arr, pi + 1, high);
    }
}
