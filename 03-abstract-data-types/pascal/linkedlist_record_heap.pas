program linkedlist_record_heap;

{$mode objfpc}

type
    PNode = ^TNode;
    TNode = record
        data: Integer;
        next: PNode;
    end;

    PLinkedList = ^TLinkedList;
    TLinkedList = object
        head: PNode;
        procedure Init;
        procedure AddStart(aData: Integer);
        procedure Show;
    end;

procedure TLinkedList.Init;
begin
    head := nil;
end;

procedure TLinkedList.AddStart(aData: Integer);
var
    newNode: PNode;
begin
    New(newNode);
    newNode^.data := aData;
    newNode^.next := head;
    head := newNode;
end;

procedure TLinkedList.Show;
var
    tmp: PNode;
begin
    tmp := head;
    while tmp <> nil do
    begin
        WriteLn(tmp^.data);
        tmp := tmp^.next;
    end;
end;

var
    list1: TLinkedList;

begin
    list1.Init;
    list1.AddStart(5);
    list1.AddStart(10);
    list1.AddStart(7);
    list1.Show;
end.
