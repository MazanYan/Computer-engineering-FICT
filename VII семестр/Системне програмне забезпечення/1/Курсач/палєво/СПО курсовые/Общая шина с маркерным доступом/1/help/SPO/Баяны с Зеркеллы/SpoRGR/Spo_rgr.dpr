//����� �������� ���������:
program Spo_rgr;

uses
  Forms,
  spo_rgr_main_unit in 'spo_rgr_main_unit.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
