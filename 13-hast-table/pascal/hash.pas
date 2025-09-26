program HashExample;

{$mode objfpc}{$H+}

uses
    SysUtils;

type
    { THash }
    THash = class
    private
        FCount, FSize: Integer;
        FMin, FMax: Integer;
        FData: array of Integer;
        function Division(k: Integer): Integer;
        function Linear(k: Integer): Integer;
        procedure Init;
        procedure Rehashing;
    public
        constructor Create(m, min, max: Integer);
        procedure Insert(k: Integer);
        procedure Print;
    end;

{ THash }

constructor THash.Create(m, min, max: Integer);
begin
    FSize := m;
    FMin := min;
    FMax := max;
    Init;
end;

function THash.Division(k: Integer): Integer;
begin
    Result := k mod FSize;
end;

function THash.Linear(k: Integer): Integer;
begin
    Result := (k + 1) mod FSize;
end;

procedure THash.Init;
var
    i: Integer;
begin
    FCount := 0;
    SetLength(FData, FSize);
    for i := 0 to FSize - 1 do
        FData[i] := -1;
end;

procedure THash.Insert(k: Integer);
var
    i: Integer;
begin
    i := Division(k);
    while FData[i] <> -1 do
        i := Linear(i);
    FData[i] := k;
    Inc(FCount);
    Rehashing;
end;

procedure THash.Rehashing;
var
    temp: array of Integer;
    i, prevSize: Integer;
begin
    if (FCount * 100 div FSize) >= FMax then
    begin
        SetLength(temp, FSize);
        for i := 0 to FSize - 1 do
            temp[i] := FData[i];

        Print;

        prevSize := FSize;
        FSize := FCount * 100 div FMin;
        Init;

        for i := 0 to prevSize - 1 do
            if temp[i] <> -1 then
                Insert(temp[i]);
    end
    else
        Print;
end;

procedure THash.Print;
var
    i: Integer;
begin
    Write('[');
    for i := 0 to FSize - 1 do
        Write(' ', FData[i]);
    WriteLn(' ] ', (FCount * 100 div FSize), '%');
end;

{ === Programa principal === }

var
    hash: THash;

begin
    hash := THash.Create(5, 20, 80); // m, min, max
    hash.Insert(5);
    hash.Insert(10);
    hash.Insert(15);
    hash.Insert(20);
    hash.Insert(25);
    hash.Insert(30);
end.
