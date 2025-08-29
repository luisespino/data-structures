using System;


class Node
{
    public int val;
    public Node left;
    public Node right;

    public Node(int val_)
    {
        val = val_;
        left = null;
        right = null;
    }
}

class BSTree
{
    public Node root;
    public BSTree()
    {
        root = null;
    }

    public void Add(int val)
    {
        if (root != null)
            Add(val, root);
        else
            root = new Node(val);
    }

    private void Add(int val, Node tmp)
    {
        if (val < tmp.val)
        {
            if (tmp.left != null)
                Add(val, tmp.left);
            else
                tmp.left = new Node(val);
        }
        else
        {
            if (tmp.right != null)
                Add(val, tmp.right);
            else
                tmp.right = new Node(val);
        }
    }

    // Preorder traversal
    public void Preorder(Node tmp)
    {
        if (tmp != null)
        {
            Console.Write(tmp.val + " ");
            Preorder(tmp.left);
            Preorder(tmp.right);
        }
    }

    // Inorder traversal
    public void Inorder(Node tmp)
    {
        if (tmp != null)
        {
            Inorder(tmp.left);
            Console.Write(tmp.val + " ");
            Inorder(tmp.right);
        }
    }

    // Postorder traversal
    public void Postorder(Node tmp)
    {
        if (tmp != null)
        {
            Postorder(tmp.left);
            Postorder(tmp.right);
            Console.Write(tmp.val + " ");
        }
    }

}

public class Program
{
    static void Main()
    {
        BSTree t = new BSTree();
        t.Add(25);
        t.Add(10);
        t.Add(35);
        t.Add(5);
        t.Add(20);
        t.Add(30);
        t.Add(40);

        t.Preorder(t.root);
        Console.WriteLine();

        t.Inorder(t.root);
        Console.WriteLine();

        t.Postorder(t.root);
        Console.WriteLine();

    }
}

