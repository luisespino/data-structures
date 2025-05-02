using System;
using System.Collections.Generic;

public class TreeNode {
    public int Symbol;
    public char Code;
    public int Frequency;
    public TreeNode Left;
    public TreeNode Right;

    public TreeNode() {
        Left = null;
        Right = null;
    }
}

public class StackNode {
    public TreeNode Root;
    public StackNode Next;

    public StackNode() {
        Root = null;
        Next = null;
    }
}

public class HuffmanTreeStack {
    public StackNode Head = null;

    public void Init(string input, int[] num) {
        foreach (char ch in input) {
            num[ch]++;
        }

        for (int i = (int)'~'; i >= (int)' '; i--) {
            if (num[i] > 0) {
                var tmp = new StackNode();
                tmp.Root = new TreeNode {
                    Symbol = i,
                    Code = '\0',
                    Frequency = num[i],
                    Left = null,
                    Right = null
                };
                tmp.Next = Head;
                Head = tmp;
            }
        }
    }

    public void Sort() {
        if (Head == null || Head.Next == null) return;

        bool swapped;
        do {
            swapped = false;
            StackNode current = Head;
            while (current.Next != null) {
                if (current.Root.Frequency > current.Next.Root.Frequency) {
                    TreeNode temp = current.Root;
                    current.Root = current.Next.Root;
                    current.Next.Root = temp;
                    swapped = true;
                }
                current = current.Next;
            }
        } while (swapped);
    }

    public void PrintStack() {
        StackNode tmp = Head;
        while (tmp != null) {
            Console.WriteLine($"{(char)tmp.Root.Symbol} : {tmp.Root.Frequency}");
            tmp = tmp.Next;
        }
    }

    public void Create() {
        while (Head != null && Head.Next != null) {
            TreeNode left = Head.Root;
            left.Code = '0';
            Head = Head.Next;

            TreeNode right = Head.Root;
            right.Code = '1';
            Head = Head.Next;

            var tmp = new StackNode();
            tmp.Root = new TreeNode {
                Symbol = 0,
                Code = '\0',
                Frequency = left.Frequency + right.Frequency,
                Left = left,
                Right = right
            };
            tmp.Next = Head;
            Head = tmp;

            Sort();
        }
    }

    public void PrintCode(int[] num) {
        for (int i = (int)' '; i <= (int)'~'; i++) {
            if (num[i] > 0) {
                string code = "";
                PrintCodeRec(Head.Root, i, ref code);
                Console.WriteLine($"{(char)i} : {code}");
            }
        }
    }

    private void PrintCodeRec(TreeNode root, int target, ref string code) {
        if (root == null) return;

        if (root.Symbol == target) {
            code = root.Code.ToString();
            return;
        }

        string temp = code;

        if (root.Left != null) {
            PrintCodeRec(root.Left, target, ref code);
            if (code.Length > 0 && code != temp) {
                code = root.Code + code;
                return;
            }
        }

        if (root.Right != null && code == temp) {
            PrintCodeRec(root.Right, target, ref code);
            if (code.Length > 0 && code != temp) {
                code = root.Code + code;
            }
        }
    }

    public void Traversal(TreeNode root) {
        if (root != null) {
            Console.WriteLine($"{root.Symbol} : {root.Frequency} : {root.Code}");
            Traversal(root.Left);
            Traversal(root.Right);
        }
    }
}

public class Program {
    public static void Main() {
        int[] num = new int[128];
        string input = "AABCBCBDEBBA";
        HuffmanTreeStack huffman = new HuffmanTreeStack();

        Console.WriteLine("*** INPUT ***");
        huffman.Init(input, num);
        huffman.PrintStack();

        Console.WriteLine("*** ORDERED ***");
        huffman.Sort();
        huffman.PrintStack();

        Console.WriteLine("*** CODE ***");
        huffman.Create();
        huffman.PrintCode(num);

        Console.WriteLine("*** TRAVERSAL ***");
        huffman.Traversal(huffman.Head.Root);
    }
}

