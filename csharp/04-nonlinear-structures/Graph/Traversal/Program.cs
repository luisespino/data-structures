using System;

class Graph
{
    int n;
    int[,] adj;

    public Graph(int n_)
    {
        n = n_;
        adj = new int[n_, n_];
    }


    public void Add(int source, int destination)
    {
        adj[source, destination] = 1;
    }

    public void BreadthTraversal(int start)
    {
        bool[] visited = new bool[n];
        for (int i = 0; i < n; i++)
            visited[i] = false;

        int[] stack = new int[n];
        int front = 0, end = 0;

        visited[start] = true;
        stack[end++] = start;

        while (front < end)
        {
            int node = stack[front++];
            Console.Write(node + " ");

            for (int i = 0; i < n; i++)
            {
                if (adj[node, i] == 1 && !visited[i])
                {
                    visited[i] = true;
                    stack[end++] = i;
                }
            }
        }
    }

    public void DepthTraversal(int start)
    {
        bool[] visited = new bool[n];
        for (int i = 0; i < n; i++)
            visited[i] = false;

        int[] stack = new int[n];
        int head = -1;

        visited[start] = true;
        stack[++head] = start;

        while (head >= 0)
        {
            int node = stack[head--];
            Console.Write(node + " ");

            for (int i = 0; i < n; i++)
            {
                if (adj[node, i] == 1 && !visited[i])
                {
                    visited[i] = true;
                    stack[++head] = i;
                }
            }
        }
    }
}

class Program
{
    static void Main()
    {
        Graph g = new Graph(8);
        g.Add(0, 1); g.Add(0, 4);
        g.Add(1, 0); g.Add(1, 2); g.Add(1, 4);
        g.Add(2, 3); g.Add(2, 5);
        g.Add(3, 6); g.Add(3, 7);
        g.Add(4, 2); g.Add(4, 5);
        g.Add(5, 2); g.Add(5, 6);
        g.Add(6, 2); g.Add(6, 7);

        Console.WriteLine("Breadth Traversal:");
        g.BreadthTraversal(0);
        Console.WriteLine();

        Console.WriteLine("Depth Traversal:");
        g.DepthTraversal(0);
        Console.WriteLine();
    }
}

