unit Unit4;

interface

uses
Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPickers, Vcl.StdCtrls,
Vcl.ComCtrls;

type
TForm4 = class(TForm)
Edit1: TEdit;
Label1: TLabel;
Button1: TButton;
Button2: TButton;
procedure Button1Click(Sender: TObject);
procedure Button2Click(Sender: TObject);
private

{ Private declarations }
public
{ Public declarations }
end;

var
Form4: TForm4;
FilteredRows: TStringList;
sl1, sl2, sl3, indices: TStringList;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm4.Button1Click(Sender: TObject);
var
  itemText: string;
  i, j, k: Integer;
begin
  sl1 := TStringList.Create;
  sl2 := TStringList.Create;
  sl3 := TStringList.Create;
  indices := TStringList.Create;
  sl3.Clear;
  for i := 0 to form2.StringGrid1.RowCount - 1 do
  begin
    for j := 0 to form2.StringGrid1.ColCount - 1 do
    begin
      sl3.Add(form2.StringGrid1.Cells[j, i]);
    end;
  end;
  try
    if form2.StringGrid1.RowCount > 1 then
    begin
      sl1.Clear;
      for i := 1 to form2.StringGrid1.RowCount - 1 do
      begin
        if form2.StringGrid1.Rows[i].DelimitedText <> '' then
          sl1.Add(form2.StringGrid1.Rows[i].DelimitedText);
      end;
      itemText := Edit1.Text;
      sl2.Clear;
      for i := 0 to sl1.Count - 1 do
      begin
        if Pos(itemText, sl1[i]) > 0 then
          sl2.Add(sl1[i]);
      end;
      form2.StringGrid1.RowCount := 1;
      sl2.Insert(0, form2.StringGrid1.Rows[0].DelimitedText);
      k := 0;
      for i := 0 to sl2.Count - 1 do
      begin
        form2.StringGrid1.Rows[k].DelimitedText := sl2[i];
        Inc(k);
        form2.StringGrid1.RowCount := k + 1;
      end;
      if form2.StringGrid1.RowCount > 1 then
        form2.StringGrid1.RowCount := form2.StringGrid1.RowCount - 1;
    end
    else
      MessageBox(Handle, 'Нету данных для фильтрации', 'Ошибка фильтрации', 0);
  finally
    sl1.Free;
    sl2.Free;
    indices.Free;
  end;
end;

procedure TForm4.Button2Click(Sender: TObject);
var
  i, j, index: Integer;
begin
  form2.StringGrid1.RowCount := 1;
  form2.StringGrid1.ColCount := 8;
  index := 0;
  for j := 0 to (sl3.Count div form2.StringGrid1.ColCount) - 1 do
  begin
    for i := 0 to form2.StringGrid1.ColCount - 1 do
    begin
      if index < sl3.Count then
      begin
        form2.StringGrid1.Cells[i, j] := sl3[index];
        inc(index);
      end;
    end;
  end;
  form2.StringGrid1.RowCount := (sl3.Count div form2.StringGrid1.ColCount) + 1;
  if (form2.StringGrid1.RowCount > 1) and (form2.StringGrid1.Cells[0, form2.StringGrid1.RowCount - 1] = '') then
    form2.StringGrid1.RowCount := form2.StringGrid1.RowCount - 1;
end;

end.
