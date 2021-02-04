package main

import "fmt"

func main() {
	var a *int
	b := 10
	a = &b
	c := &a
	d := a
	fmt.Println("b ", b)
	fmt.Println("&b ", &b)
	fmt.Println("a ", a)
	fmt.Println("&a ", &a)
	fmt.Println("*a ", *a)
	fmt.Println("c ", c)
	fmt.Println("c ", c)
	fmt.Println("&c ", &c)
	fmt.Println("*c ", *c)
	fmt.Println("**c ", **c)
	fmt.Println("*&c ", *&c)
	fmt.Println("&*c ", &*c)
	fmt.Println("d ", d)
	fmt.Println("&d ", &d)
	fmt.Println("*d ", *d)
}
