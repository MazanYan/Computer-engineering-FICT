object Form1: TForm1
  Left = 77
  Top = 103
  Width = 880
  Height = 540
  Caption = #1057#1080#1089#1090#1077#1084#1085#1086#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1085#1086#1077' '#1086#1073#1077#1089#1087#1077#1095#1077#1085#1080#1077' - '#1050#1091#1088#1089#1086#1074#1086#1081' '#1087#1088#1086#1077#1082#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 119
    Height = 13
    Caption = #1057#1074#1103#1079#1080' '#1084#1077#1078#1076#1091' '#1079#1072#1076#1072#1095#1072#1084#1080
  end
  object Label2: TLabel
    Left = 24
    Top = 384
    Width = 57
    Height = 13
    Caption = #1042#1077#1089#1072' '#1079#1072#1076#1072#1095
  end
  object Label3: TLabel
    Left = 496
    Top = 16
    Width = 115
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1087#1086#1075#1088#1091#1078#1077#1085#1080#1103
  end
  object Label4: TLabel
    Left = 32
    Top = 456
    Width = 134
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074#1077#1088#1096#1080#1085' '#1075#1088#1072#1092#1072
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 32
    Width = 433
    Height = 337
    ColCount = 16
    DefaultColWidth = 20
    DefaultRowHeight = 16
    RowCount = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentFont = False
    TabOrder = 0
  end
  object StringGrid2: TStringGrid
    Left = 16
    Top = 400
    Width = 433
    Height = 41
    ColCount = 16
    DefaultColWidth = 20
    DefaultRowHeight = 16
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
  end
  object StringGrid3: TStringGrid
    Left = 496
    Top = 32
    Width = 137
    Height = 409
    DefaultColWidth = 20
    DefaultRowHeight = 16
    RowCount = 23
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 2
  end
  object Button1: TButton
    Left = 592
    Top = 456
    Width = 75
    Height = 25
    Caption = #1055#1086#1075#1088#1091#1079#1080#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 184
    Top = 456
    Width = 25
    Height = 21
    TabOrder = 4
    Text = '15'
  end
  object Button2: TButton
    Left = 272
    Top = 448
    Width = 75
    Height = 33
    Caption = #1047#1072#1076#1072#1090#1100
    TabOrder = 5
    OnClick = Button2Click
  end
  object StringGrid4: TStringGrid
    Left = 648
    Top = 32
    Width = 201
    Height = 409
    ColCount = 4
    DefaultColWidth = 20
    DefaultRowHeight = 16
    RowCount = 23
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 6
    ColWidths = (
      20
      41
      42
      40)
  end
end
