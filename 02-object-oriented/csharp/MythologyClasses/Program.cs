using System;

abstract class Caballo
{
    public string Color;

    public Caballo()
    {
        this.Color = "blanco";
    }

    public void Caminar() { }
    public void Correr() { }

    public abstract void Parar();
}

interface IAlas
{
    void Volar();
}

interface ICuerno
{
    void Cornear();
}

interface ITorso
{
    void Hablar();
}

class Pegaso : Caballo, IAlas
{
    public string Color;

    public Pegaso(string color)
    {
        this.Color = color;
    }

    public void Show()
    {
        Console.WriteLine(Color);
    }

    public override void Parar() { }

    public void Volar() { }
}

class Unicornio : Caballo, ICuerno
{
    public Unicornio() : base() { }

    public override void Parar() { }

    public void Cornear() { }

    public void Show()
    {
        Console.WriteLine(Color);
    }
}

class Centauro : Caballo, ITorso
{
    public string Color;

    public Centauro(string color)
    {
        this.Color = color;
    }

    public override void Parar() { }

    public void Hablar() { }

    public void Show()
    {
        Console.WriteLine(Color);
    }
}

class MundoMitologico
{
    public Pegaso P = new Pegaso("negro");
    public Unicornio U = new Unicornio();
    public Centauro C = new Centauro("cafe");

    public static void Main(string[] args)
    {
        MundoMitologico M = new MundoMitologico();
        M.P.Show();
        M.U.Show();
        M.C.Show();
    }
}

