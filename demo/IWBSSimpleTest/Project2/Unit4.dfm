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
  object IWBSButton1: TIWBSButton
    Left = 80
    Top = 368
    Width = 169
    Height = 25
    Caption = 'Submit Input'
    FriendlyName = 'IWBSButton1'
    TabOrder = 0
    OnAsyncClick = IWBSButton1AsyncClick
  end
  object IWBSInput1: TIWBSInput
    Left = 80
    Top = 60
    Width = 405
    Height = 21
    Caption = 'IWBSInput1'
    FriendlyName = 'IWBSInput1'
    SubmitOnAsyncEvent = True
    TabOrder = 1
    Text = 'IWBSInput1'
  end
  object IWBSButton3: TIWBSButton
    Left = 296
    Top = 368
    Width = 189
    Height = 25
    Caption = 'Toggle visibility'
    FriendlyName = 'IWBSButton3'
    TabOrder = 2
  end
  object IWBSSelect1: TIWBSSelect
    Left = 80
    Top = 92
    Width = 405
    Height = 77
    Caption = ''
    FriendlyName = 'IWBSSelect1'
    SubmitOnAsyncEvent = True
    TabOrder = 3
    Text = 'A'
    ItemIndex = 0
    Items.Strings = (
      'Item 1=A'
      'Item 2=B'
      'Item 3=C'
      'Item 4=D'
      'Item 5=E'
      'Item 6=F')
    ItemsHaveValues = True
    MultiSelect = True
    Size = 8
  end
  object IWBSButton2: TIWBSButton
    Left = 80
    Top = 399
    Width = 169
    Height = 25
    Caption = 'Submit Lookup'
    FriendlyName = 'IWBSButton1'
    TabOrder = 4
    OnAsyncClick = IWBSButton2AsyncClick
  end
  object IWImageFile1: TIWImageFile
    Left = 80
    Top = 188
    Width = 273
    Height = 165
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    Cacheable = True
    FriendlyName = 'IWImageFile1'
    ImageFile.Filename = 'desert.jpg'
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 420
    Top = 24
  end
end
