#include <stdio.h>

int main() {
    int m[2][2][2] = {
        { {0, 1}, {2, 3} },
        { {4, 5}, {6, 7} }
    };
    int rowmajor[8];
    int colmajor[8];
    int i, j, k; // depth, row, col

    for (i = 0; i < 2; i++) {
        for (j = 0; j < 2; j++) {
            for (k = 0; k < 2; k++) {
                rowmajor[k + 2 * (j + 2 * i)] = m[i][j][k];
                colmajor[i + 2 * (j + 2 * k)] = m[i][j][k];
            }
        }
    }

    printf("Row-major: ");
    for (i = 0; i < 8; i++) {
        printf("%d ", rowmajor[i]);
    }
    printf("\n");

    printf("Col-major: ");
    for (i = 0; i < 8; i++) {
        printf("%d ", colmajor[i]);
    }
    printf("\n");

    return 0;
}
