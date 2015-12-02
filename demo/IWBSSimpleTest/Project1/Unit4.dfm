object IWForm4: TIWForm4
  Left = 0
  Top = 0
  Width = 555
  Height = 400
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  Background.Fixed = False
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  XPTheme = True
  DesignLeft = 8
  DesignTop = 8
  object IWBSButton1: TIWBSButton
    Left = 36
    Top = 48
    Width = 200
    Height = 25
    FriendlyName = 'IWBSButton1'
    ScriptEvents = <
      item
        EventCode.Strings = (
          '%OnClickParam%')
        Event = 'onClick'
      end>
    BSBlockLevel = False
    Caption = 'IWBSButton1'
  end
end
