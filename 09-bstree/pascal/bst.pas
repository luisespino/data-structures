program BSTreeDemo;

{$mode objfpc}

uses
    Classes, SysUtils, Generics.Collections;
    
type
    TNode = class
        value: Integer;
        left, right: TNode;

        constructor Create(val: Integer);
    end;

    TBST = class
        root: TNode;

        procedure Add(value: Integer); overload;
        procedure Add(value: Integer; tmp: TNode); overload;

        procedure Preorder(tmp: TNode);
        procedure Inorder(tmp: TNode);
        procedure Postorder(tmp: TNode);        
        procedure Levelorder(tmp: TNode);
        procedure GenDot(); overload;
        procedure GenDot(tmp: TNode); overload;
    end;

{ TNode }

constructor TNode.Create(val: Integer);
begin
    value := val;
    left := nil;
    right := nil;
end;

{ TBST }

procedure TBST.Add(value: Integer);
begin
    if root <> nil then
        Add(value, root)
    else
        root := TNode.Create(value);
end;

procedure TBST.Add(value: Integer; tmp: TNode);
begin
    if value < tmp.value then
    begin
        if tmp.left <> nil then
            Add(value, tmp.left)
        else
            tmp.left := TNode.Create(value);
    end
    else
    begin
        if tmp.right <> nil then
            Add(value, tmp.right)
        else
            tmp.right := TNode.Create(value);
    end;
end;

procedure TBST.Preorder(tmp: TNode);
begin
    if tmp <> nil then
    begin
        Write(tmp.value, ' ');
        Preorder(tmp.left);
        Preorder(tmp.right);
    end;
end;

procedure TBST.Inorder(tmp: TNode);
begin
    if tmp <> nil then
    begin
        Inorder(tmp.left);
        Write(tmp.value, ' ');
        Inorder(tmp.right);
    end;
end;

procedure TBST.Postorder(tmp: TNode);
begin
    if tmp <> nil then
    begin
        Postorder(tmp.left);
        Postorder(tmp.right);
        Write(tmp.value, ' ');
    end;
end;

procedure TBST.Levelorder(tmp: TNode);
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

procedure TBST.GenDot();
begin
    Writeln('graph BSTree {');
    Writeln('    node [shape=circle];');
    GenDot(root);
    Writeln('}');
end;

procedure TBST.GenDot(tmp: TNode);
begin
    if tmp <> nil then
    begin
        if tmp.left <> nil then 
            Writeln('    "', tmp.value, '" -- "', tmp.left.value, '";'); 
        if tmp.left <> nil then 
            Writeln('    "', tmp.value, '" -- "', tmp.right.value, '";'); 
        GenDot(tmp.left);
        GenDot(tmp.right);
    end;
end;


{ Main }

var
    bst: TBST;

begin
    bst := TBST.Create;
    try
        bst.Add(25); bst.Add(10);
        bst.Add(35); bst.Add(5);
        bst.Add(20); bst.Add(30);
        bst.Add(40);

        Writeln;
        Write('Preorder: ');
        bst.Preorder(bst.root); Writeln;

        Write('Inorder: ');
        bst.Inorder(bst.root); Writeln;

        Write('Postorder: ');
        bst.Postorder(bst.root); Writeln;

        Write('Levelorder: ');
        bst.Levelorder(bst.root); Writeln;

        Write('DOT: ');
        bst.GenDot(); Writeln;

    finally
        bst.Free;
    end;
end.
