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
    object IWBSText2: TIWBSText
      Left = 40
      Top = 8
      Width = 349
      Height = 185
      FriendlyName = 'IWBSText2'
      TabOrder = -1
      Lines.Strings = (
        ' <ul>'
        '  <li>Coffee</li>'
        '  <li>Tea</li>'
        '  <li>Milk</li>'
        '</ul> ')
      RawText = True
    end
    object IWBSImage1: TIWBSImage
      Left = 40
      Top = 216
      Width = 349
      Height = 241
      FriendlyName = 'IWBSImage1'
      TabOrder = -1
      ImageFile = 'C:\temp\Desert.jpg'
      Picture.Data = {07544269746D617000000000}
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 420
    Top = 24
  end
end
