package main

import "fmt"

func main() {
	// row major 3d
	var m = [2][2][2]int{{{0, 1}, {2, 3}}, {{4, 5}, {6, 7}}}
	var rowmajor [8]int
	var colmajor [8]int
	var i, j, k int
	for i = 0; i < 2; i++ {
		for j = 0; j < 2; j++ {
			for k = 0; k < 2; k++ {
				rowmajor[k+2*(j+2*i)] = m[i][j][k]
				colmajor[i+2*(j+2*k)] = m[i][j][k]
			}
		}
	}
	fmt.Print("Row-major: ");
	for i = 0; i < 8; i++ {
		fmt.Print(rowmajor[i], " ")
	}
	fmt.Println();
	fmt.Print("Col-major: ");
	for i = 0; i < 8; i++ {
		fmt.Print(colmajor[i], " ")
	}	
	fmt.Println();
}
