using System;

class Hash
{
    public int n, m;
    public int[] h;
    public int min, max;

    public Hash(int m, int min, int max)
    {
        this.m = m;
        this.min = min;
        this.max = max;
        Init();
    }

    public int Division(int k)
    {
        return k % m;
    }

    public int Linear(int k)
    {
        return (k + 1) % m;
    }

    public void Init()
    {
        n = 0;
        h = new int[m];
        for (int i = 0; i < m; i++)
            h[i] = -1;
    }

    public void Insert(int k)
    {
        int i = Division(k);
        while (h[i] != -1)
            i = Linear(i);
        h[i] = k;
        n++;
        Rehashing();
    }

    public void Rehashing()
    {
        if ((n * 100 / m) >= max)
        {
            // Array copy
            int[] temp = new int[m];
            Array.Copy(h, temp, m);
            Print();

            // Rehashing
            int mprev = m;
            m = n * 100 / min;
            Init();
            for (int i = 0; i < mprev; i++)
                if (temp[i] != -1)
                    Insert(temp[i]);
        }
        else
        {
            Print();
        }
    }

    public void Print()
    {
        Console.Write("[");
        for (int i = 0; i < m; i++)
            Console.Write(" " + h[i]);
        Console.WriteLine(" ] " + (n * 100 / m) + "%");
    }
}

class Program
{
    static void Main()
    {
        Hash hash = new Hash(5, 20, 80); // m, min, max
        hash.Insert(5);
        hash.Insert(10);
        hash.Insert(15);
        hash.Insert(20);
        hash.Insert(25);
        hash.Insert(30);
    }
}

