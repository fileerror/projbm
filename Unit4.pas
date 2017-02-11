unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons,unit6, Vcl.Samples.Spin;

type
  TForm_hackchast = class(TForm)
    btn_encrypt: TSpeedButton;
    Grp_in: TGroupBox;
    lbl_infoin: TLabel;
    Memo_input: TMemo;
    btn_load: TButton;
    Grp_out: TGroupBox;
    lbl_infoout: TLabel;
    Memo_output: TMemo;
    btn_export: TButton;
    btn_save: TButton;
    Grp_messages: TGroupBox;
    edit_info: TRichEdit;
    OpenTextFileDialog1: TOpenTextFileDialog;
    SaveTextFileDialog1: TSaveTextFileDialog;
    lbl_1: TLabel;
    spdt_maxlenkey: TSpinEdit;
    procedure btn_loadClick(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure btn_encryptClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_hackchast: TForm_hackchast;

implementation

{$R *.dfm}

procedure infomess(a:ansistring;col:tcolor);
var re:int64;
begin
  re:=length(form_hackchast.edit_info.Text)-(form_hackchast.edit_info.Lines.Count);
  form_hackchast.edit_info.Lines.Append('('+timetostr(now)+') - '+a);
  form_hackchast.edit_info.SelStart:=re;
  form_hackchast.edit_info.SelLength:=re+10;
  form_hackchast.edit_info.SelAttributes.Color:=clblue;
  form_hackchast.edit_info.SelStart:=re+11;
  form_hackchast.edit_info.SelLength:=length(form_hackchast.edit_info.Text);
  form_hackchast.edit_info.SelAttributes.Color:=col;
  form_hackchast.edit_info.SelStart:=length(form_hackchast.edit_info.Text);
  form_hackchast.edit_info.SelLength:=0;
end;

procedure TForm_hackchast.btn_encryptClick(Sender: TObject);
var s:ansistring;
begin
   if (memo_input.Text<>'') then
   begin
        infomess('Старт дешифрования',clblack);
        s:=memo_input.Text;
        memo_output.Text:=decryptENG(s,getkey(s));
        infomess('Текст расшифрован',clgreen);
   end
    else begin
        infomess('Ошибка: не введен шифртекст', clred);
        exit;
      end
end;


procedure TForm_hackchast.btn_loadClick(Sender: TObject);
begin
  if opentextfiledialog1.Execute then memo_input.Lines.LoadFromFile(opentextfiledialog1.FileName);
end;

procedure TForm_hackchast.btn_saveClick(Sender: TObject);
begin
  if savetextfiledialog1.Execute then memo_output.Lines.SaveToFile(savetextfiledialog1.FileName+'.txt');
end;

end.
