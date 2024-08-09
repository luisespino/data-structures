#include <iostream>

void mostrarArreglo(int a[], int size)
{
    std::cout << "[";
	for (int i=0; i<size; i++)
		std::cout << a[i] << " ";
	std::cout << "]\n";
}

void ordena(int a[], int size, int i, int j)
{
    if (i>=size-1) return;
    if (j>=size)
    {
        i++;
        j=i+1;
    }
    if (a[i]>a[j])
    {
        int aux = a[i];
        a[i]=a[j];
        a[j]=aux;
    }
    ordena(a, size, i, j+1);
}

void ordenaBurbuja(int a[], int size)
{
    int itera = 0;
    int aux;
    for(int i=0; i<size-1; i++)
        for(int j=i+1; j<size; j++)
            if (a[i]>a[j])
            {
                aux = a[i];
                a[i]=a[j];
                a[j]=aux;
                mostrarArreglo(a,size);
                itera++;
            }
    //std::cout << itera;
}

void ordenaSeleccion(int a[], int size)
{
    int itera = 0;
    int menor, aux;
    for(int i=0; i<size-1; i++)
    {
        menor = i;
        for(int j=i+1; j<size; j++)
        {
            itera++;
            if (a[menor]>a[j])
                menor = j;

        }
        aux = a[i];
        a[i] = a[menor];
        a[menor] = aux;
    }
    std::cout << itera;

}

void ordenaInsercion(int a[], int size)
{

    int itera = 0;
    int aux,j;
    for(int i=0; i<size; i++)
    {
        j = i;
        aux = a[i];
        while (j>0 && a[j-1]>aux)
        {
            a[j]=a[j-1];
            j--;
            //itera++;
        }
        a[j] = aux;
    }
    std::cout << itera;
}

void ordenaRapido(int a[], int primero, int ultimo)
{
    int itera = 0;
    int central = (primero+ultimo)/2;
    int pivote = a[central];
    int aux;
    int i = primero, j = ultimo;
    do{
        while (a[i]<pivote) i++;
        while (a[j]>pivote) j--;
        if (i<=j)
        {
            aux = a[i];
            a[i] = a[j];
            a[j] = aux;
            i++;
            j--;
            itera++;
            mostrarArreglo(a,5);
        }
    }
    while(i<=j);
    if (primero<j)
        ordenaRapido(a, primero, j);
    if (i<ultimo)
        ordenaRapido(a, i, ultimo);

    std::cout << itera << " ";
}

int main()
{
    int a[] = {17, 10, 12, 7, 11};
    mostrarArreglo(a,sizeof(a)/4);
    ordenaBurbuja(a,sizeof(a)/4); //7
    mostrarArreglo(a,sizeof(a)/4);
}
