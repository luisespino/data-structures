using System;

class BTreeNode
{
    // order: 4
    public const int MAX = 3;
    public const int MIN = 1;

    public int[] val = new int[MAX + 1];
    public int num = 0;
    public BTreeNode[] link = new BTreeNode[MAX + 1];
}

class BTree
{
    private BTreeNode root = null;

    public void Insert(int val)
    {
        int i;
        BTreeNode child = null;
        if (SetValue(val, out i, root, out child))
            root = CreateNode(i, child);
    }

    private bool SetValue(int val, out int pval, BTreeNode node, out BTreeNode child)
    {
        int pos;
        if (node == null)
        {
            pval = val;
            child = null;
            return true;
        }

        if (val < node.val[1]) 
        {
            pos = 0;
        }
        else
        {
            for (pos = node.num; (val < node.val[pos] && pos > 1); pos--);
            if (val == node.val[pos]) 
            {
                Console.WriteLine("Duplicates not allowed");
                pval = 0;
                child = null;
                return false;
            }
        }
        if (SetValue(val, out pval, node.link[pos], out child))
        {
            if (node.num < BTreeNode.MAX)
            {
                InsertNode(pval, pos, node, child);
            }
            else
            {
                SplitNode(pval, out pval, pos, node, child, out child);
                return true;
            }
        }
        return false;
    }

    private BTreeNode CreateNode(int val, BTreeNode child)
    {
        BTreeNode newNode = new BTreeNode();
        newNode.val[1] = val;
        newNode.num = 1;
        newNode.link[0] = root;
        newNode.link[1] = child;
        return newNode;
    }

    private void InsertNode(int val, int pos, BTreeNode node, BTreeNode child)
    {
        int j = node.num;
        while (j > pos)
        {
            node.val[j + 1] = node.val[j];
            node.link[j + 1] = node.link[j];
            j--;
        }
        node.val[j + 1] = val;
        node.link[j + 1] = child;
        node.num++;
    }

    private void SplitNode(int val, out int pval, int pos, BTreeNode node, BTreeNode child, out BTreeNode newNode)
    {
        int median, j;
        if (pos > BTreeNode.MIN)
            median = BTreeNode.MIN + 1;
        else
            median = BTreeNode.MIN;
        
        newNode = new BTreeNode();
        j = median + 1;
        while (j <= BTreeNode.MAX)
        {
            newNode.val[j - median] = node.val[j];
            newNode.link[j - median] = node.link[j];
            j++;
        }

        node.num = median;
        newNode.num = BTreeNode.MAX - median;

        if (pos <= BTreeNode.MIN)
        {
            InsertNode(val, pos, node, child);
        }
        else
        {
            InsertNode(val, pos - median, newNode, child);
        }

        pval = node.val[node.num];
        newNode.link[0] = node.link[node.num];
        node.num--;
    }

    public void Traversal(BTreeNode myNode)
    {
        if (myNode != null)
        {
            Console.Write("[");
            for (int i = 0; i < myNode.num; i++)
            {
                Console.Write(myNode.val[i + 1] + ",");
            }
            for (int i = 0; i <= myNode.num; i++)
            {
                Traversal(myNode.link[i]);
            }
            Console.Write("]");
        }
    }

    public static void Main()
    {
        BTree t = new BTree();
        t.Insert(5); t.Insert(10);
        t.Insert(15); t.Insert(20);
        t.Insert(25); t.Insert(30);
        t.Insert(35); t.Insert(40);
        t.Insert(45); t.Insert(50);
        t.Traversal(t.root);
        Console.WriteLine();
    }
}

