program MajorOrder2D;

var
    m: array[0..3, 0..3] of Integer = (
        (0, 1, 2, 3),
        (4, 5, 6, 7),
        (8, 9, 10, 11),
        (12, 13, 14, 15)
    );
    rowmajor, colmajor: array[0..15] of Integer;
    i, j: Integer;

begin
    for i := 0 to 3 do
        for j := 0 to 3 do
            begin
                rowmajor[j + 4 * i] := m[i, j];
                colmajor[i + 4 * j] := m[i, j];
            end;

    for i := 0 to 15 do
        Write(rowmajor[i], ' ');
    Writeln;

    for i := 0 to 15 do
        Write(colmajor[i], ' ');
    Writeln;
end.
