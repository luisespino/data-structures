#include <stdio.h>

int main() {
    int m[2][2][2] = {{{0, 1}, {2, 3}}, {{4, 5}, {6, 7}}};
    int rowmajor[8];
    int colmajor[8];

    for (int k = 0; k < 2; k++) {
        printf("array: %d\n", k);
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                printf("%d ", m[k][i][j]);
                rowmajor[j + 2 * (i + 2 * k)] = m[k][i][j];
                colmajor[i + 2 * (j + 2 * k)] = m[k][i][j];
            }
            printf("\n");
        }
    }

    printf("Row Major 3D:\n");
    for (int i = 0; i < 8; i++)
        printf("%d ", rowmajor[i]);
    printf("\n");

    printf("Col Major 3D:\n");
    for (int i = 0; i < 8; i++)
        printf("%d ", colmajor[i]);
    printf("\n");

    return 0;
}
