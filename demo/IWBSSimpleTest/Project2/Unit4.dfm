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
  object IWBSInputForm1: TIWBSInputForm
    Left = 16
    Top = 28
    Width = 505
    Height = 546
    object IWBSButton1: TIWBSButton
      Left = 44
      Top = 56
      Width = 181
      Height = 25
      Caption = 'IWBSButton1'
      FriendlyName = 'IWBSButton1'
      ScriptEvents = <
        item
          EventCode.Strings = (
            '$("#IWBSINPUT1").val("pepe");')
          Event = 'onClick'
        end>
      TabOrder = 0
    end
    object IWBSButton2: TIWBSButton
      Left = 44
      Top = 96
      Width = 153
      Height = 25
      Caption = 'IWBSButton2'
      FriendlyName = 'IWBSButton2'
      TabOrder = 1
      OnClick = IWBSButton2Click
    end
    object IWBSInput1: TIWBSInput
      Left = 44
      Top = 147
      Width = 253
      Height = 25
      Caption = ''
      FriendlyName = 'IWBSInput1'
      SubmitOnAsyncEvent = True
      TabOrder = 2
      Text = ''
    end
    object IWBSButton3: TIWBSButton
      Left = 44
      Top = 9
      Width = 181
      Height = 25
      Caption = 'IWBSButton3'
      FriendlyName = 'IWBSButton3'
      TabOrder = 3
      OnAsyncClick = IWBSButton3AsyncClick
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 420
    Top = 24
  end
end
