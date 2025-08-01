{$mode objfpc}
program OrthogonalListDynamic;

type
    TIntDynMatrix = array of array of Integer;

    TMatrixNode = class
        Val: Integer;
        Up, Down, Left, Right: TMatrixNode;
        constructor Create(AVal: Integer);
    end;

constructor TMatrixNode.Create(AVal: Integer);
begin
    Val := AVal;
    Up := nil;
    Down := nil;
    Left := nil;
    Right := nil;
end;

procedure BuildOrthogonalList(const Matrix: TIntDynMatrix; Rows, Cols: Integer; out Head: TMatrixNode);
var
    Nodes: array of array of TMatrixNode;
    i, j: Integer;
begin
    SetLength(Nodes, Rows, Cols);

    for i := 0 to Rows - 1 do
        for j := 0 to Cols - 1 do
            Nodes[i,j] := TMatrixNode.Create(Matrix[i][j]);

    for i := 0 to Rows - 1 do
        for j := 0 to Cols - 1 do
        begin
            if i > 0 then
            begin
                Nodes[i,j].Up := Nodes[i-1,j];
                Nodes[i-1,j].Down := Nodes[i,j];
            end;
            if j > 0 then
            begin
                Nodes[i,j].Left := Nodes[i,j-1];
                Nodes[i,j-1].Right := Nodes[i,j];
            end;
        end;

    Head := Nodes[0,0];
end;

procedure PrintOrthogonalList(Head: TMatrixNode; Rows, Cols: Integer);
var
    i, j: Integer;
    RowPtr, ColPtr: TMatrixNode;
begin
    RowPtr := Head;
    for i := 0 to Rows - 1 do
    begin
        ColPtr := RowPtr;
        for j := 0 to Cols - 1 do
        begin
            Write(ColPtr.Val, ' ');
            ColPtr := ColPtr.Right;
        end;
        Writeln;
        RowPtr := RowPtr.Down;
    end;
end;

procedure FreeOrthogonalList(Head: TMatrixNode; Rows, Cols: Integer);
var
    i, j: Integer;
    Nodes: array of array of TMatrixNode;
    RowPtr, ColPtr: TMatrixNode;
begin
    SetLength(Nodes, Rows, Cols);

    RowPtr := Head;
    for i := 0 to Rows - 1 do
    begin
        ColPtr := RowPtr;
        for j := 0 to Cols - 1 do
        begin
            Nodes[i,j] := ColPtr;
            ColPtr := ColPtr.Right;
        end;
        RowPtr := RowPtr.Down;
    end;

    for i := 0 to Rows - 1 do
        for j := 0 to Cols - 1 do
            Nodes[i,j].Free;
end;

var
    Matrix: TIntDynMatrix;
    Head: TMatrixNode;
    Rows, Cols: Integer;
begin
    Rows := 3;
    Cols := 3;
    SetLength(Matrix, Rows, Cols);

    Matrix[0,0] := 1; 
    Matrix[1,1] := 5; 
    Matrix[2,2] := 9;

    BuildOrthogonalList(Matrix, Rows, Cols, Head);
    PrintOrthogonalList(Head, Rows, Cols);
    FreeOrthogonalList(Head, Rows, Cols);
end.
