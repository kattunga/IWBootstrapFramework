object IWFrame1: TIWFrame1
  Left = 0
  Top = 0
  Width = 558
  Height = 450
  TabOrder = 0
  object IWBSRegion1: TIWBSRegion
    Left = 16
    Top = 12
    Width = 521
    Height = 413
    RenderInvisibleControls = True
    TabOrder = 0
    object IWBSInput1: TIWBSInput
      Left = 28
      Top = 32
      Width = 241
      Height = 21
      FriendlyName = 'IWBSInput'
      TabOrder = -1
      Caption = ''
      Text = ''
      PlaceHolder = 'Input text here'
    end
    object IWBSButton198: TIWBSButton
      Left = 28
      Top = 116
      Width = 241
      Height = 25
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderStatus = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      FriendlyName = 'IWBSButton198'
      TabOrder = -1
      OnAsyncClick = IWBSButton198AsyncClick
      Caption = 'Press Here'
    end
    object IWBSInput2: TIWBSInput
      Left = 28
      Top = 72
      Width = 241
      Height = 21
      FriendlyName = 'IWBSInput2'
      TabOrder = -1
      Caption = ''
      Text = ''
    end
    object IWBSButton1: TIWBSButton
      Left = 28
      Top = 156
      Width = 237
      Height = 25
      FriendlyName = 'IWBSButton1'
      ScriptEvents = <
        item
          EventCode.Strings = (
            
              '$("#IWBSINPUT1FRAME").val("this text was setted with ScriptEvent' +
              's");')
          Event = 'onClick'
        end>
      TabOrder = -1
      Caption = 'IWBSButton1'
    end
  end
end
