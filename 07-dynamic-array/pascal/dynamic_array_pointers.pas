program DynamicArrayPointers;

uses
    SysUtils;

type
    PInteger = ^Integer;

var
    Data: PInteger;
    Count: Integer;
    Capacity: Integer;
    i: Integer;
    NewValue: LongInt;
    ContinueInput: Boolean;
    Input: string;

procedure ResizeArray(NewCapacity: Integer);
begin
    if Capacity = 0 then
        GetMem(Data, NewCapacity * SizeOf(Integer))
    else
        ReallocMem(Data, NewCapacity * SizeOf(Integer));
    Capacity := NewCapacity;
end;

function GetElement(ptr: PInteger; index: Integer): PInteger;
begin
    GetElement := PInteger(PByte(ptr) + index * SizeOf(Integer));
end;

begin
    Count := 0;
    Capacity := 0;
    Data := nil;
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
                if Count = Capacity then
                begin
                    if Capacity = 0 then
                        ResizeArray(4)
                    else
                        ResizeArray(Capacity * 2);
                end;
                GetElement(Data, Count)^ := NewValue;
                Inc(Count);
            end
            else
                Writeln('Invalid entrance, try again.');
        end;
    end;

    Writeln(#10'Array content:');
    for i := 0 to Count - 1 do
        Writeln('Element [', i, '] = ', GetElement(Data, i)^);

    if Assigned(Data) then
        FreeMem(Data);
end.
