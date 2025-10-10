program LZW;

{$mode objfpc}{$H+}

uses
  SysUtils,
  Classes;

type
  TLZWCompressor = class
  private
    function FindInDictionary(const Dict: array of string;
      const Key: string; Count: integer): integer;
  public
    function Compress(const Input: ansistring): TBytes;
    function Decompress(const Compressed: TBytes): ansistring;
  end;

  function TLZWCompressor.FindInDictionary(const Dict: array of string;
  const Key: string; Count: integer): integer;
  var
    i: integer;
  begin
    for i := 0 to Count - 1 do
    begin
      if Dict[i] = Key then
      begin
        Exit(i);
      end;
    end;
    Exit(-1);
  end;

  function TLZWCompressor.Compress(const Input: ansistring): TBytes;
  var
    Dict: array of string;
    Codes: array of word;
    DictSize, CodeCount, i, Index: integer;
    Current, Next: string;
  begin
    SetLength(Dict, 4096);
    for i := 0 to 255 do
      Dict[i] := Chr(i);
    DictSize := 256;

    SetLength(Codes, 0);
    CodeCount := 0;
    Current := '';

    for i := 1 to Length(Input) do
    begin
      Next := Current + Input[i];
      Index := FindInDictionary(Dict, Next, DictSize);

      if Index <> -1 then
      begin
        Current := Next;
      end
      else
      begin
        Index := FindInDictionary(Dict, Current, DictSize);
        SetLength(Codes, CodeCount + 1);
        Codes[CodeCount] := Index;
        Inc(CodeCount);

        if DictSize < Length(Dict) then
        begin
          Dict[DictSize] := Next;
          Inc(DictSize);
        end;

        Current := Input[i];
      end;
    end;

    if Current <> '' then
    begin
      Index := FindInDictionary(Dict, Current, DictSize);
      SetLength(Codes, CodeCount + 1);
      Codes[CodeCount] := Index;
      Inc(CodeCount);
    end;

    // Convert to bytes
    SetLength(Result, CodeCount * 2);
    for i := 0 to CodeCount - 1 do
    begin
      Result[i * 2] := Codes[i] and $FF;
      Result[i * 2 + 1] := (Codes[i] shr 8) and $FF;
    end;
  end;

  function TLZWCompressor.Decompress(const Compressed: TBytes): ansistring;
  var
    Dict: array of string;
    Codes: array of word;
    DictSize, CodeCount, i: integer;
    PrevCode, CurrCode: word;
    PrevStr, CurrStr, Entry: string;
  begin
    // Convert bytes to word codes
    CodeCount := Length(Compressed) div 2;
    SetLength(Codes, CodeCount);
    for i := 0 to CodeCount - 1 do
      Codes[i] := Compressed[i * 2] + (Compressed[i * 2 + 1] shl 8);

    SetLength(Dict, 4096);
    for i := 0 to 255 do
      Dict[i] := Chr(i);
    DictSize := 256;

    PrevCode := Codes[0];
    PrevStr := Dict[PrevCode];
    Result := PrevStr;

    for i := 1 to CodeCount - 1 do
    begin
      CurrCode := Codes[i];

      if CurrCode < DictSize then
        CurrStr := Dict[CurrCode]
      else if CurrCode = DictSize then
        CurrStr := PrevStr + PrevStr[1]
      else
        raise Exception.Create('Invalid code during decompression.');

      Result := Result + CurrStr;
      Entry := PrevStr + CurrStr[1];

      if DictSize < Length(Dict) then
      begin
        Dict[DictSize] := Entry;
        Inc(DictSize);
      end;

      PrevStr := CurrStr;
    end;
  end;

var
  Compressor: TLZWCompressor;
  OriginalText, DecompressedText: ansistring;
  CompressedData: TBytes;
  i: integer;
begin
  OriginalText := 'ABABABAABABABABABABABABABABABABABABABABA';

  Compressor := TLZWCompressor.Create;
  try
    WriteLn('Original text:     ', OriginalText);
    WriteLn('Original size:     ', Length(OriginalText), ' bytes');
    WriteLn;

    CompressedData := Compressor.Compress(OriginalText);
    WriteLn('Compressed size:   ', Length(CompressedData), ' bytes');
    Write('Compressed bytes:  ');
    for i := 0 to Length(CompressedData) - 1 do
      Write(CompressedData[i], ' ');
    WriteLn;
    WriteLn;

    DecompressedText := Compressor.Decompress(CompressedData);
    WriteLn('Decompressed text: ', DecompressedText);
    WriteLn('Match:             ', BoolToStr(OriginalText =
      DecompressedText, True));

  finally
    Compressor.Free;
  end;
end.
