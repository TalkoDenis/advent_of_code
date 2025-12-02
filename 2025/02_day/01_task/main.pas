program AoCDay2Final;

{$mode objfpc}
uses 
  SysUtils;

type
  TID = Int64;

var
  TotalInvalidSum: TID = 0;
  
procedure ParseAndSolve(const InputLine: string);
var
  CurrentLine: string;
  RangeStr: string;
  CommaPos, DashPos: Integer;
  
  MaxIDLength: Integer;
  L: Integer;          
  X, IDGen: TID;       
  
  Multiplier: TID;      
  
  StartID, EndID: TID;
  StartIDStr, EndIDStr: string;
  
  i: Integer; 
  
begin
  CurrentLine := InputLine;
  TotalInvalidSum := 0;

  while Length(CurrentLine) > 0 do
  begin
    CommaPos := Pos(',', CurrentLine);
    
    // Выделяем текущий диапазон (RangeStr)
    if CommaPos > 0 then
      begin
        RangeStr := Trim(Copy(CurrentLine, 1, CommaPos - 1));
        CurrentLine := Copy(CurrentLine, CommaPos + 1, Length(CurrentLine));
      end
    else
      begin
        RangeStr := Trim(CurrentLine);
        CurrentLine := '';
      end;

    if Length(RangeStr) > 0 then
    begin
      DashPos := Pos('-', RangeStr);
      if DashPos > 0 then
      begin
        StartIDStr := Trim(Copy(RangeStr, 1, DashPos - 1));
        EndIDStr := Trim(Copy(RangeStr, DashPos + 1, Length(RangeStr)));
        
        try
          StartID := StrToInt64(StartIDStr);
          EndID := StrToInt64(EndIDStr);
        except
          Continue;
        end;

        MaxIDLength := 6; 

        for L := 1 to MaxIDLength do
        begin
          Multiplier := 1; 
          for i := 1 to L do 
            Multiplier := Multiplier * 10;
          Multiplier := Multiplier + 1;
          
          X := Multiplier div 10; 

          while X < Multiplier div 10 do 
          begin
            IDGen := X * Multiplier;
            
            if IDGen > EndID then
              Break; 
            
            if IDGen >= StartID then 
            begin
              TotalInvalidSum := TotalInvalidSum + IDGen;
            end;

            X := X + 1; 
          end; 
        end;
        
      end; 
    end; 

  end;

end;


procedure Solve;
var
  InputFile: TextFile;
  FileName: string;
  InputLine: string;
begin
  if ParamCount < 1 then
  begin
    WriteLn('ERROR: Give the file name.');
    Exit;
  end;

  FileName := ParamStr(1);
  AssignFile(InputFile, FileName);
  
  try
    Reset(InputFile); 
    ReadLn(InputFile, InputLine); 
    CloseFile(InputFile);
    ParseAndSolve(InputLine);
    WriteLn('The answer is: ', TotalInvalidSum);
    
  except
    on E: EInOutError do
      WriteLn('ERROR: Could not read the file "', FileName, '".');
    on E: Exception do
      WriteLn('ERROR: ', E.Message);
  end;
end;

begin
  Solve;
end.