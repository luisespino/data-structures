using System;
using System.Runtime.InteropServices;

class Program
{
    unsafe static void Main(string[] args)
    {
        // Stack variable
        int stackVar = 10;
        Console.WriteLine($"Stack value: {stackVar}");

        // Heap variable using Marshal
        int* heapVar = (int*)Marshal.AllocHGlobal(sizeof(int));
        *heapVar = 20;
        Console.WriteLine($"Heap value: { *heapVar }");

        // Free allocated memory
        Marshal.FreeHGlobal((IntPtr)heapVar);
    }
}
