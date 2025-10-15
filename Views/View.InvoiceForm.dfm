object SalesInvoiceForm: TSalesInvoiceForm
  Left = 0
  Top = 0
  ClientHeight = 768
  ClientWidth = 675
  Caption = 'Sales Invoice'
  Position = poDesigned
  OldCreateOrder = False
  CaptionAlign = taCenter
  BorderIcons = [biSystemMenu]
  MonitoredKeys.Keys = <>
  Movable = False
  Layout = 'fit'
  LayoutConfig.Padding = '25'
  LayoutAttribs.Padding = '25'
  TextHeight = 15
  object LabelTitle: TUniLabel
    Left = 224
    Top = 16
    Width = 178
    Height = 40
    Hint = ''
    Caption = 'dummy_Title'
    ParentFont = False
    Font.Height = -29
    Font.Style = [fsBold]
    TabOrder = 1
  end
  object LabelInvoiceBalance: TUniLabel
    AlignWithMargins = True
    Left = 8
    Top = 222
    Width = 608
    Height = 68
    Hint = ''
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0.00'
    ParentFont = False
    Font.Color = clMediumblue
    Font.Height = -51
    Font.Style = [fsBold]
    TabOrder = 2
  end
  object GroupBoxInvoiceItems: TUniGroupBox
    Left = 8
    Top = 303
    Width = 608
    Height = 236
    Hint = ''
    Caption = 'dummy_Invoice_Items'
    Layout = 'anchor'
    TabOrder = 3
    ParentFont = False
    Font.Height = -16
    Font.Style = [fsBold]
    DesignSize = (
      608
      236)
    object LabelItem: TUniLabel
      Left = 16
      Top = 34
      Width = 92
      Height = 21
      Hint = ''
      Caption = 'dummy_Item'
      ParentFont = False
      Font.Height = -16
      TabOrder = 1
    end
    object LabelQuantity: TUniLabel
      Left = 16
      Top = 73
      Width = 121
      Height = 21
      Hint = ''
      Caption = 'dummy_Quantity'
      ParentFont = False
      Font.Height = -16
      TabOrder = 2
    end
    object PopupBoxItems: TUniComboBox
      Left = 334
      Top = 29
      Width = 243
      Height = 33
      Hint = ''
      Text = ''
      ParentFont = False
      Font.Height = -17
      TabOrder = 3
      IconItems = <>
    end
    object EditQuantity: TUniEdit
      Left = 143
      Top = 68
      Width = 57
      Height = 33
      Hint = ''
      Text = ''
      ParentFont = False
      Font.Height = -17
      TabOrder = 4
    end
    object ButtonAddItem: TUniButton
      Left = 456
      Top = 68
      Width = 121
      Height = 33
      Hint = ''
      Caption = 'dummy_Add_Item'
      ParentFont = False
      Font.Height = -16
      TabOrder = 5
      OnClick = ButtonAddItemClick
    end
    object StringGridItems: TUniStringGrid
      Left = 3
      Top = 107
      Width = 574
      Height = 126
      Hint = ''
      HeaderTitle = 'Order'#39's items'
      HeaderTitleAlign = taCenter
      FixedCols = 0
      RowCount = 100
      Options = [goVertLine, goHorzLine, goColSizing, goRowMoving, goColMoving, goRowSelect]
      ShowColumnTitles = True
      Columns = <
        item
          Title.Caption = 'dummy_item1'
          Title.Color = clSkyBlue
          Title.Font.Color = clCaptionText
          Title.Font.Height = -13
          Width = 90
          Color = clMenu
        end
        item
          Title.Caption = 'dummy_item2'
          Title.Color = clSkyBlue
          Title.Font.Color = clCaptionText
          Title.Font.Height = -13
          Width = 70
          Color = clMenu
        end
        item
          Title.Caption = 'dummy_item3'
          Title.Color = clSkyBlue
          Title.Font.Color = clCaptionText
          Title.Font.Height = -13
          Width = 86
          Color = clPaleturquoise
        end
        item
          Title.Caption = 'dummy_item4'
          Title.Color = clSkyBlue
          Title.Font.Color = clCaptionText
          Title.Font.Height = -13
          Color = clDarkseagreen
        end
        item
          Title.Caption = 'ID'
          Title.Color = clSkyBlue
          Title.Font.Color = clCaptionText
          Title.Font.Height = -13
          Color = clMenu
        end>
      Anchors = []
      TabOrder = 6
    end
  end
  object ButtonPrintInvoice: TUniButton
    Left = 8
    Top = 672
    Width = 118
    Height = 25
    Hint = ''
    Caption = 'dummy_Print_Invoice'
    ParentFont = False
    Font.Height = -16
    TabOrder = 5
    OnClick = ButtonPrintInvoiceClick
  end
  object ButtonCancel: TUniButton
    Left = 497
    Top = 672
    Width = 108
    Height = 25
    Hint = ''
    Caption = 'dummy_Cancel'
    ParentFont = False
    Font.Height = -16
    TabOrder = 6
    OnClick = ButtonCancelClick
  end
  object AniIndicatorProgress: TUniProgressBar
    Left = 8
    Top = 703
    Width = 170
    Height = 24
    Hint = ''
    Text = 'loading...'
    TabOrder = 7
  end
  object LabelPrinting: TUniLabel
    Left = 184
    Top = 703
    Width = 172
    Height = 21
    Hint = ''
    Caption = 'dummy_Printing_Invoice'
    ParentFont = False
    Font.Height = -16
    TabOrder = 8
  end
  object GroupBoxCustomerDetails: TUniGroupBox
    Left = 8
    Top = 79
    Width = 608
    Height = 130
    Hint = ''
    Caption = 'dummy_Customer_Details'
    Layout = 'auto'
    TabOrder = 0
    ParentFont = False
    Font.Height = -16
    Font.Style = [fsBold]
    DesignSize = (
      608
      130)
    object LabelCustomer: TUniLabel
      Left = 13
      Top = 36
      Width = 129
      Height = 21
      Hint = ''
      Caption = 'dummy_Customer'
      ParentFont = False
      Font.Height = -16
      TabOrder = 1
    end
    object LabelDiscountRate: TUniLabel
      Left = 13
      Top = 72
      Width = 160
      Height = 21
      Hint = ''
      Caption = 'dummy_Discount_Rate'
      ParentFont = False
      Font.Height = -16
      TabOrder = 2
    end
    object LabelTotalBalanceBig: TUniLabel
      Left = 319
      Top = 99
      Width = 258
      Height = 21
      Hint = ''
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'dummy_Outstanding_Balance_Figure'
      ParentFont = False
      Font.Height = -16
      TabOrder = 3
    end
    object LabelOutstandingBalance: TUniLabel
      Left = 13
      Top = 99
      Width = 207
      Height = 21
      Hint = ''
      Caption = 'dummy_Outstanding_Balance'
      ParentFont = False
      Font.Height = -16
      TabOrder = 4
    end
    object LabelDiscountRateFigure: TUniLabel
      Left = 334
      Top = 72
      Width = 243
      Height = 21
      Hint = ''
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'dummy_Discount_Rate_Figure'
      ParentFont = False
      Font.Height = -16
      TabOrder = 5
    end
    object PopupBoxCustomer: TUniComboBox
      Left = 334
      Top = 32
      Width = 243
      Height = 34
      Hint = ''
      Text = ''
      Anchors = [akLeft, akRight]
      ParentFont = False
      Font.Height = -17
      TabOrder = 6
      IconItems = <>
      OnChange = PopupBoxCustomerChange
      ExplicitTop = 29
    end
  end
  object GroupBoxBalance: TUniGroupBox
    Left = 8
    Top = 545
    Width = 608
    Height = 121
    Hint = ''
    Caption = 'dummy_Balance'
    Layout = 'anchor'
    TabOrder = 4
    ParentFont = False
    Font.Height = -16
    Font.Style = [fsBold]
    object LabelInvBalance: TUniLabel
      Left = 13
      Top = 24
      Width = 203
      Height = 21
      Hint = ''
      Caption = 'dummy_Invoice_Balance_Text'
      Align = alCustom
      ParentFont = False
      Font.Height = -16
      TabOrder = 1
    end
    object LabelDiscount: TUniLabel
      Left = 334
      Top = 51
      Width = 243
      Height = 21
      Hint = ''
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'dummy_Discount_Rate'
      Align = alCustom
      ParentFont = False
      Font.Height = -16
      TabOrder = 2
    end
    object LabelTotalBalance: TUniLabel
      Left = 314
      Top = 78
      Width = 263
      Height = 25
      Hint = ''
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'dummy_Outstanding_Balance'
      Align = alCustom
      ParentFont = False
      Font.Height = -19
      Font.Style = [fsBold]
      TabOrder = 3
    end
    object LabelRunningBalance: TUniLabel
      Left = 334
      Top = 24
      Width = 243
      Height = 21
      Hint = ''
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'dummy_Invoice_Balance_Figure'
      Align = alCustom
      Anchors = [akLeft, akTop, akRight]
      ParentFont = False
      Font.Height = -16
      TabOrder = 4
    end
    object CheckBoxDiscount: TUniCheckBox
      Left = 13
      Top = 51
      Width = 157
      Height = 24
      Hint = ''
      Caption = 'dummy_Discount'
      ParentFont = False
      Font.Height = -16
      Align = alCustom
      TabOrder = 5
      OnChange = CheckBoxDiscountChange
    end
    object LabelTotal: TUniLabel
      Left = 13
      Top = 86
      Width = 104
      Height = 21
      Hint = ''
      Alignment = taRightJustify
      Caption = 'dummy_Total'
      Align = alCustom
      ParentFont = False
      Font.Height = -16
      Font.Style = [fsBold]
      TabOrder = 6
    end
  end
  object PopupMenuItems: TPopupMenu
    Left = 544
    Top = 24
    object MenuItemDeleteItem: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1090#1086#1074#1072#1088
      OnClick = MenuItemDeleteItemClick
    end
  end
end
