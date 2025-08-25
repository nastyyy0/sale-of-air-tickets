unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.Grids, Vcl.Menus, Vcl.Dialogs, System.IOUtils, DateUtils,
  Vcl.FileCtrl;

type
  TForm2 = class(TForm)
    MainMenu1: TMainMenu;
    StringGrid1: TStringGrid;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure N23Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
avia = record
  fio: string[20]; // ФИО
  num: string[20]; // номер рейса
  otkuda: string[20]; // Город отправления
  kuda: string[20]; // Город прибытия
  datatuda: string[20]; // Дата отправления
  timetuda: string[20]; // Время отправления
  datasuda: string[20]; // Дата прибытия
  monny: string[20]; // Стоимость
end;

var
  MainForm: TForm;
  Form2: TForm2;
  i, j, n: integer;
  a: array[1..10] of avia;
  b: avia;
  f: file of avia;
  s: string;
  fail: file of avia;
  selectedcell: integer;
  FileName: string;
  OpenDialog: TOpenDialog;
  z: array of avia;

implementation

{$R *.dfm}

uses Unit1, Unit3, Unit5, Unit6, Unit4;

procedure TForm2.FormCreate(Sender: TObject); // верхняя строка
begin
  StringGrid1.Cells[0, 0] := '№';
  StringGrid1.Cells[1, 0] := 'Город отправления';
  StringGrid1.Cells[2, 0] := 'Город прибытия';
  StringGrid1.Cells[3, 0] := 'Дата отправления';
  StringGrid1.Cells[4, 0] := 'Время отправления';
  StringGrid1.Cells[5, 0] := 'Дата прибытия';
  StringGrid1.Cells[6, 0] := 'ФИО';
  StringGrid1.Cells[7, 0] := 'Стоимость';
  Edit1.OnKeyPress := Edit1KeyPress;
end;
////////////////////////////////////////////работа со StringGrid///////////////////////////////////////////////////
procedure TForm2.N12Click(Sender: TObject); // очистить весь StringGrid
var
  i, j: Integer;
  confirmResult: Integer;
begin
  if (StringGrid1.RowCount = 1) and (StringGrid1.ColCount > 0) then
  begin
    confirmResult := MessageDlg('Вы точно хотите очистить весь StringGrid?', mtConfirmation, [mbYes, mbNo], 0);
  end
  else
  begin
    confirmResult := MessageDlg('Вы точно хотите очистить весь StringGrid?', mtConfirmation, [mbYes, mbNo], 0);
  end;

  if confirmResult = mrYes then
  begin
    if (StringGrid1.RowCount = 1) and (StringGrid1.ColCount > 0) then
    begin
       Application.MessageBox('StringGrid уже пуст!', 'Очистка StringGrid', MB_OK);
    end
    else
    begin
      for j := 0 to StringGrid1.ColCount - 1 do
        StringGrid1.Cells[j, 0] := StringGrid1.Cells[j, 0];
      StringGrid1.RowCount := 1;
      for i := 1 to StringGrid1.RowCount - 1 do
        for j := 0 to StringGrid1.ColCount - 1 do
          StringGrid1.Cells[j, i] := '';
      Application.MessageBox('StringGrid очищен!', 'Очистка StringGrid', MB_OK);
    end;
  end;
end;

procedure TForm2.Button6Click(Sender: TObject); // удаление выбранной строки
var
  selectedRow: Integer;
  i, j: Integer;
  tempData: array of array of string;
begin
  selectedRow := StringGrid1.Row;
  if selectedRow > 0 then
  begin
    StringGrid1.BeginUpdate;
    try
      SetLength(tempData, StringGrid1.RowCount - 1, StringGrid1.ColCount);
      for i := 0 to selectedRow - 1 do
        for j := 0 to StringGrid1.ColCount - 1 do
          tempData[i, j] := StringGrid1.Cells[j, i];
      for i := selectedRow to StringGrid1.RowCount - 2 do
        for j := 0 to StringGrid1.ColCount - 1 do
          tempData[i, j] := StringGrid1.Cells[j, i + 1];
      StringGrid1.RowCount := StringGrid1.RowCount - 1;
      for i := 0 to StringGrid1.RowCount - 1 do
        for j := 0 to StringGrid1.ColCount - 1 do
          StringGrid1.Cells[j, i] := tempData[i, j];
    finally
      StringGrid1.EndUpdate;
    end;
  end
  else
  begin
    Application.MessageBox('Выберите строку для удаления.', 'Ошибка', MB_OK);
  end;
