using System;

class Program
{
    static void DisplayArray(int[] a)
    {
        Console.Write("[");
        for (int i = 0; i < a.Length; i++)
        {
            Console.Write(a[i] + " ");
        }
        Console.WriteLine("]");
    }

    static void BubbleSort(int[] a)
    {
        int aux;
        for (int i = 0; i < a.Length - 1; i++)
        {
            for (int j = i + 1; j < a.Length; j++)
            {
                if (a[i] > a[j])
                {
                    aux = a[i];
                    a[i] = a[j];
                    a[j] = aux;
                    DisplayArray(a); // Display array after each swap
                }
            }
        }
    }

    static void SelectionSort(int[] a)
    {
        int min, aux;
        for (int i = 0; i < a.Length - 1; i++)
        {
            min = i;
            for (int j = i + 1; j < a.Length; j++)
            {
                if (a[min] > a[j])
                {
                    min = j;
                }
            }
            aux = a[i];
            a[i] = a[min];
            a[min] = aux;
        }
    }

    static void InsertionSort(int[] a)
    {
        int aux, j;
        for (int i = 0; i < a.Length; i++)
        {
            j = i;
            aux = a[i];
            while (j > 0 && a[j - 1] > aux)
            {
                a[j] = a[j - 1];
                j--;
            }
            a[j] = aux;
        }
    }

    static void QuickSort(int[] a, int first, int last)
    {
        int pivot, aux;
        int i = first, j = last;
        int center = (first + last) / 2;
        pivot = a[center];

        do
        {
            while (a[i] < pivot) i++;
            while (a[j] > pivot) j--;
            if (i <= j)
            {
                aux = a[i];
                a[i] = a[j];
                a[j] = aux;
                i++;
                j--;
                DisplayArray(a); // Display array during quicksort
            }
        } while (i <= j);

        if (first < j)
            QuickSort(a, first, j);
        if (i < last)
            QuickSort(a, i, last);
    }

    static void Main()
    {
        int[] a = { 17, 10, 12, 7, 11 };
        
        DisplayArray(a);
        BubbleSort(a);
        DisplayArray(a);
    }
}

