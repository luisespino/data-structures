program StaticSparseMatrixDemo;

{$mode objfpc}

uses
    SysUtils;

const
    MAX = 4;

type
    TMatrix = array[0..MAX - 1, 0..MAX - 1] of Integer;

    TStaticSparseMatrix = class
    private
        val: array of Integer;
        row: array of Integer;
        col: array of Integer;
        values: Integer;
    public
        constructor Create(const m: TMatrix);
        destructor Destroy; override;
        procedure Print;
    end;

constructor TStaticSparseMatrix.Create(const m: TMatrix);
var
    i, j, nvalues: Integer;
begin
    values := 0;
    for i := 0 to High(m) do
        for j := 0 to High(m[i]) do
            if m[i][j] <> 0 then
                Inc(values);

    SetLength(val, values);
    SetLength(row, values);
    SetLength(col, values);

    nvalues := 0;
    for i := 0 to High(m) do
        for j := 0 to High(m[i]) do
            if m[i][j] <> 0 then
            begin
                val[nvalues] := m[i][j];
                row[nvalues] := i;
                col[nvalues] := j;
                Inc(nvalues);
            end;
end;

destructor TStaticSparseMatrix.Destroy;
begin
    val := nil;
    row := nil;
    col := nil;
    inherited Destroy;
end;

procedure TStaticSparseMatrix.Print;
var
    i: Integer;
begin
    Write('val: ');
    for i := 0 to High(val) do
        Write(val[i], ' ');
    Writeln;

    Write('row: ');
    for i := 0 to High(row) do
        Write(row[i], ' ');
    Writeln;

    Write('col: ');
    for i := 0 to High(col) do
        Write(col[i], ' ');
    Writeln;
end;

var
    m: TMatrix = (
        (5, 4, 0, 0),
        (0, 1, 0, 0),
        (0, 0, 6, 0),
        (0, 0, 3, 2)
    );
    s: TStaticSparseMatrix;

begin
    s := TStaticSparseMatrix.Create(m);
    s.Print;
    s.Free;
end.
