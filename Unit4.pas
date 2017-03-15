unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons,unit6, Vcl.Samples.Spin, Vcl.Menus;

type
  TForm_hackchast = class(TForm)
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
    lbl_1: TLabel;
    spdt_maxlenkey: TSpinEdit;
    lbl_2: TLabel;
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
    btn_decrypt: TSpeedButton;
    edit_key: TMemo;
    procedure btn_loadClick(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure btn_decryptClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure Memo_inputChange(Sender: TObject);
    procedure Memo_outputChange(Sender: TObject);
    procedure Memo_inputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo_outputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_hackchast: TForm_hackchast;

implementation

{$R *.dfm}

uses Unit1, Unit2, Unit3;

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

procedure TForm_hackchast.btn_decryptClick(Sender: TObject);
var s,key:ansistring;
begin
   s:=memo_input.Text;
   if s<>'' then totalcleanstr(s);
   if (s<>'')then
   begin
        infomess('Старт дешифрования',clblack);
        key:=getkey(s);
        edit_key.Text:=key;
        key:=upkeystr(key);
        memo_output.Text:=decryptENG(s,key);
        infomess('Текст расшифрован',clgreen);
   end
      else begin
        infomess('Ошибка: шифртекст введен некорректно', clred);
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

procedure TForm_hackchast.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form_historypage.show;
  memo_input.Clear;
  memo_output.Clear;
  edit_key.Clear;
  edit_info.Clear;
end;

procedure TForm_hackchast.FormHide(Sender: TObject);
begin
  memo_input.Clear;
  memo_output.Clear;
  edit_key.Clear;
  edit_info.Clear;
  lbl_infoin.Caption:='Число символов: 0';
  lbl_infoout.Caption:='Число символов: 0';
end;

procedure TForm_hackchast.Memo_inputChange(Sender: TObject);
var s:ansistring;
    i:integer;
    l:yaz;
begin
  s:=memo_input.Text;
  if s='' then lbl_infoin.Caption:='Число символов: 0' else begin
    totalcleanstr(s);
    lbl_infoin.Caption:='Число символов: '+inttostr(length(s));
  end;
  memo_output.Clear;
  edit_key.Clear;
  lbl_infoout.Caption:='Число символов: 0'
end;


procedure TForm_hackchast.Memo_inputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssctrl in shift) and (key=ord('A'))) or ((ssctrl in shift) and (key=ord('Ф'))) then memo_input.SelectAll;
end;

procedure TForm_hackchast.Memo_outputChange(Sender: TObject);
var s:ansistring;
begin
  s:=memo_output.Text;
  if s='' then lbl_infoout.Caption:='Число символов: 0' else begin
    lbl_infoout.Caption:='Число символов: '+inttostr(length(s));
  end;
  if memo_output.Text='' then btn_save.Enabled:=false else btn_save.Enabled:=true;
end;

procedure TForm_hackchast.Memo_outputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssctrl in shift) and (key=ord('A'))) or ((ssctrl in shift) and (key=ord('Ф'))) then memo_output.SelectAll;
end;

procedure TForm_hackchast.N3Click(Sender: TObject);
begin
  form_hackchast.Hide;
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

procedure TForm_hackchast.N4Click(Sender: TObject);
begin
  form_decryptchip1.show;
  form_hackchast.Hide;
  form_decryptchip1.n1.Enabled:=true;
  form_decryptchip1.n2.Enabled:=true;
  form_decryptchip1.n3.Enabled:=true;
  form_decryptchip1.n4.Enabled:=false;
  form_decryptchip1.n5.Enabled:=true;
  form_decryptchip1.n6.Enabled:=true;
  form_decryptchip1.n7.Enabled:=true;
  form_decryptchip1.n8.Enabled:=true;
end;

procedure TForm_hackchast.N9Click(Sender: TObject);
begin
  form_historypage.Close;
end;

end.
