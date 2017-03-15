unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls;

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
    Label1: TLabel;
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_historypage: TForm_historypage;

implementation

{$R *.dfm}

uses Unit2, Unit3, Unit4, Unit7;

procedure TForm_historypage.N3Click(Sender: TObject);
begin
  form_historypage.Hide;
  form_encryptchip1.show;
  form_encryptchip1.n1.Enabled:=true;
  form_encryptchip1.n2.Enabled:=true;
  form_encryptchip1.n3.Enabled:=false;
  form_encryptchip1.n4.Enabled:=true;
  form_encryptchip1.n5.Enabled:=true;
  form_encryptchip1.n6.Enabled:=true;
  form_encryptchip1.n7.Enabled:=true;
  form_encryptchip1.n8.Enabled:=true;
end;

procedure TForm_historypage.N4Click(Sender: TObject);
begin
  form_decryptchip1.show;
  form_historypage.Hide;
  form_decryptchip1.n1.Enabled:=true;
  form_decryptchip1.n2.Enabled:=true;
  form_decryptchip1.n3.Enabled:=true;
  form_decryptchip1.n4.Enabled:=false;
  form_decryptchip1.n5.Enabled:=true;
  form_decryptchip1.n6.Enabled:=true;
  form_decryptchip1.n7.Enabled:=true;
  form_decryptchip1.n8.Enabled:=true;
end;

procedure TForm_historypage.N5Click(Sender: TObject);
begin
  form_hackchast.show;
  form_historypage.Hide;
  form_hackchast.n1.Enabled:=true;
  form_hackchast.n2.Enabled:=true;
  form_hackchast.n3.Enabled:=true;
  form_hackchast.n4.Enabled:=true;
  form_hackchast.n5.Enabled:=false;
  form_hackchast.n6.Enabled:=true;
  form_hackchast.n7.Enabled:=true;
  form_hackchast.n8.Enabled:=true;
end;

procedure TForm_historypage.N7Click(Sender: TObject);
begin
  form_historypage.Hide;
  form_stat.show;
  form_hackchast.n1.Enabled:=true;
  form_hackchast.n2.Enabled:=true;
  form_hackchast.n3.Enabled:=true;
  form_hackchast.n4.Enabled:=true;
  form_hackchast.n5.Enabled:=true;
  form_hackchast.n6.Enabled:=true;
  form_hackchast.n7.Enabled:=false;
  form_hackchast.n8.Enabled:=true;
end;

procedure TForm_historypage.N8Click(Sender: TObject);
begin
  form_historypage.Hide;
  form_encryptchip1.n1.Enabled:=true;
  form_encryptchip1.n2.Enabled:=true;
  form_encryptchip1.n3.Enabled:=true;
  form_encryptchip1.n4.Enabled:=true;
  form_encryptchip1.n5.Enabled:=true;
  form_encryptchip1.n6.Enabled:=true;
  form_encryptchip1.n7.Enabled:=true;
  form_encryptchip1.n8.Enabled:=false;
end;

procedure TForm_historypage.N9Click(Sender: TObject);
begin
  form_historypage.Close
end;

end.
