unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,unit6,
  Vcl.ExtDlgs;

type
  TForm_encryptchip1 = class(TForm)
    Memo_input: TMemo;
    Memo_output: TMemo;
    Edit_key: TEdit;
    lbl_1: TLabel;
    btn_encrypt: TSpeedButton;
    Grp_in: TGroupBox;
    btn_load: TButton;
    Grp_out: TGroupBox;
    lbl_infoin: TLabel;
    lbl_infoout: TLabel;
    btn_export: TButton;
    OpenTextFileDialog1: TOpenTextFileDialog;
    edit_info: TRichEdit;
    Grp_messages: TGroupBox;
    btn_save: TButton;
    SaveTextFileDialog1: TSaveTextFileDialog;
    procedure btn_encryptClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_loadClick(Sender: TObject);
    procedure Memo_inputChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure Memo_outputChange(Sender: TObject);
    procedure btn_exportClick(Sender: TObject);
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

uses Unit1, Unit4;

procedure infomess(a:ansistring;col:tcolor);
begin
  form_encryptchip1.edit_info.Lines.Append('('+timetostr(now)+') - '+a);
  form_encryptchip1.edit_info.SelStart:=0;
  form_encryptchip1.edit_info.SelLength:=12;
  form_encryptchip1.edit_info.SelAttributes.Color:=clblue;
  form_encryptchip1.edit_info.SelStart:=13;
  form_encryptchip1.edit_info.SelLength:=13+length(a);
  form_encryptchip1.edit_info.SelAttributes.Color:=col;


end;

procedure TForm_encryptchip1.btn_encryptClick(Sender: TObject);
var s,key:ansistring;
begin
  if (edit_key.Text='') and (memo_input.Text='') then begin
    infomess('Ошибка: не введены параметры',clred);
    exit
  end else begin
        infomess('Старт шифрования',clblack);
        s:=memo_input.Text;
        totalcleanstr(s);
        key:=edit_key.Text;
        totalcleanstr(key);
        memo_output.Text:=encryptENG(s,key);
        asc:=true;
        infomess('Текст зашифрован',clgreen);
      end;
  if edit_key.Text='' then begin
    infomess('Ошибка: не введен ключ',clred);
    exit;
  end;
  if memo_input.Text='' then begin
    infomess('Ошибка: не введен текст', clred);
    exit;
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

end.
