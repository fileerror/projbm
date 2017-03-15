unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,unit6, Vcl.StdCtrls, Vcl.ExtDlgs,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.Menus;

type
  TForm_decryptchip1 = class(TForm)
    lbl_1: TLabel;
    Grp_in: TGroupBox;
    lbl_infoin: TLabel;
    Memo_input: TMemo;
    btn_load: TButton;
    Grp_out: TGroupBox;
    lbl_infoout: TLabel;
    Memo_output: TMemo;
    btn_save: TButton;
    OpenTextFileDialog1: TOpenTextFileDialog;
    SaveTextFileDialog1: TSaveTextFileDialog;
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
    edit_key: TMemo;
    btn_decrypt: TSpeedButton;
    Grp_messages: TGroupBox;
    edit_info: TRichEdit;
    procedure btn_decryptClick(Sender: TObject);
    procedure btn_loadClick(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Memo_inputChange(Sender: TObject);
    procedure Memo_outputChange(Sender: TObject);
    procedure Memo_inputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo_outputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N5Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure FormHide(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_decryptchip1: TForm_decryptchip1;

implementation

{$R *.dfm}

uses Unit1, Unit4, Unit2;

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

procedure TForm_decryptchip1.btn_decryptClick(Sender: TObject);
var s,key:ansistring;
    lentext:integer;
begin
  s:=memo_input.Text;
  lentext:=length(s);
  if s<>'' then totalcleanstr(s);
  key:=edit_key.Text;
  if key<>'' then totalcleanstr(key);
  if (key<>'') and (s<>'') then
   begin
        infomess('Старт дешифрования',clblack);
        memo_output.Text:=decryptENG(s,key);
        infomess('Текст расшифрован',clgreen);
   end
  else if (key='') and (s<>'') then
    begin
      infomess('Ошибка: ключ введен некорректно',clred);
      exit;
    end
    else if (s='') and (key<>'') then
      begin
        infomess('Ошибка: текст введен некорректно', clred);
        exit;
      end else
        begin
          infomess('Ошибка: параметры введены некорректно',clred);
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
  memo_input.Clear;
  memo_output.Clear;
  edit_key.Clear;
  edit_info.Clear;
end;

procedure TForm_decryptchip1.FormHide(Sender: TObject);
begin
  memo_input.Clear;
  memo_output.Clear;
  edit_key.Clear;
  edit_info.Clear;
  lbl_infoin.Caption:='Число символов: 0';
  lbl_infoout.Caption:='Число символов: 0';
end;

procedure TForm_decryptchip1.Memo_inputChange(Sender: TObject);
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
  lbl_infoout.Caption:='Число символов: 0'
end;

procedure TForm_decryptchip1.Memo_inputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssctrl in shift) and (key=ord('A'))) or ((ssctrl in shift) and (key=ord('Ф'))) then memo_input.SelectAll;
end;

procedure TForm_decryptchip1.Memo_outputChange(Sender: TObject);
var s:ansistring;
begin
  s:=memo_output.Text;
  if s='' then lbl_infoout.Caption:='Число символов: 0' else begin
    lbl_infoout.Caption:='Число символов: '+inttostr(length(s));
  end;
  if memo_output.Text='' then btn_save.Enabled:=false else btn_save.Enabled:=true;
end;

procedure TForm_decryptchip1.Memo_outputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssctrl in shift) and (key=ord('A'))) or ((ssctrl in shift) and (key=ord('Ф'))) then memo_output.SelectAll;
end;

procedure TForm_decryptchip1.N3Click(Sender: TObject);
begin
  form_decryptchip1.Hide;
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

procedure TForm_decryptchip1.N5Click(Sender: TObject);
begin
  form_hackchast.show;
  form_decryptchip1.Hide;
  form_hackchast.n1.Enabled:=true;
  form_hackchast.n2.Enabled:=true;
  form_hackchast.n3.Enabled:=true;
  form_hackchast.n4.Enabled:=true;
  form_hackchast.n5.Enabled:=false;
  form_hackchast.n6.Enabled:=true;
  form_hackchast.n7.Enabled:=true;
  form_hackchast.n8.Enabled:=true;
end;

procedure TForm_decryptchip1.N9Click(Sender: TObject);
begin
  form_historypage.Close;
end;

end.
