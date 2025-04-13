def sucesores(n):
    if n[0]=='A':
        return [['B', n[1]+5,], ['C', n[1]+6]]
    if n[0]=='B':
        return [['A', n[1]+5], ['C', n[1]+6], ['D', n[1]+3], ['E', n[1]+5]]
    if n[0]=='C':
        return [['A', n[1]+6], ['B', n[1]+6], ['E', n[1]+2]]
    if n[0]=='D':
        return [['B', n[1]+3], ['E', n[1]+3], ['F', n[1]+4]]
    if n[0]=='E':
        return [['B', n[1]+5], ['C', n[1]+2], ['D', n[1]+3], ['F', n[1]+1]]
    if n[0]=='F':
        return [['D', n[1]+4], ['E', n[1]+1]]
 

def costo_uniforme (nodo_inicio, nodo_fin):
    lista = [[nodo_inicio, 0]]
    while lista:
        nodo_actual = lista.pop(0)
        print (nodo_actual)
        if nodo_actual[0] == nodo_fin[0]:
            return print ("SOLUCION")
        temp = sucesores (nodo_actual)
        print (temp)
        if temp:
            lista.extend(temp)
            lista.sort(key=lambda x: int(x[1]))
            print (lista)
    print ("NO-SOLUCION")

costo_uniforme ('A', 'F')
