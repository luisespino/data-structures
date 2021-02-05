package main

import "fmt"

func main() {
	// row major 3d
	var m = [2][2][2]int{{{0, 4}, {1, 5}}, {{2, 6}, {3, 7}}}
	var a [8]int
	var i, j, k int
	for i = 0; i < 2; i++ {
		for j = 0; j < 2; j++ {
			for k = 0; k < 2; k++ {
				a[k+2*(j+2*i)] = m[i][j][k]
			}
		}
	}
	for i = 0; i < 8; i++ {
		fmt.Print(a[i], " ")
	}
}
