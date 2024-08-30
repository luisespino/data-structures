// Luis Espino 2024

#include <iostream>

using namespace std;

class NodoC{
public:
	NodoC *derecha;
	NodoC *abajo;
	string valor;
	NodoC(string valor){
		this->valor = valor;
		derecha = NULL;
		abajo = NULL;
	}
};

class NodoFila{
public:
	int numFila;
	NodoFila *siguiente;
	NodoC *derecha;
	NodoFila(int numFila){
		this->numFila = numFila;
		siguiente = NULL;
		derecha = NULL;
	}
};

class NodoColumna{
public:
	char numColumna;
	NodoColumna *siguiente;
	NodoC *abajo;
	NodoColumna(char numColumna){
		this->numColumna = numColumna;
		siguiente = NULL;
		abajo = NULL;
	}
};

class DynamicSparseMatrix {
public:
	NodoFila *primeroFila;
	NodoColumna *primeroColumna;

	void agregarNodoFila(int numFila) {
		if (primeroFila==NULL)
			primeroFila = new NodoFila(numFila);
		else {
			NodoFila *temp = primeroFila;
			primeroFila = new NodoFila(numFila);
			primeroFila->siguiente = temp;
		}
	}

	void agregarNodoColumna(char numColumna) {
		if (primeroColumna==NULL)
			primeroColumna = new NodoColumna(numColumna);
		else {
			NodoColumna *temp = primeroColumna;
			primeroColumna = new NodoColumna(numColumna);
			primeroColumna->siguiente = temp;
		}
	}

	void agregar(string valor, char columna, int fila){
		NodoColumna *tempColumna = primeroColumna;
		NodoFila *tempFila = primeroFila;

		NodoC *nuevo = new NodoC(valor);

		while (tempColumna!=NULL) {
			if (tempColumna->numColumna==columna) {
				NodoC *temp = tempColumna->abajo;
				if (temp==NULL)
					tempColumna->abajo = nuevo;
				else {
					while (temp->abajo!=NULL) temp = temp->abajo;
					temp->abajo = nuevo;

				}
				break;
			}
			tempColumna = tempColumna->siguiente;
		}

		while (tempFila!=NULL) {
			if (tempFila->numFila==fila) {
				NodoC *temp = tempFila->derecha;
				if (temp==NULL)
					tempFila->derecha = nuevo;
				else {
					while (temp->derecha!=NULL) temp = temp->derecha;
					temp->derecha = nuevo;
				}
				break;
			}
			tempFila = tempFila->siguiente;
		}
	}

	void mostrarColumnas() {
		NodoColumna *temp = primeroColumna;
		cout << "  ";
		while(temp!=NULL) {
			cout << temp->numColumna << " ";
			temp = temp->siguiente;
		}
		cout << endl;
	}

	void mostrarFilas() {
		NodoFila *temp = primeroFila;
		while(temp!=NULL) {
			cout << temp->numFila << " ";
			NodoC *t = temp->derecha;
			while (t!=NULL){
				cout << t->valor << " ";
				t = t->derecha;
			}
			cout << endl;
			temp = temp->siguiente;
		}
		cout << endl;
	}
};


int main()
{
    DynamicSparseMatrix *sm = new DynamicSparseMatrix();
	sm->agregarNodoColumna('C');
	sm->agregarNodoColumna('B');
	sm->agregarNodoColumna('A');
	sm->agregarNodoFila(3);
	sm->agregarNodoFila(2);
	sm->agregarNodoFila(1);
	sm->agregar("5",'A', 1);
	sm->agregar("8",'A', 2);
	sm->agregar("7",'B', 2);
	sm->agregar("1",'A', 3);
	sm->agregar("3",'B', 3);
	sm->agregar("9",'C', 3);
	sm->mostrarColumnas();
	sm->mostrarFilas();
}