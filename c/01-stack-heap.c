#include <stdio.h>
#include <stdlib.h>

int main() {
    int stackVar = 10;
    printf("Stack value: %d\n", stackVar);

    int *heapVar = (int *)malloc(sizeof(int));
    *heapVar = 20;
    printf("Heap value: %d\n", *heapVar);
    free(heapVar);

    return 0;
}