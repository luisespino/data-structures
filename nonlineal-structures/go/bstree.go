// Luis Espino 2021

package main

import "fmt"

// Node is a value with two pointers
type Node struct {
	value int
	left  *Node
	right *Node
}

// BST is a set of sorted Nodes
type BST struct {
	root *Node
}

func (bst *BST) add(value int) {
	bst.root = bst._add(value, bst.root)
}

func (bst BST) _add(value int, tmp *Node) *Node {
	if tmp == nil {
		return &Node{value: value}
	} else if value > tmp.value {
		tmp.right = bst._add(value, tmp.right)
	} else {
		tmp.left = bst._add(value, tmp.left)
	}
	return tmp
}

func (bst BST) preorder(tmp *Node) {
	if tmp != nil {
		fmt.Print(tmp.value, " ")
		bst.preorder(tmp.left)
		bst.preorder(tmp.right)
	}
}

func (bst BST) inorder(tmp *Node) {
	if tmp != nil {
		bst.inorder(tmp.left)
		fmt.Print(tmp.value, " ")
		bst.inorder(tmp.right)
	}
}

func (bst BST) postorder(tmp *Node) {
	if tmp != nil {
		bst.postorder(tmp.left)
		bst.postorder(tmp.right)
		fmt.Print(tmp.value, " ")
	}
}

func main() {
	t := BST{}
	t.add(25)
	t.add(10)
	t.add(5)
	t.add(20)
	t.add(35)
	t.add(30)
	t.add(40)
	fmt.Print("Preorder  : ")
	t.preorder(t.root)
	fmt.Println()
	fmt.Print("Inorder   : ")
	t.inorder(t.root)
	fmt.Println()
	fmt.Print("Postorder : ")
	t.postorder(t.root)
}
