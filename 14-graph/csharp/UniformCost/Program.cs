using System;
using System.Collections.Generic;
using System.Linq;

class Program
{
    static List<(char, int)> Successors((char, int) n)
    {
        switch (n.Item1)
        {
            case 'A':
                return new List<(char, int)> { ('B', n.Item2 + 5), ('C', n.Item2 + 6) };
            case 'B':
                return new List<(char, int)> { ('A', n.Item2 + 5), ('C', n.Item2 + 6), ('D', n.Item2 + 3), ('E', n.Item2 + 5) };
            case 'C':
                return new List<(char, int)> { ('A', n.Item2 + 6), ('B', n.Item2 + 6), ('E', n.Item2 + 2) };
            case 'D':
                return new List<(char, int)> { ('B', n.Item2 + 3), ('E', n.Item2 + 3), ('F', n.Item2 + 4) };
            case 'E':
                return new List<(char, int)> { ('B', n.Item2 + 5), ('C', n.Item2 + 2), ('D', n.Item2 + 3), ('F', n.Item2 + 1) };
            case 'F':
                return new List<(char, int)> { ('D', n.Item2 + 4), ('E', n.Item2 + 1) };
            default:
                return new List<(char, int)>();
        }
    }

    static void UniformCost(char start, char end)
    {
        var frontier = new List<(char, int)> { (start, 0) };

        while (frontier.Any())
        {
            var current = frontier.First();
            frontier.RemoveAt(0);

            Console.WriteLine($"Current: ({current.Item1}, {current.Item2})");

            if (current.Item1 == end)
            {
                Console.WriteLine("SOLUTION");
                return;
            }

            var temp = Successors(current);

            string tempString = string.Join(", ", temp.Select(t => $"({t.Item1}, {t.Item2})"));
            Console.WriteLine($"Succesors of {current.Item1}: {tempString}");

            frontier.AddRange(temp);
            frontier = frontier.OrderBy(x => x.Item2).ToList();

            string frontierStringAfterSort = string.Join(", ", frontier.Select(f => $"({f.Item1}, {f.Item2})"));
            Console.WriteLine($"Frontier: {frontierStringAfterSort}");
        }

        Console.WriteLine("NO-SOLUTION");
    }

    static void Main()
    {
        UniformCost('A', 'F');
    }
}

