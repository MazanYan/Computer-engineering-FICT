object Form4: TForm4
  Left = 151
  Top = 141
  BorderStyle = bsSingle
  Caption = 'Form4'
  ClientHeight = 177
  ClientWidth = 198
  Color = 15652821
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clNavy
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbPrev: TLabel
    Left = 8
    Top = 8
    Width = 132
    Height = 13
    Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1074#1077#1088#1096#1080#1085#1072
  end
  object lbNext: TLabel
    Left = 8
    Top = 64
    Width = 124
    Height = 13
    Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1074#1077#1088#1096#1080#1085#1072
  end
  object cbPrev: TComboBox
    Left = 8
    Top = 24
    Width = 177
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object cbNext: TComboBox
    Left = 8
    Top = 80
    Width = 177
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 104
    Top = 128
    Width = 81
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    Kind = bkCancel
  end
  object bbOk: TBitBtn
    Left = 8
    Top = 128
    Width = 81
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
end
