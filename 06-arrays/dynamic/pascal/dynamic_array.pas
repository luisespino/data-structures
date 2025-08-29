program DynamicArray;

uses
    SysUtils;

var
    Numbers: array of Integer;
    i: Integer;
    NewValue: LongInt;
    ContinueInput: Boolean;
    Input: string;

begin
    SetLength(Numbers, 0); // init
    ContinueInput := True;

    while ContinueInput do
    begin
        Write('Enter a number ("x" to exit): ');
        ReadLn(Input);

        if LowerCase(Input) = 'x' then
            ContinueInput := False
        else
        begin
            if TryStrToInt(Input, NewValue) then
            begin
                SetLength(Numbers, Length(Numbers) + 1);
                Numbers[High(Numbers)] := NewValue;
            end
            else
                Writeln('Invalid entrance, try again.');
        end;
    end;

    // Mostrar el contenido del arreglo
    Writeln(#10'Array content:');
    for i := 0 to High(Numbers) do
        Writeln('Element [', i, '] = ', Numbers[i]);

end.
