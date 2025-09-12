program MerklePascal;

{$mode objfpc}{$H+}

uses
    SysUtils, Math;

type
    TDataNode = class
    public
        Value: Integer;
        Next: TDataNode; // No se usa pero se conserva para equivalencia
        constructor Create(AValue: Integer);
    end;

    THashNode = class
    public
        Hash: Integer;
        Left: THashNode;
        Right: THashNode;
        Down: TDataNode;
        constructor Create(AHash: Integer);
    end;

    TMerkle = class
    private
        FTopHash: THashNode;
        FDataBlock: array of TDataNode;
        FDot: string;
        FMax: Integer;
        FIndex: Integer;

        procedure CreateTree(tmp: THashNode; exp: Integer);
        procedure GenHash(tmp: THashNode; n: Integer);
        procedure Preorder(tmp: THashNode);
        procedure DotGen(tmp: THashNode);
    public
        constructor Create(AMax: Integer);
        destructor Destroy; override;
        procedure Add(value: Integer);
        procedure Auth;
        procedure Show;
        property Dot: string read FDot write FDot;
        property TopHash: THashNode read FTopHash;
    end;

{ TDataNode }

constructor TDataNode.Create(AValue: Integer);
begin
    Value := AValue;
    Next := nil;
end;

{ THashNode }

constructor THashNode.Create(AHash: Integer);
begin
    Hash := AHash;
    Left := nil;
    Right := nil;
    Down := nil;
end;

{ TMerkle }

constructor TMerkle.Create(AMax: Integer);
begin
    FTopHash := nil;
    FMax := AMax;
    FIndex := 0;
    SetLength(FDataBlock, FMax);
    FDot := '';
end;

destructor TMerkle.Destroy;
var
    i: Integer;

    procedure FreeHashNode(node: THashNode);
    begin
        if node = nil then Exit;
        FreeHashNode(node.Left);
        FreeHashNode(node.Right);
        node.Free;
    end;

begin
    for i := 0 to Length(FDataBlock) - 1 do
        if Assigned(FDataBlock[i]) then
            FDataBlock[i].Free;

    FreeHashNode(FTopHash);
    inherited Destroy;
end;

procedure TMerkle.Add(value: Integer);
begin
    if FIndex >= Length(FDataBlock) then
        SetLength(FDataBlock, FIndex + 1);
    FDataBlock[FIndex] := TDataNode.Create(value);
    Inc(FIndex);
end;

procedure TMerkle.CreateTree(tmp: THashNode; exp: Integer);
begin
    if exp > 0 then
    begin
        tmp.Left := THashNode.Create(0);
        tmp.Right := THashNode.Create(0);
        CreateTree(tmp.Left, exp - 1);
        CreateTree(tmp.Right, exp - 1);
    end;
end;

procedure TMerkle.GenHash(tmp: THashNode; n: Integer);
begin
    if tmp = nil then Exit;

    GenHash(tmp.Left, n);
    GenHash(tmp.Right, n);

    if (tmp.Left = nil) and (tmp.Right = nil) then
    begin
        tmp.Down := FDataBlock[n - FIndex];
        Dec(FIndex);
        tmp.Hash := tmp.Down.Value * 10;
    end
    else
        tmp.Hash := (tmp.Left.Hash + tmp.Right.Hash) * 10;
end;

procedure TMerkle.Preorder(tmp: THashNode);
begin
    if tmp = nil then Exit;

    Write(tmp.Hash, ' ');
    Preorder(tmp.Left);
    Preorder(tmp.Right);
end;

procedure TMerkle.Auth;
var
    exp, i: Integer;
    total: Integer;
begin
    exp := 1;
    while Power(2, exp) < (FIndex + 1) do
        Inc(exp);

    total := Trunc(Power(2, exp));

    for i := FIndex to total - 1 do
    begin
        FDataBlock[i] := TDataNode.Create(i * 100);
        Inc(FIndex);
    end;

    Writeln(#10'DATABLOCK: ');
    for i := 0 to FIndex - 1 do
        Write(FDataBlock[i].Value, ' ');
    Writeln;

    FTopHash := THashNode.Create(0);
    CreateTree(FTopHash, exp);
    GenHash(FTopHash, FIndex);

    Writeln(#10'PRE-ORDER MERKLE TREE: ');
    Preorder(FTopHash);
    Writeln;
    Writeln;
end;


procedure TMerkle.Show;
var
    i: Integer;
begin
    for i := 0 to FIndex - 1 do
        Write(FDataBlock[i].Value, ' ');
    Writeln;
end;

procedure TMerkle.DotGen(tmp: THashNode);
begin
    if tmp = nil then Exit;

    FDot += Format('%d [label="%d"];', [tmp.Hash, tmp.Hash]);

    if tmp.Left <> nil then
        FDot += Format('%d--%d;', [tmp.Hash, tmp.Left.Hash]);

    if tmp.Right <> nil then
        FDot += Format('%d--%d;', [tmp.Hash, tmp.Right.Hash]);

    DotGen(tmp.Left);
    DotGen(tmp.Right);

    if (tmp.Left = nil) and (tmp.Right = nil) and (tmp.Down <> nil) then
    begin
        FDot += Format('%d [label="%d" shape=rect];', [tmp.Down.Value, tmp.Down.Value]);
        FDot += Format('%d--%d;', [tmp.Hash, tmp.Down.Value]);
    end;
end;

{ Main }

var
    m: TMerkle;

begin
    m := TMerkle.Create(8);
    try
        m.Add(4);
        m.Add(5);
        m.Add(6);
        m.Add(7);
        m.Add(8);

        m.Auth;

        m.FDot := 'graph{';
        m.DotGen(m.TopHash);
        m.FDot += '}';

        Writeln(m.Dot);
    finally
        m.Free;
    end;
end.
