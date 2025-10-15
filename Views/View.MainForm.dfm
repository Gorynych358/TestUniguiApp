object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 503
  ClientWidth = 416
  Caption = 'MainForm'
  BorderStyle = bsSingle
  Position = poDesigned
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Movable = False
  Layout = 'fit'
  OnCreate = UniFormCreate
  DesignSize = (
    416
    503)
  TextHeight = 15
  object ButtonInvoice: TUniButton
    Left = 88
    Top = 88
    Width = 241
    Height = 153
    Hint = ''
    Caption = 'dummy_IssueButton'
    Anchors = [akLeft, akTop, akRight, akBottom]
    ParentFont = False
    Font.Height = -16
    Font.Style = [fsBold]
    TabOrder = 0
    OnClick = ButtonInvoiceClick
  end
  object LabelTitle: TUniLabel
    Left = 120
    Top = 25
    Width = 167
    Height = 37
    Hint = ''
    Margins.Left = 20
    Margins.Top = 20
    Margins.Right = 20
    Margins.Bottom = 0
    Caption = 'dummy_Title'
    ParentFont = False
    Font.Height = -27
    Font.Style = [fsBold]
    TabOrder = 1
  end
  object LabelTotalSalesFigure: TUniLabel
    Left = 240
    Top = 265
    Width = 154
    Height = 32
    Hint = ''
    Caption = 'dummy_Sales'
    ParentFont = False
    Font.Color = clDarkgreen
    Font.Height = -24
    Font.Style = [fsBold]
    TabOrder = 2
  end
  object LabelTotalSalesText: TUniLabel
    Left = 8
    Top = 272
    Width = 163
    Height = 25
    Hint = ''
    Caption = 'dummy_TotalSales'
    ParentFont = False
    Font.Height = -19
    Font.Style = [fsBold]
    TabOrder = 3
  end
  object DebugOutputMemo: TUniMemo
    Left = 8
    Top = 312
    Width = 386
    Height = 169
    Hint = ''
    Margins.Bottom = 5
    Lines.Strings = (
      'DebugOutputMemo')
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 4
    EmptyText = #1042#1099#1074#1086#1076' '#1086#1090#1083#1072#1076#1086#1095#1085#1086#1081' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080
  end
end
