using System;

class Program
{
    static void Main()
    {
        int ini = 0, fin = 99, pos = 0, itera = 0, valor = 76;
        int[] a = new int[fin + 1];

        for (int i = 0; i <= fin; i++)
        {
            a[i] = i;
        }

        while (ini <= fin)
        {
            itera++;
            pos = (fin - ini) / 2 + ini;
            if (a[pos] == valor)
            {
                Console.WriteLine($"{itera} iterations");
                break;
            }
            else if (valor < a[pos])
            {
                fin = pos - 1;
            }
            else
            {
                ini = pos + 1;
            }
        }
    }
}
