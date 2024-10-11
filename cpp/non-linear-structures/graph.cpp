#include <iostream>
#include <list>

using namespace std;

class Grafo
{
    int n;
    std::list<int> *ady;
public:
    Grafo(int n_): n(n_), ady(new std::list<int>[n_]) {}
    void add(int origen, int destino)
    {
        ady[origen].push_back(destino);
    }
    void anchura(int inicio)
    {
        bool *visitados = new bool[n];
        for(int i = 0; i < n; i++)
            visitados[i] = false;
        std::list<int> cola;
        visitados[inicio] = true;
        cola.push_back(inicio);
        std::list<int>::iterator i;
        while(!cola.empty())
        {
            inicio = cola.front();
            std::cout << inicio << " ";
            cola.pop_front();
            for(i = ady[inicio].begin(); i != ady[inicio].end(); i++)
            {
                if(!visitados[*i])
                {
                    visitados[*i] = true;
                    cola.push_back(*i);
                }
            }
        }
    }
    void profundidad(int inicio)
    {
        bool *visitados = new bool[n];
        for(int i = 0; i < n; i++)
            visitados[i] = false;
        std::list<int> cola;
        visitados[inicio] = true;
        cola.push_front(inicio);
        std::list<int>::iterator i;
        while(!cola.empty())
        {
            inicio = cola.front();
            std::cout << inicio << " ";
            cola.pop_front();
            for(i = ady[inicio].begin(); i != ady[inicio].end(); i++)
            {
                if(!visitados[*i])
                {
                    visitados[*i] = true;
                    cola.push_front(*i);
                }
            }
        }
    }
};


int main()
{
    Grafo g(8);
    g.add(0, 1);g.add(0, 4);
    g.add(1, 0);g.add(1, 2);g.add(1, 4);
    g.add(2, 3);g.add(2, 5);
    g.add(3, 6);g.add(3, 7);
    g.add(4, 2);g.add(4, 5);
    g.add(5, 2);g.add(5, 6);
    g.add(6, 2);g.add(6, 7);
    g.anchura(0);
    cout << "\n";
    g.profundidad(0);
    cout << "\n";
    return 0;
}