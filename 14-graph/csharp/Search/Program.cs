using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        BreadthTraversal(1);
        DepthTraversal(1);
        BreadthSearch(1, 5);
        DepthSearch(1, 9);
    }

    static List<int> Successors(int node)
    {
        List<int> suc = new List<int>();

        switch (node)
        {
            case 1: suc.AddRange(new int[] { 2, 4, 5 }); break;
            case 2: suc.AddRange(new int[] { 1, 3, 4, 5, 6 }); break;
            case 3: suc.AddRange(new int[] { 2, 5, 6 }); break;
            case 4: suc.AddRange(new int[] { 1, 2, 5, 7, 8 }); break;
            case 5: suc.AddRange(new int[] { 1, 2, 3, 4, 6, 7, 8, 9 }); break;
            case 6: suc.AddRange(new int[] { 2, 3, 5, 8, 9 }); break;
            case 7: suc.AddRange(new int[] { 4, 5, 8 }); break;
            case 8: suc.AddRange(new int[] { 4, 5, 6, 7, 9 }); break;
            case 9: suc.AddRange(new int[] { 5, 6, 8 }); break;
            default: suc.Add(0); break;
        }

        return suc;
    }

    static void BreadthTraversal(int startNode)
    {
        List<int> list = new List<int> { startNode };
        List<int> visited = new List<int>();
        int n = 1;
        while (n > 0)
        {
            int currentNode = list[0];
            list.RemoveAt(0); 
            visited.Add(currentNode);

            List<int> temp = Successors(currentNode);
            foreach (var successor in temp)
            {
                if (!visited.Contains(successor) && !list.Contains(successor))
                {
                    list.Add(successor); 
                }
            }

            n = list.Count;
        }

        Console.Write("***** Breadth traversal: ");
        foreach (var node in visited)
        {
            Console.Write(node + " ");
        }
        Console.WriteLine();
    }

    static void DepthTraversal(int startNode)
    {
        List<int> list = new List<int> { startNode };
        List<int> visited = new List<int>();
        int n = 1;
        while (n > 0)
        {
            int currentNode = list[0];
            list.RemoveAt(0);
            visited.Add(currentNode);

            List<int> temp = Successors(currentNode);
            foreach (var successor in temp)
            {
                if (!visited.Contains(successor) && !list.Contains(successor))
                {
                    list.Insert(0, successor);
                }
            }
            n = list.Count;
        }

        Console.Write("***** Depth traversal: ");
        foreach (var node in visited)
        {
            Console.Write(node + " ");
        }
        Console.WriteLine();
    }

    static void BreadthSearch(int startNode, int endNode)
    {
        List<int> list = new List<int> { startNode };
        Console.WriteLine($"***** Breadth First Search: begin={startNode} end={endNode}");

        while (list.Count > 0)
        {
            int currentNode = list[0];
            list.RemoveAt(0);
            Console.Write($"pop: {currentNode} ");

            if (currentNode == endNode)
            {
                Console.WriteLine("FOUND");
                return;
            }

            List<int> temp = Successors(currentNode);
            Console.Write("successors: ");
            foreach (var successor in temp)
            {
                Console.Write(successor + " ");
            }
            Console.WriteLine();

            if (temp.Contains(0)) continue;
            list.AddRange(temp); 
        }

        Console.WriteLine("NOT FOUND");
    }

    static void DepthSearch(int startNode, int endNode)
    {
        List<int> list = new List<int> { startNode };
        Console.WriteLine($"***** Depth First Search: begin={startNode} end={endNode} (reversed list)");

        while (list.Count > 0)
        {
            int currentNode = list[0];
            list.RemoveAt(0);
            Console.Write($"pop: {currentNode} ");

            if (currentNode == endNode)
            {
                Console.WriteLine("FOUND");
                return;
            }

            List<int> temp = Successors(currentNode);
            temp.Reverse(); 
            Console.Write("successors: ");
            foreach (var successor in temp)
            {
                Console.Write(successor + " ");
            }
            Console.WriteLine();

            if (temp.Contains(0)) continue;
            list.InsertRange(0, temp); 
        }
        Console.WriteLine("NOT FOUND");
    }
}

