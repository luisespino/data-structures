using System;

class Program
{
    static int inf = 9999;

    static int[,] adj = {
        {0, 5, 6, 0, 0, 0},
        {5, 0, 6, 3, 5, 0},
        {6, 6, 0, 0, 2, 0},
        {0, 3, 0, 0, 3, 4},
        {0, 5, 2, 3, 0, 1},
        {0, 0, 0, 4, 1, 0}
    };

    static void Dijkstra(int start)
    {
        int n = adj.GetLength(0);
        int[] distance = new int[n];
        bool[] explored = new bool[n];
        int[] path = new int[n];

        for (int i = 0; i < n; i++)
        {
            distance[i] = inf;
            explored[i] = false;
        }

        distance[start] = 0;
        path[start] = -1;

        for (int c = 0; c < n; c++)
        {
            int min = inf;
            int i = 0;

            for (int j = 0; j < n; j++)
            {
                if (!explored[j] && distance[j] < min)
                {
                    min = distance[j];
                    i = j;
                }
            }

            explored[i] = true;

            for (int j = 0; j < n; j++)
            {
                if (!explored[j] && adj[i, j] != 0 && distance[i] != inf &&
                    distance[i] + adj[i, j] < distance[j])
                {
                    distance[j] = distance[i] + adj[i, j];
                    path[j] = i;
                }
            }
        }

        Console.WriteLine("Node\tDistance\tPath");
        for (int i = 0; i < n; i++)
        {
            Console.WriteLine($"{i}\t{distance[i]}\t\t{path[i]}");
        }
        
    }

    static void Main(string[] args)
    {
        Dijkstra(0);
    }
}

