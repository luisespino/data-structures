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
    document.getElementById("log").innerHTML+="<br>[ "
    document.getElementById("log").innerHTML+=temp
    while(temp) {
      document.getElementById("log").innerHTML+=temp.valor;
      document.getElementById("log").innerHTML+=" ";
      temp = temp.siguiente
    }
    document.getElementById("log").innerHTML+="]"
  } 
}

var lista = new Lista()
lista.agregar(10)
lista.agregar(15)
lista.agregar(5)
lista.mostrar()
