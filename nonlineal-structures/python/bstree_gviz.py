# Luis Espino 2021

from graphviz import Graph

def inc():
    global i
    i += 1
    return i

class Node:
    def __init__(self, value):
        self.value = value
        self.left  = None
        self.right = None

class BSTree:
    def __init__(self):
        self.root = None

    #add        
    def add(self, value):
        self.root = self._add(value, self.root)
    
    def _add(self, value, tmp):
        if tmp is None:
            return Node(value)        
        elif (value>tmp.value):
            tmp.right=self._add(value, tmp.right)
        else:
            tmp.left=self._add(value, tmp.left)
        return tmp

    #traversals
    def gviz(self, parent):
        self._gviz(self.root, parent)

    def _gviz(self, tmp, parent):
        if tmp:
            id = inc()
            dot.node(str(id),str(tmp.value))
            if parent:         
                dot.edge(str(parent), str(id))
            self._gviz(tmp.left, id)
            self._gviz(tmp.right, id)

#init
t = BSTree()
i = 0
dot = Graph()
dot.attr(splines='false')
dot.node_attr.update(shape='oval', fontname='arial', color='blue4', fontcolor='blue4')
dot.edge_attr.update(color='blue4') 

#add
t.add(25)
t.add(10)
t.add(5)
t.add(20)
t.add(35)
t.add(30)
t.add(40)

#print tree
t.gviz(None)
dot.view()