unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TForm_historypage = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_historypage: TForm_historypage;

implementation

{$R *.dfm}

uses Unit2, Unit3;

procedure TForm_historypage.N3Click(Sender: TObject);
begin
  form_historypage.Hide;
  form_encryptchip1.show;
end;

procedure TForm_historypage.N4Click(Sender: TObject);
begin
  form_decryptchip1.show;
end;

end.
