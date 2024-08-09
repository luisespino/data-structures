#include <iostream>

using namespace std;

int main()
{
    int m[2][2][2] = {0, 1, 2, 3, 4, 5, 6, 7};
    int a[8];
    for (int i = 0; i < 2; i++)
        for (int j = 0; j < 2; j++)
            for (int k = 0; k < 2; k++)
                a[i + 2 * (j + 2 * k)] = m[k][i][j];
    
    for (int i = 0; i < 8; i++)
        cout << a[i] << " ";
    cout << endl;
}


