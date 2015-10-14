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
    Enabled = False
    FriendlyName = 'IWBSRadioGroup1'
    SubmitOnAsyncEvent = True
    TabOrder = 0
    Items.Strings = (
      'item 1'
      'item 2'
      'item 3')
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
    Caption = 'IWBSInput1'
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
    Caption = 'false'
    FriendlyName = 'IWBSCheckBox1'
    SubmitOnAsyncEvent = True
    TabOrder = 5
    Text = 'false'
    ValueChecked = 'true'
    ValueUnchecked = 'true'
  end
  object IWBSRadioButton1: TIWBSRadioButton
    Left = 288
    Top = 452
    Width = 121
    Height = 25
    Caption = 'true'
    FriendlyName = 'IWBSRadioButton1'
    SubmitOnAsyncEvent = True
    TabOrder = 6
    Text = 'true'
    Checked = True
    Group = 'group'
    ValueChecked = 'true'
    ValueUnchecked = 'false'
  end
  object IWBSRadioButton2: TIWBSRadioButton
    Left = 288
    Top = 491
    Width = 121
    Height = 25
    Caption = 'false'
    FriendlyName = 'IWBSRadioButton2'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    Text = 'false'
    Group = 'group'
    ValueChecked = 'true'
    ValueUnchecked = 'false'
  end
  object IWListbox1: TIWListbox
    Left = 224
    Top = 96
    Width = 121
    Height = 121
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    TabOrder = 8
    MaxItems = 0
    FriendlyName = 'IWListbox1'
    NoSelectionText = '-- No Selection --'
  end
  object IWCheckBox1: TIWCheckBox
    Left = 80
    Top = 492
    Width = 121
    Height = 21
    Caption = 'IWCheckBox1'
    Editable = True
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 9
    Checked = False
    FriendlyName = 'IWCheckBox1'
  end
  object IWBSCheckBox2: TIWBSCheckBox
    Left = 80
    Top = 519
    Width = 121
    Height = 25
    Caption = 'false'
    FriendlyName = 'IWBSCheckBox2'
    SubmitOnAsyncEvent = True
    TabOrder = 10
    Text = 'false'
    ValueChecked = 'true'
    ValueUnchecked = 'false'
  end
  object IWBSInput2: TIWBSInput
    Left = 80
    Top = 20
    Width = 121
    Height = 25
    Caption = 'IWBSInput2'
    FriendlyName = 'IWBSInput2'
    SubmitOnAsyncEvent = True
    TabOrder = 11
    Text = 'IWBSInput2'
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 420
    Top = 24
  end
end
