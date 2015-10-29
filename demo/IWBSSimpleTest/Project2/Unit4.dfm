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
  object IWBSRegion3: TIWBSRegion
    Left = 0
    Top = 0
    Width = 555
    Height = 593
    Align = alClient
    BSRegionType = bsrtContainer
    ExplicitLeft = 40
    ExplicitTop = 152
    ExplicitWidth = 469
    ExplicitHeight = 193
    object IWBSText2: TIWBSText
      Left = 40
      Top = 8
      Width = 349
      Height = 185
      Lines.Strings = (
        ' <ul>'
        '  <li>Coffee</li>'
        '  <li>Tea</li>'
        '  <li>Milk</li>'
        '</ul> ')
      RawText = True
    end
    object IWBSButton1: TIWBSButton
      Left = 40
      Top = 248
      Width = 139
      Height = 25
      Caption = 'IWBSButton1'
      FriendlyName = 'IWBSButton1'
      TabOrder = 0
      OnAsyncClick = IWBSButton1AsyncClick
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 420
    Top = 24
  end
end
