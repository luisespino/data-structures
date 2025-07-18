program swap_pointers;

{$mode objfpc}

procedure Swap(a, b: PInteger);
var
    temp: Integer;
begin
    temp := a^;
    a^ := b^;
    b^ := temp;
end;

var
    x, y: Integer;
    p1, p2: ^Integer;

begin
    x := 100;
    y := 200;
    p1 := @x;
    p2 := @y;

    Writeln('Before the swap:');
    Writeln('x = ', x);
    Writeln('y = ', y);

    Swap(p1, p2);

    Writeln('After the swap:');
    Writeln('x = ', x);
    Writeln('y = ', y);
end.
