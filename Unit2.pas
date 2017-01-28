unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls;

type
  TForm_encriptchip1 = class(TForm)
    edit_info: TRichEdit;
    Memo_input: TMemo;
    Memo_output: TMemo;
    Edit_key: TEdit;
    lbl_1: TLabel;
    btn_encrypt: TSpeedButton;
    GroupBox1: TGroupBox;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_encriptchip1: TForm_encriptchip1;

implementation

{$R *.dfm}

end.
