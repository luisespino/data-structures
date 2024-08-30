// Luis Espino 2024

#include <iostream>

#define MAX 4

using namespace std;

// coordinate list implementation
class StaticSparseMatrix
{
    public:
    int *val, *row, *col, values;

    StaticSparseMatrix(int m[MAX][MAX])
    {
        // get number of values
        values = 0;
        for (int i = 0; i < MAX; i++)
            for (int j = 0; j < MAX; j++)
                if (m[i][j] != 0)
                    values++;
        
        // init arrays
        val = new int[values];
        row = new int[values];
        col = new int[values];

        // build coordinate list
        int nvalues = 0;
        for (int i = 0; i < MAX; i++)
            for (int j = 0; j < MAX; j++)
                if (m[i][j]!=0)
                {
                    val[nvalues] = m[i][j];
                    row[nvalues] = i;
                    col[nvalues++] = j;
                }
    }

    ~StaticSparseMatrix()
    {
        delete[] val;
        delete[] row;
        delete[] col;
    }

    void print()
    {
        cout << "val: ";
        for (int i = 0; i < values; i++)
            cout << val[i] << " ";
        cout << endl << "row: ";
        for (int i = 0; i < values; i++)
            cout << row[i] << " ";
        cout << endl << "col: ";
        for (int i = 0; i < values; i++)
            cout << col[i] << " ";
        cout << endl;
    }
};

int main()
{
    int m[MAX][MAX] = { {5, 4, 0, 0},
                        {0, 1, 0, 0},
                        {0, 0, 6, 0},
                        {0, 0, 3, 2} };
    StaticSparseMatrix *s = new StaticSparseMatrix(m);
    s->print();
    return 0;
}