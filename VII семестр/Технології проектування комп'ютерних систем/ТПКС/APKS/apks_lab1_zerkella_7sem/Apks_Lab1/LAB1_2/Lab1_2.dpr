program Lab1_2;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����: ����� 2';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
