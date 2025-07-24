program RecursiveFunctions;

uses SysUtils;

function Mult(a, b: Integer): Integer;
begin
    if b > 0 then
        Mult := a + Mult(a, b - 1)
    else
        Mult := 0;
end;

function Divi(a, b: Integer): Integer;
begin
    if a >= b then
        Divi := 1 + Divi(a - b, b)
    else
        Divi := 0;
end;

function Fact(n: Integer): Integer;
begin
    if n > 1 then
        Fact := n * Fact(n - 1)
    else
        Fact := 1;
end;

function Fibo(n: Integer): Integer;
begin
    if n > 1 then
        Fibo := Fibo(n - 1) + Fibo(n - 2)
    else
        Fibo := n;
end;

function Acker(m, n: Integer): Integer;
begin
    if m = 0 then
        Acker := n + 1
    else if n = 0 then
        Acker := Acker(m - 1, 1)
    else
        Acker := Acker(m - 1, Acker(m, n - 1));
end;

function Par(n: Integer): Boolean; forward;
function Impar(n: Integer): Boolean; forward;

function Par(n: Integer): Boolean;
begin
    if n = 0 then
        Par := True
    else
        Par := Impar(n - 1);
end;

function Impar(n: Integer): Boolean;
begin
    if n = 0 then
        Impar := False
    else
        Impar := Par(n - 1);
end;

begin
    WriteLn('3 * 2    : ', Mult(3, 2));
    WriteLn('6 / 3    : ', Divi(6, 3));
    WriteLn('fact(5)  : ', Fact(5));
    WriteLn('fibo(5)  : ', Fibo(5));
    WriteLn('ack(2,2) : ', Acker(2, 2));
    WriteLn('impar(3) : ', BoolToStr(Impar(3), True));
    WriteLn('par(3)   : ', BoolToStr(Par(3), True));
end.
