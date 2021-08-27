# Luis Espino 2021
# Examples of Binary Search Tree of Lists

class NodeList:
    def __init__(self, value):
        self.value = value
        self.next = None

class List:
    def __init__(self):
        self.head = None

    def add(self, value):
        tmp = NodeList(value)
        tmp.next = self.head
        self.head = tmp

    def show(self):
        print("[", end = " ")
        tmp = self.head
        while tmp:
            print(tmp.value, end=" ")
            tmp = tmp.next
        print("]")

class Node:
    def __init__(self, value, list):
        self.value = value
        self.list  = list
        self.left  = None
        self.right = None

class BSTree:
    def __init__(self):
        self.root = None

    #add
        
    def add(self, value, list):
        self.root = self._add(value, list, self.root)
    
    def _add(self, value, list, tmp):
        if tmp is None:
            return Node(value, list)        
        elif (value>tmp.value):
            tmp.right=self._add(value, list, tmp.right)
        else:
            tmp.left=self._add(value, list, tmp.left)
        return tmp

    #traversal

    def show(self):
        self._show(self.root)

    def _show(self, tmp):
        if tmp:
            self._show(tmp.left)
            print(str(tmp.value), end = " ")
            tmp.list.show()
            self._show(tmp.right)

#init
t = BSTree()

#add
tmp = List()
tmp.add("Fernandez")
tmp.add("Santiago")
bst = BSTree()
bst.add(25, tmp)

tmp = List()
tmp.add("Lemus")
tmp.add("Karla")
bst.add(5, tmp)

tmp = List()
tmp.add("Cabrera")
tmp.add("Angel")
bst.add(10, tmp)

tmp = List()
tmp.add("Gonzalez")
tmp.add("Carlos")
bst.add(41, tmp)

#print tree
bst.show()