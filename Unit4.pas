unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons,unit6, Vcl.Samples.Spin;

type
  TForm_hackchast = class(TForm)
    btn_decrypt: TSpeedButton;
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
    edit_key: TEdit;
    lbl_2: TLabel;
    procedure btn_loadClick(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure btn_decryptClick(Sender: TObject);
    procedure Memo_inputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo_outputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_hackchast: TForm_hackchast;

implementation

{$R *.dfm}

uses Unit1;

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
   if (s<>'')then// and (form_hackchast.spdt_maxlenkey.Value<=length(s) div 2) then
   begin
        infomess('����� ������������',clblack);
        key:=getkey(s);
        edit_key.Text:=key;
        memo_output.Text:=decryptENG(s,key);
        infomess('����� �����������',clgreen);
   end
      else begin
        infomess('������: ��������� ������ �����������', clred);
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

procedure TForm_hackchast.Memo_inputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssctrl in shift) and (key=ord('A'))) or ((ssctrl in shift) and (key=ord('�'))) then memo_input.SelectAll;
end;

procedure TForm_hackchast.Memo_outputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if ((ssctrl in shift) and (key=ord('A'))) or ((ssctrl in shift) and (key=ord('�'))) then memo_output.SelectAll;
end;

end.
