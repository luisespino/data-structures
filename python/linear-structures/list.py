class Node:
    def __init__(self, data=None):
        self.data = data
        self.next = None

class LinkedList:
    def __init__(self):
        self.head = None

    def addStart(self, data):
        tmp = Node(data)
        tmp.next = self.head
        self.head = tmp

    def show(self):
        tmp = self.head
        while tmp is not None:
            print (tmp.data)
            tmp = tmp.next

list1 = LinkedList()
list1.addStart(5)
list1.addStart(10)
list1.addStart(7)
list1.show()
