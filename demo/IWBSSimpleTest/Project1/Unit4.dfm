object IWForm4: TIWForm4
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
  object GridNavBar: TIWBSNavBar
    Left = 0
    Top = 0
    Width = 555
    Height = 55
    Align = alTop
    ExplicitLeft = -393
    ExplicitTop = 38
    ExplicitWidth = 948
    object BtnSav: TIWBSButton
      Left = 6
      Top = 24
      Width = 35
      Height = 25
      LockOnAsyncEvents = [aeClick]
      FriendlyName = 'BtnSav'
      BSBlockLevel = False
      BSGlyphicon = 'save'
    end
    object BtnPrn: TIWBSButton
      Left = 47
      Top = 24
      Width = 35
      Height = 25
      LockOnAsyncEvents = [aeClick]
      FriendlyName = 'BtnPrn'
      BSBlockLevel = False
      BSGlyphicon = 'print'
    end
    object BtnGra: TIWBSButton
      Left = 90
      Top = 24
      Width = 35
      Height = 25
      Enabled = False
      FriendlyName = 'BtnPrn'
      BSBlockLevel = False
      BSGlyphicon = 'ok'
    end
    object BtnCan: TIWBSButton
      Left = 131
      Top = 24
      Width = 35
      Height = 25
      Enabled = False
      FriendlyName = 'BtnCan'
      BSBlockLevel = False
      BSGlyphicon = 'remove'
    end
    object BtnIns: TIWBSButton
      Left = 172
      Top = 25
      Width = 35
      Height = 25
      FriendlyName = 'BtnCan'
      BSBlockLevel = False
      BSGlyphicon = 'plus'
    end
    object BtnDel: TIWBSButton
      Left = 213
      Top = 24
      Width = 35
      Height = 25
      FriendlyName = 'BtnCan'
      BSBlockLevel = False
      BSGlyphicon = 'minus'
    end
    object BtnMod: TIWBSButton
      Left = 254
      Top = 24
      Width = 35
      Height = 25
      FriendlyName = 'BtnCan'
      BSBlockLevel = False
      BSGlyphicon = 'pencil'
    end
    object BtnCls: TIWBSButton
      Left = 295
      Top = 24
      Width = 35
      Height = 25
      FriendlyName = 'BtnCan'
      BSBlockLevel = False
      BSGlyphicon = 'log-out'
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 152
    Top = 140
  end
end
