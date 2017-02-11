unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,unit6, Vcl.StdCtrls, Vcl.ExtDlgs,
  Vcl.ComCtrls, Vcl.Buttons;

type
  TForm_decryptchip1 = class(TForm)
    lbl_1: TLabel;
    btn_encrypt: TSpeedButton;
    Edit_key: TEdit;
    Grp_in: TGroupBox;
    lbl_infoin: TLabel;
    Memo_input: TMemo;
    btn_load: TButton;
    Grp_out: TGroupBox;
    lbl_infoout: TLabel;
    Memo_output: TMemo;
    btn_save: TButton;
    Grp_messages: TGroupBox;
    edit_info: TRichEdit;
    OpenTextFileDialog1: TOpenTextFileDialog;
    SaveTextFileDialog1: TSaveTextFileDialog;
    procedure btn_encryptClick(Sender: TObject);
    procedure btn_loadClick(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Memo_inputChange(Sender: TObject);
    procedure Memo_outputChange(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_decryptchip1: TForm_decryptchip1;

implementation

{$R *.dfm}

uses Unit1;

procedure infomess(a:ansistring;col:tcolor);
var re:int64;
begin
  re:=length(form_decryptchip1.edit_info.Text)-(form_decryptchip1.edit_info.Lines.Count);
  form_decryptchip1.edit_info.Lines.Append('('+timetostr(now)+') - '+a);
  form_decryptchip1.edit_info.SelStart:=re;
  form_decryptchip1.edit_info.SelLength:=re+10;
  form_decryptchip1.edit_info.SelAttributes.Color:=clblue;
  form_decryptchip1.edit_info.SelStart:=re+11;
  form_decryptchip1.edit_info.SelLength:=length(form_decryptchip1.edit_info.Text);
  form_decryptchip1.edit_info.SelAttributes.Color:=col;
  form_decryptchip1.edit_info.SelStart:=length(form_decryptchip1.edit_info.Text);
  form_decryptchip1.edit_info.SelLength:=0;
end;

procedure TForm_decryptchip1.btn_encryptClick(Sender: TObject);
var s,key:ansistring;
begin
   if (edit_key.Text<>'') and (memo_input.Text<>'') then
   begin
        infomess('Старт дешифрования',clblack);
        s:=memo_input.Text;
        totalcleanstr(s);
        key:=edit_key.Text;
        totalcleanstr(key);
        memo_output.Text:=decryptENG(s,key);
        infomess('Текст расшифрован',clgreen);
   end
  else if (edit_key.Text='') and (memo_input.Text<>'') then
    begin
      infomess('Ошибка: не введен ключ',clred);
      exit;
    end
    else if (memo_input.Text='') and (edit_key.Text<>'') then
      begin
        infomess('Ошибка: не введен текст', clred);
        exit;
      end else
        begin
          infomess('Ошибка: не введены параметры',clred);
          exit
        end;
end;



procedure TForm_decryptchip1.btn_loadClick(Sender: TObject);
begin
  if opentextfiledialog1.Execute then memo_input.Lines.LoadFromFile(opentextfiledialog1.FileName);
end;

procedure TForm_decryptchip1.btn_saveClick(Sender: TObject);
begin
  if savetextfiledialog1.Execute then memo_output.Lines.SaveToFile(savetextfiledialog1.FileName+'.txt');
end;

procedure TForm_decryptchip1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  form_historypage.show;
end;

procedure TForm_decryptchip1.Memo_inputChange(Sender: TObject);
var s:ansistring;
    i:integer;
    l:yaz;
begin
  s:=memo_input.Text;
  if s='' then lbl_infoin.Caption:='Всего 0 символов' else begin
    totalcleanstr(s);
    lbl_infoin.Caption:='Всего '+inttostr(length(s))+' символов';
  end;
end;

procedure TForm_decryptchip1.Memo_outputChange(Sender: TObject);
var s:ansistring;
begin
  s:=memo_output.Text;
  if s='' then lbl_infoout.Caption:='Всего 0 символов' else begin
    lbl_infoout.Caption:='Всего '+inttostr(length(s))+' символов';
  end;
end;

end.
