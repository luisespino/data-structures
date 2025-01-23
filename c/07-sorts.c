#include <stdio.h>

void displayArray(int a[], int size) {
    printf("[");
    for (int i = 0; i < size; i++) {
        printf("%d ", a[i]);
    }
    printf("]\n");
}

void bubbleSort(int a[], int size) {
    int iter = 0;
    int aux;
    for (int i = 0; i < size - 1; i++) {
        for (int j = i + 1; j < size; j++) {
            if (a[i] > a[j]) {
                aux = a[i];
                a[i] = a[j];
                a[j] = aux;
                displayArray(a, size);
                // iter++; // Uncomment if you want to track iterations
            }
        }
    }
    // printf("%d", iter); // Uncomment if you want to display the number of iterations
}

void selectionSort(int a[], int size) {
    int iter = 0;
    int min, aux;
    for (int i = 0; i < size - 1; i++) {
        min = i;
        for (int j = i + 1; j < size; j++) {
            // iter++; // Uncomment if you want to track iterations
            if (a[min] > a[j]) {
                min = j;
            }
        }
        aux = a[i];
        a[i] = a[min];
        a[min] = aux;
    }
    // printf("%d", iter); // Uncomment if you want to display the number of iterations
}

void insertionSort(int a[], int size) {
    int iter = 0;
    int aux, j;
    for (int i = 0; i < size; i++) {
        j = i;
        aux = a[i];
        while (j > 0 && a[j - 1] > aux) {
            a[j] = a[j - 1];
            j--;
            // iter++; // Uncomment if you want to track iterations
        }
        a[j] = aux;
    }
    // printf("%d", iter); // Uncomment if you want to display the number of iterations
}

void quickSort(int a[], int first, int last) {
    int iter = 0;
    int pivot, aux;
    int i = first, j = last;
    int center = (first + last) / 2;
    pivot = a[center];

    do {
        while (a[i] < pivot) i++;
        while (a[j] > pivot) j--;
        if (i <= j) {
            aux = a[i];
            a[i] = a[j];
            a[j] = aux;
            i++;
            j--;
            // iter++; // Uncomment if you want to track iterations
            displayArray(a, 5); // This line can be used to display the array at each iteration
        }
    } while (i <= j);

    if (first < j)
        quickSort(a, first, j);
    if (i < last)
        quickSort(a, i, last);

    // printf("%d", iter); // Uncomment if you want to display the number of iterations
}

int main() {
    int a[] = {17, 10, 12, 7, 11};
    int size = sizeof(a) / sizeof(a[0]);
    
    displayArray(a, size);
    bubbleSort(a, size); 
    displayArray(a, size);

    return 0;
}
