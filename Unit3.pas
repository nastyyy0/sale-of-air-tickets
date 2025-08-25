unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.WinXPickers;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    TimePicker1: TTimePicker;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char); //Ограничение фимилии
    procedure Edit2KeyPress(Sender: TObject; var Key: Char); //Ограничение  номер рейса
    procedure Edit3KeyPress(Sender: TObject; var Key: Char); //Ограничение стоимость
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char); //Ограничение город отправления
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char); //Ограничение город прибытия

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Edit1.OnKeyPress := Edit1KeyPress;
  Edit2.OnKeyPress := Edit2KeyPress;
  Edit3.OnKeyPress := Edit3KeyPress;
  ComboBox1.OnKeyPress := ComboBox1KeyPress;
  ComboBox2.OnKeyPress := ComboBox2KeyPress;
end;

procedure TForm3.Button1Click(Sender: TObject);  //добавление записи
begin
  if ((ComboBox1.Text = ComboBox2.Text) or (ComboBox1.Text = 'Город отправления') or
     (ComboBox1.Text = ' ') or (ComboBox2.Text = ' ') or
     (ComboBox2.Text = 'Город прибытия'))
  then
  begin
    Application.MessageBox('Измените город отправления или прибытия!', 'Ошибка ввода маршрута', MB_OK);
  end
  else if (Trim(Edit1.Text) = '') or (Edit1.Text = 'ФИО') then
  begin
    Application.MessageBox('Введите ФИО!', 'Ошибка ввода ФИО', MB_OK);
  end
  else if ((Edit3.Text = 'Стоимость') or (Trim(Edit3.Text) = '')) then
  begin
    Application.MessageBox('Введите стоимость!', 'Ошибка ввода стоимости', MB_OK);
  end
  else if (StrToInt(Edit3.Text) <= 0) then
  begin
    Application.MessageBox('Некорректно введена стоимость!', 'Ошибка ввода стоимости', MB_OK);
  end
  else if ((Edit2.Text = 'Номер рейса') or (Trim(Edit3.Text) = '')) then
  begin
    Application.MessageBox('Введите номер рейса!', 'Ошибка ввода номера рейса', MB_OK);
  end
  else if (StrToInt(Edit2.Text) <= 0) then
  begin
    Application.MessageBox('Номер рейса введен некорректно!', 'Ошибка ввода номера рейса', MB_OK);
  end
  else if DateTimePicker1.Date > DateTimePicker2.Date then
  begin
    Application.MessageBox('Дата отправления должна быть не позднее даты прибытия!', 'Ошибка ввода даты', MB_OK);
  end
  else
  begin
    form2.StringGrid1.RowCount := form2.StringGrid1.RowCount + 1;
    form2.StringGrid1.Cells[0, form2.StringGrid1.RowCount - 1] := form3.Edit2.Text;
    form2.StringGrid1.Cells[1, form2.StringGrid1.RowCount - 1] := form3.ComboBox1.Text;
    form2.StringGrid1.Cells[2, form2.StringGrid1.RowCount - 1] := form3.ComboBox2.Text;
    form2.StringGrid1.Cells[3, form2.StringGrid1.RowCount - 1] := DateToStr(form3.DateTimePicker1.Date);
    form2.StringGrid1.Cells[4, form2.StringGrid1.RowCount - 1] := TimeToStr(form3.TimePicker1.Time);
    form2.StringGrid1.Cells[5, form2.StringGrid1.RowCount - 1] := DateToStr(form3.DateTimePicker2.Date);
    form2.StringGrid1.Cells[6, form2.StringGrid1.RowCount - 1] := form3.Edit1.Text;
    form2.StringGrid1.Cells[7, form2.StringGrid1.RowCount - 1] := form3.Edit3.Text;

    Form3.Edit1.Text := 'ФИО';
    Form3.Edit2.Text := 'Номер рейса';
    Form3.Edit3.Text := 'Стоимость';
    Form3.ComboBox1.Text := 'Город отправления';
    Form3.ComboBox2.Text := 'Город прибытия';
    Form3.DateTimePicker1.Date := Now;
    Form3.TimePicker1.Time := 0;
    Form3.DateTimePicker2.Date := Now;
    Form3.Close;
    Form3.Refresh;
  end;
end;

procedure TForm3.Edit2KeyPress(Sender: TObject; var Key: Char);   //номер рейса корректость
begin
  if not (Key in ['0'..'9',#8]) then
  Key := #0;
end;

procedure TForm3.Edit3KeyPress(Sender: TObject; var Key: Char); //стоимость корректность
begin
  if not (Key in ['0'..'9',#8]) then
  Key := #0;
end;

procedure TForm3.Edit1KeyPress(Sender: TObject; var Key: Char);  //фио корректность
begin
  if (Key in ['0'..'9']) or (Key in ['a'..'z']) or (Key in ['A'..'Z']) or
  (Key in ['<', '>', '/', '?', '"', ';', ':', '\', '|', '{', '}', '(',
  ')', '-', '_', '*', '+', '=', '&', '^', '%', '$', '#', '№', '@', '!',
  '`', '~', ']', '[', '''', ',', '.'])or (Key in ['№']) then
    Key := #0;
end;

procedure TForm3.ComboBox1KeyPress(Sender: TObject; var Key: Char);  //город отправления корректность
begin
  if ((Key in ['A'..'Z']) or (Key in ['a'..'z']) or (Key in ['<', '>', '/',
  '?', '"', ';', ':', '\', '|', '{', '}', '(', ')', '-', '_', '*', '+', '=',
  '&', '^', '%', '$', '#', '@', '!', '`', '~', ']', '[', '''', ',', '.']) or (Key
  in ['0'..'9']) or (Key in ['№'])) then
    Key := #0;
end;

procedure TForm3.ComboBox2KeyPress(Sender: TObject; var Key: Char);  //город прибытия корректность
begin
  if (Key in ['A'..'Z']) or (Key in ['a'..'z']) or (Key in ['<', '>', '/',
  '?', '"', ';', ':', '\', '|', '{', '}', '(', ')', '-', '_', '*', '+', '=',
  '&', '^', '%', '$', '#', '№', '@', '!', '`', '~', ']', '[', '''', ',', '.']) or (Key
  in ['0'..'9']) or (Key in ['№']) then
    Key := #0;
end;
/////////////////////////////////////////корректности ввода//////////////////////////////////////////

procedure TForm3.Button2Click(Sender: TObject);
begin
  Form3.Close;
end;

end.
