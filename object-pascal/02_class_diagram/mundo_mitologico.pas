program MundoMitologico;

{$mode objfpc}

type
    // Clase base
    TCaballo = class(TInterfacedObject) // avoid COM subsystem
    protected
        FColor: String;
    public
        constructor Create;
        procedure Caminar; virtual;
        procedure Correr; virtual;
        procedure Parar; virtual; abstract;
    end;

    // Interfaces
    IAlas = interface
        procedure Volar;
    end;

    ICuerno = interface
        procedure Cornear;
    end;

    ITorso = interface
        procedure Hablar;
    end;

    // Clases derivadas
    TPegaso = class(TCaballo, IAlas)
    public
        constructor Create(AColor: String);
        procedure Show;
        procedure Parar; override;
        procedure Volar;
    end;

    TUnicornio = class(TCaballo, ICuerno)
    public
        constructor Create;
        procedure Show;
        procedure Parar; override;
        procedure Cornear;
    end;

    TCentauro = class(TCaballo, ITorso)
    public
        constructor Create(AColor: String);
        procedure Show;
        procedure Parar; override;
        procedure Hablar;
    end;

    // Clase mundo
    TMundoMitologico = class
    public
        pegaso: TPegaso;
        unicornio: TUnicornio;
        centauro: TCentauro;
        constructor Create;
        destructor Destroy; override;
    end;

{ TCaballo }

constructor TCaballo.Create;
begin
    FColor := 'blanco';
end;

procedure TCaballo.Caminar;
begin
    // vacía
end;

procedure TCaballo.Correr;
begin
    // vacía
end;

{ TPegaso }

constructor TPegaso.Create(AColor: String);
begin
    inherited Create;
    FColor := AColor;
end;

procedure TPegaso.Show;
begin
    WriteLn('Pegaso: ', FColor);
end;

procedure TPegaso.Parar;
begin
    // vacía
end;

procedure TPegaso.Volar;
begin
    // vacía
end;

{ TUnicornio }

constructor TUnicornio.Create;
begin
    inherited Create;
    FColor := 'blanco';
end;

procedure TUnicornio.Show;
begin
    WriteLn('Unicornio: ', FColor);
end;

procedure TUnicornio.Parar;
begin
    // vacía
end;

procedure TUnicornio.Cornear;
begin
    // vacía
end;

{ TCentauro }

constructor TCentauro.Create(AColor: String);
begin
    inherited Create;
    FColor := AColor;
end;

procedure TCentauro.Show;
begin
    WriteLn('Centauro: ', FColor);
end;

procedure TCentauro.Parar;
begin
    // vacía
end;

procedure TCentauro.Hablar;
begin
    // vacía
end;

{ TMundoMitologico }

constructor TMundoMitologico.Create;
begin
    inherited Create;
    pegaso := TPegaso.Create('negro');
    unicornio := TUnicornio.Create;
    centauro := TCentauro.Create('café');
end;

destructor TMundoMitologico.Destroy;
begin
    pegaso.Free;
    unicornio.Free;
    centauro.Free;
    inherited Destroy;
end;

{ Programa principal }

var
    mundo: TMundoMitologico;

begin
    mundo := TMundoMitologico.Create;
    try
        mundo.pegaso.Show;
        mundo.unicornio.Show;
        mundo.centauro.Show;
    finally
        mundo.Free;
    end;
end.
