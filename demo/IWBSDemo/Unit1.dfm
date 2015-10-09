object IWFrame1: TIWFrame1
  Left = 0
  Top = 0
  Width = 558
  Height = 450
  TabOrder = 0
  object IWBSRegion1: TIWBSRegion
    Left = 16
    Top = 20
    Width = 521
    Height = 413
    RenderInvisibleControls = True
    TabOrder = 0
    object IWBSInput1: TIWBSInput
      Left = 28
      Top = 32
      Width = 241
      Height = 21
      Caption = ''
      FriendlyName = 'IWBSInput'
      SubmitOnAsyncEvent = True
      TabOrder = 0
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
      Caption = 'Press Here'
      Color = clBtnFace
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'IWBSButton198'
      TabOrder = 1
      OnAsyncClick = IWBSButton198AsyncClick
    end
    object IWBSInput2: TIWBSInput
      Left = 28
      Top = 72
      Width = 241
      Height = 21
      Caption = ''
      FriendlyName = 'IWBSInput2'
      SubmitOnAsyncEvent = True
      TabOrder = 2
    end
    object IWBSButton1: TIWBSButton
      Left = 28
      Top = 156
      Width = 237
      Height = 25
      Caption = 'IWBSButton1'
      Color = clBtnFace
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'IWBSButton1'
      ScriptEvents = <
        item
          EventCode.Strings = (
            'console.log('#39'paso'#39');')
          Event = 'onClick'
        end>
      TabOrder = 3
    end
  end
end
