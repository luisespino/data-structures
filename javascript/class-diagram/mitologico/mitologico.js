// Autor: Luis Espino
// 2022

// abstract class and interfaces are not supported,
// but abstract class can use throw new Error
// and interfaces can use prototype "Duck typing"

// abstract
class Caballo{
    constructor() {
        this.color = "blanco"
    }
    caminar() {
        // ...
    }
    correr() {
        // ...
    }
    parar() {
        throw new Error("Method 'parar()' must be implemented.")
    }
}

// multiple inheritance is not supported,
// but double inheritance is possible

// interface
class Alas extends Caballo {
    volar() {
        throw new Error("Method 'volar()' must be implemented.")
    }
}

// interface
class Cuerno extends Caballo {
    cornear() {
        throw new Error("Method 'cornear()' must be implemented.")
    }
}

// interface
class Torso extends Caballo {
    hablar() {
        throw new Error("Method 'hablar()' must be implemented.")
    }
}

class Pegaso extends Alas{
    constructor(color) {
        this.color = color
    }
    show() {
        document.getElementById("log").innerHTML+=color+"<br>"
    }
    parar() {
        // ...
    }
    volar() {
        // ...
    }
}

class Unicornio extends Cuerno{
    constructor () {
        super()
    }
    parar() {
        // ...
    }
    cornear() {
        // ...
    }
    show() {
    	document.getElementById("log").innerHTML+=color+"<br>"
    }
}

class Centauro extends Torso{
    constructor (color) {
        this.color = color
    }
    parar() {
        // ...
    }
    hablar() {
        // ...
    }
    show() {
    	document.getElementById("log").innerHTML+=color+"<br>"
    }
}

class MundoMitologico {
    p = new Pegaso("negro")
    u = new Unicornio()
    c = new Centauro("cafe")
}

m = new MundoMitologico();
m.p.show();
m.u.show();
m.c.show();

