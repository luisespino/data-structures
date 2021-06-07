class Nodo {
  constructor(valor) {
    this.valor = valor
    this.siguiente = null
  }
}

class Lista{
  constructor() {
    this.cabeza = null
  }
  
  agregar(valor) {
    var temp = new Nodo(valor)
    temp.siguiente = this.cabeza
    this.cabeza = temp
  }
  
  mostrar() {
    var temp = this.cabeza
    document.getElementById("log").innerHTML+="[ "    
    while(temp) {
      document.getElementById("log").innerHTML+=temp.valor+" ";
      temp = temp.siguiente
    }
    document.getElementById("log").innerHTML+="]"
  } 
}

var a = []

for (var i = 0; i < 5; i++) {
a[i] = new Lista()
}

a[1%5].agregar(1)
a[3%5].agregar(3)
a[6%5].agregar(6)
a[8%5].agregar(8)
a[14%5].agregar(14)

for (var i = 0; i < 5; i++) {
document.getElementById("log").innerHTML+="<br>"+i+" -> "  
a[i].mostrar()
}
