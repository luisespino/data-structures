// Autor: Luis Espino
// 2020

abstract class Caballo{
    String color;    
    Caballo(){
        this.color = "blanco";
    }
    void caminar(){};
    void correr(){};
    abstract void parar();
}

interface Alas{
    void volar();
}

interface Cuerno{
    void cornear();
}

interface Torso{
    void hablar();
}

class Pegaso extends Caballo implements Alas{
    String color;
    Pegaso(String color){
    	this.color = color;
    }
    void show(){
        System.out.println(color);
    }
    void parar() {};
    public void volar() {};
}

class Unicornio extends Caballo implements Cuerno{
    void parar(){};
    public void cornear(){};
    Unicornio(){
    	super();
    } 
    void show(){
    	System.out.println(color);
    }

}

class Centauro extends Caballo implements Torso{
    String color;
    void parar(){}
    public void hablar(){}
    Centauro(String color){
    	this.color = color;    	
    }
    void show()    {
    	System.out.println(color);
    }
}

public class MundoMitologico {
    Pegaso p = new Pegaso("negro");
    Unicornio u = new Unicornio();
    Centauro c = new Centauro("cafe");

    public static void main(String[] args) {
	MundoMitologico m = new MundoMitologico();
	m.p.show();
	m.u.show();
	m.c.show();
    }
}
