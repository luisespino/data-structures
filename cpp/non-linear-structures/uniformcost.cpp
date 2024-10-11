#include <iostream>
#include <string>
#include <algorithm>

using namespace std;

const int MAX_SUCESORES = 10; // Número máximo de sucesores
const int MAX_NODOS = 100;     // Número máximo de nodos en la lista

// Función para obtener los sucesores de un nodo
int sucesores(const string& nodo, int costo_acumulado, string sucesores[][2]) {
    int count = 0;

    if (nodo == "A") {
        sucesores[count][0] = "B"; 
        sucesores[count][1] = to_string(costo_acumulado + 5);
        count++;
        sucesores[count][0] = "C"; 
        sucesores[count][1] = to_string(costo_acumulado + 6);
        count++;
    } else if (nodo == "B") {
        sucesores[count][0] = "A"; 
        sucesores[count][1] = to_string(costo_acumulado + 5);
        count++;
        sucesores[count][0] = "C"; 
        sucesores[count][1] = to_string(costo_acumulado + 6);
        count++;
        sucesores[count][0] = "D"; 
        sucesores[count][1] = to_string(costo_acumulado + 3);
        count++;
        sucesores[count][0] = "E"; 
        sucesores[count][1] = to_string(costo_acumulado + 5);
        count++;
    } else if (nodo == "C") {
        sucesores[count][0] = "A"; 
        sucesores[count][1] = to_string(costo_acumulado + 6);
        count++;
        sucesores[count][0] = "B"; 
        sucesores[count][1] = to_string(costo_acumulado + 6);
        count++;
        sucesores[count][0] = "E"; 
        sucesores[count][1] = to_string(costo_acumulado + 2);
        count++;
    } else if (nodo == "D") {
        sucesores[count][0] = "B"; 
        sucesores[count][1] = to_string(costo_acumulado + 3);
        count++;
        sucesores[count][0] = "E"; 
        sucesores[count][1] = to_string(costo_acumulado + 3);
        count++;
        sucesores[count][0] = "F"; 
        sucesores[count][1] = to_string(costo_acumulado + 4);
        count++;
    } else if (nodo == "E") {
        sucesores[count][0] = "B"; 
        sucesores[count][1] = to_string(costo_acumulado + 5);
        count++;
        sucesores[count][0] = "C"; 
        sucesores[count][1] = to_string(costo_acumulado + 2);
        count++;
        sucesores[count][0] = "D"; 
        sucesores[count][1] = to_string(costo_acumulado + 3);
        count++;
        sucesores[count][0] = "F"; 
        sucesores[count][1] = to_string(costo_acumulado + 1);
        count++;
    } else if (nodo == "F") {
        sucesores[count][0] = "D"; 
        sucesores[count][1] = to_string(costo_acumulado + 4);
        count++;
        sucesores[count][0] = "E"; 
        sucesores[count][1] = to_string(costo_acumulado + 1);
        count++;
    }

    return count; // Retorna el número de sucesores encontrados
}

// Función para encontrar la solución usando costo uniforme
void costo_uniforme(const string& nodo_inicio, const string& nodo_fin) {
    string lista[MAX_NODOS][2]; // Lista de nodos y costos
    int lista_size = 0;

    lista[lista_size][0] = nodo_inicio;
    lista[lista_size++][1] = "0"; // Costo inicial

    while (lista_size > 0) {
        // Sacar el nodo actual (primer elemento)
        string nodo_actual = lista[0][0];
        int costo_actual = stoi(lista[0][1]);

        // Desplazar la lista hacia la izquierda
        for (int i = 0; i < lista_size - 1; ++i) {
            lista[i][0] = lista[i + 1][0];
            lista[i][1] = lista[i + 1][1];
        }
        lista_size--;

        cout << "Nodo actual: " << nodo_actual << ", Costo: " << costo_actual << endl;

        if (nodo_actual == nodo_fin) {
            cout << "SOLUCION" << endl;
            return;
        }

        string sucesores_arr[MAX_SUCESORES][2];
        int num_sucesores = sucesores(nodo_actual, costo_actual, sucesores_arr);

        cout << "Sucesores: ";
        for (int i = 0; i < num_sucesores; ++i) {
            cout << "[" << sucesores_arr[i][0] << ", " << sucesores_arr[i][1] << "] ";
        }
        cout << endl;

        for (int i = 0; i < num_sucesores; ++i) {
            // Agregar sucesores a la lista
            lista[lista_size][0] = sucesores_arr[i][0];
            lista[lista_size][1] = sucesores_arr[i][1];
            lista_size++;
        }

        // Ordenar la lista por costo (burbuja simple)
        for (int i = 0; i < lista_size - 1; ++i) {
            for (int j = 0; j < lista_size - i - 1; ++j) {
                if (stoi(lista[j][1]) > stoi(lista[j + 1][1])) {
                    swap(lista[j], lista[j + 1]);
                }
            }
        }

        cout << "Lista actualizada: ";
        for (int i = 0; i < lista_size; ++i) {
            cout << "[" << lista[i][0] << ", " << lista[i][1] << "] ";
        }
        cout << endl;
    }

    cout << "NO-SOLUCION" << endl;
}

int main() {
    costo_uniforme("A", "F");
    return 0;
}
