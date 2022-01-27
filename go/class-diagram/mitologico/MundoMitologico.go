package main

import "fmt"

type Caballo struct {
	color string
}

func NewCaballo() *Caballo {
	return &Caballo{"blanco"}
}

func (c Caballo) caminar() {}

func (c Caballo) correr() {}

func (c Caballo) parar() {}

type Alas interface {
	volar()
}

type Cuerno interface {
	cornear()
}

type Torso interface {
	hablar()
}

type Pegaso struct {
	Caballo
}

func (p Pegaso) volar() {}

func (p Pegaso) show() {
	fmt.Println(p.color)
}

type Unicornio struct {
	Caballo
}

func (u Unicornio) cornear() {}

func (u Unicornio) show() {
	fmt.Println(u.color)
}

type Centauro struct {
	Caballo
}

func (c Centauro) hablar() {}

func (c Centauro) show() {
	fmt.Println(c.color)
}

type MundoMitologico struct {
	p Pegaso
	u Unicornio
	c Centauro
}

func main() {
	m := MundoMitologico{
		Pegaso{Caballo{color: "negro"}},
		Unicornio{Caballo{color: "blanco"}},
		Centauro{Caballo{color: "cafe"}},
	}
	m.p.show()
	m.u.show()
	m.c.show()
}
