package main

import "fmt"

func main() {
	// row major 2d
	var m = [4][4]int{{0, 1, 2, 3}, {4, 5, 6, 7}, {8, 9, 10, 11}, {12, 13, 14, 15}}
	var rowmajor [16]int
	var colmajor [16]int
	var i, j int
	for i = 0; i < 4; i++ {
		for j = 0; j < 4; j++ {
			rowmajor[j+4*i] = m[i][j]
			colmajor[i+4*j] = m[i][j]
		}
	}
	for i = 0; i < 16; i++ {
		fmt.Print(rowmajor[i], " ")
	}
	fmt.Println()
		for i = 0; i < 16; i++ {
		fmt.Print(colmajor[i], " ")
	}
	fmt.Println()	
}

