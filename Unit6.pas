unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
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
  Form6: TForm6;

implementation

{$R *.dfm}

uses Unit2, Unit3;

procedure TForm6.Button1Click(Sender: TObject);  //удалить по рейсу
var
  i, j: Integer;
  found: Boolean;
begin
  if (ComboBox1.ItemIndex < 0) or (ComboBox2.ItemIndex < 0) then
  begin
    Application.MessageBox('Измените город отправления или прибытия!', 'Ошибка', MB_OK);
    Exit;
  end;
   if (ComboBox1.Text = ComboBox2.Text) then
  begin
   Application.MessageBox('Измените город отправления или прибытия!', 'Ошибка', MB_OK);
    Exit;
  end;
  for i := 1 to form2.StringGrid1.RowCount - 1 do
  begin
    found := (form2.StringGrid1.Cells[1, i] = ComboBox1.Text) and (form2.StringGrid1.Cells[2, i] = ComboBox2.Text);
    if found then
    begin
      for j := i to form2.StringGrid1.RowCount - 2 do
      begin
        form2.StringGrid1.Cells[0, j] := form2.StringGrid1.Cells[0, j+1];
        form2.StringGrid1.Cells[1, j] := form2.StringGrid1.Cells[1, j+1];
        form2.StringGrid1.Cells[2, j] := form2.StringGrid1.Cells[2, j+1];
        form2.StringGrid1.Cells[3, j] := form2.StringGrid1.Cells[3, j+1];
        form2.StringGrid1.Cells[4, j] := form2.StringGrid1.Cells[4, j+1];
        form2.StringGrid1.Cells[5, j] := form2.StringGrid1.Cells[5, j+1];
        form2.StringGrid1.Cells[6, j] := form2.StringGrid1.Cells[6, j+1];
        form2.StringGrid1.Cells[7, j] := form2.StringGrid1.Cells[7, j+1];
      end;
      form2.StringGrid1.RowCount := form2.StringGrid1.RowCount - 1;
      Break;
    end;
  end;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  Close;
end;

end.
