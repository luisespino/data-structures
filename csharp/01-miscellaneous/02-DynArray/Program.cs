using System;
using System.Runtime.InteropServices;

class Program
{
    static void Main()
    {
        Console.Write("Enter size: ");
        int n = int.Parse(Console.ReadLine());

        IntPtr a = Marshal.AllocHGlobal(n * sizeof(int));

        for (int i = 0; i < n; i++)
        {
            Marshal.WriteInt32(a, i * sizeof(int), i);
        }

        for (int i = 0; i < n; i++)
        {
            int value = Marshal.ReadInt32(a, i * sizeof(int));
            Console.WriteLine(value);
        }

        Marshal.FreeHGlobal(a);
    }
}

