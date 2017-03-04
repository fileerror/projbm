unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,unit6,
  Vcl.ExtDlgs, Vcl.Menus;

type
  TForm_encryptchip1 = class(TForm)
    Memo_input: TMemo;
    Memo_output: TMemo;
    lbl_1: TLabel;
    btn_encrypt: TSpeedButton;
    Grp_in: TGroupBox;
    btn_load: TButton;
    Grp_out: TGroupBox;
    lbl_infoin: TLabel;
    lbl_infoout: TLabel;
    OpenTextFileDialog1: TOpenTextFileDialog;
    edit_info: TRichEdit;
    Grp_messages: TGroupBox;
    btn_save: TButton;
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
    procedure btn_encryptClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_loadClick(Sender: TObject);
    procedure Memo_inputChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure Memo_outputChange(Sender: TObject);
    procedure btn_exportClick(Sender: TObject);
    procedure Memo_inputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo_outputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_encryptchip1: TForm_encryptchip1;
  mesln:integer;
  asc:boolean;

implementation

{$R *.dfm}

uses Unit1, Unit4, Unit3;

procedure infomess(a:ansistring;col:tcolor);
var re:int64;
begin
  re:=length(form_encryptchip1.edit_info.Text)-(form_encryptchip1.edit_info.Lines.Count);
  form_encryptchip1.edit_info.Lines.Append('('+timetostr(now)+') - '+a);
  form_encryptchip1.edit_info.SelStart:=re;
  form_encryptchip1.edit_info.SelLength:=re+10;
  form_encryptchip1.edit_info.SelAttributes.Color:=clblue;
  form_encryptchip1.edit_info.SelStart:=re+11;
  form_encryptchip1.edit_info.SelLength:=length(form_encryptchip1.edit_info.Text);
  form_encryptchip1.edit_info.SelAttributes.Color:=col;
   form_encryptchip1.edit_info.SelStart:=length(form_encryptchip1.edit_info.Text);
  form_encryptchip1.edit_info.SelLength:=0;
end;

procedure TForm_encryptchip1.btn_encryptClick(Sender: TObject);
var s,key:ansistring;
begin
  s:=memo_input.Text;
  if s<>'' then totalcleanstr(s);
  key:=edit_key.Text;
  if key<>'' then totalcleanstr(key);
  if (key<>'') and (s<>'') then
   begin
        infomess('Старт шифрования',clblack);
        memo_output.Text:=encryptENG(s,key);
        asc:=true;
        infomess('Текст зашифрован',clgreen);
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

procedure TForm_encryptchip1.btn_exportClick(Sender: TObject);
begin
  form_hackchast.Show;
end;

procedure TForm_encryptchip1.btn_loadClick(Sender: TObject);
begin
  if opentextfiledialog1.Execute then memo_input.Lines.LoadFromFile(opentextfiledialog1.FileName);
end;

procedure TForm_encryptchip1.btn_saveClick(Sender: TObject);
begin
  if savetextfiledialog1.Execute then memo_output.Lines.SaveToFile(savetextfiledialog1.FileName+'.txt');
end;

procedure TForm_encryptchip1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  form_historypage.show;
  memo_input.Clear;
  memo_output.Clear;
  edit_key.Clear;
  edit_info.Clear;
end;

procedure TForm_encryptchip1.FormCreate(Sender: TObject);
begin
  mesln:=0;
  asc:=false;
end;

procedure TForm_encryptchip1.Memo_inputChange(Sender: TObject);
var s:ansistring;
    i:integer;
    l:yaz;
begin
  s:=memo_input.Text;
  if s='' then lbl_infoin.Caption:='Всего 0 символов' else begin
    totalcleanstr(s);
    lbl_infoin.Caption:='Всего '+inttostr(length(s))+' символов';
  end;
  memo_output.Clear;
  lbl_infoout.Caption:='Всего 0 символов'
end;

procedure TForm_encryptchip1.Memo_inputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssctrl in shift) and (key=ord('A'))) or ((ssctrl in shift) and (key=ord('Ф'))) then memo_input.SelectAll;
end;

procedure TForm_encryptchip1.Memo_outputChange(Sender: TObject);
var s:ansistring;
begin
  if asc then begin
    showmessage('Внимание! Изменение шифртекста приведет к некорректной дешифровке');
    asc:=false;
  end;
  s:=memo_output.Text;
  if s='' then lbl_infoout.Caption:='Всего 0 символов' else begin
    lbl_infoout.Caption:='Всего '+inttostr(length(s))+' символов';
  end;
end;

procedure TForm_encryptchip1.Memo_outputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssctrl in shift) and (key=ord('A'))) or ((ssctrl in shift) and (key=ord('Ф'))) then memo_output.SelectAll;
end;

procedure TForm_encryptchip1.N4Click(Sender: TObject);
begin
  form_decryptchip1.show;
  form_encryptchip1.Hide;
  form_decryptchip1.n1.Enabled:=true;
  form_decryptchip1.n2.Enabled:=true;
  form_decryptchip1.n3.Enabled:=true;
  form_decryptchip1.n4.Enabled:=false;
  form_decryptchip1.n5.Enabled:=true;
  form_decryptchip1.n6.Enabled:=true;
  form_decryptchip1.n7.Enabled:=true;
  form_decryptchip1.n8.Enabled:=true;

end;

procedure TForm_encryptchip1.N5Click(Sender: TObject);
begin
  form_hackchast.show;
  form_encryptchip1.Hide;
  form_hackchast.n1.Enabled:=true;
  form_hackchast.n2.Enabled:=true;
  form_hackchast.n3.Enabled:=true;
  form_hackchast.n4.Enabled:=true;
  form_hackchast.n5.Enabled:=false;
  form_hackchast.n6.Enabled:=true;
  form_hackchast.n7.Enabled:=true;
  form_hackchast.n8.Enabled:=true;
end;

procedure TForm_encryptchip1.N9Click(Sender: TObject);
begin
 form_historypage.close;
end;

end.
