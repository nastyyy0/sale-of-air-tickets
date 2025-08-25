unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm5 = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  avia=record
  num: string[20];//№
  otkuda: string[20]; //Город отправления
  kuda: string[20]; //Город прибытия
  datatuda: string[20]; //Дата отправления
  timetuda: string[20];  //Время отправления
  datasuda: string[20]; //Дата прибытия
  fio: string[20]; //ФИО
  monny: string[20]; //Стоимость
  end;

var
  Form5: TForm5;
  a:array[0..100] of avia;
  f:file of avia;
  i,n,j,m,k:integer;
  fil: TSearchRec;
  rect: Trect;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm5.ComboBox1Change(Sender: TObject);  // поиск файла
begin
Combobox1.Items.Clear;
  if FindFirst('*.dat',faAnyFile, fil) = 0 then
    repeat
      Combobox1.Items.Add(fil.name);
      until FindNext(fil)<> 0;
FindClose(fil);
end;

procedure TForm5.Button1Click(Sender: TObject);   //открытие и занесение
begin
if (combobox1.text='') then
  begin
    MessageBox(Handle, 'Вы не выбрали файл', 'Ошибка', 0);
    Exit;
  end
  else
    AssignFile(F, ComboBox1.text);
    Reset(F);
    j:=FileSize(F);
    form2.StringGrid1.RowCount:= j + 1;
    for j:= 1 to form2.StringGrid1.RowCount - 1 do
    begin
      Read(F, a[i]);
      form2.StringGrid1.Cells[0,j]:= a[i].num;
      form2.StringGrid1.Cells[1,j]:= a[i].otkuda;
      form2.StringGrid1.Cells[2,j]:= a[i].kuda;
      form2.StringGrid1.Cells[3,j]:= a[i].datatuda;
      form2.StringGrid1.Cells[4,j]:= a[i].timetuda;
      form2.StringGrid1.Cells[5,j]:= a[i].datasuda;
      form2.StringGrid1.Cells[6,j]:= a[i].fio;
       form2.StringGrid1.Cells[7,j]:= a[i].monny;
    end;
end;

procedure TForm5.Button2Click(Sender: TObject); //закрыть
begin
form5.Close;
end;

end.
