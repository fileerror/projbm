object Form_stat: TForm_stat
  Left = 0
  Top = 0
  Caption = 'Form_stat'
  ClientHeight = 373
  ClientWidth = 765
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 296
    Top = 8
    Width = 461
    Height = 357
    Legend.Alignment = laBottom
    Title.Text.Strings = (
      #1063#1072#1089#1090#1086#1090#1085#1072#1103' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1072)
    View3D = False
    TabOrder = 0
    DefaultCanvas = 'TGDIPlusCanvas'
    PrintMargins = (
      15
      11
      15
      11)
    ColorPaletteIndex = 13
    object Series1: TBarSeries
      SeriesColor = 5623067
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
  object Button1: TButton
    Left = 192
    Top = 223
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo_text: TMemo
    Left = 10
    Top = 8
    Width = 271
    Height = 193
    Lines.Strings = (
      '')
    TabOrder = 2
  end
  object MainMenu1: TMainMenu
    Left = 704
    Top = 176
    object N1: TMenuItem
      Caption = #1064#1080#1092#1088' '#1086#1076#1085#1086#1072#1083#1092#1072#1074#1080#1090#1085#1086#1081' '#1079#1072#1084#1077#1085#1099
    end
    object N2: TMenuItem
      Caption = #1064#1080#1092#1088' '#1042#1080#1078#1077#1085#1077#1088#1072
      object N3: TMenuItem
        Caption = #1064#1080#1092#1088#1086#1074#1072#1085#1080#1077
      end
      object N4: TMenuItem
        Caption = #1044#1077#1096#1080#1092#1088#1086#1074#1072#1085#1080#1077
      end
      object N5: TMenuItem
        Caption = #1042#1079#1083#1086#1084' '#1096#1080#1092#1088#1072' '#1084#1077#1090#1086#1076#1086#1084' '#1080#1085#1076#1077#1082#1089#1072' '#1089#1086#1074#1087#1072#1076#1077#1085#1080#1081
      end
      object N6: TMenuItem
        Caption = #1042#1079#1083#1086#1084' '#1096#1080#1092#1088#1072' '#1084#1077#1090#1086#1076#1086#1084' '#1050#1072#1089#1080#1089#1082#1080
      end
    end
    object N7: TMenuItem
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
    end
    object N8: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    end
    object N9: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = N9Click
    end
  end
end
