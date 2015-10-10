object IWForm4: TIWForm4
  Left = 0
  Top = 0
  Width = 555
  Height = 593
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  Background.Fixed = False
  LayoutMgr = IWBSLayoutMgr1
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  XPTheme = True
  DesignLeft = 8
  DesignTop = 8
  object IWBSRadioGroup1: TIWBSRadioGroup
    Left = 80
    Top = 140
    Width = 409
    Height = 193
    Visible = False
    StyleRenderOptions.RenderVisibility = False
    SubmitOnAsyncEvent = True
    TrimValues = True
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    Layout = glVertical
    FriendlyName = 'IWBSRadioGroup1'
    Items.Strings = (
      'item 1'
      'item 2'
      'item 3')
    TabOrder = -1
    Caption = ''
    Enabled = False
  end
  object IWBSButton1: TIWBSButton
    Left = 80
    Top = 368
    Width = 241
    Height = 25
    Caption = 'IWBSButton1'
    Color = clBtnFace
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'IWBSButton1'
    TabOrder = 1
    OnAsyncClick = IWBSButton1AsyncClick
  end
  object IWBSButton2: TIWBSButton
    Left = 80
    Top = 408
    Width = 241
    Height = 25
    Caption = 'IWBSButton1'
    Color = clBtnFace
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'IWBSButton1'
    TabOrder = 2
  end
  object IWBSInput1: TIWBSInput
    Left = 80
    Top = 60
    Width = 405
    Height = 21
    Caption = ''
    FriendlyName = 'IWBSInput1'
    SubmitOnAsyncEvent = True
    TabOrder = 3
    Text = 'IWBSInput1'
  end
  object IWBSButton3: TIWBSButton
    Left = 332
    Top = 368
    Width = 189
    Height = 25
    Caption = 'Toggle visibility'
    Color = clBtnFace
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'IWBSButton3'
    TabOrder = 4
    OnAsyncClick = IWBSButton3AsyncClick
  end
  object IWBSCheckBox1: TIWBSCheckBox
    Left = 80
    Top = 452
    Width = 121
    Height = 25
    Caption = ''
    FriendlyName = 'IWBSCheckBox1'
    SubmitOnAsyncEvent = True
    TabOrder = 5
    Text = 'IWBSCheckBox1'
    ValueChecked = 'true'
    ValueUnchecked = 'true'
  end
  object IWRadioButton1: TIWRadioButton
    Left = 256
    Top = 452
    Width = 121
    Height = 21
    Caption = 'IWRadioButton1'
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    Group = 'no group'
    Value = 'IWRadioButton1'
    FriendlyName = 'IWRadioButton1'
    SubmitOnAsyncEvent = True
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 420
    Top = 24
  end
end
