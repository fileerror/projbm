unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,unit6, Vcl.StdCtrls;

type
  TForm_decryptchip1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_decryptchip1: TForm_decryptchip1;

implementation

{$R *.dfm}

procedure TForm_decryptchip1.Button1Click(Sender: TObject);
var s:ansistring;
begin
  s:=memo1.Text;
  totalcleanstr(s);
  memo1.Text:=s;
end;

end.
