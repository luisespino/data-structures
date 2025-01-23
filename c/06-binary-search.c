#include <stdio.h>

int main() {
    int ini = 0, fin = 99, pos = 0, itera = 0, valor = 76;
    int a[fin + 1];

    for (int i = 0; i <= fin; i++) {
        a[i] = i;
    }

    while (ini <= fin) {
        itera++;
        pos = (fin - ini) / 2 + ini;
        if (a[pos] == valor) {
            printf("%d iterations\n", itera);
            break;
        }
        else if (valor < a[pos]) {
            fin = pos - 1;
        }
        else {
            ini = pos + 1;
        }
    }

    return 0;
}
