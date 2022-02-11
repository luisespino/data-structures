public class Sort {

    int a [] = {17, 10, 12, 7, 11};

    void show()
    {
        System.out.print("[");
        for (int i=0; i<a.length; i++)
            System.out.print(a[i]+" ");
        System.out.print("]\n");            
    }
    
    void bubbleSort()
    {
        int itera = 0;
        int aux;
        for(int i=0; i<a.length-1; i++)
            for(int j=i+1; j<a.length; j++)
                if (a[i]>a[j])
                {
                    aux = a[i];
                    a[i]=a[j];
                    a[j]=aux;
                    show();
                    itera++;
                }
        System.out.println("Iteraciones: "+itera);
    }
    
    void selectionSort()
    {
        int itera = 0;
        int menor, aux;
        for(int i=0; i<a.length-1; i++)
        {
            menor = i;
            for(int j=i+1; j<a.length; j++)
            {
                show();                
                itera++;
                if (a[menor]>a[j])
                    menor = j;
            }
            aux = a[i];
            a[i] = a[menor];
            a[menor] = aux;
        }
        System.out.println("Iteraciones: "+itera);    
    }
    
    void insertionSort()
    {
        int itera = 0;
        int aux,j;
        for(int i=0; i<a.length; i++)
        {
            j = i;
            aux = a[i];
            while (j>0 && a[j-1]>aux)
            {
                a[j]=a[j-1];
                j--;
                show();                
                itera++;
            }
            a[j] = aux;
        }
        System.out.println("Iteraciones: "+itera);
    }
    
    void quickSort(int primero, int ultimo)
    {
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
                show();
            }
        }
        while(i<=j);
        if (primero<j)
            quickSort(primero, ultimo);
        if (i<ultimo)
            quickSort(i, ultimo);
    }    
        
    public static void main(String [] args) {
        Sort s = new Sort();
        s.show();
        s.bubbleSort();
        //s.selectionSort();
        //s.insertionSort();
        //s.quickSort(0, s.a.length-1);
        s.show();
    }
}
