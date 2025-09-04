// © 2025 Luis Espino. All rights reserved.

program BTreeProgram;

{$mode objfpc}

uses
    SysUtils;

type
    TBTreeNode = class
    public
        const
            MAX = 3;
            MIN = 1;
        var
            val: array[0..MAX] of Integer;
            num: Integer;
            link: array[0..MAX] of TBTreeNode;
        constructor Create;
    end;

    TBTree = class
    private
        root: TBTreeNode;
        function SetValue(val: Integer; out pval: Integer; node: TBTreeNode; out child: TBTreeNode): Boolean;
        function CreateNode(val: Integer; child: TBTreeNode): TBTreeNode;
        procedure InsertNode(val, pos: Integer; node, child: TBTreeNode);
        procedure SplitNode(val: Integer; out pval: Integer; pos: Integer; node, child: TBTreeNode; out newNode: TBTreeNode);
    public
        constructor Create;
        procedure Insert(val: Integer);
        procedure Traversal(myNode: TBTreeNode);
        procedure ExportDot(const FileName: string);
        procedure TraversalDot(myNode: TBTreeNode; var F: Text);
    end;

constructor TBTreeNode.Create;
var
    i: Integer;
begin
    num := 0;
    for i := 0 to MAX do
    begin
        val[i] := 0;
        link[i] := nil;
    end;
end;

constructor TBTree.Create;
begin
    root := nil;
end;

procedure TBTree.Insert(val: Integer);
var
    i: Integer;
    child: TBTreeNode;
begin
    if SetValue(val, i, root, child) then
        root := CreateNode(i, child);
end;

function TBTree.SetValue(val: Integer; out pval: Integer; node: TBTreeNode; out child: TBTreeNode): Boolean;
var
    pos: Integer;
begin
    if node = nil then
    begin
        pval := val;
        child := nil;
        Exit(True);
    end;

    if val < node.val[1] then
        pos := 0
    else
    begin
        pos := node.num;
        while (val < node.val[pos]) and (pos > 1) do
            Dec(pos);
        if val = node.val[pos] then
        begin
            WriteLn('Duplicates not allowed');
            pval := 0;
            child := nil;
            Exit(False);
        end;
    end;

    if SetValue(val, pval, node.link[pos], child) then
    begin
        if node.num < TBTreeNode.MAX then
            InsertNode(pval, pos, node, child)
        else
        begin
            SplitNode(pval, pval, pos, node, child, child);
            Exit(True);
        end;
    end;
    Result := False;
end;

function TBTree.CreateNode(val: Integer; child: TBTreeNode): TBTreeNode;
var
    newNode: TBTreeNode;
begin
    newNode := TBTreeNode.Create;
    newNode.val[1] := val;
    newNode.num := 1;
    newNode.link[0] := root;
    newNode.link[1] := child;
    Result := newNode;
end;

procedure TBTree.InsertNode(val, pos: Integer; node, child: TBTreeNode);
var
    j: Integer;
begin
    j := node.num;
    while j > pos do
    begin
        node.val[j + 1] := node.val[j];
        node.link[j + 1] := node.link[j];
        Dec(j);
    end;
    node.val[j + 1] := val;
    node.link[j + 1] := child;
    Inc(node.num);
end;

procedure TBTree.SplitNode(val: Integer; out pval: Integer; pos: Integer; node, child: TBTreeNode; out newNode: TBTreeNode);
var
    median, j: Integer;
begin
    if pos > TBTreeNode.MIN then
        median := TBTreeNode.MIN + 1
    else
        median := TBTreeNode.MIN;

    newNode := TBTreeNode.Create;
    j := median + 1;
    while j <= TBTreeNode.MAX do
    begin
        newNode.val[j - median] := node.val[j];
        newNode.link[j - median] := node.link[j];
        Inc(j);
    end;

    node.num := median;
    newNode.num := TBTreeNode.MAX - median;

    if pos <= TBTreeNode.MIN then
        InsertNode(val, pos, node, child)
    else
        InsertNode(val, pos - median, newNode, child);

    pval := node.val[node.num];
    newNode.link[0] := node.link[node.num];
    Dec(node.num);
end;

procedure TBTree.Traversal(myNode: TBTreeNode);
var
    i: Integer;
begin
    if myNode <> nil then
    begin
        Write('[');
        for i := 0 to myNode.num - 1 do
            Write(myNode.val[i + 1], ',');
        for i := 0 to myNode.num do
            Traversal(myNode.link[i]);
        Write(']');
    end;
end;

procedure TBTree.ExportDot(const FileName: string);
var
    F: Text;
begin
    AssignFile(F, FileName);
    Rewrite(F);
    try
        Writeln(F, 'graph BTree {');
        Writeln(F, '    node [shape=record];');
        if root <> nil then
            TraversalDot(root, F);
        Writeln(F, '}');
    finally
        CloseFile(F);
    end;
end;

procedure TBTree.TraversalDot(myNode: TBTreeNode; var F: Text);
var
    i: Integer;
    id, childId, lbl: string;
begin
    if myNode = nil then Exit;

    id := 'N' + IntToHex(PtrUInt(myNode) and $FFF, 3);
    
    lbl := '';
    for i := 1 to myNode.num do
    begin
        if i > 1 then
            lbl := lbl + ' | ';
        lbl := lbl + IntToStr(myNode.val[i]);
    end;
    if lbl = '' then
        lbl := ' ';

    Writeln(F, '    ', id, ' [label="', lbl, '"];');

    for i := 0 to myNode.num do
    begin
        if myNode.link[i] <> nil then
        begin
            childId := 'N' + IntToHex(PtrUInt(myNode.link[i]) and $FFF, 3);
            Writeln(F, '    ', id, ' -- ', childId, ';');
            TraversalDot(myNode.link[i], F);
        end;
    end;
end;

var
    t: TBTree;
begin
    t := TBTree.Create;
    t.Insert(5); t.Insert(10);
    t.Insert(15); t.Insert(20);
    t.Insert(25); t.Insert(30);
    t.Insert(35); t.Insert(40);
    t.Insert(45); t.Insert(50);

    Write('http://mshang.ca/syntree/: ');
    t.Traversal(t.root);
    WriteLn;

    t.ExportDot('btree.dot');
    WriteLn('Generated DOT file: btree.dot');
    t.Free;

end.
