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
    let temp = new Nodo(valor)
    temp.siguiente = this.cabeza
    this.cabeza = temp
  }
  
  mostrar() {
    let temp = this.head
    document.getElementById("log").innerHTML+="<br>[ "
    while(temp) {
      document.getElementById("log").innerHTML+=temp.valor;
      document.getElementById("log").innerHTML+=" ";
      temp = temp.siguiente
    }
    document.getElementById("log").innerHTML+="]"
  }
  
}
