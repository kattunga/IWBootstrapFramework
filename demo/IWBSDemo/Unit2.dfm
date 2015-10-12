object IWForm2: TIWForm2
  Left = 0
  Top = 0
  Width = 1084
  Height = 1600
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  ExtraHeader.Strings = (
    '')
  OnCreate = IWAppFormCreate
  Background.Fixed = False
  LayoutMgr = IWBSLayoutMgr1
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  XPTheme = True
  KeepAlive = True
  DesignLeft = 8
  DesignTop = -799
  object IWBSRegion3: TIWBSRegion
    Left = 0
    Top = 0
    Width = 1084
    Height = 1600
    Align = alClient
    BSRegionType = bsrtContainer
    object IWBSRegion5: TIWBSRegion
      Left = 1
      Top = 62
      Width = 1082
      Height = 1537
      Align = alClient
      BSRegionType = bsrtRow
      object IWBSRegion8: TIWBSRegion
        Left = 1
        Top = 1
        Width = 1080
        Height = 1535
        Align = alClient
        BSRegionType = bsrtColumn
        object IWTabControl21: TIWBSTabControl
          Left = 1
          Top = 1
          Width = 1078
          Height = 1533
          RenderInvisibleControls = True
          ActiveTabFont.Color = clWebWHITE
          ActiveTabFont.FontFamily = 'Arial, Sans-Serif, Verdana'
          ActiveTabFont.Size = 10
          ActiveTabFont.Style = [fsBold]
          InactiveTabFont.Color = clWebBLACK
          InactiveTabFont.FontFamily = 'Arial, Sans-Serif, Verdana'
          InactiveTabFont.Size = 10
          InactiveTabFont.Style = []
          ActiveTabColor = clWebDARKGRAY
          InactiveTabColor = clWebLIGHTGRAY
          ActivePage = 0
          Align = alClient
          BorderOptions.NumericWidth = 0
          BorderOptions.BorderWidth = cbwNumeric
          BorderOptions.Style = cbsNone
          BorderOptions.Color = clNone
          Color = clWebSILVER
          BSTabOptions.Pills = True
          BSTabOptions.Responsive = True
          DesignSize = (
            1078
            1533)
          object IWTabControl21Page4: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 1513
            RenderInvisibleControls = True
            TabOrder = 3
            Title = 'Other Bootstrap Controls'
            BorderOptions.NumericWidth = 0
            BorderOptions.BorderWidth = cbwNumeric
            BorderOptions.Style = cbsNone
            BorderOptions.Color = clNone
            Color = clWebWHITE
            object IWBSRegion30: TIWBSRegion
              Left = 0
              Top = 0
              Width = 1078
              Height = 1513
              Align = alClient
              Style.Strings = (
                'margin: 1em')
              object IWBSRegion9: TIWBSRegion
                Left = 16
                Top = 12
                Width = 698
                Height = 60
                BSRegionType = bsrtJumbotron
                object IWText1: TIWText
                  Left = 20
                  Top = 11
                  Width = 540
                  Height = 38
                  BGColor = clNone
                  ConvertSpaces = False
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWText1'
                  Lines.Strings = (
                    '<h1>This is a Jumbotron</h1>'
                    '<h2>Example page header <small>Subtext for header</small></h2>')
                  RawText = True
                  UseFrame = False
                  WantReturns = True
                end
              end
              object IWBSRegion14: TIWBSRegion
                Left = 16
                Top = 78
                Width = 698
                Height = 60
                BSRegionType = bsrtPageHeader
                object IWText4: TIWText
                  Left = 20
                  Top = 11
                  Width = 540
                  Height = 38
                  BGColor = clNone
                  ConvertSpaces = False
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWText1'
                  Lines.Strings = (
                    '<h1>This is a Page Header</h1>'
                    '<h2>Example page header <small>Subtext for header</small></h2>')
                  RawText = True
                  UseFrame = False
                  WantReturns = True
                end
              end
              object IWBSRegion24: TIWBSRegion
                Left = 16
                Top = 151
                Width = 698
                Height = 60
                BSRegionType = bsrtWell
                BSRelativeSize = bsrzLg
                object IWText10: TIWText
                  Left = 20
                  Top = 11
                  Width = 540
                  Height = 38
                  BGColor = clNone
                  ConvertSpaces = False
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWText1'
                  Lines.Strings = (
                    '<h1>This is a Well</h1>'
                    '<h2>Example page header <small>Subtext for header</small></h2>')
                  RawText = True
                  UseFrame = False
                  WantReturns = True
                end
              end
              object IWBSRegion19: TIWBSRegion
                Left = 16
                Top = 255
                Width = 698
                Height = 268
                BSPanelStyle = bspsPrimary
                BSRegionType = bsrtPanel
                object IWBSRegion20: TIWBSRegion
                  Left = 8
                  Top = 22
                  Width = 681
                  Height = 80
                  BSRegionType = bsrtPanelHeading
                  object IWText8: TIWText
                    Left = 19
                    Top = 55
                    Width = 269
                    Height = 22
                    BGColor = clNone
                    ConvertSpaces = False
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWText1'
                    Lines.Strings = (
                      '<h2>this is panel heading</h2>')
                    RawText = True
                    UseFrame = False
                    WantReturns = True
                  end
                  object IWBSRegion23: TIWBSRegion
                    Left = 12
                    Top = 18
                    Width = 653
                    Height = 34
                    BSRegionType = bsrtPanelTitle
                    object IWText7: TIWText
                      Left = 163
                      Top = 9
                      Width = 269
                      Height = 22
                      BGColor = clNone
                      ConvertSpaces = False
                      Font.Color = clNone
                      Font.Size = 10
                      Font.Style = []
                      FriendlyName = 'IWText1'
                      Lines.Strings = (
                        '<h2>this is panel title</h2>')
                      RawText = True
                      UseFrame = False
                      WantReturns = True
                    end
                  end
                end
                object IWBSRegion21: TIWBSRegion
                  Left = 8
                  Top = 193
                  Width = 681
                  Height = 60
                  BSRegionType = bsrtPanelFooter
                  object IWText9: TIWText
                    Left = 24
                    Top = 20
                    Width = 269
                    Height = 22
                    BGColor = clNone
                    ConvertSpaces = False
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWText1'
                    Lines.Strings = (
                      '<h2>this is panel footer</h2>')
                    RawText = True
                    UseFrame = False
                    WantReturns = True
                  end
                end
                object IWBSRegion22: TIWBSRegion
                  Left = 8
                  Top = 108
                  Width = 681
                  Height = 79
                  BSRegionType = bsrtPanelBody
                  object IWText6: TIWText
                    Left = 155
                    Top = 37
                    Width = 269
                    Height = 22
                    BGColor = clNone
                    ConvertSpaces = False
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWText1'
                    Lines.Strings = (
                      '<h2>this is panel body</h2>')
                    RawText = True
                    UseFrame = False
                    WantReturns = True
                  end
                end
              end
            end
          end
          object IWTabControl21Page1: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 1513
            RenderInvisibleControls = True
            TabOrder = 1
            Title = 'Input Group'
            BorderOptions.NumericWidth = 0
            BorderOptions.BorderWidth = cbwNumeric
            BorderOptions.Style = cbsNone
            BorderOptions.Color = clNone
            Color = clWebWHITE
            object IWBSRegion15: TIWBSRegion
              Left = 24
              Top = 13
              Width = 620
              Height = 574
              BSGridOptions.GridMDSpan = 6
              object IWBSInputGroup1: TIWBSInputGroup
                Left = 33
                Top = 119
                Width = 360
                Height = 43
                Caption = 'Button Left (large)'
                BSRelativeSize = bsrzLg
                object IWBSButton22: TIWBSButton
                  Left = 7
                  Top = 8
                  Width = 87
                  Height = 25
                  Hint = 'Press this button'
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'IWBSButton22'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton22'
                  TabOrder = 20
                  OnAsyncClick = IWBSButton22AsyncClick
                end
                object IWBSInput8: TIWBSInput
                  Left = 101
                  Top = 12
                  Width = 121
                  Height = 21
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = ''
                  FriendlyName = 'IWBSInput8'
                  SubmitOnAsyncEvent = True
                  TabOrder = 21
                end
              end
              object IWBSInputGroup2: TIWBSInputGroup
                Left = 33
                Top = 177
                Width = 360
                Height = 43
                Caption = 'Button Right'
                object IWBSButton23: TIWBSButton
                  Left = 231
                  Top = 8
                  Width = 98
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'IWBSButton22'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton22'
                  TabOrder = 22
                end
                object IWBSInput9: TIWBSInput
                  Left = 99
                  Top = 8
                  Width = 121
                  Height = 21
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = ''
                  FriendlyName = 'IWBSInput8'
                  SubmitOnAsyncEvent = True
                  TabOrder = 23
                end
              end
              object IWBSInputGroup3: TIWBSInputGroup
                Left = 33
                Top = 234
                Width = 360
                Height = 51
                Caption = 'Two Buttons (small)'
                BSRelativeSize = bsrzSm
                object IWBSButton24: TIWBSButton
                  Left = 242
                  Top = 8
                  Width = 91
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'IWBSButton22'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton22'
                  TabOrder = 24
                  BSGlyphicon = 'arrow-down'
                end
                object IWBSInput10: TIWBSInput
                  Left = 101
                  Top = 13
                  Width = 121
                  Height = 21
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = ''
                  FriendlyName = 'IWBSInput8'
                  SubmitOnAsyncEvent = True
                  TabOrder = 25
                end
                object IWBSButton25: TIWBSButton
                  Left = 11
                  Top = 8
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'IWBSButton22'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton22'
                  TabOrder = 26
                  BSGlyphicon = 'align-center'
                end
              end
              object IWBSRegion16: TIWBSRegion
                Left = 33
                Top = 10
                Width = 532
                Height = 92
                BSRegionType = bsrtPageHeader
                object IWText5: TIWText
                  Left = 12
                  Top = 15
                  Width = 258
                  Height = 24
                  BGColor = clNone
                  ConvertSpaces = False
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWText5'
                  Lines.Strings = (
                    '<h2>This are input groups</h2>')
                  RawText = True
                  UseFrame = False
                  WantReturns = True
                end
              end
              object IWBSInputGroup4: TIWBSInputGroup
                Left = 33
                Top = 306
                Width = 360
                Height = 58
                Caption = 'CheckBox AddOn'
                object IWBSInput11: TIWBSInput
                  Left = 169
                  Top = 17
                  Width = 121
                  Height = 21
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = ''
                  FriendlyName = 'IWBSInput8'
                  SubmitOnAsyncEvent = True
                  TabOrder = 27
                end
                object IWBSCheckBox3: TIWBSCheckBox
                  Left = 21
                  Top = 16
                  Width = 121
                  Height = 21
                  AutoEditable = False
                  Caption = 'IWBSCheckBox3'
                  FriendlyName = 'IWBSCheckBox3'
                  SubmitOnAsyncEvent = True
                  TabOrder = 28
                  Text = 'false'
                  ValueChecked = 'true'
                  ValueUnchecked = 'false'
                end
              end
              object IWBSInputGroup5: TIWBSInputGroup
                Left = 33
                Top = 379
                Width = 360
                Height = 58
                Caption = 'Radio AddOn'
                object IWBSInput12: TIWBSInput
                  Left = 169
                  Top = 17
                  Width = 121
                  Height = 21
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = ''
                  FriendlyName = 'IWBSInput8'
                  SubmitOnAsyncEvent = True
                  TabOrder = 29
                end
                object IWBSRadioButton5: TIWBSRadioButton
                  Left = 21
                  Top = 16
                  Width = 121
                  Height = 21
                  Caption = 'IWBSRadioButton5'
                  FriendlyName = 'IWBSRadioButton5'
                  SubmitOnAsyncEvent = True
                  TabOrder = 5
                  Text = 'false'
                  Group = 'no group'
                  ValueChecked = 'true'
                  ValueUnchecked = 'false'
                end
              end
              object IWBSInputGroup6: TIWBSInputGroup
                Left = 33
                Top = 443
                Width = 360
                Height = 43
                Caption = 'Glyphicons'
                object IWBSInput4: TIWBSInput
                  Left = 101
                  Top = 12
                  Width = 121
                  Height = 21
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = ''
                  FriendlyName = 'IWBSInput8'
                  SubmitOnAsyncEvent = True
                  TabOrder = 30
                end
                object IWBSGlyphicon1: TIWBSGlyphicon
                  Left = 12
                  Top = 12
                  Width = 29
                  Height = 21
                  BSGlyphicon = 'align-center'
                end
                object IWBSGlyphicon2: TIWBSGlyphicon
                  Left = 292
                  Top = 12
                  Width = 21
                  Height = 21
                end
              end
              object IWBSInputGroup7: TIWBSInputGroup
                Left = 33
                Top = 492
                Width = 360
                Height = 43
                Caption = 'Labels'
                object IWBSInput5: TIWBSInput
                  Left = 101
                  Top = 12
                  Width = 121
                  Height = 21
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = ''
                  FriendlyName = 'IWBSInput8'
                  SubmitOnAsyncEvent = True
                  TabOrder = 31
                end
                object IWBSLabel1: TIWBSLabel
                  Left = 11
                  Top = 12
                  Width = 40
                  Height = 16
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  HasTabOrder = False
                  Caption = 'Before'
                  FriendlyName = 'IWBSLabel1'
                end
                object IWBSLabel2: TIWBSLabel
                  Left = 248
                  Top = 12
                  Width = 30
                  Height = 16
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  HasTabOrder = False
                  Caption = 'After'
                  FriendlyName = 'IWBSLabel2'
                end
              end
            end
          end
          object IWTabControl21Page3: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 1513
            RenderInvisibleControls = True
            TabOrder = 2
            Title = 'Buttons'
            BorderOptions.NumericWidth = 0
            BorderOptions.BorderWidth = cbwNumeric
            BorderOptions.Style = cbsNone
            BorderOptions.Color = clNone
            Color = clWebWHITE
            object IWBSRegion10: TIWBSRegion
              Left = 16
              Top = 81
              Width = 1041
              Height = 361
              object IWBSBtnToolBar1: TIWBSRegion
                Left = 20
                Top = 9
                Width = 1018
                Height = 75
                Style.Strings = (
                  'margin: 2em')
                BSRegionType = bsrtButtonToolbar
                object IWBSBtnGroup1: TIWBSRegion
                  Left = 3
                  Top = 19
                  Width = 352
                  Height = 53
                  BSRegionType = bsrtButtonGroup
                  object IWBSButton1: TIWBSButton
                    Left = 3
                    Top = 17
                    Width = 82
                    Height = 30
                    Hint = 'This is a hint'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Left'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 0
                    BSButtonSize = bsszLg
                    BSGlyphicon = 'align-left'
                  end
                  object IWBSButton2: TIWBSButton
                    Left = 91
                    Top = 17
                    Width = 85
                    Height = 30
                    Hint = 'This is a hint'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Center'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 1
                    BSButtonSize = bsszMd
                    BSGlyphicon = 'align-center'
                  end
                  object IWBSButton3: TIWBSButton
                    Left = 182
                    Top = 18
                    Width = 75
                    Height = 30
                    Hint = 'This is a hint'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Rigth'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 2
                    BSButtonSize = bsszSm
                    BSGlyphicon = 'align-right'
                  end
                  object IWBSButton4: TIWBSButton
                    Left = 267
                    Top = 17
                    Width = 82
                    Height = 30
                    Hint = 'This is a hint'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Justify'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 3
                    BSButtonSize = bsszXs
                    BSGlyphicon = 'align-justify'
                  end
                end
                object IWBSBtnGroup2: TIWBSRegion
                  Left = 361
                  Top = 20
                  Width = 224
                  Height = 51
                  BSRegionType = bsrtButtonGroup
                  object IWBSButton5: TIWBSButton
                    Left = 17
                    Top = 20
                    Width = 36
                    Height = 27
                    Hint = 'This is a hint'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 4
                    BSButtonSize = bsszLg
                    BSGlyphicon = 'align-left'
                  end
                  object IWBSButton6: TIWBSButton
                    Left = 65
                    Top = 22
                    Width = 36
                    Height = 25
                    Hint = 'This is a hint'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 6
                    BSButtonSize = bsszMd
                    BSGlyphicon = 'align-center'
                  end
                  object IWBSButton7: TIWBSButton
                    Left = 107
                    Top = 21
                    Width = 46
                    Height = 25
                    Hint = 'This is a hint'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 7
                    BSButtonSize = bsszSm
                    BSGlyphicon = 'align-right'
                  end
                  object IWBSButton8: TIWBSButton
                    Left = 159
                    Top = 20
                    Width = 34
                    Height = 28
                    Hint = 'This is a hint'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 8
                    BSButtonSize = bsszXs
                    BSGlyphicon = 'align-justify'
                  end
                end
                object IWBSBtnGroup3: TIWBSRegion
                  Left = 632
                  Top = 22
                  Width = 367
                  Height = 50
                  BSButtonGroupOptions.Vertical = True
                  BSRegionType = bsrtButtonGroup
                  object IWBSButton9: TIWBSButton
                    Left = 9
                    Top = 17
                    Width = 76
                    Height = 30
                    Hint = 'This is a hint'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Left'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 9
                    BSButtonSize = bsszLg
                    BSGlyphicon = 'align-left'
                  end
                  object IWBSButton10: TIWBSButton
                    Left = 97
                    Top = 17
                    Width = 86
                    Height = 30
                    Hint = 'This is a hint'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Center'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 10
                    BSButtonSize = bsszMd
                    BSGlyphicon = 'align-center'
                  end
                  object IWBSButton11: TIWBSButton
                    Left = 189
                    Top = 17
                    Width = 76
                    Height = 30
                    Hint = 'This is a hint'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Rigth'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 11
                    BSButtonSize = bsszSm
                    BSGlyphicon = 'align-right'
                  end
                  object IWBSButton12: TIWBSButton
                    Left = 271
                    Top = 17
                    Width = 76
                    Height = 30
                    Hint = 'This is a hint'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Justify'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 12
                    BSButtonSize = bsszXs
                    BSGlyphicon = 'align-justify'
                  end
                end
              end
              object IWBSBtnGroup4: TIWBSRegion
                Left = 20
                Top = 109
                Width = 675
                Height = 60
                Style.Strings = (
                  'margin: 2em')
                BSRegionType = bsrtButtonGroup
                object IWBSButton13: TIWBSButton
                  Left = 13
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'Default'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 13
                end
                object IWBSButton14: TIWBSButton
                  Left = 94
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'Info'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 14
                  BSButtonStyle = bsbsInfo
                end
                object IWBSButton15: TIWBSButton
                  Left = 175
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'Link'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 15
                  BSButtonStyle = bsbsLink
                end
                object IWBSButton16: TIWBSButton
                  Left = 256
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'Primary'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 16
                  BSButtonStyle = bsbsPrimary
                end
                object IWBSButton17: TIWBSButton
                  Left = 337
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'Success'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 17
                  BSButtonStyle = bsbsSuccess
                end
                object IWBSButton18: TIWBSButton
                  Left = 418
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'Warning'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 18
                  BSButtonStyle = bsbsWarning
                end
                object IWBSButton19: TIWBSButton
                  Left = 499
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'Danger'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 19
                  BSButtonStyle = bsbsDanger
                end
                object IWBSButton29: TIWBSButton
                  Left = 580
                  Top = 18
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'Close'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 32
                  BSButtonStyle = bsbsClose
                end
              end
            end
          end
          object IWTabControl21Page5: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 1513
            RenderInvisibleControls = True
            TabOrder = 4
            Title = 'Create components at runtime'
            BorderOptions.NumericWidth = 0
            BorderOptions.BorderWidth = cbwNumeric
            BorderOptions.Style = cbsNone
            BorderOptions.Color = clNone
            Color = clWebWHITE
            object IWBSRegion6: TIWBSRegion
              Left = 0
              Top = 0
              Width = 1078
              Height = 1513
              Align = alClient
              Style.Strings = (
                'margin: 1em')
              object IWBSInputForm4: TIWBSInputForm
                Left = 15
                Top = 12
                Width = 1020
                Height = 1029
                object IWBSRegion12: TIWBSRegion
                  Left = 27
                  Top = 12
                  Width = 538
                  Height = 60
                  BSRegionType = bsrtWell
                  object IWBSButton27: TIWBSButton
                    Left = 16
                    Top = 23
                    Width = 393
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    LockOnAsyncEvents = [aeClick]
                    Caption = 'Dinamically create modal dialog from TIWFrame'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 61
                    OnAsyncClick = IWBSButton27AsyncClick
                  end
                end
                object IWBSRegion26: TIWBSRegion
                  Left = 27
                  Top = 85
                  Width = 538
                  Height = 60
                  BSRegionType = bsrtWell
                  object IWBSButton28: TIWBSButton
                    Left = 12
                    Top = 24
                    Width = 393
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    LockOnAsyncEvents = [aeClick]
                    Caption = 'Dinamically create dialog from code'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 62
                    OnAsyncClick = IWBSButton28AsyncClick
                  end
                end
                object IWBSRegion13: TIWBSRegion
                  Left = 27
                  Top = 163
                  Width = 538
                  Height = 91
                  BSRegionType = bsrtWell
                  object IWBSButton31: TIWBSButton
                    Left = 12
                    Top = 16
                    Width = 393
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    LockOnAsyncEvents = [aeClick]
                    Caption = 'Dinamically create advanced dialog from code'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 63
                    OnAsyncClick = IWBSButton31AsyncClick
                  end
                  object IWBSInput23: TIWBSInput
                    Left = 12
                    Top = 47
                    Width = 121
                    Height = 21
                    Caption = ''
                    FriendlyName = 'IWBSInput6'
                    SubmitOnAsyncEvent = True
                    TabOrder = 64
                    PlaceHolder = 'IWBSInput23'
                  end
                end
                object IWBSRegion17: TIWBSRegion
                  Left = 27
                  Top = 260
                  Width = 538
                  Height = 66
                  BSRegionType = bsrtWell
                  object IWBSButton26: TIWBSButton
                    Left = 12
                    Top = 13
                    Width = 265
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Dinamically create frame with inputs'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 65
                    OnAsyncClick = IWBSButton26AsyncClick
                  end
                end
                object IWBSRegion11: TIWBSRegion
                  Left = 27
                  Top = 335
                  Width = 538
                  Height = 76
                  BSRegionType = bsrtWell
                  object IWBSButton21: TIWBSButton
                    Left = 12
                    Top = 7
                    Width = 397
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Dinamically create button with anonymous proc'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 66
                    OnAsyncClick = IWBSButton21AsyncClick
                  end
                  object IWBSInput6: TIWBSInput
                    Left = 12
                    Top = 38
                    Width = 121
                    Height = 21
                    Caption = ''
                    FriendlyName = 'IWBSInput6'
                    SubmitOnAsyncEvent = True
                    TabOrder = 67
                  end
                end
                object IWBSRegion27: TIWBSRegion
                  Left = 27
                  Top = 428
                  Width = 538
                  Height = 60
                  BSRegionType = bsrtWell
                  object IWBSButton32: TIWBSButton
                    Left = 9
                    Top = 20
                    Width = 393
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Dinamically create Alert'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 68
                    OnAsyncClick = IWBSButton32AsyncClick
                  end
                end
                object IWBSRegion28: TIWBSRegion
                  Left = 27
                  Top = 505
                  Width = 538
                  Height = 104
                  BSRegionType = bsrtWell
                  object IWBSButton33: TIWBSButton
                    Left = 9
                    Top = 9
                    Width = 393
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Dinamically create complex Alert'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 69
                    OnAsyncClick = IWBSButton33AsyncClick
                  end
                  object IWBSInput24: TIWBSInput
                    Left = 9
                    Top = 49
                    Width = 121
                    Height = 21
                    Caption = ''
                    FriendlyName = 'IWBSInput6'
                    SubmitOnAsyncEvent = True
                    TabOrder = 72
                  end
                end
                object IWBSRegion31: TIWBSRegion
                  Left = 27
                  Top = 616
                  Width = 538
                  Height = 60
                  BSRegionType = bsrtWell
                  object IWBSButton34: TIWBSButton
                    Left = 9
                    Top = 20
                    Width = 393
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Raise an exception'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 74
                    OnAsyncClick = IWBSButton34AsyncClick
                  end
                end
              end
            end
          end
          object IWTabControl21Page2: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 1513
            RenderInvisibleControls = True
            TabOrder = 5
            Title = 'TabControl Options'
            BorderOptions.NumericWidth = 0
            BorderOptions.BorderWidth = cbwNumeric
            BorderOptions.Style = cbsNone
            BorderOptions.Color = clNone
            Color = clWebWHITE
            object IWBSRegion7: TIWBSRegion
              Left = 15
              Top = 6
              Width = 433
              Height = 493
              BSGridOptions.GridSMSpan = 6
              Style.Strings = (
                'margin: 1em')
              BSRegionType = bsrtWell
              object IWBSInputForm1: TIWBSInputForm
                Left = 15
                Top = 12
                Width = 293
                Height = 394
                object IWBSButton30: TIWBSButton
                  Left = 17
                  Top = 229
                  Width = 184
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'Apply settings'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton20aaaaaa'
                  TabOrder = 54
                  OnClick = IWBSButton30Click
                end
                object chkContFluid: TIWBSCheckBox
                  Left = 15
                  Top = 41
                  Width = 121
                  Height = 21
                  ShowHint = False
                  AutoEditable = False
                  Caption = 'Container Fluid'
                  FriendlyName = 'chkContFluid'
                  SubmitOnAsyncEvent = True
                  TabOrder = 55
                  Text = 'false'
                  ValueChecked = 'true'
                  ValueUnchecked = 'false'
                end
                object chkTabsJust: TIWBSCheckBox
                  Left = 15
                  Top = 111
                  Width = 121
                  Height = 21
                  Caption = 'Tabs Justified'
                  FriendlyName = 'chkTabsJust'
                  SubmitOnAsyncEvent = True
                  TabOrder = 56
                  Text = 'false'
                  ValueChecked = 'true'
                  ValueUnchecked = 'false'
                end
                object chkTabsStacked: TIWBSCheckBox
                  Left = 15
                  Top = 138
                  Width = 121
                  Height = 21
                  Caption = 'Tabs Stacked'
                  FriendlyName = 'chkTabsStacked'
                  SubmitOnAsyncEvent = True
                  TabOrder = 57
                  Text = 'false'
                  ValueChecked = 'true'
                  ValueUnchecked = 'false'
                end
                object chkTabsPills: TIWBSCheckBox
                  Left = 15
                  Top = 169
                  Width = 121
                  Height = 21
                  Caption = 'Tabs Pills'
                  FriendlyName = 'chkTabsPills'
                  SubmitOnAsyncEvent = True
                  TabOrder = 58
                  Text = 'false'
                  ValueChecked = 'true'
                  ValueUnchecked = 'false'
                end
                object chkTabsFade: TIWBSCheckBox
                  Left = 16
                  Top = 196
                  Width = 121
                  Height = 21
                  Caption = 'Tabs Fade'
                  FriendlyName = 'chkTabsFade'
                  SubmitOnAsyncEvent = True
                  TabOrder = 59
                  Text = 'false'
                  ValueChecked = 'true'
                  ValueUnchecked = 'false'
                end
                object chkTabsResponsive: TIWBSCheckBox
                  Left = 15
                  Top = 76
                  Width = 121
                  Height = 21
                  Caption = 'Tabs Responsive'
                  FriendlyName = 'chkTabsJust'
                  SubmitOnAsyncEvent = True
                  TabOrder = 60
                  Text = 'false'
                  ValueChecked = 'true'
                  ValueUnchecked = 'false'
                end
              end
            end
          end
          object IWTabControl21Page0: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 1513
            RenderInvisibleControls = True
            TabOrder = 0
            Title = 'Form Controls'
            BorderOptions.NumericWidth = 0
            BorderOptions.BorderWidth = cbwNumeric
            BorderOptions.Style = cbsNone
            BorderOptions.Color = clNone
            Color = clWebWHITE
            object IWBSRegion25: TIWBSRegion
              Left = 0
              Top = 0
              Width = 1078
              Height = 1305
              Align = alTop
              Style.Strings = (
                'margin: 1em')
              BSRegionType = bsrtRow
              object IWBSRegion2: TIWBSRegion
                Left = 1
                Top = 1
                Width = 334
                Height = 1303
                Align = alLeft
                BSGridOptions.GridMDSpan = 4
                BSRegionType = bsrtColumn
                object IWBSRegion18: TIWBSRegion
                  Left = 10
                  Top = 20
                  Width = 245
                  Height = 187
                  BSRegionType = bsrtWell
                  object IWBSInputForm3: TIWBSInputForm
                    Left = 3
                    Top = 18
                    Width = 234
                    Height = 159
                    object LstFormType: TIWBSRadioGroup
                      Left = 10
                      Top = 47
                      Width = 128
                      Height = 64
                      Caption = ''
                      FriendlyName = 'LstFormType'
                      SubmitOnAsyncEvent = True
                      TabOrder = 51
                      Text = 'form-vertical'
                      ItemIndex = 0
                      Items.Strings = (
                        'form-vertical'
                        'form-horizontal'
                        'form-inline')
                    end
                    object IWBSButton35: TIWBSButton
                      Left = 10
                      Top = 122
                      Width = 127
                      Height = 25
                      RenderSize = False
                      StyleRenderOptions.RenderSize = False
                      Caption = 'Apply change'
                      Color = clBtnFace
                      Font.Color = clNone
                      Font.Size = 10
                      Font.Style = []
                      FriendlyName = 'IWBSButton20aaaaaa'
                      TabOrder = 33
                      OnClick = IWBSButton35Click
                    end
                    object IWText2: TIWText
                      Left = 12
                      Top = 16
                      Width = 201
                      Height = 19
                      BGColor = clNone
                      ConvertSpaces = False
                      Font.Color = clNone
                      Font.Size = 10
                      Font.Style = []
                      FriendlyName = 'IWText2'
                      Lines.Strings = (
                        '<h3>Form Layout</h3>')
                      RawText = True
                      UseFrame = False
                      WantReturns = True
                    end
                  end
                end
              end
              object IWBSInputForm2: TIWBSInputForm
                Left = 335
                Top = 1
                Width = 742
                Height = 1303
                Align = alClient
                BSGridOptions.GridMDSpan = 8
                BSFormOptions.CaptionsSize.GridMDSpan = 4
                BSFormOptions.InputsSize.GridMDSpan = 8
                object IWBSInput1: TIWBSInput
                  Left = 12
                  Top = 35
                  Width = 201
                  Height = 25
                  ExtraTagParams.Strings = (
                    '')
                  Caption = 'Input Type Text'
                  FriendlyName = 'IWBSInput1'
                  SubmitOnAsyncEvent = True
                  TabOrder = 34
                  BSTextAlignment = bstaCenter
                  PlaceHolder = 'Name'
                end
                object IWBSInput2: TIWBSInput
                  Left = 12
                  Top = 220
                  Width = 201
                  Height = 25
                  Caption = 'Input Type Numer'
                  FriendlyName = 'IWBSInput2'
                  SubmitOnAsyncEvent = True
                  TabOrder = 35
                  PlaceHolder = 'Amount'
                  BSInputType = bsitNumber
                end
                object IWBSInput3: TIWBSInput
                  Left = 12
                  Top = 62
                  Width = 201
                  Height = 25
                  Caption = 'Input Type Password'
                  FriendlyName = 'IWBSInput3'
                  Required = True
                  SubmitOnAsyncEvent = True
                  TabOrder = 36
                  PlaceHolder = 'Password'
                  BSInputType = bsitPassword
                end
                object IWBSMemo2: TIWBSMemo
                  Left = 14
                  Top = 447
                  Width = 433
                  Height = 121
                  Caption = 'This is a Memo'
                  FriendlyName = 'IWBSMemo2'
                  SubmitOnAsyncEvent = True
                  TabOrder = 37
                  BSTextAlignment = bstaRight
                  BSTextCase = bstcUppercase
                  PlaceHolder = 'This is a text area with right align and uppercase'
                end
                object IWBSButton20: TIWBSButton
                  Left = 12
                  Top = 4
                  Width = 326
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'Ajax Click (see input values in memo)'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton20'
                  TabOrder = 40
                  OnAsyncClick = IWBSButton20AsyncClick
                  BSGlyphicon = 'check'
                end
                object IWBSInput7: TIWBSInput
                  Left = 12
                  Top = 113
                  Width = 201
                  Height = 25
                  Caption = 'Input Type Date'
                  FriendlyName = 'IWBSInput3'
                  Required = True
                  SubmitOnAsyncEvent = True
                  TabOrder = 41
                  PlaceHolder = 'Date'
                  BSInputType = bsitDate
                end
                object IWBSInput14: TIWBSInput
                  Left = 12
                  Top = 89
                  Width = 201
                  Height = 25
                  Caption = 'Input Type DateTimeLocal'
                  FriendlyName = 'IWBSInput3'
                  Required = True
                  SubmitOnAsyncEvent = True
                  TabOrder = 42
                  PlaceHolder = 'DateTimeLocal'
                  BSInputType = bsitDateTimeLocal
                end
                object IWBSInput15: TIWBSInput
                  Left = 12
                  Top = 139
                  Width = 201
                  Height = 25
                  Caption = 'Input Type Month'
                  FriendlyName = 'IWBSInput3'
                  Required = True
                  SubmitOnAsyncEvent = True
                  TabOrder = 43
                  PlaceHolder = 'Month'
                  BSInputType = bsitMonth
                end
                object IWBSInput16: TIWBSInput
                  Left = 12
                  Top = 166
                  Width = 201
                  Height = 25
                  Caption = 'Input Type Time'
                  FriendlyName = 'IWBSInput3'
                  Required = True
                  SubmitOnAsyncEvent = True
                  TabOrder = 44
                  PlaceHolder = 'Time'
                  BSInputType = bsitTime
                end
                object IWBSInput17: TIWBSInput
                  Left = 12
                  Top = 193
                  Width = 201
                  Height = 25
                  Caption = 'Input Type Week'
                  FriendlyName = 'IWBSInput3'
                  Required = True
                  SubmitOnAsyncEvent = True
                  TabOrder = 45
                  PlaceHolder = 'Week'
                  BSInputType = bsitWeek
                end
                object IWBSInput18: TIWBSInput
                  Left = 12
                  Top = 244
                  Width = 201
                  Height = 25
                  Caption = 'Input Type Email'
                  FriendlyName = 'IWBSInput2'
                  SubmitOnAsyncEvent = True
                  TabOrder = 46
                  PlaceHolder = 'Email'
                  BSInputType = bsitEmail
                end
                object IWBSInput19: TIWBSInput
                  Left = 12
                  Top = 270
                  Width = 201
                  Height = 25
                  Caption = 'Input Type Url'
                  FriendlyName = 'IWBSInput2'
                  SubmitOnAsyncEvent = True
                  TabOrder = 47
                  PlaceHolder = 'home page'
                  BSInputType = bsitUrl
                end
                object IWBSInput20: TIWBSInput
                  Left = 12
                  Top = 297
                  Width = 201
                  Height = 25
                  Caption = 'Input Type Search'
                  FriendlyName = 'IWBSInput2'
                  SubmitOnAsyncEvent = True
                  TabOrder = 48
                  PlaceHolder = 'Search'
                  BSInputType = bsitSearch
                end
                object IWBSInput21: TIWBSInput
                  Left = 12
                  Top = 324
                  Width = 201
                  Height = 25
                  Caption = 'Input Type Tel'
                  FriendlyName = 'IWBSInput2'
                  SubmitOnAsyncEvent = True
                  TabOrder = 49
                  PlaceHolder = 'Telephone'
                  BSInputType = bsitTel
                end
                object IWBSInput22: TIWBSInput
                  Left = 12
                  Top = 351
                  Width = 201
                  Height = 25
                  Caption = 'Input Type Color'
                  FriendlyName = 'IWBSInput2'
                  SubmitOnAsyncEvent = True
                  TabOrder = 50
                  PlaceHolder = 'Pick a Color'
                  BSInputType = bsitColor
                end
                object IWBSInput13: TIWBSInput
                  Left = 12
                  Top = 381
                  Width = 201
                  Height = 25
                  Caption = 'Input NonEditableAsLabel'
                  Editable = False
                  FriendlyName = 'IWBSInput2'
                  NonEditableAsLabel = True
                  SubmitOnAsyncEvent = True
                  TabOrder = 76
                  Text = 'This is a static text'
                  PlaceHolder = 'Pick a Color'
                end
                object IWBSRadioGroup1: TIWBSRadioGroup
                  Left = 15
                  Top = 932
                  Width = 237
                  Height = 125
                  Caption = 'This is a radio group'
                  FriendlyName = 'IWBSRadioGroup1'
                  SubmitOnAsyncEvent = True
                  TabOrder = 70
                  Text = 'item 1'
                  ItemIndex = 0
                  Items.Strings = (
                    'item 1'
                    'item 2'
                    'item 3'
                    'item 4')
                end
                object IWBSComboBox2: TIWBSSelect
                  Left = 14
                  Top = 764
                  Width = 291
                  Height = 25
                  Caption = 'This is a ComboBox'
                  FriendlyName = 'IWBSComboBox1'
                  SubmitOnAsyncEvent = True
                  TabOrder = 39
                  Items.Strings = (
                    'item 1'
                    'item 2'
                    'item 3'
                    'item 4')
                end
                object IWBSListbox2: TIWBSSelect
                  Left = 14
                  Top = 584
                  Width = 291
                  Height = 77
                  Caption = 'This is a ListBox with multi select'
                  FriendlyName = 'IWBSListbox1'
                  SubmitOnAsyncEvent = True
                  TabOrder = 38
                  Items.Strings = (
                    'item 1'
                    'item 2'
                    'item 3'
                    'item 4')
                  MultiSelect = True
                  Size = 0
                end
                object IWBSListbox3: TIWBSSelect
                  Left = 14
                  Top = 675
                  Width = 291
                  Height = 77
                  Caption = 'This is a ListBox with single select'
                  FriendlyName = 'IWBSListbox1'
                  SubmitOnAsyncEvent = True
                  TabOrder = 52
                  Items.Strings = (
                    'item 1'
                    'item 2'
                    'item 3'
                    'item 4')
                  Size = 0
                end
                object IWBSCheckBox1: TIWBSCheckBox
                  Left = 12
                  Top = 416
                  Width = 201
                  Height = 25
                  Caption = 'IWBSCheckBox1'
                  FriendlyName = 'IWBSCheckBox1'
                  SubmitOnAsyncEvent = True
                  TabOrder = 78
                  Text = 'false'
                  ValueChecked = 'true'
                  ValueUnchecked = 'false'
                end
                object IWBSRegion1: TIWBSRegion
                  Left = 15
                  Top = 799
                  Width = 237
                  Height = 121
                  BSRegionType = bsrtFormGroup
                  object IWBSRadioButton6: TIWBSRadioButton
                    Left = 8
                    Top = 12
                    Width = 121
                    Height = 21
                    Caption = 'Radio Button 1'
                    FriendlyName = 'IWBSRadioButton6'
                    SubmitOnAsyncEvent = True
                    TabOrder = 71
                    Text = 'true'
                    Checked = True
                    Group = 'group1'
                    ValueChecked = 'true'
                    ValueUnchecked = 'false'
                  end
                  object IWBSRadioButton7: TIWBSRadioButton
                    Left = 8
                    Top = 40
                    Width = 121
                    Height = 21
                    Caption = 'Radio Button 2'
                    FriendlyName = 'IWBSRadioButton6'
                    SubmitOnAsyncEvent = True
                    TabOrder = 73
                    Text = 'false'
                    Group = 'group1'
                    ValueChecked = 'true'
                    ValueUnchecked = 'false'
                  end
                  object IWBSRadioButton8: TIWBSRadioButton
                    Left = 8
                    Top = 65
                    Width = 121
                    Height = 21
                    Caption = 'Radio Button 3'
                    FriendlyName = 'IWBSRadioButton6'
                    SubmitOnAsyncEvent = True
                    TabOrder = 75
                    Text = 'false'
                    Group = 'group1'
                    ValueChecked = 'true'
                    ValueUnchecked = 'false'
                  end
                  object IWBSRadioButton9: TIWBSRadioButton
                    Left = 8
                    Top = 92
                    Width = 121
                    Height = 21
                    Caption = 'Radio Button 4'
                    FriendlyName = 'IWBSRadioButton6'
                    SubmitOnAsyncEvent = True
                    TabOrder = 77
                    Text = 'false'
                    Group = 'group1'
                    ValueChecked = 'true'
                    ValueUnchecked = 'false'
                  end
                end
              end
            end
          end
        end
      end
    end
    object IWBSRegion29: TIWBSRegion
      Left = 1
      Top = 1
      Width = 1082
      Height = 61
      Align = alTop
      BSRegionType = bsrtRow
      object IWBSRegion4: TIWBSRegion
        Left = 1
        Top = 1
        Width = 1080
        Height = 59
        Align = alClient
        BSRegionType = bsrtColumn
        object IWBSButton36: TIWBSButton
          Left = 617
          Top = 15
          Width = 242
          Height = 25
          Css = 'pull-right'
          Caption = 'Switch to Data Aware Demo'
          Color = clBtnFace
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'IWBSButton1'
          TabOrder = 53
          OnClick = IWBSButton36Click
        end
        object IWText3: TIWBSText
          Left = 5
          Top = 5
          Width = 381
          Height = 41
          Css = 'pull-left'
          BGColor = clNone
          ConvertSpaces = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'IWText1'
          Lines.Strings = (
            '<h3>This is the standard demo</h3>')
          RawText = True
          UseFrame = False
          WantReturns = True
        end
      end
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 720
    Top = 115
  end
end
