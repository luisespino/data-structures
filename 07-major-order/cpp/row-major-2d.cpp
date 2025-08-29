#include <iostream>

using namespace std;

int main()
{
    int m[4][4] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 
                    9, 10, 11, 12, 13, 14, 15};
    int a[16];
    for (int i = 0; i < 4; i++)
        for (int j = 0; j < 4; j++)
            a[i * 4 + j] = m[i][j];
    
    for (int i = 0; i < 16; i++)
        cout << a[i] << " ";
    cout << endl;
}

