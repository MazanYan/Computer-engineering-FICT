unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,unit2, Menus, ImgList, ToolWin, ComCtrls;

  const
  ColWidth=130;
  RowHeight=90;

const
  CLR_ELLIPSE = clGreen;
  CLR_VERSE = clRed;
  CLR_RECT = clBlue;
  CLR_TEXTRECT = clBlack;
  CLR_ROMB = clBlue;
  CLR_TEXTROMB = clBlack;
  CLR_EMPTYRECT = clBlack;
  CLR_CONNECT = clBlack;
  CLR_YESNO = clBlue;

type
  TConVar=0..2;
var
  EndVerNum:integer;
  PrevList:array of integer;
  CurrentVer:integer;

procedure Connect(Col1,Row1,Col2,Row2:integer;Variant:TConVar; Clr: TColor);
procedure PutRect(Col,Row,N:integer;text:string; Clr: TColor);
procedure PutRomb(Col,Row,N:integer;Text:string; Clr: TColor);
procedure PutEllipse(Col,Row,N:integer; Clr: TColor);

procedure DisConnect(Col1,Row1,Col2,Row2:integer;Variant:TConVar);
procedure DelRect(Col,Row:integer;text:string);
procedure DelRomb(Col,Row:integer;text:string);
procedure DelEllipse(Col,Row:integer);

