program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form_historypage},
  Unit2 in 'Unit2.pas' {Form_encryptchip1},
  Unit3 in 'Unit3.pas' {Form_decryptchip1},
  Unit4 in 'Unit4.pas' {Form_hackchast},
  Unit5 in 'Unit5.pas' {Form_hackkasiski},
  Unit6 in 'Unit6.pas';

{$R *.res}

begin
  Application.Initialize;
 // Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_historypage, Form_historypage);
  Application.CreateForm(TForm_encryptchip1, Form_encryptchip1);
  Application.CreateForm(TForm_decryptchip1, Form_decryptchip1);
  Application.CreateForm(TForm_hackchast, Form_hackchast);
  Application.CreateForm(TForm_hackkasiski, Form_hackkasiski);
  Application.Run;
end.
