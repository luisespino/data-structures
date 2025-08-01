{$mode objfpc}
program SparseMatrixDemo;

uses
    SysUtils;

type
    PSparseNode = ^TSparseNode;
    TSparseNode = class
    public
        data: string;
        row, col: Integer;
        up, down, right, left: TSparseNode;
        constructor Create(const aData: string; aRow, aCol: Integer);
    end;

    TSparseMatrix = class
    private
        head: TSparseNode;
    public
        constructor Create;
        destructor Destroy; override;
        procedure Add(const data: string; row, col: Integer);
        procedure PrintRef(dim: Integer);
    end;

constructor TSparseNode.Create(const aData: string; aRow, aCol: Integer);
begin
    data := aData;
    row := aRow;
    col := aCol;
    up := nil;
    down := nil;
    right := nil;
    left := nil;
end;

constructor TSparseMatrix.Create;
begin
    head := TSparseNode.Create('XX', 0, 0);
end;

destructor TSparseMatrix.Destroy;
begin
    // Aquí podrías liberar todos los nodos si deseas
    inherited Destroy;
end;

procedure TSparseMatrix.Add(const data: string; row, col: Integer);
var
    ci, cip, ri, rip, newNode, tmp: TSparseNode;
    update: Boolean;
begin
    ci := head;
    cip := nil;
    update := False;
    newNode := nil;

    while ci <> nil do
    begin
        if ci.col = col then
        begin
            ri := ci;
            rip := nil;
            while ri <> nil do
            begin
                if ri.row = row then
                begin
                    ri.data := data;
                    update := True;
                    Break;
                end
                else if ri.row > row then
                begin
                    newNode := TSparseNode.Create(data, row, col);
                    newNode.up := rip;
                    newNode.down := ri;
                    if rip <> nil then rip.down := newNode;
                    ri.up := newNode;
                    if col = 0 then update := True;
                    Break;
                end
                else if ri.down = nil then
                begin
                    newNode := TSparseNode.Create(data, row, col);
                    newNode.up := ri;
                    ri.down := newNode;
                    if col = 0 then update := True;
                    Break;
                end;
                rip := ri;
                ri := ri.down;
            end;
            Break;
        end
        else if ci.col > col then
        begin
            if row = 0 then
            begin
                newNode := TSparseNode.Create(data, row, col);
                newNode.left := cip;
                newNode.right := ci;
                if cip <> nil then cip.right := newNode;
                ci.left := newNode;
                update := True;
            end
            else
            begin
                tmp := TSparseNode.Create('XX', 0, col);
                tmp.left := cip;
                tmp.right := ci;
                if cip <> nil then cip.right := tmp;
                ci.left := tmp;
                newNode := TSparseNode.Create(data, row, col);
                tmp.down := newNode;
                newNode.up := tmp;
            end;
            Break;
        end
        else if ci.right = nil then
        begin
            if row = 0 then
            begin
                newNode := TSparseNode.Create(data, row, col);
                newNode.left := ci;
                ci.right := newNode;
                update := True;
            end
            else
            begin
                tmp := TSparseNode.Create('XX', 0, col);
                tmp.left := ci;
                ci.right := tmp;
                newNode := TSparseNode.Create(data, row, col);
                tmp.down := newNode;
                newNode.up := tmp;
            end;
            Break;
        end;
        cip := ci;
        ci := ci.right;
    end;

    if not update then
    begin
        ri := head;
        rip := nil;
        while ri <> nil do
        begin
            if ri.row = row then
            begin
                ci := ri;
                cip := nil;
                while ci <> nil do
                begin
                    if ci.col > col then
                    begin
                        newNode.left := cip;
                        newNode.right := ci;
                        if cip <> nil then cip.right := newNode;
                        ci.left := newNode;
                        Break;
                    end
                    else if ci.right = nil then
                    begin
                        newNode.left := ci;
                        ci.right := newNode;
                        Break;
                    end;
                    cip := ci;
                    ci := ci.right;
                end;
                Break;
            end
            else if ri.row > row then
            begin
                if col = 0 then
                begin
                    newNode.up := rip;
                    newNode.down := ri;
                    if rip <> nil then rip.down := newNode;
                    ri.up := newNode;
                end
                else
                begin
                    tmp := TSparseNode.Create('XX', row, 0);
                    tmp.up := rip;
                    tmp.down := ri;
                    if rip <> nil then rip.down := tmp;
                    ri.up := tmp;
                    tmp.right := newNode;
                    newNode.left := tmp;
                end;
                Break;
            end
            else if ri.down = nil then
            begin
                if col = 0 then
                begin
                    newNode.up := ri;
                    ri.down := newNode;
                end
                else
                begin
                    tmp := TSparseNode.Create('XX', row, 0);
                    tmp.up := ri;
                    ri.down := tmp;
                    tmp.right := newNode;
                    newNode.left := tmp;
                end;
                Break;
            end;
            rip := ri;
            ri := ri.down;
        end;
    end;
end;

procedure TSparseMatrix.PrintRef(dim: Integer);
var
    i, j: Integer;
    r, c: TSparseNode;
begin
    r := head;
    for i := 0 to dim - 1 do
    begin
        if r <> nil then
        begin
            if r.row = i then
            begin
                c := r;
                for j := 0 to dim - 1 do
                begin
                    if (c <> nil) and (c.col = j) then
                    begin
                        Write(c.data, ' ');
                        c := c.right;
                    end
                    else
                        Write('-- ');
                end;
                r := r.down;
            end
            else
            begin
                for j := 0 to dim - 1 do
                    Write('-- ');
            end;
        end
        else
        begin
            for j := 0 to dim - 1 do
                Write('-- ');
        end;
        Writeln;
    end;
end;

var
    sp: TSparseMatrix;

begin
    sp := TSparseMatrix.Create;
    sp.Add('00', 0, 0);
    sp.Add('02', 0, 2);
    sp.Add('03', 0, 3);
    sp.Add('11', 1, 1);
    sp.Add('22', 2, 2);
    sp.Add('30', 3, 0);
    sp.Add('33', 3, 3);
    sp.PrintRef(4);
    sp.Free;
end.