end;

procedure TForm2.Button7Click(Sender: TObject); //поиск
begin
  if Trim(Edit1.Text) = '' then
  begin
    Application.MessageBox('Пожалуйста, введите текст для поиска.', 'Ошибка', MB_OK);
    Exit;
  end;

  StringGrid1.Repaint();
  for i := 0 to StringGrid1.ColCount - 1 do
  begin
    for j := 1 to StringGrid1.RowCount - 1 do
    begin
      if Pos(AnsiLowerCase(Trim(Edit1.Text)), AnsiLowerCase(Trim(StringGrid1.Cells[i, j]))) <> 0 then
      begin
        rect := StringGrid1.CellRect(i, j);
        StringGrid1.Canvas.Brush.Color := $00ADD8E6;
        StringGrid1.Canvas.FillRect(rect);
        StringGrid1.Canvas.TextOut(rect.Left + 6, rect.Top + 5, StringGrid1.Cells[i, j]);
      end;
    end;
  end;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char); //корректность
begin
  if (Key in ['a'..'z']) or (Key in ['A'..'Z']) or
  (Key in ['<', '>', '/', '?', '"', ';', ':', '\', '|', '{', '}', '(',
  ')', '-', '_', '*', '+', '=', '&', '^', '%', '$', '#', '№', '@', '!',
  '`', '~', ']', '[', '''', ',', '.'])or (Key in ['№']) then
    Key := #0;
end;
/////////////////////////////////////////////работа со StringGrid//////////////////////////////////////////////////////

///////////////////////////////////////////переход на другие формы////////////////////////////////////////////////////
procedure TForm2.Button2Click(Sender: TObject); // добавление записи
begin
  Form3.ShowModal;
end;

procedure TForm2.Button5Click(Sender: TObject); //удаление по рейсу
begin
  Form6.Show;
end;

procedure TForm2.N8Click(Sender: TObject);  //фильтрация
begin
  Form4.ShowModal;
end;
/////////////////////////////////////////////переход на другие формы////////////////////////////////////////////////////

////////////////////////////////////////////////////функции/////////////////////////////////////////////////////////////
procedure TForm2.Button3Click(Sender: TObject); //уменьшение стоимости на 10
var
  Row: Integer;
  Value: Double;
begin
  for Row := 0 to StringGrid1.RowCount - 1 do
  begin
    if TryStrToFloat(StringGrid1.Cells[7, Row], Value) then
    begin
      Value := Value - 10;
      StringGrid1.Cells[7, Row] := FormatFloat('0.##', Value);
    end;
  end;
end;

procedure TForm2.Button4Click(Sender: TObject); // вывод записей за текущий месяц по дате прибытия
var
  us: avia;
  i, j: integer;
begin
  // Устанавливаем количество строк в StringGrid1 равным 1
  StringGrid1.RowCount := 1;
  Reset(f);
  // Получаем количество записей в файле
  j := FileSize(f);
  for j := 1 to FileSize(f) do
  begin
    read(f, us);
    if (us.datasuda <> '') and (MonthOf(StrToDate(us.datasuda)) = MonthOf(Now)) then
    begin
      // Записываем данные из переменной us в соответствующие ячейки StringGrid1
      StringGrid1.Cells[0, StringGrid1.RowCount] := us.num;
      StringGrid1.Cells[1, StringGrid1.RowCount] := us.otkuda;
      StringGrid1.Cells[2, StringGrid1.RowCount] := us.kuda;
      StringGrid1.Cells[3, StringGrid1.RowCount] := us.datatuda;
      StringGrid1.Cells[4, StringGrid1.RowCount] := us.timetuda;
      StringGrid1.Cells[5, StringGrid1.RowCount] := us.datasuda;
      StringGrid1.Cells[6, StringGrid1.RowCount] := us.fio;
      StringGrid1.Cells[7, StringGrid1.RowCount] := us.monny;
      StringGrid1.RowCount := StringGrid1.RowCount + 1;
    end;
  end;
  CloseFile(f);
end;


/////////////////////////////////////////////////свои функции////////////////////////////////////////////////////////////


////////////////////////////////////////////////////Файл/////////////////////////////////////////////////////////////////
procedure TForm2.N1Click(Sender: TObject); //сохранить файл
var
  SaveDialog: TSaveDialog;
  FileName: string;
  i: Integer;
begin
  SaveDialog := TSaveDialog.Create(Self);
  try
    SaveDialog.Title := 'Сохранить файл как';
    SaveDialog.DefaultExt := 'dat';
    SaveDialog.Filter := 'DAT files (*.dat)|*.dat';
    if SaveDialog.Execute then
    begin
      FileName := SaveDialog.FileName;
      AssignFile(f, FileName);
      Rewrite(f);
      for i := 1 to StringGrid1.RowCount - 1 do
      begin
        a[i].num := StringGrid1.Cells[0, i];
        a[i].otkuda := StringGrid1.Cells[1, i];
        a[i].kuda := StringGrid1.Cells[2, i];
        a[i].datatuda := StringGrid1.Cells[3, i];
        a[i].timetuda := StringGrid1.Cells[4, i];
        a[i].datasuda := StringGrid1.Cells[5, i];
        a[i].fio := StringGrid1.Cells[6, i];
        a[i].monny := StringGrid1.Cells[7, i];
        Write(f, a[i]);
      end;
      CloseFile(f);
      Application.MessageBox('Файл сохранен!', 'Сохранение файла', MB_OK);
    end;
  finally
    SaveDialog.Free;
  end;
end;

procedure TForm2.N2Click(Sender: TObject); //открыть файл
 var
  a: array of avia;
  FileName: string;
begin
  OpenDialog1 := TOpenDialog.Create(nil);
  try
    OpenDialog1.Title := 'Открыть файл';
    OpenDialog1.DefaultExt := 'dat';
    OpenDialog1.Filter := 'Бинарные файлы (*.dat)|*.dat';
    if OpenDialog1.Execute then
    begin
      FileName := OpenDialog1.FileName;
      AssignFile(f, FileName);
      try
        Reset(f);
        n := FileSize(f);
        SetLength(a, n);
        StringGrid1.RowCount := n + 1;
        for i:= 0 to n - 1 do
        begin
          Read(f, a[i]);
          StringGrid1.Cells[0, i + 1] := a[i].num;
          StringGrid1.Cells[1, i + 1] := a[i].otkuda;
          StringGrid1.Cells[2, i + 1] := a[i].kuda;
          StringGrid1.Cells[3, i + 1] := a[i].datatuda;
          StringGrid1.Cells[4, i + 1] := a[i].timetuda;
          StringGrid1.Cells[5, i + 1] := a[i].datasuda;
          StringGrid1.Cells[6, i + 1] := a[i].fio;
          StringGrid1.Cells[7, i + 1] := a[i].monny;
        end;
        Application.MessageBox('Файл открыт!', 'Открытие файла', MB_OK);
      finally
        CloseFile(f);
      end;
    end;
  finally
    OpenDialog1.Free;
  end;
end;
//////////////////////////////////////////////////////Файл////////////////////////////////////////////////////


//////////////////////////////////////////////////Сортировки//////////////////////////////////////////////////
procedure TForm2.N11Click(Sender: TObject); //стоимость по возрастанию
var z, i, j: integer;
    us: record
      fio: string;
      num: string;
      otkuda: string;
      kuda: string;
      datatuda: string;
      timetuda: string;
      datasuda: string;
      monny: string;
    end;
begin
  with StringGrid1 do begin
    z := 1;
    while True do begin
      if Cells[0, z] = '' then begin
        z := z - 1;
        Break;
      end;
      z := z + 1;
    end;
    for i := 1 to z - 1 do begin
      for j := z - 1 downto i + 1 do begin
        if StrToFloat(Cells[7, j - 1]) > StrToFloat(Cells[7, j]) then begin
          us.fio := Cells[0, j - 1];
          us.num := Cells[1, j - 1];
          us.otkuda := Cells[2, j - 1];
          us.kuda := Cells[3, j - 1];
          us.datatuda := Cells[4, j - 1];
          us.timetuda := Cells[5, j - 1];
          us.datasuda := Cells[6, j - 1];
          us.monny := Cells[7, j - 1];
          Cells[0, j - 1] := Cells[0, j];
          Cells[1, j - 1] := Cells[1, j];
          Cells[2, j - 1] := Cells[2, j];
          Cells[3, j - 1] := Cells[3, j];
          Cells[4, j - 1] := Cells[4, j];
          Cells[5, j - 1] := Cells[5, j];
          Cells[6, j - 1] := Cells[6, j];
          Cells[7, j - 1] := Cells[7, j];
          Cells[0, j] := us.fio;
          Cells[1, j] := us.num;
          Cells[2, j] := us.otkuda;
          Cells[3, j] := us.kuda;
          Cells[4, j] := us.datatuda;
          Cells[5, j] := us.timetuda;
          Cells[6, j] := us.datasuda;
          Cells[7, j] := us.monny;
        end;
      end;
    end;
  end;
end;


procedure TForm2.N13Click(Sender: TObject);  //стоимость по убыванию
var z, i, j: integer;
    us: record
      fio: string;
      num: string;
      otkuda: string;
      kuda: string;
      datatuda: string;
      timetuda: string;
      datasuda: string;
      monny: string;
    end;
begin
  with StringGrid1 do begin
    z := 1;
    while True do begin
      if Cells[0, z] = '' then begin
        z := z - 1;
        Break;
      end;
      z := z + 1;
    end;
    for i := 1 to z - 1 do begin
      for j := z - 1 downto i + 1 do begin
        if StrToFloat(Cells[7, j - 1]) < StrToFloat(Cells[7, j]) then begin
          us.fio := Cells[0, j - 1];
          us.num := Cells[1, j - 1];
          us.otkuda := Cells[2, j - 1];
          us.kuda := Cells[3, j - 1];
          us.datatuda := Cells[4, j - 1];
          us.timetuda := Cells[5, j - 1];
          us.datasuda := Cells[6, j - 1];
          us.monny := Cells[7, j - 1];
          Cells[0, j - 1] := Cells[0, j];
          Cells[1, j - 1] := Cells[1, j];
          Cells[2, j - 1] := Cells[2, j];
          Cells[3, j - 1] := Cells[3, j];
          Cells[4, j - 1] := Cells[4, j];
          Cells[5, j - 1] := Cells[5, j];
          Cells[6, j - 1] := Cells[6, j];
          Cells[7, j - 1] := Cells[7, j];
          Cells[0, j] := us.fio;
          Cells[1, j] := us.num;
          Cells[2, j] := us.otkuda;
          Cells[3, j] := us.kuda;
          Cells[4, j] := us.datatuda;
          Cells[5, j] := us.timetuda;
          Cells[6, j] := us.datasuda;
          Cells[7, j] := us.monny;
        end;
      end;
    end;
  end;
end;

procedure TForm2.N15Click(Sender: TObject);  //номер рейса по возрастанию
var z, i, j: integer;
    us: record
      fio: string;
      num: string;
      otkuda: string;
      kuda: string;
      datatuda: string;
      timetuda: string;
      datasuda: string;
      monny: string;
    end;
begin
  with StringGrid1 do begin
    z := 1;
    while True do begin
      if Cells[0, z] = '' then begin
        z := z - 1;
        Break;
      end;
      z := z + 1;
    end;
    for i := 1 to z - 1 do begin
      for j := z - 1 downto i + 1 do begin
        if StrToFloat(Cells[0, j - 1]) > StrToFloat(Cells[0, j]) then begin
          us.num := Cells[0, j - 1];
          us.otkuda := Cells[1, j - 1];
          us.kuda := Cells[2, j - 1];
          us.datatuda := Cells[3, j - 1];
          us.timetuda := Cells[4, j - 1];
          us.datasuda := Cells[5, j - 1];
          us.fio := Cells[6, j - 1];
          us.monny := Cells[7, j - 1];
          Cells[0, j - 1] := Cells[0, j];
          Cells[1, j - 1] := Cells[1, j];
          Cells[2, j - 1] := Cells[2, j];
          Cells[3, j - 1] := Cells[3, j];
          Cells[4, j - 1] := Cells[4, j];
          Cells[5, j - 1] := Cells[5, j];
          Cells[6, j - 1] := Cells[6, j];
          Cells[7, j - 1] := Cells[7, j];
          Cells[0, j] := us.num;
          Cells[1, j] := us.otkuda;
          Cells[2, j] := us.kuda;
          Cells[3, j] := us.datatuda;
          Cells[4, j] := us.timetuda;
          Cells[5, j] := us.datasuda;
          Cells[6, j] := us.fio;
          Cells[7, j] := us.monny;
        end;
      end;
    end;
  end;
end;

procedure TForm2.N16Click(Sender: TObject);  //номер рейса по убыванию
var z, i, j: integer;
    us: record
      fio: string;
      num: string;
      otkuda: string;
      kuda: string;
      datatuda: string;
      timetuda: string;
      datasuda: string;
      monny: string;
    end;
begin
  with StringGrid1 do begin
    z := 1;
    while True do begin
      if Cells[0, z] = '' then begin
        z := z - 1;
        Break;
      end;
      z := z + 1;
    end;
    for i := 1 to z - 1 do begin
      for j := z - 1 downto i + 1 do begin
        if StrToFloat(Cells[0, j - 1]) < StrToFloat(Cells[0, j]) then begin
          us.fio := Cells[0, j - 1];
          us.num := Cells[1, j - 1];
          us.otkuda := Cells[2, j - 1];
          us.kuda := Cells[3, j - 1];
          us.datatuda := Cells[4, j - 1];
          us.timetuda := Cells[5, j - 1];
          us.datasuda := Cells[6, j - 1];
          us.monny := Cells[7, j - 1];
          Cells[0, j - 1] := Cells[0, j];
          Cells[1, j - 1] := Cells[1, j];
          Cells[2, j - 1] := Cells[2, j];
          Cells[3, j - 1] := Cells[3, j];
          Cells[4, j - 1] := Cells[4, j];
          Cells[5, j - 1] := Cells[5, j];
          Cells[6, j - 1] := Cells[6, j];
          Cells[7, j - 1] := Cells[7, j];
          Cells[0, j] := us.fio;
          Cells[1, j] := us.num;
          Cells[2, j] := us.otkuda;
          Cells[3, j] := us.kuda;
          Cells[4, j] := us.datatuda;
          Cells[5, j] := us.timetuda;
          Cells[6, j] := us.datasuda;
          Cells[7, j] := us.monny;
        end;
      end;
    end;
  end;
end;

procedure TForm2.N18Click(Sender: TObject);   //фио от а до я
var
  n:integer;
begin
  n:=StringGrid1.RowCount-1;
  for i := n-1 downto 1 do
  for j := 1 to i do
  if (StringGrid1.Cells[6,j])>(StringGrid1.Cells[6,j+1]) then
  begin
    S:=StringGrid1.Cells[6,j];
    StringGrid1.Cells[6,j]:=StringGrid1.Cells[6,j+1];
    StringGrid1.Cells[6,j+1]:=s;
  end;
end;

procedure TForm2.N19Click(Sender: TObject);  //фио от я до а
var
  n:integer;
begin
  n:=StringGrid1.RowCount-1;
  for i := n-1 downto 1 do
  for j := 1 to i do
  if (StringGrid1.Cells[6,j])<(StringGrid1.Cells[6,j+1]) then
  begin
    S:=StringGrid1.Cells[6,j];
    StringGrid1.Cells[6,j]:=StringGrid1.Cells[6,j+1];
    StringGrid1.Cells[6,j+1]:=s;
  end;
end;

procedure TForm2.N21Click(Sender: TObject);  //город отправления от а до я
var z, i, j: integer;
    us: record
      fio: string;
      num: string;
      otkuda: string;
      kuda: string;
      datatuda: string;
      timetuda: string;
      datasuda: string;
      monny: string;
    end;
begin
  with StringGrid1 do begin
    z := 1;
    while True do begin
      if Cells[0, z] = '' then begin
        z := z - 1;
        Break;
      end;
      z := z + 1;
    end;
    for i := 2 to z do begin
      for j := i + 1 to z do begin
        if Cells[1, i - 1] < Cells[1, j - 1] then begin
          us.num := Cells[0, i - 1];
          us.otkuda := Cells[1, i - 1];
          us.kuda := Cells[2, i - 1];
          us.datatuda := Cells[3, i - 1];
          us.timetuda := Cells[4, i - 1];
          us.datasuda := Cells[5, i - 1];
          us.fio := Cells[6, i - 1];
          us.monny := Cells[7, i - 1];
          Cells[0, i - 1] := Cells[0, j - 1];
          Cells[1, i - 1] := Cells[1, j - 1];
          Cells[2, i - 1] := Cells[2, j - 1];
          Cells[3, i - 1] := Cells[3, j - 1];
          Cells[4, i - 1] := Cells[4, j - 1];
          Cells[5, i - 1] := Cells[5, j - 1];
          Cells[6, i - 1] := Cells[6, j - 1];
          Cells[7, i - 1] := Cells[7, j - 1];
          Cells[0, j - 1] := us.num;
          Cells[1, j - 1] := us.otkuda;
          Cells[2, j - 1] := us.kuda;
          Cells[3, j - 1] := us.datatuda;
          Cells[4, j - 1] := us.timetuda;
          Cells[5, j - 1] := us.datasuda;
          Cells[6, j - 1] := us.fio;
          Cells[7, j - 1] := us.monny;
        end;
      end;
    end;
  end;
end;

procedure TForm2.N22Click(Sender: TObject);  //город отправления от я до а
var z, i, j: integer;
    us: record
      fio: string;
      num: string;
      otkuda: string;
      kuda: string;
      datatuda: string;
      timetuda: string;
      datasuda: string;
      monny: string;
    end;
begin
  with StringGrid1 do begin
    z := 1;
    while True do begin
      if Cells[0, z] = '' then begin
        z := z - 1;
        Break;
      end;
      z := z + 1;
    end;
    for i := 2 to z do begin
      for j := i + 1 to z do begin
        if Cells[1, i - 1] > Cells[1, j - 1] then begin
          us.num := Cells[0, i - 1];
          us.otkuda := Cells[1, i - 1];
          us.kuda := Cells[2, i - 1];
          us.datatuda := Cells[3, i - 1];
          us.timetuda := Cells[4, i - 1];
          us.datasuda := Cells[5, i - 1];
          us.fio := Cells[6, i - 1];
          us.monny := Cells[7, i - 1];
          Cells[0, i - 1] := Cells[0, j - 1];
          Cells[1, i - 1] := Cells[1, j - 1];
          Cells[2, i - 1] := Cells[2, j - 1];
          Cells[3, i - 1] := Cells[3, j - 1];
          Cells[4, i - 1] := Cells[4, j - 1];
          Cells[5, i - 1] := Cells[5, j - 1];
          Cells[6, i - 1] := Cells[6, j - 1];
          Cells[7, i - 1] := Cells[7, j - 1];
          Cells[0, j - 1] := us.num;
          Cells[1, j - 1] := us.otkuda;
          Cells[2, j - 1] := us.kuda;
          Cells[3, j - 1] := us.datatuda;
          Cells[4, j - 1] := us.timetuda;
          Cells[5, j - 1] := us.datasuda;
          Cells[6, j - 1] := us.fio;
          Cells[7, j - 1] := us.monny;
        end;
      end;
    end;
  end;
end;

procedure TForm2.N23Click(Sender: TObject);
begin
  Application.MessageBox('Данная программа предназначена для учета продажи авиабилетов.' +
  'Основными функциями программы являются вывод информации о пассажирах за текущий месяц,' +
  'удаление информации о клиентах по выбранному рейсу (маршруту), уменьшение стоимости на 10.',
  'О программе', MB_OK);
end;

procedure TForm2.N24Click(Sender: TObject);   //дата отправления от старых
var z, i, j: integer;
    us: record
      fio: string;
      num: string;
      otkuda: string;
      kuda: string;
      datatuda: string;
      timetuda: string;
      datasuda: string;
      monny: string;
    end;
    dateTuda1, dateTuda2: TDateTime;
begin
  with StringGrid1 do begin
    z := 1;
    while True do begin
      if Cells[0, z] = '' then begin
        z := z - 1;
        Break;
      end;
      z := z + 1;
    end;
    for i := 2 to z do begin
      for j := i + 1 to z do begin
        dateTuda1 := StrToDateTime(Cells[3, i - 1]);
        dateTuda2 := StrToDateTime(Cells[3, j - 1]);
        if dateTuda1 > dateTuda2 then begin
          us.num := Cells[0, i - 1];
          us.otkuda := Cells[1, i - 1];
          us.kuda := Cells[2, i - 1];
          us.datatuda := Cells[3, i - 1];
          us.timetuda := Cells[4, i - 1];
          us.datasuda := Cells[5, i - 1];
          us.fio := Cells[6, i - 1];
          us.monny := Cells[7, i - 1];
          Cells[0, i - 1] := Cells[0, j - 1];
          Cells[1, i - 1] := Cells[1, j - 1];
          Cells[2, i - 1] := Cells[2, j - 1];
          Cells[3, i - 1] := Cells[3, j - 1];
          Cells[4, i - 1] := Cells[4, j - 1];
          Cells[5, i - 1] := Cells[5, j - 1];
          Cells[6, i - 1] := Cells[6, j - 1];
          Cells[7, i - 1] := Cells[7, j - 1];
          Cells[0, j - 1] := us.num;
          Cells[1, j - 1] := us.otkuda;
          Cells[2, j - 1] := us.kuda;
          Cells[3, j - 1] := us.datatuda;
          Cells[4, j - 1] := us.timetuda;
          Cells[5, j - 1] := us.datasuda;
          Cells[6, j - 1] := us.fio;
          Cells[7, j - 1] := us.monny;
        end;
      end;
    end;
  end;
end;

procedure TForm2.N25Click(Sender: TObject);   //дата отправления сначала новые
var z, i, j: integer;
    us: record
      fio: string;
      num: string;
      otkuda: string;
      kuda: string;
      datatuda: string;
      timetuda: string;
      datasuda: string;
      monny: string;
    end;
    dateTuda1, dateTuda2: TDateTime;
begin
  with StringGrid1 do begin
    z := 1;
    while True do begin
      if Cells[0, z] = '' then begin
        z := z - 1;
        Break;
      end;
      z := z + 1;
    end;
    for i := 2 to z do begin
      for j := i + 1 to z do begin
        dateTuda1 := StrToDateTime(Cells[3, i - 1]);
        dateTuda2 := StrToDateTime(Cells[3, j - 1]);
        if dateTuda1 < dateTuda2 then begin
          us.num := Cells[0, i - 1];
          us.otkuda := Cells[1, i - 1];
          us.kuda := Cells[2, i - 1];
          us.datatuda := Cells[3, i - 1];
          us.timetuda := Cells[4, i - 1];
          us.datasuda := Cells[5, i - 1];
          us.fio := Cells[6, i - 1];
          us.monny := Cells[7, i - 1];
          Cells[0, i - 1] := Cells[0, j - 1];
          Cells[1, i - 1] := Cells[1, j - 1];
          Cells[2, i - 1] := Cells[2, j - 1];
          Cells[3, i - 1] := Cells[3, j - 1];
          Cells[4, i - 1] := Cells[4, j - 1];
          Cells[5, i - 1] := Cells[5, j - 1];
          Cells[6, i - 1] := Cells[6, j - 1];
          Cells[7, i - 1] := Cells[7, j - 1];
          Cells[0, j - 1] := us.num;
          Cells[1, j - 1] := us.otkuda;
          Cells[2, j - 1] := us.kuda;
          Cells[3, j - 1] := us.datatuda;
          Cells[4, j - 1] := us.timetuda;
          Cells[5, j - 1] := us.datasuda;
          Cells[6, j - 1] := us.fio;
          Cells[7, j - 1] := us.monny;
        end;
      end;
    end;
  end;
end;

procedure TForm2.N4Click(Sender: TObject);  //город прибытия от а до я
var z, i, j: integer;
    us: record
      fio: string;
      num: string;
      otkuda: string;
      kuda: string;
      datatuda: string;
      timetuda: string;
      datasuda: string;
      monny: string;
    end;
begin
  with StringGrid1 do begin
    z := 1;
    while True do begin
      if Cells[0, z] = '' then begin
        z := z - 1;
        Break;
      end;
      z := z + 1;
    end;
    for i := 2 to z do begin
      for j := i + 1 to z do begin
        if Cells[2, i - 1] < Cells[2, j - 1] then begin
          us.num := Cells[0, i - 1];
          us.otkuda := Cells[1, i - 1];
          us.kuda := Cells[2, i - 1];
          us.datatuda := Cells[3, i - 1];
          us.timetuda := Cells[4, i - 1];
          us.datasuda := Cells[5, i - 1];
          us.fio := Cells[6, i - 1];
          us.monny := Cells[7, i - 1];
          Cells[0, i - 1] := Cells[0, j - 1];
          Cells[1, i - 1] := Cells[1, j - 1];
          Cells[2, i - 1] := Cells[2, j - 1];
          Cells[3, i - 1] := Cells[3, j - 1];
          Cells[4, i - 1] := Cells[4, j - 1];
          Cells[5, i - 1] := Cells[5, j - 1];
          Cells[6, i - 1] := Cells[6, j - 1];
          Cells[7, i - 1] := Cells[7, j - 1];
          Cells[0, j - 1] := us.num;
          Cells[1, j - 1] := us.otkuda;
          Cells[2, j - 1] := us.kuda;
          Cells[3, j - 1] := us.datatuda;
          Cells[4, j - 1] := us.timetuda;
          Cells[5, j - 1] := us.datasuda;
          Cells[6, j - 1] := us.fio;
          Cells[7, j - 1] := us.monny;
        end;
      end;
    end;
  end;
end;

procedure TForm2.N5Click(Sender: TObject);  //город прибытия от я до а
var z, i, j: integer;
    us: record
      fio: string;
      num: string;
      otkuda: string;
      kuda: string;
      datatuda: string;
      timetuda: string;
      datasuda: string;
      monny: string;
    end;
begin
  with StringGrid1 do begin
    z := 1;
    while True do begin
      if Cells[0, z] = '' then begin
        z := z - 1;
        Break;
      end;
      z := z + 1;
    end;
    for i := 2 to z do begin
      for j := i + 1 to z do begin
        if Cells[2, i - 1] > Cells[2, j - 1] then begin
          us.num := Cells[0, i - 1];
          us.otkuda := Cells[1, i - 1];
          us.kuda := Cells[2, i - 1];
          us.datatuda := Cells[3, i - 1];
          us.timetuda := Cells[4, i - 1];
          us.datasuda := Cells[5, i - 1];
          us.fio := Cells[6, i - 1];
          us.monny := Cells[7, i - 1];
          Cells[0, i - 1] := Cells[0, j - 1];
          Cells[1, i - 1] := Cells[1, j - 1];
          Cells[2, i - 1] := Cells[2, j - 1];
          Cells[3, i - 1] := Cells[3, j - 1];
          Cells[4, i - 1] := Cells[4, j - 1];
          Cells[5, i - 1] := Cells[5, j - 1];
          Cells[6, i - 1] := Cells[6, j - 1];
          Cells[7, i - 1] := Cells[7, j - 1];
          Cells[0, j - 1] := us.num;
          Cells[1, j - 1] := us.otkuda;
          Cells[2, j - 1] := us.kuda;
          Cells[3, j - 1] := us.datatuda;
          Cells[4, j - 1] := us.timetuda;
          Cells[5, j - 1] := us.datasuda;
          Cells[6, j - 1] := us.fio;
          Cells[7, j - 1] := us.monny;
        end;
      end;
    end;
  end;
end;

procedure TForm2.N7Click(Sender: TObject); //редактировать
var
  EditingEnabled: Boolean;
begin
  EditingEnabled := not EditingEnabled;
  if EditingEnabled then
  begin
    StringGrid1.Options := StringGrid1.Options + [goEditing];
  end
  else
  begin
    StringGrid1.Options := StringGrid1.Options - [goEditing];
  end;
end;
//////////////////////////////////////////////////Сортировки//////////////////////////////////////////////////

procedure TForm2.Button1Click(Sender: TObject); //выход
begin
close;
end;

end.
