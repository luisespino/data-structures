// Luis Espino 2020

#include <iostream>

using namespace std;

// clase abstracta
class Caballo
{
    void caminar(){}
    void correr(){}
    virtual void parar() = 0;
protected:
    string color;
public:
    Caballo(){
        color = "blanco";
    }
};

// interfaces
class Alas
{
    virtual void volar() = 0;
};

class Cuerno
{
    virtual void cornear() = 0;
};

class Torso
{
    virtual void hablar() = 0;
};

// clase concreta
class Pegaso: Caballo, Alas
{
    string color;
public:
    Pegaso(string color_): color(color_) {}
    void show()
    {
        cout << color << endl;
    }
    void parar(){}
    void volar(){}
};

// clase concreta
class Unicornio: Caballo, Cuerno
{
    void parar(){}
    void cornear(){}
public:
    Unicornio():Caballo(){} //super
    void show()
    {
        cout << color << endl;
    }

};

// clase concreta
class Centauro: Caballo, Torso
{
    string color;
    void parar(){}
    void hablar(){}
public:
    Centauro(string color_): color(color_) {}
    void show()
    {
        cout << color << endl;
    }
};

// clase principal
class MundoMitologico
{
public:
    Pegaso *p = new Pegaso("negro"); 
    Unicornio *u = new Unicornio(); 
    Centauro *c = new Centauro("cafe");
};

int main()
{   
    // declaración en el heap
    MundoMitologico *m = new MundoMitologico();
    m->p->show(); 
    m->u->show();

    // declaración en el stack
    Centauro c2("cafe");
    c2.show(); 
}
