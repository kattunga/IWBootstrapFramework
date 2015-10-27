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
  object IWBSRegion1: TIWBSRegion
    Left = 40
    Top = 32
    Width = 469
    Height = 89
    Css = 'navbar-default navbar-fixed-top'
    BSRegionType = bsrtNavBar
    object IWBSRegion2: TIWBSRegion
      Left = 40
      Top = 40
      Width = 357
      Height = 40
      BSRegionType = bsrtContainer
    end
  end
  object IWBSRegion3: TIWBSRegion
    Left = 40
    Top = 152
    Width = 469
    Height = 193
    BSRegionType = bsrtContainer
    object IWBSRegion4: TIWBSRegion
      Left = 32
      Top = 24
      Width = 417
      Height = 157
      BSRegionType = bsrtWell
      object IWBSText1: TIWBSText
        Left = 24
        Top = 32
        Width = 369
        Height = 109
        Lines.Strings = (
          'This is a text')
      end
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 420
    Top = 24
  end
end
