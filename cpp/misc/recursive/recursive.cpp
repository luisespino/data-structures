#include <iostream>

using namespace std;

int multi(int a, int b)
{
    if (b > 0)
        return a+multi(a, b-1);
    return 0;
}

int divi(int a, int b)
{
    if (a > 1)
        return 1+divi(a-b,b);
    return 0;
}

int factorial(int n)
{
    if (n > 1)
        return multi(n,factorial(n-1));
    return 1;
}

int fibonacci(int n)
{
    if (n > 1)
        return fibonacci(n-1) + fibonacci(n-2);
    return n;
}

int ackermann(int m, int n)
{
    if (m == 0)
        return n + 1;
    else if (n == 0)
        return ackermann(m - 1, 1);
    return ackermann(m - 1, ackermann(m, n - 1));

}

bool par(int n);
bool impar(int n);

bool par(int n)
{
    if (n == 0)
        return true;
    return impar(n - 1);
}

bool impar(int n)
{
    if (n == 0)
        return false;
    return par(n - 1);
}

int main()
{
    cout << "multi(2, 3):     " << multi(2, 3) << endl;
    cout << "divi(10, 3):     " << divi(10, 3) << endl;
    cout << "factorial(5):    " << factorial(5) << endl;
    cout << "fibonacci(8):    " << fibonacci(8) << endl;
    cout << "ackermann(3, 2): " << ackermann(3, 2) << endl;
    cout << "par(4):          " << boolalpha << par(4) << endl;
    return 0;
}