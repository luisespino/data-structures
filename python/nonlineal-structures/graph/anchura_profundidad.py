# Luis Espino 2017
# Búsqueda por anchura y profundidad
# Problema matriz de 3x3

def sucesores(n):
    if n == 1: return [2, 4, 5]
    elif n == 2: return [1, 3, 4, 5, 6]
    elif n == 3: return [2, 5, 6]
    elif n == 4: return [1, 2, 5, 7, 8]
    elif n == 5: return [1, 2, 3, 4, 6, 7 ,8, 9]
    elif n == 6: return [2, 3, 5, 8 ,9]
    elif n == 7: return [4, 5, 8]
    elif n == 8: return [4, 5, 6 ,7, 9]
    elif n == 9: return [5, 6 , 8]
    else: return None


def anchura(nodo_inicio, nodo_fin):
    lista = [nodo_inicio]
    while lista:
        nodo_actual = lista.pop(0)
        print (nodo_actual)
        if nodo_actual == nodo_fin:
            return print("SOLUCIÓN")
        temp = sucesores(nodo_actual)
        #temp.reverse()
        print (temp)
        if temp:
            lista.extend(temp)
            print(lista)
    print ("NO-SOLUCIÓN")

def profundidad (nodo_inicio, nodo_fin):
    lista = [nodo_inicio]
    while lista:
        nodo_actual = lista.pop(0)
        print (nodo_actual)
        if nodo_actual == nodo_fin:
            print(len(lista))
            return print("SOLUCIÓN")
        temp = sucesores(nodo_actual)
        temp.reverse()
        print (temp)
        if temp:
            temp.extend(lista)
            lista = temp
            print(lista)
    print ("NO-SOLUCIÓN")
    
#anchura (1,9)
profundidad (1,9)
