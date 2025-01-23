#include <stdio.h>

int main()
{
    int *a, b, **c, *d;
    b = 10;
    a = &b;
    c = &a;
    d = a;

    printf("b %d\n", b);
    printf("&b %p\n", (void*)&b);
    printf("a %p\n", (void*)a);
    printf("&a %p\n", (void*)&a);
    printf("*a %d\n", *a);
    printf("c %p\n", (void*)c);
    printf("&c %p\n", (void*)&c);
    printf("*c %p\n", (void*)*c);
    printf("**c %d\n", **c);
    printf("*&c %p\n", (void*)*&c);
    printf("&*c %p\n", (void*)&*c);
    printf("d %p\n", (void*)d);
    printf("&d %p\n", (void*)&d);
    printf("*d %d\n", *d);

    return 0;
}