type
  TForm1 = class(TForm)
    lbPath: TListBox;
    lbCycle: TListBox;
    SaveDialog1: TSaveDialog;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    nOpen: TMenuItem;
    nSave: TMenuItem;
    nNew: TMenuItem;
    N6: TMenuItem;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    tbConnect: TToolButton;
    imButtons: TImageList;
    tbDelConnect: TToolButton;
    ToolButton3: TToolButton;
    tbDelVerse: TToolButton;
    ToolButton5: TToolButton;
    tbControl: TToolButton;
    Splitter1: TSplitter;
    pnMain: TPanel;
    cbType: TComboBox;
    pnLeft: TPanel;
    Splitter2: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure nOpenClick(Sender: TObject);
    procedure nSaveClick(Sender: TObject);
    procedure nNewClick(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure tbDelVerseClick(Sender: TObject);
    procedure tbConnectClick(Sender: TObject);
    procedure tbDelConnectClick(Sender: TObject);
    procedure tbControlClick(Sender: TObject);
    procedure cbTypeChange(Sender: TObject);
  private
    { Private declarations }
  public
    IsSomeLeft: Boolean;
  end;

var
  Form1: TForm1;

implementation

uses Unit3, Unit4;

{$R *.dfm}

procedure Connect(Col1,Row1,Col2,Row2:integer;Variant:TConVar; Clr: TColor);
  var x1,x2,y1,y2,x3,y3,x4,y4,x5,y5,x6,y6:integer;
begin
   x1 := 0;
   y1 := 0;
   y2 := 0;
   x2 := 0;
    if variant=0 then
    begin
      x1:=round((Col1-0.75)*ColWidth);
      x2:=x1;
      y1:=round((Row1-0.5)*RowHeight);
      y2:=y1+round(0.25*RowHeight);
      if (row1>row2)and (Variant=0) then
        y2:=y2-5;

    end;
    if variant=1 then
    begin
      if col1<col2 then
        x1:=round((Col1-0.5)*ColWidth)
      else
        x1:=(Col1-1)*ColWidth;
      y1:=round((Row1-0.75)*RowHeight);
      x2:=x1;
      y2:=y1;
    end;
    if variant=2 then
    begin
      x1:=round((Col1-0.75)*ColWidth);
      y1:=round((Row1-0.75)*RowHeight);
      x2:=x1;
      y2:=y1+round(0.25*RowHeight);
    end;
    if (Col1=Col2)and(row1>row2) then
    begin
      x3:=x1-{+}round(ColWidth/2)+2*((row1-row2)mod 5);{+5}
      y3:=y2;
      x4:=x3;
      y4:=(Row2-1)*RowHeight-round(0.25*RowHeight);
      x5:=round((Col2-0.75)*ColWidth);
      y5:=y4;
      x6:=x5;
      y6:=(Row2-1)*RowHeight;
    end
    else
    begin
      y3:=y2;
      y4:=(Row2-1)*RowHeight-round(0.25*RowHeight);
      x5:=round((Col2-0.75)*ColWidth);
      if row1>row2 then
        y4:=y4+5 ;

      y5:=y4;
      x6:=x5;
      y6:=(Row2-1)*RowHeight;
      if (variant=1) and (col2=col1)then
        x3:=x1-round(ColWidth*0.25)
      else
        x3:=round((x1+x5)/2);//-(row1 mod 5)*5;
      if row1>row2 then
        x3:=x3-3*(row1 mod 5);
      x4:=x3
    end;
   Form1.Image1.Canvas.Pen.Color := Clr;
   Form1.Image1.Canvas.MoveTo(x1,y1);
   Form1.Image1.Canvas.LineTo(x2,y2);
   Form1.Image1.Canvas.LineTo(x3,y3);
   Form1.Image1.Canvas.LineTo(x4,y4);
   Form1.Image1.Canvas.LineTo(x5,y5);
   Form1.Image1.Canvas.LineTo(x6,y6);
end;

procedure PutRect(Col,Row,N:integer;text:string; Clr: TColor);
  var x1,x2,y1,y2:integer;
begin
  x1:=(Col-1)*ColWidth;
  y1:=(Row-1)*RowHeight;
  x2:=round((Col-0.5)*ColWidth);
  y2:=round((Row-0.5)*RowHeight)-3;
  Form1.Image1.Canvas.Pen.Color := Clr;
  Form1.Image1.Canvas.Rectangle(x1,y1,x2,y2);
  Form1.Image1.Canvas.Font.Color := CLR_TEXTRECT;
  Form1.Image1.Canvas.TextOut(round((x1+x2)/2)-15,round((y1+y2)/2)-5,text);
  if N=-1 then
  begin
    Form1.Image1.Canvas.Rectangle(X1-10,y1-7,x1+4,y1+4)
  end
  else begin
        Form1.Image1.Canvas.Font.Color := CLR_VERSE;
    Form1.Image1.Canvas.TextOut(x1-10,y1-7,inttostr(N));
  end;
end;


procedure PutRomb(Col,Row,N:integer;Text:string; Clr: TColor);
  var Coord:array[1..4] of TPoint;
begin
  Coord[1].x:=(Col-1)*ColWidth;
  Coord[1].y:=round((Row-0.75)*RowHeight);
  Coord[2].x:=round((Col-0.75)*ColWidth);
  Coord[2].y:=(Row-1)*RowHeight;
  Coord[3].x:=round((Col-0.5)*ColWidth);
  Coord[3].y:=Coord[1].y;
  Coord[4].x:=Coord[2].x;
  Coord[4].y:=round((Row-0.5)*RowHeight);
  Form1.Image1.Canvas.Pen.Color := Clr;
  Form1.Image1.Canvas.Polygon(Coord);
  Form1.Image1.Canvas.Font.Color := CLR_TEXTROMB;
  Form1.Image1.Canvas.TextOut(Coord[2].x-5,Coord[1].y-5,Text);
  if N=-1 then
  begin
    Form1.Image1.Canvas.Font.Color := clWhite;
    Form1.Image1.Canvas.TextOut(Coord[3].x, Coord[3].Y - Form1.Image1.Canvas.TextHeight('���') - 3, '���');
    Form1.Image1.Canvas.TextOut(Coord[4].x + 3, Coord[4].Y, '��');
    Form1.Image1.Canvas.Rectangle(Coord[1].x-7,Coord[1].y-13,Coord[1].x,Coord[1].y)
  end
  else begin
    Form1.Image1.Canvas.Font.Color := CLR_YESNO;
    Form1.Image1.Canvas.TextOut(Coord[3].x, Coord[3].Y - Form1.Image1.Canvas.TextHeight('���') - 3, '���');
    Form1.Image1.Canvas.TextOut(Coord[4].x + 3, Coord[4].Y, '��');
    Form1.Image1.Canvas.Font.Color := CLR_VERSE;
    Form1.Image1.Canvas.TextOut(Coord[1].x-7,Coord[1].y-13,IntTostr(N));
  end;
end;

procedure PutEllipse(Col,Row,N:integer; Clr: TColor);
  var x1,x2,y1,y2:integer;
begin
  x1:=(Col-1)*ColWidth;
  y1:=(Row-1)*RowHeight;
  x2:=round((Col-0.5)*ColWidth);
  y2:=round((Row-0.75)*RowHeight)-3;
  Form1.Image1.Canvas.Pen.Color := Clr;
  Form1.Image1.Canvas.Ellipse(x1,y1,x2,y2);
  if N=-1 then
  begin
    Form1.Image1.Canvas.Rectangle(x1-10,y1-10,x1,y1+5)
  end
  else begin
    Form1.Image1.Canvas.Font.Color := CLR_VERSE;
    Form1.Image1.Canvas.TextOut(x1-7,y1-7,intTostr(N));
  end;
end;

procedure DisConnect(Col1,Row1,Col2,Row2:integer;Variant:TConVar);
begin
  connect(Col1,Row1,Col2,Row2,Variant, clWhite);
end;{DisConnect}

procedure DelRect(Col,Row:integer;text:string);
begin
  PutRect(Col,Row,-1,Text, clWhite);
end;{DelRect}

procedure DelRomb(Col,Row:integer;text:string);
begin
  PutRomb(Col,Row,-1,Text, clWhite);
end;{DelRomb}

procedure DelEllipse(Col,Row:integer);
begin
  Putellipse(Col,Row,-1, clWhite);
end;{delEllipse}

procedure ClearLeftPanel;
begin
  Form1.IsSomeLeft := False;
  Form1.lbCycle.Clear;
  Form1.lbPath.Clear;
end;

procedure UpdateLeftPanel;
begin
  if Form1.IsSomeLeft then
  begin
    Form1.pnLeft.Visible := True;
    Form1.lbPath.Visible := Form1.cbType.ItemIndex = 0;
    Form1.lbCycle.Visible := Form1.cbType.ItemIndex = 1;
  end
  else begin
    Form1.pnLeft.Visible := False;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
  var i:integer;
begin
  CurrentVer:=0;
  MaxVerNum:=0;
  EndVerNum:=-1;
  VerCount:=1;
  Form1.Image1.Canvas.Pen.Width := 2;
  Form1.Image1.Canvas.Font.Style := [fsBold];
  ClearLeftPanel;
  UpdateLeftPanel;
  for i:=0 to maxV do
  with Verlist[i] do
  begin
    nextMain:=-1;
    NextAlt:=-1;
    exist:=false;
  end;
  With VerList[0] do
  begin
    Num:=0;
    Vid:=b;
    exist:=true;
    Row:=2;
    Col:=3;
    PutEllipse(Col,Row,0,CLR_ELLIPSE)
  end;
  WindowState := wsMaximized;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.nOpenClick(Sender: TObject);
  type TVer=record
        num:integer;
        Vid:TVid;
        Value:string [10];
        NextMain,NextAlt,col,row:integer
      end;

  var f:file of TVer;
       rec:Tver;
      i:integer;
      Variant:TConVar;
begin
  if OpenDialog1.Execute then
  begin
    MaxverNum:=0;
    Image1.Canvas.Rectangle(0,0,2000,2000);
    PutEllipse(3,2,0,CLR_ELLIPSE)  ;
    ClearLeftPanel;
    UpdateLeftPanel;
    for i:=0 to MaxV-1 do
      with VerList[i] do
      begin
        num:=0;
        value:='';
        NextMain:=0;
        NextAlt:=0;
        SetLength(Prev,0);
        exist:=false
      end;

     AssignFile(f,OpenDialog1.FileName);
     Reset(f);
     i:=0;
     VerCount:=0;
     while not eof(f) do
     begin
       read(f,rec);
       VerList[i].num:=rec.num;
       VerList[i].Vid:=rec.Vid;
       VerList[i].Value:=rec.Value;
       VerList[i].NextMain:=rec.NextMain;
       VerList[i].NextAlt:=rec.NextAlt;
       VerList[i].Col:=rec.col;
       VerList[i].Row:=rec.row;
       SetLength(VerList[i].Prev,0);
       i:=i+1;
       VerCount:=VerCount+1;
       if rec.num>MaxverNum then
         maxverNum:=rec.num;
     end;
     closeFile(f);
  for i:=0 to VerCount-1 do
  with VerList[i] do
  begin
    exist:=true;
    if NextMain>-1 then
    begin
      SetLength(VerList[FindVer(NextMain)].Prev,Length(VerList[FindVer(NextMain)].Prev)+1);
      VerList[FindVer(NextMain)].Prev[Length(VerList[FindVer(NextMain)].Prev)-1]:=Num
    end;
    if NextAlt>-1 then
    begin
      SetLength(VerList[FindVer(NextAlt)].Prev,Length(VerList[FindVer(NextAlt)].Prev)+1);
      VerList[FindVer(NextAlt)].Prev[Length(VerList[FindVer(NextAlt)].Prev)-1]:=Num
    end;
  end;
  Variant := 0;
  for i:=0 to VerCount-1 do
    with VerList[i] do
    begin
      case Vid of
        o:Variant:=0;
        l:Variant:=0;
        b:Variant:=2;
      end;
    case Vid of
      k:PutEllipse(Col,row,Num,CLR_ELLIPSE);
      o:PutRect(Col,Row,Num,Value, CLR_RECT);
      l:PutRomb(Col,Row,Num,Value, CLR_ROMB)
    end;
  if NextMain>-1 then
    Connect(Col,Row,VerList[FindVer(NextMain)].Col, VerList[FindVer(NextMain)].Row,Variant, CLR_CONNECT);
  if NextAlt>-1 then
    Connect(Col,Row,VerList[FindVer(NextAlt)].Col, VerList[FindVer(NextAlt)].Row,1, CLR_CONNECT);
  end ;
  end ;
end;

procedure TForm1.nSaveClick(Sender: TObject);
  type TVer=record
        num:integer;
        Vid:TVid;
        Value:string [10];
        NextMain,NextAlt,col,row:integer
      end;

  var f:file of TVer;
       rec:Tver;
      i:integer;
begin
  if  SaveDialog1.Execute then
  begin
     AssignFile(f,SaveDialog1.FileName);
     Rewrite(f);

     for i:=0 to MaxVerNum do
     if VerList[i].exist then
     begin
       rec.num:=VerList[i].num;
       rec.Vid:=VerList[i].Vid;
       rec.Value:=VerList[i].Value;
       rec.NextMain:=VerList[i].NextMain;
       rec.NextAlt:=VerList[i].NextAlt;
       rec.col:=VerList[i].Col;
       rec.row:=VerList[i].Row;
       write(f,rec)
     end;
     closeFile(f);
  end;
end;

procedure TForm1.nNewClick(Sender: TObject);
  var i:integer;
begin
  ClearLeftPanel;
  UpdateLeftPanel;

  Image1.Canvas.Rectangle(0,0,2000,2000);
  CurrentVer:=0;
  MaxVerNum:=0;
  EndVerNum:=-1;
  VerCount:=1;
  for i:=0 to maxV do
  with Verlist[i] do
  begin
    nextMain:=-1;
    NextAlt:=-1;
    exist:=false;
  end;
  With VerList[0] do
  begin
    Num:=0;
    Vid:=b;
    exist:=true;
    Row:=2;
    Col:=3;
    PutEllipse(Col,Row,0,CLR_ELLIPSE)
  end
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
  var i:integer;
      empty:boolean;
begin
    Form3:=TForm3.Create(Self);
    empty:=true;
    for i:=0 to MaxVerNum do
    if VerList[i].exist then
      begin
      if (Verlist[i].Vid<>k)and(Verlist[i].NextMain=-1) then
      begin
        empty:=false;
        Form3.ComboBox1.Items.Add(IntToStr(VerList[i].Num));
      end;
      if VerList[i].Vid=l then
        if VerList[i].NextAlt=-1 then
        begin
          empty:=false;
          Form3.ComboBox1.Items.Add(IntToStr(VerList[i].Num)+'/ �������������� �����');
        end;
    end;
  if empty then
   showError('���������� �������� ������� � ����')
  else
  begin
    Form3.ComboBox1.ItemIndex:=0;
    form3.cbType.ItemIndex:=0;
    Form3.ShowModal;
    Form3.Free;
  end;
end;

procedure TForm1.tbDelVerseClick(Sender: TObject);
  var i:integer;
begin
  Form4:=TForm4.Create(Self);
  for i:=1 to MaxVerNum do
    if VerList[i].exist then
      Form4.cbPrev.Items.Add(IntToStr(VerList[i].Num));
  if Form4.cbPrev.Items.Count > 0 then
  begin
    Form4.cbPrev.ItemIndex:=0;
    Form4.bbOk.OnClick := Form4.SubmitDelVerse;
    Form4.cbPrev.Visible:=True;
    Form4.cbNext.Visible:=False;
    Form4.lbNext.Visible:=false;
    Form4.lbPrev.Caption:='��������� �������';
    Form4.lbPrev.Visible := True;
    Form4.Caption:='��������';
    Form4.ShowModal;
  end
  else ShowError('������ �������');
  Form4.Free;
end;

procedure TForm1.tbConnectClick(Sender: TObject);
  var i:integer;
  empty:boolean;
begin
  Form4:=TForm4.Create(Self);
  empty:=true;
  for i:=0 to MaxVerNum do
  if VerList[i].exist then
  begin
    if (Verlist[i].Vid<>k)and(Verlist[i].NextMain=-1) then
    begin
      empty:=false;
      Form4.cbPrev.Items.Add(IntToStr(VerList[i].Num));
    end;
    if VerList[i].Vid=l then
      if VerList[i].NextAlt=-1 then
      begin
        empty:=false;
        Form4.cbPrev.Items.Add(IntToStr(VerList[i].Num)+'/ �������������� �����');
      end;
  end;
  if empty then
    showError('���������� �������� ����� � ���� !')
  else
  begin
    for i:=1 to MaxVerNum do
      if VerList[i].exist then
        Form4.cbNext.Items.Add(IntToStr(VerList[i].Num));
    Form4.cbPrev.ItemIndex:=0;
    Form4.cbNext.ItemIndex:=0;
    Form4.bbOk.OnClick := Form4.SubmitConnect;
    Form4.cbPrev.Visible:=true;
    Form4.cbNext.Enabled:=true;
    Form4.lbPrev.Visible:=true;
    Form4.lbNext.Caption:='��������� �������';
    Form4.Caption:='����������';
    Form4.ShowModal;
    Form4.Free;
  end;
end;

procedure TForm1.tbDelConnectClick(Sender: TObject);
  var i:integer;
      empty:boolean;
begin
  Form4:=TForm4.Create(Self);
  empty:=true;
  for i:=0 to MaxVerNum do
  if VerList[i].exist then
  begin
    if (Verlist[i].Vid<>k)and(Verlist[i].NextMain<>-1) then
    begin
       empty:=false;
       Form4.cbPrev.Items.Add(IntToStr(VerList[i].Num));
    end;
    if VerList[i].Vid=l then
      if VerList[i].NextAlt<>-1 then
      begin
        empty:=false;
        Form4.cbPrev.Items.Add(IntToStr(VerList[i].Num)+'/ �������������� �����');
      end;
  end;
  if empty then
    showError('���� �� �������� ������')
  else
  begin
    for i:=1 to MaxVerNum do
    if VerList[i].exist then
      Form4.cbNext.Items.Add(IntToStr(VerList[i].Num));
    Form4.cbPrev.ItemIndex:=0;
    Form4.cbNext.ItemIndex:=0;

    Form4.bbOk.OnClick := Form4.SubmitDelConnect;
    Form4.cbPrev.Visible:=true;
    Form4.cbPrev.Enabled:=true;
    Form4.lbPrev.Visible:=true;
    Form4.lbNext.Caption:='��������� �������';
    Form4.Caption:='��������  �����';

    Form4.ShowModal;
    Form4.Free;
  end
end;

procedure TForm1.tbControlClick(Sender: TObject);
  var i,j:integer;
      AllRight:boolean;
begin
  CreateTabSv;
  AllRight:=true;
  if CorrectConnect then
  begin
    PathCycle;
    ClearLeftPanel;
    UpdateLeftPanel;
    for i:=0 to ComplPathCount-1 do
    begin
      lbPath.Items.Add(' ');
      for j:=0 to length(CompletePathArr[i])-1 do begin
        if J > 0 then lbPath.Items[i]:=lbPath.Items[i] + ' > ';
        lbPath.Items[i]:=lbPath.Items[i]+ inttostr(CompletePathArr[i,j]);
      end;
    end;
    for i:=1 to CycleCount do
    begin
      lbCycle.Items.Add('');
      for j:=0 to length(CycleArr[i])-1 do
      begin
        if J > 0 then lbCycle.Items[i-1]:=lbCycle.Items[i-1] + ' > ';
        lbCycle.Items[i-1]:=lbCycle.Items[i-1]+ inttostr(CycleArr[i,j]);
      end;
    end;
    Form1.IsSomeLeft := True;
    if  not AllInPath then
      Allright:=False
    else
       if not CycleCorrect then
         AllRight:=False
       else
         if not  TestConnect then
           AllRight:=false
  end
  else
    AllRight:=false;
if AllRight then
  ShowInfo('���� ��������, ������ �� �������');

  UpdateLeftPanel;
end;

procedure TForm1.cbTypeChange(Sender: TObject);
begin
  UpdateLeftPanel;
end;

end.
