program Sort;

{$mode objfpc}

var
    a: array[0..4] of Integer = (17, 10, 12, 7, 11);

procedure Show;
var
    i: Integer;
begin
    Write('[');
    for i := 0 to High(a) do
        Write(a[i], ' ');
    Writeln(']');
end;

procedure BubbleSort;
var
    i, j, aux, itera: Integer;
begin
    itera := 0;
    for i := 0 to High(a) - 1 do
        for j := i + 1 to High(a) do
            if a[i] > a[j] then
            begin
                aux := a[i];
                a[i] := a[j];
                a[j] := aux;
                Show;
                Inc(itera);
            end;
    Writeln('Iteraciones: ', itera);
end;

procedure SelectionSort;
var
    i, j, menor, aux, itera: Integer;
begin
    itera := 0;
    for i := 0 to High(a) - 1 do
    begin
        menor := i;
        for j := i + 1 to High(a) do
        begin
            Show;
            Inc(itera);
            if a[menor] > a[j] then
                menor := j;
        end;
        aux := a[i];
        a[i] := a[menor];
        a[menor] := aux;
    end;
    Writeln('Iteraciones: ', itera);
end;

procedure InsertionSort;
var
    i, j, aux, itera: Integer;
begin
    itera := 0;
    for i := 0 to High(a) do
    begin
        j := i;
        aux := a[i];
        while (j > 0) and (a[j - 1] > aux) do
        begin
            a[j] := a[j - 1];
            Dec(j);
            Show;
            Inc(itera);
        end;
        a[j] := aux;
    end;
    Writeln('Iteraciones: ', itera);
end;

procedure QuickSort(primero, ultimo: Integer);
var
    i, j, central, pivote, aux: Integer;
begin
    i := primero;
    j := ultimo;
    central := (primero + ultimo) div 2;
    pivote := a[central];

    repeat
        while a[i] < pivote do Inc(i);
        while a[j] > pivote do Dec(j);
        if i <= j then
        begin
            aux := a[i];
            a[i] := a[j];
            a[j] := aux;
            Inc(i);
            Dec(j);
            Show;
        end;
    until i > j;

    if primero < j then
        QuickSort(primero, j);
    if i < ultimo then
        QuickSort(i, ultimo);
end;

begin
    Writeln('Bubble Sort:');
    Show;
    BubbleSort;
    // SelectionSort;
    // InsertionSort;
    // QuickSort(0, High(a));
    Show;
end.
