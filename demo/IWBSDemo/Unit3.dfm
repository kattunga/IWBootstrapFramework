object IWFrame3: TIWFrame3
  Left = 0
  Top = 0
  Width = 689
  Height = 578
  TabOrder = 0
  object IWBSModal1: TIWBSModal
    Left = 3
    Top = 3
    Width = 674
    Height = 566
    RenderInvisibleControls = True
    TabOrder = 0
    AsyncDestroy = True
    BSModalVisible = True
    DestroyOnHide = True
    object IWBSRegion1: TIWBSRegion
      Left = 1
      Top = 1
      Width = 672
      Height = 564
      RenderInvisibleControls = True
      Align = alClient
      BSRegionType = bsrtModalContent
      object IWBSRegion2: TIWBSRegion
        Left = 40
        Top = 152
        Width = 601
        Height = 325
        RenderInvisibleControls = True
        BSRegionType = bsrtModalBody
        object IWLabel4: TIWLabel
          Left = 24
          Top = 16
          Width = 99
          Height = 16
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'This is the body'
        end
        object IWBSInput1: TIWBSInput
          Left = 24
          Top = 64
          Width = 121
          Height = 21
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          StyleRenderOptions.RenderPosition = False
          StyleRenderOptions.RenderFont = False
          StyleRenderOptions.RenderStatus = False
          StyleRenderOptions.RenderAbsolute = False
          StyleRenderOptions.RenderPadding = False
          StyleRenderOptions.RenderBorder = False
          AutoFocus = True
          Caption = 'Input'
          FriendlyName = 'IWBSInput1'
          SubmitOnAsyncEvent = True
          TabOrder = 0
          Text = ''
        end
        object IWBSSelect1: TIWBSSelect
          Left = 24
          Top = 104
          Width = 121
          Height = 25
          Caption = ''
          FriendlyName = 'IWBSSelect1'
          SubmitOnAsyncEvent = True
          TabOrder = 2
          Text = ''
          Items.Strings = (
            'item 1'
            'item 2'
            'item 3'
            'item 4')
          MultiSelect = True
        end
      end
      object IWBSRegion3: TIWBSRegion
        Left = 40
        Top = 86
        Width = 601
        Height = 60
        RenderInvisibleControls = True
        BSRegionType = bsrtModalHeader
        object IWLabel2: TIWLabel
          Left = 28
          Top = 24
          Width = 113
          Height = 16
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'This is the header'
        end
        object IWBSButton199: TIWBSButton
          Left = 544
          Top = 16
          Width = 29
          Height = 29
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          StyleRenderOptions.RenderPosition = False
          StyleRenderOptions.RenderFont = False
          StyleRenderOptions.RenderStatus = False
          StyleRenderOptions.RenderAbsolute = False
          StyleRenderOptions.RenderPadding = False
          StyleRenderOptions.RenderBorder = False
          BSButtonStyle = bsbsClose
          BSDataDismiss = bsbdModal
          FriendlyName = 'IWBSButton199'
          TabOrder = 1
        end
      end
      object IWBSRegion4: TIWBSRegion
        Left = 40
        Top = 488
        Width = 601
        Height = 60
        RenderInvisibleControls = True
        BSRegionType = bsrtModalFooter
        object IWLabel1: TIWLabel
          Left = 24
          Top = 20
          Width = 106
          Height = 16
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'This is the footer'
        end
      end
      object IWBSRegion5: TIWBSRegion
        Left = 40
        Top = 14
        Width = 601
        Height = 60
        RenderInvisibleControls = True
        BSRegionType = bsrtModalTitle
        object IWLabel3: TIWLabel
          Left = 28
          Top = 28
          Width = 92
          Height = 16
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'This is the title'
        end
      end
    end
  end
end
