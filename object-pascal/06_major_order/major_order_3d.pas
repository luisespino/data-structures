program RowColMajor3D;

var
    m: array[0..1, 0..1, 0..1] of Integer = (
        (
            (0, 1),
            (2, 3)
        ),
        (
            (4, 5),
            (6, 7)
        )
    );
    rowmajor, colmajor: array[0..7] of Integer;
    i, j, k: Integer;

begin
    for i := 0 to 1 do
        for j := 0 to 1 do
            for k := 0 to 1 do
            begin
                rowmajor[k + 2 * (j + 2 * i)] := m[i, j, k];
                colmajor[i + 2 * (j + 2 * k)] := m[i, j, k];
            end;

    Write('Row-major: ');
    for i := 0 to 7 do
        Write(rowmajor[i], ' ');
    Writeln;

    Write('Col-major: ');
    for i := 0 to 7 do
        Write(colmajor[i], ' ');
    Writeln;
end.
