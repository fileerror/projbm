unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.Series, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, Vcl.Menus,
  Vcl.StdCtrls,unit6;

type
  TForm_stat = class(TForm)
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
    Chart1: TChart;
    Series1: TBarSeries;
    Button1: TButton;
    Memo_text: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_stat: TForm_stat;
  p:array['A'..'Z'] of integer;
  pch:array['A'..'Z'] of double;

implementation

{$R *.dfm}

uses Unit1;

procedure refreshchart;
var l:char;
begin
  for l := 'A' to 'Z' do
    form_stat.Series1.YValue[ord(l)-65]:=pch[l];
  form_stat.Chart1.Refresh;
end;

procedure TForm_stat.Button1Click(Sender: TObject);
var i,j,k,q:integer;
    n:set of ansichar;
    s:ansistring;
    l:char;
begin
  s:=memo_text.Text;
  q:=(length(s) div 142)+1;
  totalcleanstr(s);
  s:=AnsiUpperCase(s);
  for l := 'A' to 'Z' do begin
    p[l]:=0;
  end;
  for I := 1  to length(s) do begin
    inc(p[s[i]]);
    pch[s[i]]:=p[s[i]]/length(s);
    if i mod q=0 then refreshchart;
  end;
  refreshchart;
end;

procedure TForm_stat.Button2Click(Sender: TObject);
begin
  memo_text.Clear;
  form_stat.Series1.Clear;
end;

procedure TForm_stat.FormCreate(Sender: TObject);
var k:integer;
    l:char;
begin
  for l := 'A' to 'Z' do form_stat.Series1.Add(0,l,clgreen);
end;

procedure TForm_stat.N9Click(Sender: TObject);
begin
  form_historypage.close;
end;

end.
