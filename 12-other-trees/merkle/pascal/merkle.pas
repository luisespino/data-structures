program MerkleMain;

uses
    MerkleUnit, Classes, SysUtils;

var
    m: TMerkle;
    dotOutput: TStringList;

begin
    m := TMerkle.Create;
    try
        m.Add(4);
        m.Add(5);
        m.Add(6);
        m.Add(7);
        m.Add(8);
        m.Auth;

        dotOutput := TStringList.Create;
        try
            m.Show(dotOutput);
            Writeln;
            Writeln('Datablock:');
            Writeln(dotOutput.Text);
        finally
            dotOutput.Free;
        end;

        m.dot := '{node [shape=box];';
        m.DotGen(m.tophash);
        m.dot := m.dot + '}';
        Writeln('DOT Graph:');
        Writeln(m.dot);
    finally
        m.Free;
    end;
end.
