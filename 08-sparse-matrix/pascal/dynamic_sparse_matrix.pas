program DynamicSparseMatrix;

{$mode objfpc}

uses
    SysUtils;

type
    TNodoC = class
    public
        derecha: TNodoC;
        abajo: TNodoC;
        valorStr: string;
        constructor Create(const v: string);
    end;

    TNodoFila = class
    public
        numFilaVal: Integer;
        siguiente: TNodoFila;
        derecha: TNodoC;
        constructor Create(fila: Integer);
    end;

    TNodoColumna = class
    public
        numColVal: Char;
        siguiente: TNodoColumna;
        abajo: TNodoC;
        constructor Create(col: Char);
    end;

    TDynamicSparseMatrix = class
    public
        primeroFila: TNodoFila;
        primeroColumna: TNodoColumna;
        constructor Create;
        procedure agregarNodoFila(fila: Integer);
        procedure agregarNodoColumna(col: Char);
        procedure agregar(valor: string; columna: Char; fila: Integer);
        procedure mostrarColumnas;
        procedure mostrarFilas;
    end;

constructor TNodoC.Create(const v: string);
begin
    valorStr := v;
    derecha := nil;
    abajo := nil;
end;

constructor TNodoFila.Create(fila: Integer);
begin
    numFilaVal := fila;
    siguiente := nil;
    derecha := nil;
end;

constructor TNodoColumna.Create(col: Char);
begin
    numColVal := col;
    siguiente := nil;
    abajo := nil;
end;

constructor TDynamicSparseMatrix.Create;
begin
    primeroFila := nil;
    primeroColumna := nil;
end;

procedure TDynamicSparseMatrix.agregarNodoFila(fila: Integer);
var
    nuevo: TNodoFila;
begin
    nuevo := TNodoFila.Create(fila);
    if primeroFila = nil then
        primeroFila := nuevo
    else
    begin
        nuevo.siguiente := primeroFila;
        primeroFila := nuevo;
    end;
end;

procedure TDynamicSparseMatrix.agregarNodoColumna(col: Char);
var
    nuevo: TNodoColumna;
begin
    nuevo := TNodoColumna.Create(col);
    if primeroColumna = nil then
        primeroColumna := nuevo
    else
    begin
        nuevo.siguiente := primeroColumna;
        primeroColumna := nuevo;
    end;
end;

procedure TDynamicSparseMatrix.agregar(valor: string; columna: Char; fila: Integer);
var
    nuevo: TNodoC;
    tempCol: TNodoColumna;
    tempFila: TNodoFila;
    temp: TNodoC;
begin
    nuevo := TNodoC.Create(valor);

    tempCol := primeroColumna;
    while tempCol <> nil do
    begin
        if tempCol.numColVal = columna then
        begin
            if tempCol.abajo = nil then
                tempCol.abajo := nuevo
            else
            begin
                temp := tempCol.abajo;
                while temp.abajo <> nil do
                    temp := temp.abajo;
                temp.abajo := nuevo;
            end;
            Break;
        end;
        tempCol := tempCol.siguiente;
    end;

    tempFila := primeroFila;
    while tempFila <> nil do
    begin
        if tempFila.numFilaVal = fila then
        begin
            if tempFila.derecha = nil then
                tempFila.derecha := nuevo
            else
            begin
                temp := tempFila.derecha;
                while temp.derecha <> nil do
                    temp := temp.derecha;
                temp.derecha := nuevo;
            end;
            Break;
        end;
        tempFila := tempFila.siguiente;
    end;
end;

procedure TDynamicSparseMatrix.mostrarColumnas;
var
    temp: TNodoColumna;
begin
    Write('  ');
    temp := primeroColumna;
    while temp <> nil do
    begin
        Write(temp.numColVal, ' ');
        temp := temp.siguiente;
    end;
    Writeln;
end;

procedure TDynamicSparseMatrix.mostrarFilas;
var
    temp: TNodoFila;
    t: TNodoC;
begin
    temp := primeroFila;
    while temp <> nil do
    begin
        Write(temp.numFilaVal, ' ');
        t := temp.derecha;
        while t <> nil do
        begin
            Write(t.valorStr, ' ');
            t := t.derecha;
        end;
        Writeln;
        temp := temp.siguiente;
    end;
end;

var
    sm: TDynamicSparseMatrix;

begin
    sm := TDynamicSparseMatrix.Create;
    sm.agregarNodoColumna('C');
    sm.agregarNodoColumna('B');
    sm.agregarNodoColumna('A');
    sm.agregarNodoFila(3);
    sm.agregarNodoFila(2);
    sm.agregarNodoFila(1);
    sm.agregar('5', 'A', 1);
    sm.agregar('8', 'A', 2);
    sm.agregar('7', 'B', 2);
    sm.agregar('1', 'A', 3);
    sm.agregar('3', 'B', 3);
    sm.agregar('9', 'C', 3);
    sm.mostrarColumnas;
    sm.mostrarFilas;
end.
