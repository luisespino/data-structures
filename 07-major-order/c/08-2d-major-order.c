#include <stdio.h>

int main() {
    int m[4][4] = {{0, 1, 2, 3}, {4, 5, 6, 7}, {8, 9, 10, 11}, {12, 13, 14, 15}};
    int rowmajor[16];
    int colmajor[16];

    for (int i = 0; i < 4; i++)
        for (int j = 0; j < 4; j++) {
            rowmajor[j + 4 * i] = m[i][j];
            colmajor[i + 4 * j] = m[i][j];
        }

    for (int i = 0; i < 16; i++)
        printf("%d ", rowmajor[i]);
    printf("\n");

    for (int i = 0; i < 16; i++)
        printf("%d ", colmajor[i]);
    printf("\n");

    return 0;
}
