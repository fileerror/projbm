object Form_historypage: TForm_historypage
  Left = 0
  Top = 0
  Align = alCustom
  BorderStyle = bsSingle
  Caption = 'Form_historypage'
  ClientHeight = 383
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 192
    Top = 216
    Width = 380
    Height = 48
    Caption = #1047#1076#1077#1089#1100' '#1073#1091#1076#1077#1090' '#1080#1089#1090#1086#1088#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object MainMenu1: TMainMenu
    Left = 336
    Top = 104
    object N1: TMenuItem
      Caption = #1064#1080#1092#1088' '#1086#1076#1085#1086#1072#1083#1092#1072#1074#1080#1090#1085#1086#1081' '#1079#1072#1084#1077#1085#1099
    end
    object N2: TMenuItem
      Caption = #1064#1080#1092#1088' '#1042#1080#1078#1077#1085#1077#1088#1072
      object N3: TMenuItem
        Caption = #1064#1080#1092#1088#1086#1074#1072#1085#1080#1077
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = #1044#1077#1096#1080#1092#1088#1086#1074#1072#1085#1080#1077
        OnClick = N4Click
      end
      object N5: TMenuItem
        Caption = #1042#1079#1083#1086#1084' '#1096#1080#1092#1088#1072' '#1084#1077#1090#1086#1076#1086#1084' '#1080#1085#1076#1077#1082#1089#1072' '#1089#1086#1074#1087#1072#1076#1077#1085#1080#1081
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = #1042#1079#1083#1086#1084' '#1096#1080#1092#1088#1072' '#1084#1077#1090#1086#1076#1086#1084' '#1050#1072#1089#1080#1089#1082#1080
      end
    end
    object N7: TMenuItem
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
      OnClick = N7Click
    end
    object N8: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnClick = N8Click
    end
    object N9: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = N9Click
    end
  end
end
