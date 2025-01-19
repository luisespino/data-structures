using System;
using System.Runtime.InteropServices;

class Program
{
    public unsafe class Node
    {
        public int Val;
        public Node* Next;
    }
    
    public unsafe class List
    {
        public Node* Head;

        public List()
        {
            Head = null;
        }

        public unsafe void Insert(int val)
        {
            Node* Tmp = (Node*)Marshal.AllocHGlobal(sizeof(Node));
            *Tmp = new Node{ Val = val, Next = null };
            
            if (Head == null)
            {
                Head = Tmp;
            }
            else
            {
                Tmp->Next = Head;
                Head = Tmp;
            }
        }

        public unsafe void Print()
        {
            Node* Tmp = Head;
            while (Tmp != null)
            {
                Console.Write(Tmp->Val + " ");
                Tmp = Tmp->Next;
            }
            Console.WriteLine();
        }
    }
    
    static void Main()
    {
        unsafe
        {
            List list = new List();
            list.Insert(10);
            list.Insert(20);
            list.Insert(30);
            list.Insert(40);
            
            list.Print();
        }
    }
}
