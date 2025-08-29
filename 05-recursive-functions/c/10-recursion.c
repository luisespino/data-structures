#include <stdio.h>
#include <stdbool.h>

int multi(int a, int b) {
    if (b > 0) 
        return a + multi(a, b-1);
    return 0;
}

int divi(int a, int b) {
    if (a > 1)
        return 1 + divi(a-b, b);
    return 0;
}

int factorial(int n) {
    if (n > 1)
        return n * factorial(n-1);
    return 1;
}

int fibonacci(int n) {
    if (n > 1)
        return fibonacci(n-1) + fibonacci(n-2);
    return n;
}

int ackermann(int m, int n) {
    if (m == 0)
        return n + 1;
    else if (n == 0)
        return ackermann(m-1, 1);
    else
        return ackermann(m-1, ackermann(m, n-1));
}


bool odd(int n);
bool even(int n);

bool even(int n) {
    if (n == 0)
        return true;
    return odd(n - 1);
}

bool odd(int n) {
    if (n == 0)
        return false;
    return even(n - 1);
}

int main() {
    printf("3*2     : %d\n", multi(3, 2));
    printf("6/3     : %d\n", divi(6, 3));
    printf("fact(5) : %d\n", factorial(5));
    printf("fibo(5) : %d\n", fibonacci(5));
    printf("ack(2,2): %d\n", ackermann(2, 2));
    printf("even(3): %d\n", even(3));
    printf("odd(3)  : %d\n", odd(3));
    return 0;
}
