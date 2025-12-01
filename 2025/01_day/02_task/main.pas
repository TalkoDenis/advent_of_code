program AoCDay1Part2Final;

{$mode objfpc}

uses
  SysUtils; 

procedure SolvePuzzle;
var
  InputFile: TextFile;
  FileName: string;
  Line: string;
  
  ZeroCount: Int64; 
  
  CurrentPosition: Integer; 
  MODULO: Integer;
  Direction: Char;
  Distance: Integer;
  Shift: Integer;
  Crossings: Int64;
begin
  if ParamCount < 1 then
  begin
    WriteLn('ERROR! Write like: ./aoc_day1 my_input.txt');
    Exit;
  end;
  FileName := ParamStr(1);
  
  CurrentPosition := 50; 
  ZeroCount := 0; 
  MODULO := 100; 

  AssignFile(InputFile, FileName);
  
  try
    Reset(InputFile); 

    while not Eof(InputFile) do
    begin
      ReadLn(InputFile, Line);
      
      if Length(Line) < 2 then
        Continue;

      Direction := Line[1]; 
      
      try
        Distance := StrToInt(Copy(Line, 2, Length(Line)));
      except
        Continue; 
      end;

      Crossings := 0; 
      
      if Direction = 'R' then 
      begin
        Crossings := (Int64(CurrentPosition) + Int64(Distance)) div Int64(MODULO);
      end
      else if Direction = 'L' then 
      begin
        Crossings := (Int64(MODULO - CurrentPosition) + Int64(Distance)) div Int64(MODULO);
      end;
      
      ZeroCount := ZeroCount + Crossings;

      Shift := Distance;
      if Direction = 'L' then 
        Shift := -Distance;
        
      CurrentPosition := CurrentPosition + Shift;
      
      while CurrentPosition < 0 do
        CurrentPosition := CurrentPosition + MODULO;

      CurrentPosition := CurrentPosition mod MODULO;
        
    end;
    
    CloseFile(InputFile);
    
    WriteLn('Result is', ZeroCount);
    
  except
    on E: EInOutError do
      WriteLn('ERROR: Could not read a file "', FileName, '".');
    on E: Exception do
      WriteLn('ERROR: ', E.Message);
  end;
end;

begin
  SolvePuzzle;
end.