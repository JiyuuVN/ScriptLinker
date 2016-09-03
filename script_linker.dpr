program script_linker;

{-----------------------------------------------------------------
 Формат команды: script_linker "папка с файлами" "файл для вывода"
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
      Writeln('Неверная строка парметров!');
      Exit;
    end;

    FileList := TStringList.Create;
    if ParamStr(1) = '-f' then begin
      if FindFirst(ParamStr(2) + '*.txt', 0, search) <> 0 then begin
        WriteLn('Файлов нет.');
        Exit;
      end;

      FileList.Add(search.Name);

      while FindNext(search) = 0  do FileList.Add(search.Name);
      FindClose(search);
    end else begin
      FileList.LoadFromFile(ParamStr(2));
    end;
    Writeln('Файлов для обработки: ', FileList.Count);

    OutputStrings := TStringList.Create;

    for i := 0 to FileList.Count - 1 do begin
      WriteLn('Добавляю ' + FileList[i]);
      InputStrings := TStringList.Create;
      InputStrings.LoadFromFile(ExtractFilePath(ParamStr(2)) + FileList[i]);
      OutputStrings.AddStrings(InputStrings);
      OutputStrings.Add('');
      InputStrings.Free;
    end;
    WriteLn('Сборка завершена.');

    if ParamStr(3) <> '' then OutputFile := ParamStr(3);
    OutputStrings.SaveToFile(OutputFile, TEncoding.UTF8);
    OutputStrings.Free;
    Writeln('Результат сохранён в ' + OutputFile);
    //Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
