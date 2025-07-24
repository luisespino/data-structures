program linkedlist_class_heap;

{$mode objfpc}

type
    TNode = class
        data: Integer;
        next: TNode;
        constructor Create(aData: Integer);
    end;

    TLinkedList = class
        head: TNode;
        procedure AddStart(aData: Integer);
        procedure Show;
    end;

constructor TNode.Create(aData: Integer);
begin
    data := aData;
    next := nil;
end;

procedure TLinkedList.AddStart(aData: Integer);
var
    newNode: TNode;
begin
    newNode := TNode.Create(aData);
    newNode.next := head;
    head := newNode;
end;

procedure TLinkedList.Show;
var
    tmp: TNode;
begin
    tmp := head;
    while tmp <> nil do
    begin
        WriteLn(tmp.data);
        tmp := tmp.next;
    end;
end;

var
    list1: TLinkedList;

begin
    list1 := TLinkedList.Create;
    list1.AddStart(5);
    list1.AddStart(10);
    list1.AddStart(7);
    list1.Show;

    // Liberar memoria (opcional en programas cortos, recomendable en más grandes)
    list1.Free;
end.
