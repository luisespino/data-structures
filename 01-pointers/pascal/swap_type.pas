program swap_type;

{$mode objfpc}

type
    PInteger = ^Integer;

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

begin
    x := 100;
    y := 200;

    Writeln('Before the swap:');
    Writeln('x = ', x);
    Writeln('y = ', y);

    Swap(@x, @y);

    Writeln('After the swap:');
    Writeln('x = ', x);
    Writeln('y = ', y);
end.
