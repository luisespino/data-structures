// Luis Espino 2021
// Example of Binary Search Tree of Lists

package main

import "fmt"

// NodeList is a integer with next pointer
type NodeList struct {
	data string
	next *NodeList
}

// List with stack insert
type List struct {
	head *NodeList
}

func (l *List) add(data string) {
	l.head = &NodeList{data: data, next: l.head}
}

func (l *List) show() {
	tmp := l.head
	fmt.Print("[ ")
	for tmp != nil {
		fmt.Print(tmp.data, " ")
		tmp = tmp.next
	}
	fmt.Println("]")
}

// Node is a key with two pointers
type Node struct {
	key   int
	value *List
	left  *Node
	right *Node
}

// BST is a set of sorted Nodes
type BST struct {
	root *Node
}

func (bst *BST) add(key int, value *List) {
	bst.root = bst._add(key, value, bst.root)
}

func (bst BST) _add(key int, value *List, tmp *Node) *Node {
	if tmp == nil {
		return &Node{key: key, value: value}
	} else if key > tmp.key {
		tmp.right = bst._add(key, value, tmp.right)
	} else {
		tmp.left = bst._add(key, value, tmp.left)
	}
	return tmp
}

func (bst BST) show(tmp *Node) {
	if tmp != nil {
		bst.show(tmp.left)
		fmt.Print(tmp.key, " ")
		tmp.value.show()
		bst.show(tmp.right)
	}
}

func main() {
	bst := &BST{}
	tmp := &List{}
	tmp.add("FERNANDEZ")
	tmp.add("SANTIAGO")
	bst.add(25, tmp)
	tmp = &List{}
	tmp.add("LEMUS")
	tmp.add("KARLA")
	bst.add(5, tmp)
	tmp = &List{}
	tmp.add("CABRERA")
	tmp.add("ANGEL")
	bst.add(10, tmp)
	tmp = &List{}
	tmp.add("GONZALEZ")
	tmp.add("CARLOS")
	bst.add(41, tmp)
	bst.show(bst.root)
}
