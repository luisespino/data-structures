package main

import "fmt"

func main() {
	var a [5]List
	a[1%5].add(1)
	a[3%5].add(3)
	a[6%5].add(6)
	a[8%5].add(8)
	a[14%5].add(14)
	var i int
	for i = 0; i < 5; i++ {
		fmt.Print(i, " -> ")
		a[i].show()
		fmt.Println()
	}
}
