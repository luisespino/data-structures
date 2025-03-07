using System;

class Node
{
    public int val;
    public Node izq;
    public Node der;
    public int alt;
    
    public Node(int val_)
    {
        val = val_;
        izq = null;
        der = null;
        alt = 0;
    }
}

class AVLTree
{
    public Node raiz;

    public AVLTree()
    {
        raiz = null;
    }

    public void Add(int val)
    {
        if (raiz != null)
            Add(val, ref raiz);
        else
            raiz = new Node(val);
    }

    public void Add(int val, ref Node tmp)
    {
        if (tmp == null)
            tmp = new Node(val);
        else if (val < tmp.val)
        {
            Add(val, ref tmp.izq);
            if ((Altura(tmp.izq) - Altura(tmp.der)) == 2)
            {
                if (val < tmp.izq.val)
                    tmp = Srl(tmp);
                else
                    tmp = Drl(tmp);
            }
        }
        else if (val > tmp.val)
        {
            Add(val, ref tmp.der);
            if ((Altura(tmp.der) - Altura(tmp.izq)) == 2)
            {
                if (val > tmp.der.val)
                    tmp = Srr(tmp);
                else
                    tmp = Drr(tmp);
            }
        }

        int d = Altura(tmp.der);
        int i = Altura(tmp.izq);
        int m = Maxi(d, i);
        tmp.alt = m + 1;
    }

    public int Altura(Node tmp)
    {
        if (tmp == null)
            return -1;
        else
            return tmp.alt;
    }

    public void Preorden(Node tmp)
    {
        if (tmp != null)
        {
            Console.Write(tmp.val + " ");
            Preorden(tmp.izq);
            Preorden(tmp.der);
        }
    }

    public void Enorden(Node tmp)
    {
        if (tmp != null)
        {
            Enorden(tmp.izq);
            Console.Write(tmp.val + " ");
            Enorden(tmp.der);
        }
    }

    public void Postorden(Node tmp)
    {
        if (tmp != null)
        {
            Postorden(tmp.izq);
            Postorden(tmp.der);
            Console.Write(tmp.val + " ");
        }
    }

    public Node Srl(Node t1)
    {
        Node t2 = t1.izq;
        t1.izq = t2.der;
        t2.der = t1;

        t1.alt = Maxi(Altura(t1.izq), Altura(t1.der)) + 1;
        t2.alt = Maxi(Altura(t2.izq), t1.alt) + 1;

        return t2;
    }

    public Node Srr(Node t1)
    {
        Node t2 = t1.der;
        t1.der = t2.izq;
        t2.izq = t1;

        t1.alt = Maxi(Altura(t1.izq), Altura(t1.der)) + 1;
        t2.alt = Maxi(Altura(t2.der), t1.alt) + 1;

        return t2;
    }

    public Node Drl(Node tmp)
    {
        tmp.izq = Srr(tmp.izq);
        return Srl(tmp);
    }

    public Node Drr(Node tmp)
    {
        tmp.der = Srl(tmp.der);
        return Srr(tmp);
    }

    public int Maxi(int val1, int val2)
    {
        return (val1 > val2) ? val1 : val2;
    }
}

class Program
{
    static void Main()
    {
        AVLTree t = new AVLTree();
        t.Add(5);
        t.Add(10);
        t.Add(15);
        t.Add(20);
        t.Add(25);
        t.Add(30);
        t.Add(35);

        t.Preorden(t.raiz);
        Console.WriteLine();
        
        t.Enorden(t.raiz);
        Console.WriteLine();
        
        t.Postorden(t.raiz);
        Console.WriteLine();
    }
}

