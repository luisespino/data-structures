program LZW_VariableBit;

{$mode objfpc}{$H+}

uses
  SysUtils;

type
  TLZWCompressor = class
  private
    function FindInDictionary(const Dict: array of string;
      const Key: string; Count: integer): integer;
    procedure WriteBits(var Buffer: TBytes; var BitPos: integer;
      Value, NumBits: integer);
    function ReadBits(const Buffer: TBytes; var BitPos: integer;
      NumBits: integer): integer;
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
      if Dict[i] = Key then
        Exit(i);
    Exit(-1);
  end;

  // Escribe NumBits de Value en el buffer
  procedure TLZWCompressor.WriteBits(var Buffer: TBytes; var BitPos: integer;
    Value, NumBits: integer);
  var
    ByteIndex, BitOffset, i: integer;
  begin
    for i := 0 to NumBits - 1 do
    begin
      ByteIndex := BitPos div 8;
      BitOffset := BitPos mod 8;
      if ByteIndex >= Length(Buffer) then
        SetLength(Buffer, ByteIndex + 1);
      if ((Value shr i) and 1) = 1 then
        Buffer[ByteIndex] := Buffer[ByteIndex] or (1 shl BitOffset);
      Inc(BitPos);
    end;
  end;

  // Lee NumBits desde el buffer
  function TLZWCompressor.ReadBits(const Buffer: TBytes; var BitPos: integer;
    NumBits: integer): integer;
  var
    ByteIndex, BitOffset, i, Bit: integer;
  begin
    Result := 0;
    for i := 0 to NumBits - 1 do
    begin
      ByteIndex := BitPos div 8;
      BitOffset := BitPos mod 8;
      if ByteIndex >= Length(Buffer) then
        Break;
      Bit := (Buffer[ByteIndex] shr BitOffset) and 1;
      Result := Result or (Bit shl i);
      Inc(BitPos);
    end;
  end;

  function TLZWCompressor.Compress(const Input: ansistring): TBytes;
  var
    Dict: array of string;
    DictSize, BitPos, i, Index, CodeSize: integer;
    Current, Next: string;
  begin
    SetLength(Dict, 4096);
    for i := 0 to 255 do
      Dict[i] := Chr(i);
    DictSize := 256;

    SetLength(Result, 0);
    BitPos := 0;
    CodeSize := 9;

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
        WriteBits(Result, BitPos, Index, CodeSize);

        if DictSize < 4096 then
        begin
          Dict[DictSize] := Next;
          Inc(DictSize);

          // Aumentar el tamaño del código si se requiere
          if (DictSize = (1 shl CodeSize)) and (CodeSize < 12) then
            Inc(CodeSize);
        end;

        Current := Input[i];
      end;
    end;

    if Current <> '' then
    begin
      Index := FindInDictionary(Dict, Current, DictSize);
      WriteBits(Result, BitPos, Index, CodeSize);
    end;

    // Ajustar el tamaño final del buffer
    SetLength(Result, (BitPos + 7) div 8);
  end;

  function TLZWCompressor.Decompress(const Compressed: TBytes): ansistring;
  var
    Dict: array of string;
    DictSize, BitPos, CodeSize, i: integer;
    PrevCode, CurrCode: integer;
    PrevStr, CurrStr, Entry: string;
  begin
    SetLength(Dict, 4096);
    for i := 0 to 255 do
      Dict[i] := Chr(i);
    DictSize := 256;

    BitPos := 0;
    CodeSize := 9;

    PrevCode := ReadBits(Compressed, BitPos, CodeSize);
    PrevStr := Dict[PrevCode];
    Result := PrevStr;

    while BitPos + CodeSize <= Length(Compressed) * 8 do
    begin
      CurrCode := ReadBits(Compressed, BitPos,ReadBits(Compressed, Bit CodeSize);

      if CurrCode < DictSize then
        CurrStr := Dict[CurrCode]
      else if CurrCode = DictSize then
        CurrStr := PrevStr + PrevStr[1]
      else
        raise Exception.Create('Invalid code during decompression.');

      Result := Result + CurrStr;
      Entry := PrevStr + CurrStr[1];

      if DictSize < 4096 then
      begin
        Dict[DictSize] := Entry;
        Inc(DictSize);
        if (DictSize = (1 shl CodeSize)) and (CodeSize < 12) then
          Inc(CodeSize);
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
    WriteLn('Match:             ', BoolToStr(OriginalText = DecompressedText, True));
  finally
    Compressor.Free;
  end;
end.
