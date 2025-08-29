using System;
using System.Text;

public class DataNode {
    public int Value;
    public DataNode Next;

    public DataNode(int value) {
        Value = value;
        Next = null;
    }
}

public class HashNode {
    public int Hash;
    public HashNode Left;
    public HashNode Right;
    public DataNode Down;

    public HashNode(int hash) {
        Hash = hash;
        Left = null;
        Right = null;
        Down = null;
    }
}

public class Merkle {
    public HashNode TopHash;
    public DataNode[] DataBlock;
    public string Dot;
    public int Max;
    public int Index;

    public Merkle(int max) {
        TopHash = null;
        Max = max;
        Index = 0;
        DataBlock = new DataNode[max];
        Dot = "";
    }

    public void Add(int value) {
        DataBlock[Index++] = new DataNode(value);
    }

    public void CreateTree(int exp) {
        TopHash = new HashNode(0);
        CreateTree(TopHash, exp);
    }

    private void CreateTree(HashNode tmp, int exp) {
        if (exp > 0) {
            tmp.Left = new HashNode(0);
            tmp.Right = new HashNode(0);
            CreateTree(tmp.Left, exp - 1);
            CreateTree(tmp.Right, exp - 1);
        }
    }

    public void GenHash(HashNode tmp, int n) {
        if (tmp != null) {
            GenHash(tmp.Left, n);
            GenHash(tmp.Right, n);

            if (tmp.Left == null && tmp.Right == null) {
                tmp.Down = DataBlock[n - Index];
                Index--;
                tmp.Hash = tmp.Down.Value * 10;
            } else {
                tmp.Hash = (tmp.Left.Hash + tmp.Right.Hash) * 10;
            }
        }
    }

    public void Preorder(HashNode tmp) {
        if (tmp != null) {
            Console.Write(tmp.Hash + " ");
            Preorder(tmp.Left);
            Preorder(tmp.Right);
        }
    }

    public void Auth() {
        int exp = 1;
        while (Math.Pow(2, exp) < (Index + 1)) {
            exp += 1;
        }

        for (int i = Index; i < Math.Pow(2, exp); i++) {
            DataBlock[Index++] = new DataNode(i * 100);
        }

	Console.WriteLine("\nDATABLOCK: ");
        for (int i = 0; i < Index; i++) {
            Console.Write(DataBlock[i].Value + " ");
        }
        Console.WriteLine();

        CreateTree(exp);
        GenHash(TopHash, Index);
        
        Console.WriteLine("\nPRE-ORDER MERKLE TREE: ");
        Preorder(TopHash);
        Console.WriteLine();
    }

    public void Show() {
        for (int i = 0; i < (Index +1); i++) {
            Console.Write(DataBlock[i].Value + " ");
        }
    }

    public void DotGen(HashNode tmp) {
        if (tmp != null) {
            Dot += $"{tmp.Hash} [label=\"{tmp.Hash}\"];";

            if (tmp.Left != null) {
                Dot += $"{tmp.Hash}--{tmp.Left.Hash};";
            }
            if (tmp.Right != null) {
                Dot += $"{tmp.Hash}--{tmp.Right.Hash};";
            }

            DotGen(tmp.Left);
            DotGen(tmp.Right);

            if (tmp.Left == null && tmp.Right == null && tmp.Down != null) {
                Dot += $"{tmp.Down.Value} [label=\"{tmp.Down.Value}\" shape=rect];";
                Dot += $"{tmp.Hash}--{tmp.Down.Value};";
            }
        }
    }
}

class Program {
    static void Main(string[] args) {
        Merkle m = new Merkle(8);
        m.Add(4);
        m.Add(5);
        m.Add(6);
        m.Add(7);
        m.Add(8);
        m.Auth();

        m.Dot +=  "graph {";
        m.DotGen(m.TopHash);
        m.Dot += "}";
        Console.WriteLine("\nDOT MERKLE TREE: ");
        Console.WriteLine(m.Dot);
    }
}

