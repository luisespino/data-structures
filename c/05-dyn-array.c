#include <stdio.h>
#include <stdlib.h>

int main()
{
    int n;
    printf("Enter size: ");
    scanf("%d", &n);

    int *a = (int *)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++)
        a[i] = i;

    for (int i = 0; i < n; i++)
        printf("%d \n", a[i]);

    free(a);

    return 0;
}
