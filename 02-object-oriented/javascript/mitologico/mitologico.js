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
    constructor() {
        super()
    }
    volar() {
        throw new Error("Method 'volar()' must be implemented.")
    }
}

// interface
class Cuerno extends Caballo {
    constructor() {
        super()
    }
    cornear() {
        throw new Error("Method 'cornear()' must be implemented.")
    }
}

// interface
class Torso extends Caballo {
    constructor() {
        super()
    }
    hablar() {
        throw new Error("Method 'hablar()' must be implemented.")
    }
}

class Pegaso extends Alas {
    constructor(color) {
        super()
        this.color = color
    }
    show() {
        document.getElementById("log").innerHTML+=this.color+"<br>"
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
    	document.getElementById("log").innerHTML+=this.color+"<br>"
    }
}

class Centauro extends Torso{
    constructor (color) {
        super();
        this.color = color
    }
    parar() {
        // ...
    }
    hablar() {
        // ...
    }
    show() {
    	document.getElementById("log").innerHTML+=this.color+"<br>"
    }
}

class MundoMitologico {
    constructor() {
        this.p = new Pegaso("negro")
        this.u = new Unicornio()
        this.c = new Centauro("cafe")    
    }
}

document.getElementById("log").innerHTML+="constructors result:<br>"
var m = new MundoMitologico()
m.p.show()
m.u.show()
m.c.show()

