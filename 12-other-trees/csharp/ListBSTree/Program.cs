using System;

class NodeList
{
    public string Value;
    public NodeList Next;

    public NodeList(string value)
    {
        Value = value;
        Next = null;
    }
}

class List
{
    public NodeList Head;

    public List()
    {
        Head = null;
    }

    public void Add(string value)
    {
        NodeList tmp = new NodeList(value);
        tmp.Next = Head;
        Head = tmp;
    }

    public void Show()
    {
        Console.Write("[ ");
        NodeList tmp = Head;
        while (tmp != null)
        {
            Console.Write(tmp.Value + " ");
            tmp = tmp.Next;
        }
        Console.WriteLine("]");
    }
}

class Node
{
    public int Value;
    public List List;
    public Node Left;
    public Node Right;

    public Node(int value, List list)
    {
        Value = value;
        List = list;
        Left = null;
        Right = null;
    }
}

class BSTree
{
    public Node Root;

    public BSTree()
    {
        Root = null;
    }

    public void Add(int value, List list)
    {
        Root = _Add(value, list, Root);
    }

    private Node _Add(int value, List list, Node tmp)
    {
        if (tmp == null)
        {
            return new Node(value, list);
        }
        else if (value > tmp.Value)
        {
            tmp.Right = _Add(value, list, tmp.Right);
        }
        else
        {
            tmp.Left = _Add(value, list, tmp.Left);
        }
        return tmp;
    }

    public void Show()
    {
        _Show(Root);
    }

    private void _Show(Node tmp)
    {
        if (tmp != null)
        {
            _Show(tmp.Left);
            Console.Write(tmp.Value + " ");
            tmp.List.Show();
            _Show(tmp.Right);
        }
    }
}

class Program
{
    static void Main()
    {
        // Create a new BSTree
        BSTree bst = new BSTree();

        // Add nodes with their associated lists
        List tmp = new List();
        tmp.Add("Fernandez");
        tmp.Add("Santiago");
        bst.Add(25, tmp);

        tmp = new List();
        tmp.Add("Lemus");
        tmp.Add("Karla");
        bst.Add(5, tmp);

        tmp = new List();
        tmp.Add("Cabrera");
        tmp.Add("Angel");
        bst.Add(10, tmp);

        tmp = new List();
        tmp.Add("Gonzalez");
        tmp.Add("Carlos");
        bst.Add(41, tmp);

        // Print the tree
        bst.Show();
    }
}

