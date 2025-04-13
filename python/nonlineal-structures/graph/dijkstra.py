
def dijkstra (origen):
    distancia = [None]*len(ady)
    visto     = [None]*len(ady)
    camino    = [None]*len(ady)
    for i in range(len(ady)):
        distancia[i] = inf
        visto[i]     = False
    distancia[origen] = 0
    camino[origen]    = -1    
    for c in range(len(ady)):
        min = inf
        i = 0
        for j in range(len(ady)):
            if not visto[j] and distancia[j] < min:
                min = distancia[j]
                i   = j
        visto[i] = True        
        for j in range(len(ady)):
            if not visto[j] and ady[i][j] and distancia[i]!=inf \
               and distancia[i]+ady[i][j] < distancia[j]:
                distancia[j] = distancia[i] + ady[i][j]
                camino[j]    = i
    print("Nodo\tDistancia\tCamino")
    for i in range(len(ady)):
        print(str(i)+'\t'+str(distancia[i])+
              '\t'+'\t'+str(camino[i]))

inf = 9999


ady = [[0, 5, 6, 0, 0, 0],
       [5, 0, 6, 3, 5, 0],
       [6, 6, 0, 0, 2, 0],
       [0, 3, 0, 0, 3, 4],
       [0, 5, 2, 3, 0, 1],
       [0, 0, 0, 4, 1, 0]]



dijkstra(0)

ady = [[0, 6, 0, 4, 7, 0, 0, 0],
       [6, 0, 0, 7, 0, 3, 9, 0],
       [0, 0, 0, 0, 4,4, 0, 0],
       [4, 7, 0, 0, 0, 5, 0, 5],
       [7, 0, 4, 0, 0, 0, 0, 6],
       [0, 3, 4, 5, 0, 0, 0, 0],
       [0, 9, 0, 0, 0, 0, 0, 8],
       [0, 0, 0, 5, 6, 0, 8, 0]]




ady = [[0, 7, 0, 0, 0, 0, 0, 0],
       [7, 0, 2, 0, 0, 0, 0, 0],
       [0, 2, 0, 0, 4, 0, 5, 0],
       [0, 0, 0, 0, 0, 0, 0, 7],
       [0, 0, 4, 0, 0, 0, 0, 8],
       [0, 0, 0, 0, 0, 0, 1, 0],
       [0, 0, 5, 0, 0, 1, 0, 0],
       [0, 0, 0, 7, 8, 0, 0, 0]]
