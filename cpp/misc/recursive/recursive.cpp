#include <iostream>

using namespace std;

int multi(int a, int b)
{
    if (b>0)
        return a+multi(a, b-1);
    return 0;
}

int divi(int a, int b)
{
    if (a>1)
        return 1+divi(a-b,b);
    return 0;
}

int factorial(int n)
{
    if (n>1)
        return multi(n,factorial(n-1));
    return 1;
}

int main()
{
    cout << multi(2, 3) << endl;
    cout << divi(10, 3) << endl;
    cout << factorial(5) << endl;
}