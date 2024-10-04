// Luis Espino (c) 2024

#include <iostream>

using namespace std;

class Hash
{
    public:
    int n, m;
    int *h;
    int min, max;
    
    Hash(int m, int min, int max)
    {
        this->m = m;
        this->min = min;
        this->max = max;
        init();
	}
    
    int division(int k)
    { 
        return (k % m); 
    }
    
    int linear(int k)
    { 
        return ((k+1) % m); 
    }
    
    void init()
    {
        n = 0;
        h = new int[m];
        for(int i=0; i<m; i++) 
            h[i] = -1;		
	}
    
    void insert(int k)
    {
        int i = division(k);
        while (h[i] != -1)
            i = linear (i);
        h[i] = k;
        n++;
        rehashing();
    }
    
    void rehashing()
    {
        if ((n*100/m)>=max)
        {
            //array copy
            int *temp = h;
            print();
            //rehashing
            int mprev = m;
            m = n*100/min;
            init();
            for (int i=0; i<mprev; i++)
                if (temp[i]!=-1)
                    insert(temp[i]);
        }
        else print();
    }
    
    void print()
    {
        cout << "[" ;
        for(int i=0; i<m; i++)
            cout << " " << h[i];
        cout << " ] " << (n*100/m) << "%" << endl;
    }
};

int main() {
    Hash *hash = new Hash(5, 20, 80); // m, min, max
    hash->insert(5);
    hash->insert(10);
    hash->insert(15);
    hash->insert(20);
    hash->insert(25);
    hash->insert(30);
    return 0;
}
