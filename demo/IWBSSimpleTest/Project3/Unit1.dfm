object IWForm1: TIWForm1
  Left = 0
  Top = 0
  Width = 555
  Height = 400
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
  object rgn1: TIWBSRegion
    Left = 24
    Top = 96
    Width = 513
    Height = 289
    BSRegionType = bsrtContainer
    object rgn2: TIWBSRegion
      Left = 16
      Top = 24
      Width = 481
      Height = 249
      BSRegionType = bsrtRow
      object btn1: TIWBSButton
        Left = 192
        Top = 80
        Width = 200
        Height = 25
        FriendlyName = 'btn1'
        TabOrder = -1
        OnAsyncClick = btn1AsyncClick
        Caption = 'Open Modal'
      end
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 56
    Top = 32
  end
end
