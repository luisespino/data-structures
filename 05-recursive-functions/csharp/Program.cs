using System;

class Program
{
    static int Multi(int a, int b)
    {
        if (b > 0)
            return a + Multi(a, b - 1);
        return 0;
    }

    static int Divi(int a, int b)
    {
        if (a > 1)
            return 1 + Divi(a - b, b);
        return 0;
    }

    static int Factorial(int n)
    {
        if (n > 1)
            return Multi(n, Factorial(n - 1));
        return 1;
    }

    static int Fibonacci(int n)
    {
        if (n > 1)
            return Fibonacci(n - 1) + Fibonacci(n - 2);
        return n;
    }

    static int Ackermann(int m, int n)
    {
        if (m == 0)
            return n + 1;
        else if (n == 0)
            return Ackermann(m - 1, 1);
        return Ackermann(m - 1, Ackermann(m, n - 1));
    }

    static bool Par(int n)
    {
        if (n == 0)
            return true;
        return Impar(n - 1);
    }

    static bool Impar(int n)
    {
        if (n == 0)
            return false;
        return Par(n - 1);
    }

    static void Main()
    {
        Console.WriteLine("multi(2, 3):     " + Multi(2, 3));
        Console.WriteLine("divi(10, 3):     " + Divi(10, 3));
        Console.WriteLine("factorial(5):    " + Factorial(5));
        Console.WriteLine("fibonacci(8):    " + Fibonacci(8));
        Console.WriteLine("ackermann(3, 2): " + Ackermann(3, 2));
        Console.WriteLine("par(4):          " + Par(4));
    }
}

