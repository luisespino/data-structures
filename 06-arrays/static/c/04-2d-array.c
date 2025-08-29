#include <stdio.h>

int main()
{
    int a[5][5];
    int v = 0;

    for (int i = 0; i < 5; i++)
        for (int j = 0; j < 5; j++)
            a[i][j] = v++;

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++)
            printf("%02d ", a[i][j]);
        printf("\n");
    }

    return 0;
}
