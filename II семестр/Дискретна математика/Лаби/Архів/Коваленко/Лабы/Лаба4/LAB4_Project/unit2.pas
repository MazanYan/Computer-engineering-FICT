unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Grids;
const n=17;       //незмінна кількість вершин
  m=144;          //незмінна кількість ребер

type

  { TOperForm }

  TOperForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Label3: TLabel;
    load: TButton;
    ExitButton: TButton;
    InfoPanel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    sg1: TStringGrid;
    sg2: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure loadClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  OperForm: TOperForm;

implementation

{$R *.lfm}

{ TOperForm }

procedure TOperForm.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TOperForm.Image1Click(Sender: TObject);
begin

end;

procedure TOperForm.Label1Click(Sender: TObject);
begin

end;

procedure TOperForm.Button1Click(Sender: TObject);
var
  i,j: Integer;
  a: array[1..3] of byte;
  f: Byte;
begin
  Image1.Visible:=true;     //картинка стає видимою
 sg2.Clean;
 for i:=1 to n do
     sg2.Cells[i,0]:='v'+intToStr(i);    //заповнення крайніх рядків

  for i:=1 to n do
     sg2.Cells[0,i]:='v'+intToStr(i);    //заповнення крайніх стовбців

  for i:=1 to m do
     begin
     f:=1;                         //лічильник для індекса
        a[1]:=0;                   //індекс1
        a[2]:=0;                   //індекс2
     for j:=1 to n do
        begin
        if (sg1.Cells[i,j]='1') then        //знаходить першу одиницю стовбці
        begin
        a[f]:=j;                         //запам’ятовує індекс 1, а потім 2
        f:=f+1;
        end;
        if (sg1.Cells[i,j]='2') then    //якщо знаходить двійку «2» в стовбці
        begin
        a[1]:=j;
        a[2]:=j;                       //обидва індекси рівні номеру її рядку
        end;
        end;
          if (a[1]<>0) then begin            //якщо це не нуль «0»
          sg2.Cells[a[1],a[2]]:='1'; //в sg2 заповнює "1" відповідно до індексів
          sg2.Cells[a[2],a[1]]:='1';
          end;
     end;
 InfoPanel.Caption:='Завдання виконано';
end;

procedure TOperForm.Button2Click(Sender: TObject);      //перевірка
var i,j:Integer;
  q:Boolean;
  k:byte;
begin
     for i:=1 to m do
     begin
         q:=true;
         k:=0;
         for j:=1 to n do
         begin
             if (q=true) then
             begin
              if (sg1.Cells[i,j]='1') then  //знаходить першу та другу одиницю
              k:=k+1;
              if (k=2) then
              q:=false;
              end
             else (sg1.Cells[i,j]:=''); //після двох одиниць заповнює пропусками
         end;
     end;
     InfoPanel.Caption:='Опрацювання виконано';
end;

procedure TOperForm.loadClick(Sender: TObject);      //загрузка даних
var F : Text;
    Str:String;
    i,j:Integer;
begin
   sg1.Clean;
 for i:=1 to m do
     sg1.Cells[i,0]:='e'+intToStr(i);          //заповнення крайніх рядків
  for i:=1 to n do
     sg1.Cells[0,i]:='v'+intToStr(i);         //заповнення крайніх стовбців
 AssignFile(F,'DATA\P2.txt');
 Reset(F);
 Readln(F, Str);
 sg1.RowCount:=StrToInt(str);
 Readln(F, Str);
 sg1.ColCount:=StrToInt(str);
 For j:=1 to sg1.RowCount-1 do
 For i:=1 to sg1.ColCount-1 do
 begin
  Readln(F,str);
  sg1.Cells[i,j]:=str;    //заповнення відношеннями
 end;
 CloseFile(F);
 InfoPanel.Caption:='Загрузка виконана';
end;

end.

