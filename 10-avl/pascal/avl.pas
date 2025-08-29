program AVLTreeDemo;

{$mode objfpc}

uses
    Classes, SysUtils;

type
    TNode = class
        Value: Integer;
        Left, Right: TNode;
        Height: Integer;

        constructor Create(AValue: Integer);
    end;

    TAVLTree = class
        Root: TNode;

        procedure Add(AValue: Integer); overload;
        procedure Add(AValue: Integer; var tmp: TNode); overload;

        function HeightOf(Node: TNode): Integer;
        function Max(A, B: Integer): Integer;

        function SRL(Node: TNode): TNode;
        function SRR(Node: TNode): TNode;
        function DRL(Node: TNode): TNode;
        function DRR(Node: TNode): TNode;

        procedure Preorder(Node: TNode);
        procedure Inorder(Node: TNode);
        procedure Postorder(Node: TNode);

        procedure Levelorder(tmp: TNode);
        procedure GenDot(); overload;
        procedure GenDot(tmp: TNode); overload;

        function Magic(Node: TNode): Integer;
    end;

{ TNode }

constructor TNode.Create(AValue: Integer);
begin
    Value := AValue;
    Left := nil;
    Right := nil;
    Height := 0;
end;

{ TAVLTree }

procedure TAVLTree.Add(AValue: Integer);
begin
    if Root <> nil then
        Add(AValue, Root)
    else
        Root := TNode.Create(AValue);
end;

procedure TAVLTree.Add(AValue: Integer; var tmp: TNode);
var
    d, i, m: Integer;
begin
    if tmp = nil then
        tmp := TNode.Create(AValue)
    else if AValue < tmp.Value then
    begin
        Add(AValue, tmp.Left);
        if (HeightOf(tmp.Left) - HeightOf(tmp.Right)) = 2 then
        begin
            if AValue < tmp.Left.Value then
                tmp := SRL(tmp)
            else
                tmp := DRL(tmp);
        end;
    end
    else if AValue > tmp.Value then
    begin
        Add(AValue, tmp.Right);
        if (HeightOf(tmp.Right) - HeightOf(tmp.Left)) = 2 then
        begin
            if AValue > tmp.Right.Value then
                tmp := SRR(tmp)
            else
                tmp := DRR(tmp);
        end;
    end;

    d := HeightOf(tmp.Right);
    i := HeightOf(tmp.Left);
    m := Max(d, i);
    tmp.Height := m + 1;
end;


function TAVLTree.HeightOf(Node: TNode): Integer;
begin
    if Node = nil then
        Exit(-1)
    else
        Exit(Node.Height);
end;

function TAVLTree.Max(A, B: Integer): Integer;
begin
    if A > B then
        Exit(A)
    else
        Exit(B);
end;

function TAVLTree.SRL(Node: TNode): TNode;
var
    Temp: TNode;
begin
    Temp := Node.Left;
    Node.Left := Temp.Right;
    Temp.Right := Node;

    Node.Height := Max(HeightOf(Node.Left), HeightOf(Node.Right)) + 1;
    Temp.Height := Max(HeightOf(Temp.Left), Node.Height) + 1;

    Result := Temp;
end;

function TAVLTree.SRR(Node: TNode): TNode;
var
    Temp: TNode;
begin
    Temp := Node.Right;
    Node.Right := Temp.Left;
    Temp.Left := Node;

    Node.Height := Max(HeightOf(Node.Left), HeightOf(Node.Right)) + 1;
    Temp.Height := Max(HeightOf(Temp.Right), Node.Height) + 1;

    Result := Temp;
end;

function TAVLTree.DRL(Node: TNode): TNode;
begin
    Node.Left := SRR(Node.Left);
    Result := SRL(Node);
end;

function TAVLTree.DRR(Node: TNode): TNode;
begin
    Node.Right := SRL(Node.Right);
    Result := SRR(Node);
end;

procedure TAVLTree.Preorder(Node: TNode);
begin
    if Node <> nil then
    begin
        Write(Node.Value, ' ');
        Preorder(Node.Left);
        Preorder(Node.Right);
    end;
end;

procedure TAVLTree.Inorder(Node: TNode);
begin
    if Node <> nil then
    begin
        Inorder(Node.Left);
        Write(Node.Value, ' ');
        Inorder(Node.Right);
    end;
end;

procedure TAVLTree.Postorder(Node: TNode);
begin
    if Node <> nil then
    begin
        Postorder(Node.Left);
        Postorder(Node.Right);
        Write(Node.Value, ' ');
    end;
end;

procedure TAVLTree.Levelorder(tmp: TNode);
var
    queue: TList;
    node: TNode;
begin
    if tmp = nil then Exit;

    queue := TList.Create;
    try
        queue.Add(tmp);

        while queue.Count > 0 do
        begin
            node := TNode(queue[0]);
            queue.Delete(0);
            Write(node.value, ' ');

            if node.left <> nil then
                queue.Add(node.left);
            if node.right <> nil then
                queue.Add(node.right);
        end;
    finally
        queue.Free;
    end;
end;

procedure TAVLTree.GenDot();
begin
    Writeln('graph AVLTree {');
    Writeln('    node [shape=circle];');
    GenDot(root);
    Writeln('}');
end;

procedure TAVLTree.GenDot(tmp: TNode);
begin
    if tmp <> nil then
    begin
        if tmp.left <> nil then 
            Writeln('    "', tmp.value, '" -- "', tmp.left.value, '";'); 
        if tmp.right <> nil then 
            Writeln('    "', tmp.value, '" -- "', tmp.right.value, '";'); 
        GenDot(tmp.left);
        GenDot(tmp.right);
    end;
end;

function TAVLTree.Magic(Node: TNode): Integer;
begin
    if Node <> nil then
        Result := Node.Value + Magic(Node.Right) - Magic(Node.Left)
    else
        Result := 0;
end;

{ Main }

var
    AVL: TAVLTree;
begin
    AVL := TAVLTree.Create;
    try
        AVL.Add(5); AVL.Add(10); AVL.Add(15); AVL.Add(20);
        AVL.Add(25); AVL.Add(30); AVL.Add(35);

        Write('Preorder: ');
        AVL.Preorder(AVL.Root); Writeln;

        Write('Inorder: ');
        AVL.Inorder(AVL.Root); Writeln;

        Write('Postorder: ');
        AVL.Postorder(AVL.Root); Writeln;

        Write('Levelorder: ');
        AVL.Levelorder(AVL.Root); Writeln;

        Write('DOT: ');
        AVL.GenDot(); Writeln;

        //Writeln('Altura: ', AVL.HeightOf(AVL.Root));
        //Writeln('Magic: ', AVL.Magic(AVL.Root));
    finally
        AVL.Free;
    end;
end.
