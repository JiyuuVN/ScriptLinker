program script_linker;

{-----------------------------------------------------------------
 ��ଠ� �������: script_linker "����� � 䠩����" "䠩� ��� �뢮��"
 -----------------------------------------------------------------}

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes;

var
  FileList, OutputStrings, InputStrings : TStringList;
  search : TSearchRec;
  i : Cardinal;
  OutputFile : string = 'result.txt';
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    if ParamCount < 2 then begin
      Writeln('����ୠ� ��ப� ��ଥ�஢!');
      Exit;
    end;

    FileList := TStringList.Create;
    if ParamStr(1) = '-f' then begin
      if FindFirst(ParamStr(2) + '*.txt', 0, search) <> 0 then begin
        WriteLn('������ ���.');
        Exit;
      end;

      FileList.Add(search.Name);

      while FindNext(search) = 0  do FileList.Add(search.Name);
      FindClose(search);
    end else begin
      FileList.LoadFromFile(ParamStr(2));
    end;
    Writeln('������ ��� ��ࠡ�⪨: ', FileList.Count);

    OutputStrings := TStringList.Create;

    for i := 0 to FileList.Count - 1 do begin
      WriteLn('�������� ' + FileList[i]);
      InputStrings := TStringList.Create;
      InputStrings.LoadFromFile(ExtractFilePath(ParamStr(2)) + FileList[i]);
      OutputStrings.AddStrings(InputStrings);
      OutputStrings.Add('');
      InputStrings.Free;
    end;
    WriteLn('���ઠ �����襭�.');

    if ParamStr(3) <> '' then OutputFile := ParamStr(3);
    OutputStrings.SaveToFile(OutputFile, TEncoding.UTF8);
    OutputStrings.Free;
    Writeln('������� ��࠭� � ' + OutputFile);
    //Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
