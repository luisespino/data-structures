# Luis Espino 2020

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
        return tmp;

    #traversals

    def preorder(self):
        self._preorder(self.root)

    def _preorder(self, tmp):
        if tmp:
            print(tmp.value,end = ' ')
            self._preorder(tmp.left)            
            self._preorder(tmp.right)

    def inorder(self):
        self._inorder(self.root)

    def _inorder(self, tmp):
        if tmp:
            self._inorder(tmp.left)
            print(tmp.value,end = ' ')
            self._inorder(tmp.right)

    def postorder(self):
        self._postorder(self.root)

    def _postorder(self, tmp):
        if tmp:
            self._postorder(tmp.left)            
            self._postorder(tmp.right)
            print(tmp.value,end = ' ')
           

#init
t = BSTree()

#add
t.add(25)
t.add(10)
t.add(5)
t.add(20)
t.add(35)
t.add(30)
t.add(40)

#print traversals
t.preorder()
print()
t.inorder()
print()
t.postorder()
