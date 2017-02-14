unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,unit6, Vcl.StdCtrls, Vcl.ExtDlgs,
  Vcl.ComCtrls, Vcl.Buttons;

type
  TForm_decryptchip1 = class(TForm)
    lbl_1: TLabel;
    btn_decrypt: TSpeedButton;
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

procedure TForm_decryptchip1.btn_decryptClick(Sender: TObject);
var s,key:ansistring;
begin
  s:=memo_input.Text;
  if s<>'' then totalcleanstr(s);
  key:=edit_key.Text;
  if key<>'' then totalcleanstr(key);
  if (key<>'') and (s<>'') then
   begin
        infomess('����� ������������',clblack);
        memo_output.Text:=decryptENG(s,key);
        infomess('����� �����������',clgreen);
   end
  else if (key='') and (s<>'') then
    begin
      infomess('������: ���� ������ �����������',clred);
      exit;
    end
    else if (s='') and (key<>'') then
      begin
        infomess('������: ����� ������ �����������', clred);
        exit;
      end else
        begin
          infomess('������: ��������� ������� �����������',clred);
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

procedure TForm_decryptchip1.Memo_inputChange(Sender: TObject);
var s:ansistring;
    i:integer;
    l:yaz;
begin
  s:=memo_input.Text;
  if s='' then lbl_infoin.Caption:='����� 0 ��������' else begin
    totalcleanstr(s);
    lbl_infoin.Caption:='����� '+inttostr(length(s))+' ��������';
  end;
end;

procedure TForm_decryptchip1.Memo_inputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssctrl in shift) and (key=ord('A'))) or ((ssctrl in shift) and (key=ord('�'))) then memo_input.SelectAll;
end;

procedure TForm_decryptchip1.Memo_outputChange(Sender: TObject);
var s:ansistring;
begin
  s:=memo_output.Text;
  if s='' then lbl_infoout.Caption:='����� 0 ��������' else begin
    lbl_infoout.Caption:='����� '+inttostr(length(s))+' ��������';
  end;
end;

procedure TForm_decryptchip1.Memo_outputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssctrl in shift) and (key=ord('A'))) or ((ssctrl in shift) and (key=ord('�'))) then memo_output.SelectAll;
end;

end.
