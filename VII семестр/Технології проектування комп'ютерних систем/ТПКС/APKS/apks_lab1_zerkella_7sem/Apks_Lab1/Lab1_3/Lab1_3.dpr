program lab1_3;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����: ����� 3';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
