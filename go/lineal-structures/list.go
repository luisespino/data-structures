package main

import "fmt"

type Node struct {
	data int
	next *Node
}

type List struct {
	head *Node
}

func (l *List) add(data int) {
	tmp := &Node{data: data, next: l.head}
	l.head = tmp
}

func (l *List) show() {
	tmp := l.head
	for tmp != nil {
		fmt.Print(tmp.data, " ")
		tmp = tmp.next
	}
}

func main2() { //Go does not allow multiple main
	l := List{}
	l.add(3)
	l.add(9)
	l.add(6)
	l.show()
}
