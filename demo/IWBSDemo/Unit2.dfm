object IWForm2: TIWForm2
  Left = 0
  Top = 0
  Width = 1084
  Height = 869
  RenderInvisibleControls = True
  OnRender = IWAppFormRender
  AllowPageAccess = True
  ConnectionMode = cmAny
  OnCreate = IWAppFormCreate
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
    Width = 1084
    Height = 869
    RenderInvisibleControls = True
    Align = alClient
    BSRegionType = bsrtContainer
    BSFormType = bsftVertical
    object IWBSRegion4: TIWBSRegion
      Left = 1
      Top = 1
      Width = 1082
      Height = 60
      RenderInvisibleControls = True
      Align = alTop
      BSRegionType = bsrtRow
      object IWBSRegion6: TIWBSRegion
        Left = 373
        Top = 1
        Width = 708
        Height = 58
        RenderInvisibleControls = True
        TabOrder = 1
        BSGridOptions.GridMDSpan = 6
        Align = alClient
        BSRegionType = bsrtColumn
        object chkTabsFade: TIWBSCheckBox
          Left = 288
          Top = 33
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
          Caption = 'Tabs Fade'
          Editable = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          SubmitOnAsyncEvent = True
          Style = stNormal
          TabOrder = 6
          Checked = False
          FriendlyName = 'chkTabsFade'
        end
        object chkTabsJust: TIWBSCheckBox
          Left = 16
          Top = 34
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
          Caption = 'Tabs Justified'
          Editable = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          SubmitOnAsyncEvent = True
          Style = stNormal
          TabOrder = 7
          Checked = False
          FriendlyName = 'chkTabsJust'
        end
        object chkTabsPills: TIWBSCheckBox
          Left = 288
          Top = 6
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
          Caption = 'Tabs Pills'
          Editable = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          SubmitOnAsyncEvent = True
          Style = stNormal
          TabOrder = 8
          Checked = False
          FriendlyName = 'chkTabsPills'
        end
        object chkTabsStacked: TIWBSCheckBox
          Left = 152
          Top = 8
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
          Caption = 'Tabs Stacked'
          Editable = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          SubmitOnAsyncEvent = True
          Style = stNormal
          TabOrder = 9
          Checked = False
          FriendlyName = 'chkTabsStacked'
        end
        object chkContFluid: TIWBSCheckBox
          Left = 16
          Top = 7
          Width = 121
          Height = 21
          Hint = 'This is a hint'
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          StyleRenderOptions.RenderPosition = False
          StyleRenderOptions.RenderFont = False
          StyleRenderOptions.RenderStatus = False
          StyleRenderOptions.RenderAbsolute = False
          StyleRenderOptions.RenderPadding = False
          StyleRenderOptions.RenderBorder = False
          Caption = 'Container Fluid'
          Editable = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          SubmitOnAsyncEvent = True
          Style = stNormal
          TabOrder = 10
          Checked = False
          FriendlyName = 'chkContFluid'
        end
      end
      object IWBSRegion7: TIWBSRegion
        Left = 1
        Top = 1
        Width = 372
        Height = 58
        RenderInvisibleControls = True
        TabOrder = 0
        BSGridOptions.GridMDSpan = 6
        Align = alLeft
        BSRegionType = bsrtColumn
        object IWBSButton30: TIWBSButton
          Left = 10
          Top = 29
          Width = 75
          Height = 25
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          StyleRenderOptions.RenderPosition = False
          StyleRenderOptions.RenderFont = False
          StyleRenderOptions.RenderStatus = False
          StyleRenderOptions.RenderAbsolute = False
          StyleRenderOptions.RenderPadding = False
          StyleRenderOptions.RenderBorder = False
          Caption = 'Refresh'
          Color = clBtnFace
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'IWBSButton20aaaaaa'
          TabOrder = 5
          OnClick = IWBSButton30Click
        end
        object IWLabel1: TIWLabel
          Left = 10
          Top = 8
          Width = 280
          Height = 16
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'Press here to submit and refresh tab options'
        end
      end
    end
    object IWBSRegion5: TIWBSRegion
      Left = 1
      Top = 61
      Width = 1082
      Height = 807
      RenderInvisibleControls = True
      Align = alClient
      BSRegionType = bsrtRow
      object IWBSRegion8: TIWBSRegion
        Left = 1
        Top = 1
        Width = 1080
        Height = 805
        RenderInvisibleControls = True
        Align = alClient
        BSRegionType = bsrtColumn
        object IWTabControl21: TIWBSTabControl
          Left = 1
          Top = 1
          Width = 1078
          Height = 803
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
          ActivePage = 5
          Align = alClient
          BorderOptions.NumericWidth = 0
          BorderOptions.BorderWidth = cbwNumeric
          BorderOptions.Style = cbsNone
          BorderOptions.Color = clNone
          BSChildRenderOptions = [bschDisablePosition, bschDisableSize, bschDisableFont]
          DesignSize = (
            1078
            803)
          object IWTabControl21Page1: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 783
            RenderInvisibleControls = True
            TabOrder = 3
            Title = 'Buttons'
            BorderOptions.NumericWidth = 0
            BorderOptions.BorderWidth = cbwNumeric
            BorderOptions.Style = cbsNone
            BorderOptions.Color = clNone
            Color = clWebWHITE
            object IWBSRegion10: TIWBSRegion
              Left = 16
              Top = 80
              Width = 1041
              Height = 361
              RenderInvisibleControls = True
              object IWBSBtnToolBar1: TIWBSBtnToolBar
                Left = 20
                Top = 15
                Width = 900
                Height = 60
                RenderInvisibleControls = True
                object IWBSBtnGroup1: TIWBSBtnGroup
                  Left = 12
                  Top = 7
                  Width = 220
                  Height = 42
                  RenderInvisibleControls = True
                  object IWBSButton1: TIWBSButton
                    Left = 1
                    Top = 1
                    Width = 50
                    Height = 40
                    Hint = 'This is a hint'
                    Align = alLeft
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    StyleRenderOptions.RenderPosition = False
                    StyleRenderOptions.RenderFont = False
                    StyleRenderOptions.RenderStatus = False
                    StyleRenderOptions.RenderAbsolute = False
                    StyleRenderOptions.RenderPadding = False
                    StyleRenderOptions.RenderBorder = False
                    Caption = 'Left'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 11
                    BSGlyphicon = 'align-left'
                    BSButtonSize = bsszLg
                  end
                  object IWBSButton2: TIWBSButton
                    Left = 51
                    Top = 1
                    Width = 50
                    Height = 40
                    Hint = 'This is a hint'
                    Align = alLeft
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    StyleRenderOptions.RenderPosition = False
                    StyleRenderOptions.RenderFont = False
                    StyleRenderOptions.RenderStatus = False
                    StyleRenderOptions.RenderAbsolute = False
                    StyleRenderOptions.RenderPadding = False
                    StyleRenderOptions.RenderBorder = False
                    Caption = 'Center'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 12
                    BSGlyphicon = 'align-center'
                    BSButtonSize = bsszMd
                  end
                  object IWBSButton3: TIWBSButton
                    Left = 101
                    Top = 1
                    Width = 50
                    Height = 40
                    Hint = 'This is a hint'
                    Align = alLeft
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    StyleRenderOptions.RenderPosition = False
                    StyleRenderOptions.RenderFont = False
                    StyleRenderOptions.RenderStatus = False
                    StyleRenderOptions.RenderAbsolute = False
                    StyleRenderOptions.RenderPadding = False
                    StyleRenderOptions.RenderBorder = False
                    Caption = 'Rigth'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 13
                    BSGlyphicon = 'align-right'
                    BSButtonSize = bsszSm
                  end
                  object IWBSButton4: TIWBSButton
                    Left = 151
                    Top = 1
                    Width = 50
                    Height = 40
                    Hint = 'This is a hint'
                    Align = alLeft
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    StyleRenderOptions.RenderPosition = False
                    StyleRenderOptions.RenderFont = False
                    StyleRenderOptions.RenderStatus = False
                    StyleRenderOptions.RenderAbsolute = False
                    StyleRenderOptions.RenderPadding = False
                    StyleRenderOptions.RenderBorder = False
                    Caption = 'Justify'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 14
                    BSGlyphicon = 'align-justify'
                    BSButtonSize = bsszXs
                  end
                end
                object IWBSBtnGroup2: TIWBSBtnGroup
                  Left = 246
                  Top = 8
                  Width = 315
                  Height = 42
                  RenderInvisibleControls = True
                  object IWBSButton5: TIWBSButton
                    Left = 1
                    Top = 1
                    Width = 75
                    Height = 40
                    Hint = 'This is a hint'
                    Align = alLeft
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    StyleRenderOptions.RenderPosition = False
                    StyleRenderOptions.RenderFont = False
                    StyleRenderOptions.RenderStatus = False
                    StyleRenderOptions.RenderAbsolute = False
                    StyleRenderOptions.RenderPadding = False
                    StyleRenderOptions.RenderBorder = False
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 15
                    BSGlyphicon = 'align-left'
                    BSButtonSize = bsszLg
                    ExplicitLeft = 16
                    ExplicitTop = 8
                    ExplicitHeight = 25
                  end
                  object IWBSButton6: TIWBSButton
                    Left = 76
                    Top = 1
                    Width = 75
                    Height = 40
                    Hint = 'This is a hint'
                    Align = alLeft
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    StyleRenderOptions.RenderPosition = False
                    StyleRenderOptions.RenderFont = False
                    StyleRenderOptions.RenderStatus = False
                    StyleRenderOptions.RenderAbsolute = False
                    StyleRenderOptions.RenderPadding = False
                    StyleRenderOptions.RenderBorder = False
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 16
                    BSGlyphicon = 'align-center'
                    BSButtonSize = bsszMd
                    ExplicitLeft = 108
                    ExplicitTop = 8
                    ExplicitHeight = 25
                  end
                  object IWBSButton7: TIWBSButton
                    Left = 151
                    Top = 1
                    Width = 75
                    Height = 40
                    Hint = 'This is a hint'
                    Align = alLeft
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    StyleRenderOptions.RenderPosition = False
                    StyleRenderOptions.RenderFont = False
                    StyleRenderOptions.RenderStatus = False
                    StyleRenderOptions.RenderAbsolute = False
                    StyleRenderOptions.RenderPadding = False
                    StyleRenderOptions.RenderBorder = False
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 17
                    BSGlyphicon = 'align-right'
                    BSButtonSize = bsszSm
                    ExplicitLeft = 200
                    ExplicitTop = 8
                    ExplicitHeight = 25
                  end
                  object IWBSButton8: TIWBSButton
                    Left = 226
                    Top = 1
                    Width = 75
                    Height = 40
                    Hint = 'This is a hint'
                    Align = alLeft
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    StyleRenderOptions.RenderPosition = False
                    StyleRenderOptions.RenderFont = False
                    StyleRenderOptions.RenderStatus = False
                    StyleRenderOptions.RenderAbsolute = False
                    StyleRenderOptions.RenderPadding = False
                    StyleRenderOptions.RenderBorder = False
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 18
                    BSGlyphicon = 'align-justify'
                    BSButtonSize = bsszXs
                    ExplicitLeft = 286
                    ExplicitTop = 8
                    ExplicitHeight = 25
                  end
                end
                object IWBSBtnGroup3: TIWBSBtnGroup
                  Left = 576
                  Top = 7
                  Width = 220
                  Height = 42
                  RenderInvisibleControls = True
                  BGOptions.Vertical = True
                  object IWBSButton9: TIWBSButton
                    Left = 1
                    Top = 1
                    Width = 50
                    Height = 40
                    Hint = 'This is a hint'
                    Align = alLeft
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    StyleRenderOptions.RenderPosition = False
                    StyleRenderOptions.RenderFont = False
                    StyleRenderOptions.RenderStatus = False
                    StyleRenderOptions.RenderAbsolute = False
                    StyleRenderOptions.RenderPadding = False
                    StyleRenderOptions.RenderBorder = False
                    Caption = 'Left'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 19
                    BSGlyphicon = 'align-left'
                    BSButtonSize = bsszLg
                  end
                  object IWBSButton10: TIWBSButton
                    Left = 51
                    Top = 1
                    Width = 50
                    Height = 40
                    Hint = 'This is a hint'
                    Align = alLeft
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    StyleRenderOptions.RenderPosition = False
                    StyleRenderOptions.RenderFont = False
                    StyleRenderOptions.RenderStatus = False
                    StyleRenderOptions.RenderAbsolute = False
                    StyleRenderOptions.RenderPadding = False
                    StyleRenderOptions.RenderBorder = False
                    Caption = 'Center'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 20
                    BSGlyphicon = 'align-center'
                    BSButtonSize = bsszMd
                  end
                  object IWBSButton11: TIWBSButton
                    Left = 101
                    Top = 1
                    Width = 50
                    Height = 40
                    Hint = 'This is a hint'
                    Align = alLeft
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    StyleRenderOptions.RenderPosition = False
                    StyleRenderOptions.RenderFont = False
                    StyleRenderOptions.RenderStatus = False
                    StyleRenderOptions.RenderAbsolute = False
                    StyleRenderOptions.RenderPadding = False
                    StyleRenderOptions.RenderBorder = False
                    Caption = 'Rigth'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 21
                    BSGlyphicon = 'align-right'
                    BSButtonSize = bsszSm
                  end
                  object IWBSButton12: TIWBSButton
                    Left = 151
                    Top = 1
                    Width = 50
                    Height = 40
                    Hint = 'This is a hint'
                    Align = alLeft
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    StyleRenderOptions.RenderPosition = False
                    StyleRenderOptions.RenderFont = False
                    StyleRenderOptions.RenderStatus = False
                    StyleRenderOptions.RenderAbsolute = False
                    StyleRenderOptions.RenderPadding = False
                    StyleRenderOptions.RenderBorder = False
                    Caption = 'Justify'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton1'
                    TabOrder = 22
                    BSGlyphicon = 'align-justify'
                    BSButtonSize = bsszXs
                  end
                end
              end
              object IWBSBtnGroup4: TIWBSBtnGroup
                Left = 20
                Top = 88
                Width = 608
                Height = 60
                RenderInvisibleControls = True
                object IWBSButton13: TIWBSButton
                  Left = 13
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Caption = 'Default'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 23
                end
                object IWBSButton14: TIWBSButton
                  Left = 94
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Caption = 'Info'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 24
                  BSButtonStyle = bsbsInfo
                end
                object IWBSButton15: TIWBSButton
                  Left = 175
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Caption = 'Link'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 25
                  BSButtonStyle = bsbsLink
                end
                object IWBSButton16: TIWBSButton
                  Left = 256
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Caption = 'Primary'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 26
                  BSButtonStyle = bsbsPrimary
                end
                object IWBSButton17: TIWBSButton
                  Left = 337
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Caption = 'Success'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 27
                  BSButtonStyle = bsbsSuccess
                end
                object IWBSButton18: TIWBSButton
                  Left = 418
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Caption = 'Warning'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 28
                  BSButtonStyle = bsbsWarning
                end
                object IWBSButton19: TIWBSButton
                  Left = 499
                  Top = 20
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Caption = 'Danger'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton13'
                  TabOrder = 29
                  BSButtonStyle = bsbsDanger
                end
              end
            end
          end
          object IWTabControl21Page3: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 783
            RenderInvisibleControls = True
            TabOrder = 1
            Title = 'Form Controls with form-group'
            BorderOptions.NumericWidth = 0
            BorderOptions.BorderWidth = cbwNumeric
            BorderOptions.Style = cbsNone
            BorderOptions.Color = clNone
            Color = clWebWHITE
            object IWBSRegion2: TIWBSRegion
              Left = 13
              Top = 16
              Width = 334
              Height = 481
              RenderInvisibleControls = True
              BSGridOptions.GridMDSpan = 4
              BSRegionType = bsrtColumn
              object IWText3: TIWText
                Left = 1
                Top = 1
                Width = 332
                Height = 220
                Align = alTop
                BGColor = clNone
                ConvertSpaces = False
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWText2'
                Lines.Strings = (
                  '<h3>Bootstrap supports the following form controls:</h3>'
                  '<h4>'
                  '<ul>'
                  '<li>input</li>'
                  '<li>textarea</li>'
                  '<li>checkbox</li>'
                  '<li>radio</li>'
                  '<li>select</li>'
                  '</ul>'
                  '</h4>'
                  '')
                RawText = True
                UseFrame = False
                WantReturns = True
              end
            end
            object IWBSRegion13: TIWBSRegion
              Left = 364
              Top = 16
              Width = 714
              Height = 753
              RenderInvisibleControls = True
              BSGridOptions.GridMDSpan = 6
              BSRegionType = bsrtColumn
              object IWBSInput1: TIWBSInput
                Left = 12
                Top = 14
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput1'
                MaxLength = 20
                SubmitOnAsyncEvent = True
                TabOrder = 38
                BSTextAlignment = bstaCenter
                Caption = 'Input Type Text'
                PlaceHolder = 'Name'
              end
              object IWBSInput2: TIWBSInput
                Left = 12
                Top = 226
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput2'
                SubmitOnAsyncEvent = True
                TabOrder = 39
                Caption = 'Input Type Numer'
                InputType = bsitNumber
                PlaceHolder = 'Amount'
              end
              object IWBSInput3: TIWBSInput
                Left = 12
                Top = 41
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput3'
                Required = True
                SubmitOnAsyncEvent = True
                TabOrder = 40
                Caption = 'Input Type Password'
                InputType = bsitPassword
                PlaceHolder = 'Password'
              end
              object IWBSMemo2: TIWBSMemo
                Left = 12
                Top = 393
                Width = 433
                Height = 121
                RenderSize = False
                StyleRenderOptions.RenderSize = False
                StyleRenderOptions.RenderPosition = False
                StyleRenderOptions.RenderFont = False
                StyleRenderOptions.RenderStatus = False
                StyleRenderOptions.RenderAbsolute = False
                StyleRenderOptions.RenderPadding = False
                StyleRenderOptions.RenderBorder = False
                BGColor = clNone
                Editable = True
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                InvisibleBorder = False
                HorizScrollBar = False
                VertScrollBar = False
                Required = False
                TabOrder = 41
                SubmitOnAsyncEvent = True
                BSTextAlignment = bstaRight
                BSTextCase = bstcUppercase
                Caption = 'This is a Memo'
                PlaceHolder = 'This is a text area with right align and uppercase'
              end
              object IWBSListbox2: TIWBSListbox
                Left = 12
                Top = 520
                Width = 121
                Height = 77
                RenderSize = False
                StyleRenderOptions.RenderSize = False
                StyleRenderOptions.RenderPosition = False
                StyleRenderOptions.RenderFont = False
                StyleRenderOptions.RenderStatus = False
                StyleRenderOptions.RenderAbsolute = False
                StyleRenderOptions.RenderPadding = False
                StyleRenderOptions.RenderBorder = False
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                RequireSelection = False
                TabOrder = 42
                MaxItems = 0
                FriendlyName = 'IWBSListbox1'
                Items.Strings = (
                  'item 1'
                  'item 2'
                  'item 3'
                  'item 4')
                MultiSelect = True
                Caption = 'This is a ListBox with multi select'
                NoSelectionText = '-- No Selection --'
              end
              object IWBSComboBox2: TIWBSComboBox
                Left = 12
                Top = 700
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                TabOrder = 43
                ItemIndex = -1
                Items.Strings = (
                  'item 1'
                  'item 2'
                  'item 3'
                  'item 4')
                FriendlyName = 'IWBSComboBox1'
                Caption = 'This is a ComboBox'
                NoSelectionText = '-- No Selection --'
              end
              object IWBSButton20: TIWBSButton
                Left = 584
                Top = 3
                Width = 119
                Height = 25
                RenderSize = False
                StyleRenderOptions.RenderSize = False
                StyleRenderOptions.RenderPosition = False
                StyleRenderOptions.RenderFont = False
                StyleRenderOptions.RenderStatus = False
                StyleRenderOptions.RenderAbsolute = False
                StyleRenderOptions.RenderPadding = False
                StyleRenderOptions.RenderBorder = False
                Caption = 'Ajax Click'
                Color = clBtnFace
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSButton20'
                TabOrder = 44
                OnAsyncClick = IWBSButton20AsyncClick
                BSButtonStyle = bsbsSuccess
              end
              object IWBSInput7: TIWBSInput
                Left = 12
                Top = 119
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput3'
                Required = True
                SubmitOnAsyncEvent = True
                TabOrder = 45
                Caption = 'Input Type Date'
                InputType = bsitDate
                PlaceHolder = 'Date'
              end
              object IWBSInput13: TIWBSInput
                Left = 12
                Top = 68
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput3'
                Required = True
                SubmitOnAsyncEvent = True
                TabOrder = 57
                Caption = 'Input Type DateTime'
                InputType = bsitDateTime
                PlaceHolder = 'DateTime'
              end
              object IWBSInput14: TIWBSInput
                Left = 12
                Top = 95
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput3'
                Required = True
                SubmitOnAsyncEvent = True
                TabOrder = 58
                Caption = 'Input Type DateTimeLocal'
                InputType = bsitDateTimeLocal
                PlaceHolder = 'DateTimeLocal'
              end
              object IWBSInput15: TIWBSInput
                Left = 12
                Top = 145
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput3'
                Required = True
                SubmitOnAsyncEvent = True
                TabOrder = 59
                Caption = 'Input Type Month'
                InputType = bsitMonth
                PlaceHolder = 'Month'
              end
              object IWBSInput16: TIWBSInput
                Left = 12
                Top = 172
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput3'
                Required = True
                SubmitOnAsyncEvent = True
                TabOrder = 60
                Caption = 'Input Type Time'
                InputType = bsitTime
                PlaceHolder = 'Time'
              end
              object IWBSInput17: TIWBSInput
                Left = 12
                Top = 199
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput3'
                Required = True
                SubmitOnAsyncEvent = True
                TabOrder = 61
                Caption = 'Input Type Week'
                InputType = bsitWeek
                PlaceHolder = 'Week'
              end
              object IWBSInput18: TIWBSInput
                Left = 12
                Top = 250
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput2'
                SubmitOnAsyncEvent = True
                TabOrder = 62
                Caption = 'Input Type Email'
                InputType = bsitEmail
                PlaceHolder = 'Email'
              end
              object IWBSInput19: TIWBSInput
                Left = 12
                Top = 276
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput2'
                SubmitOnAsyncEvent = True
                TabOrder = 63
                Caption = 'Input Type Url'
                InputType = bsitUrl
                PlaceHolder = 'home page'
              end
              object IWBSInput20: TIWBSInput
                Left = 12
                Top = 303
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput2'
                SubmitOnAsyncEvent = True
                TabOrder = 64
                Caption = 'Input Type Search'
                InputType = bsitSearch
                PlaceHolder = 'Search'
              end
              object IWBSInput21: TIWBSInput
                Left = 12
                Top = 330
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput2'
                SubmitOnAsyncEvent = True
                TabOrder = 65
                Caption = 'Input Type Tel'
                InputType = bsitTel
                PlaceHolder = 'Telephone'
              end
              object IWBSInput22: TIWBSInput
                Left = 12
                Top = 357
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
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWBSInput2'
                SubmitOnAsyncEvent = True
                TabOrder = 66
                Caption = 'Input Type Color'
                InputType = bsitColor
                PlaceHolder = 'Pick a Color'
              end
              object IWBSListbox3: TIWBSListbox
                Left = 12
                Top = 611
                Width = 121
                Height = 77
                RenderSize = False
                StyleRenderOptions.RenderSize = False
                StyleRenderOptions.RenderPosition = False
                StyleRenderOptions.RenderFont = False
                StyleRenderOptions.RenderStatus = False
                StyleRenderOptions.RenderAbsolute = False
                StyleRenderOptions.RenderPadding = False
                StyleRenderOptions.RenderBorder = False
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                RequireSelection = False
                TabOrder = 67
                MaxItems = 0
                FriendlyName = 'IWBSListbox1'
                Items.Strings = (
                  'item 1'
                  'item 2'
                  'item 3'
                  'item 4')
                Caption = 'This is a Regular ListBox'
                NoSelectionText = '-- No Selection --'
              end
            end
          end
          object IWTabControl21Page4: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 783
            RenderInvisibleControls = True
            TabOrder = 2
            Title = 'Form Controls with Input Group'
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
              RenderInvisibleControls = True
              BSGridOptions.GridMDSpan = 6
              object IWBSInputGroup1: TIWBSInputGroup
                Left = 33
                Top = 119
                Width = 360
                Height = 43
                RenderInvisibleControls = True
                Caption = 'Button Left'
                object IWBSButton22: TIWBSButton
                  Left = 7
                  Top = 8
                  Width = 75
                  Height = 25
                  Hint = 'Press this button'
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Caption = 'IWBSButton22'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton22'
                  TabOrder = 47
                  OnAsyncClick = IWBSButton22AsyncClick
                end
                object IWBSInput8: TIWBSInput
                  Left = 101
                  Top = 12
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
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSInput8'
                  SubmitOnAsyncEvent = True
                  TabOrder = 48
                  Caption = ''
                end
              end
              object IWBSInputGroup2: TIWBSInputGroup
                Left = 33
                Top = 177
                Width = 360
                Height = 43
                RenderInvisibleControls = True
                Caption = 'Button Right'
                object IWBSButton23: TIWBSButton
                  Left = 231
                  Top = 8
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Caption = 'IWBSButton22'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton22'
                  TabOrder = 49
                end
                object IWBSInput9: TIWBSInput
                  Left = 99
                  Top = 8
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
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSInput8'
                  SubmitOnAsyncEvent = True
                  TabOrder = 50
                  Caption = ''
                end
              end
              object IWBSInputGroup3: TIWBSInputGroup
                Left = 33
                Top = 234
                Width = 360
                Height = 51
                RenderInvisibleControls = True
                Caption = 'Two Buttons'
                object IWBSButton24: TIWBSButton
                  Left = 238
                  Top = 6
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Caption = 'IWBSButton22'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton22'
                  TabOrder = 51
                end
                object IWBSInput10: TIWBSInput
                  Left = 101
                  Top = 13
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
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSInput8'
                  SubmitOnAsyncEvent = True
                  TabOrder = 52
                  Caption = ''
                end
                object IWBSButton25: TIWBSButton
                  Left = 11
                  Top = 8
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Caption = 'IWBSButton22'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton22'
                  TabOrder = 53
                  BSGlyphicon = 'align-center'
                end
              end
              object IWBSRegion16: TIWBSRegion
                Left = 33
                Top = 10
                Width = 532
                Height = 92
                RenderInvisibleControls = True
                BSRegionType = bsrtPageHeader
                object IWText5: TIWText
                  Left = 33
                  Top = 9
                  Width = 416
                  Height = 52
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
                RenderInvisibleControls = True
                Caption = 'CheckBox AddOn'
                object IWBSInput11: TIWBSInput
                  Left = 169
                  Top = 17
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
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSInput8'
                  SubmitOnAsyncEvent = True
                  TabOrder = 54
                  Caption = ''
                end
                object IWBSCheckBox3: TIWBSCheckBox
                  Left = 21
                  Top = 16
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
                  Caption = 'IWBSCheckBox3'
                  Editable = True
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  SubmitOnAsyncEvent = True
                  Style = stNormal
                  TabOrder = 55
                  Checked = False
                  FriendlyName = 'IWBSCheckBox3'
                end
              end
              object IWBSInputGroup5: TIWBSInputGroup
                Left = 33
                Top = 379
                Width = 360
                Height = 58
                RenderInvisibleControls = True
                Caption = 'Radio AddOn'
                object IWBSInput12: TIWBSInput
                  Left = 169
                  Top = 17
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
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSInput8'
                  SubmitOnAsyncEvent = True
                  TabOrder = 56
                  Caption = ''
                end
                object IWBSRadioButton5: TIWBSRadioButton
                  Left = 21
                  Top = 16
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
                  Caption = 'IWBSRadioButton5'
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  Group = 'no group'
                  Value = 'IWBSRadioButton5'
                  FriendlyName = 'IWBSRadioButton5'
                  SubmitOnAsyncEvent = True
                end
              end
            end
          end
          object IWTabControl21Page2: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 783
            RenderInvisibleControls = True
            TabOrder = 4
            Title = 'Bootstrap Components'
            BorderOptions.NumericWidth = 0
            BorderOptions.BorderWidth = cbwNumeric
            BorderOptions.Style = cbsNone
            BorderOptions.Color = clNone
            Color = clWebWHITE
            object IWBSRegion9: TIWBSRegion
              Left = 16
              Top = 12
              Width = 698
              Height = 60
              RenderInvisibleControls = True
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
              Top = 102
              Width = 698
              Height = 60
              RenderInvisibleControls = True
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
          end
          object IWTabControl21Page0: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 783
            RenderInvisibleControls = True
            TabOrder = 0
            Title = 'Form Controls'
            BorderOptions.NumericWidth = 0
            BorderOptions.BorderWidth = cbwNumeric
            BorderOptions.Style = cbsNone
            BorderOptions.Color = clNone
            Color = clWebWHITE
            object IWBSRegion1: TIWBSRegion
              Left = 0
              Top = 0
              Width = 1078
              Height = 783
              RenderInvisibleControls = True
              Align = alClient
              BSRegionType = bsrtRow
              object IWBSRegion11: TIWBSRegion
                Left = 9
                Top = 12
                Width = 334
                Height = 481
                RenderInvisibleControls = True
                BSGridOptions.GridMDSpan = 4
                BSRegionType = bsrtColumn
                object IWText2: TIWText
                  Left = 1
                  Top = 1
                  Width = 332
                  Height = 220
                  Align = alTop
                  BGColor = clNone
                  ConvertSpaces = False
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWText2'
                  Lines.Strings = (
                    '<h3>Bootstrap supports the following form controls:</h3>'
                    '<h4>'
                    '<ul>'
                    '<li>input</li>'
                    '<li>textarea</li>'
                    '<li>checkbox</li>'
                    '<li>radio</li>'
                    '<li>select</li>'
                    '</ul>'
                    '</h4>'
                    '')
                  RawText = True
                  UseFrame = False
                  WantReturns = True
                end
              end
              object IWBSRegion12: TIWBSRegion
                Left = 361
                Top = 12
                Width = 714
                Height = 753
                RenderInvisibleControls = True
                BSGridOptions.GridMDSpan = 6
                BSRegionType = bsrtColumn
                object IWBSInput4: TIWBSInput
                  Left = 12
                  Top = 18
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
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSInput1'
                  MaxLength = 20
                  SubmitOnAsyncEvent = True
                  TabOrder = 30
                  BSTextAlignment = bstaCenter
                  Caption = ''
                  PlaceHolder = 'Name'
                end
                object IWBSInput5: TIWBSInput
                  Left = 12
                  Top = 54
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
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSInput2'
                  SubmitOnAsyncEvent = True
                  TabOrder = 31
                  Caption = ''
                  InputType = bsitNumber
                  PlaceHolder = 'Amount'
                end
                object IWBSInput6: TIWBSInput
                  Left = 12
                  Top = 93
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
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSInput3'
                  Required = True
                  SubmitOnAsyncEvent = True
                  TabOrder = 32
                  Caption = ''
                  InputType = bsitPassword
                  PlaceHolder = 'Password'
                end
                object IWBSMemo1: TIWBSMemo
                  Left = 12
                  Top = 127
                  Width = 433
                  Height = 121
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  BGColor = clNone
                  Editable = True
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  InvisibleBorder = False
                  HorizScrollBar = False
                  VertScrollBar = False
                  Required = False
                  TabOrder = 33
                  SubmitOnAsyncEvent = True
                  BSTextAlignment = bstaRight
                  BSTextCase = bstcUppercase
                  Caption = ''
                  PlaceHolder = 'This is a memo'
                end
                object IWBSRadioButton1: TIWBSRadioButton
                  Left = 12
                  Top = 360
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
                  Caption = 'IWBSRadioButton1'
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  Checked = True
                  Group = 'no group'
                  Value = 'IWBSRadioButton1'
                  FriendlyName = 'IWBSRadioButton1'
                  SubmitOnAsyncEvent = True
                end
                object IWBSRadioButton2: TIWBSRadioButton
                  Left = 12
                  Top = 380
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
                  Caption = 'IWBSRadioButton1'
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  Group = 'no group'
                  Value = 'IWBSRadioButton1'
                  FriendlyName = 'IWBSRadioButton1'
                  SubmitOnAsyncEvent = True
                end
                object IWBSRadioButton3: TIWBSRadioButton
                  Left = 12
                  Top = 401
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
                  Caption = 'IWBSRadioButton1'
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  Group = 'no group'
                  Value = 'IWBSRadioButton1'
                  FriendlyName = 'IWBSRadioButton1'
                  SubmitOnAsyncEvent = True
                end
                object IWBSRadioButton4: TIWBSRadioButton
                  Left = 12
                  Top = 420
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
                  Caption = 'IWBSRadioButton1'
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  Group = 'no group'
                  Value = 'IWBSRadioButton1'
                  FriendlyName = 'IWBSRadioButton1'
                  SubmitOnAsyncEvent = True
                end
                object IWBSCheckBox1: TIWBSCheckBox
                  Left = 12
                  Top = 272
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
                  Caption = 'IWBSCheckBox1'
                  Editable = True
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  SubmitOnAsyncEvent = True
                  Style = stNormal
                  TabOrder = 34
                  Checked = False
                  FriendlyName = 'IWBSCheckBox1'
                end
                object IWBSCheckBox2: TIWBSCheckBox
                  Left = 12
                  Top = 299
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
                  Caption = 'IWBSCheckBox1'
                  Editable = True
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  SubmitOnAsyncEvent = True
                  Style = stNormal
                  TabOrder = 35
                  Checked = False
                  FriendlyName = 'IWBSCheckBox1'
                end
                object IWBSListbox1: TIWBSListbox
                  Left = 12
                  Top = 455
                  Width = 121
                  Height = 121
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  TabOrder = 36
                  MaxItems = 0
                  FriendlyName = 'IWBSListbox1'
                  Items.Strings = (
                    'item 1'
                    'item 2'
                    'item 3'
                    'item 4')
                  Caption = ''
                  NoSelectionText = '-- No Selection --'
                end
                object IWBSComboBox1: TIWBSComboBox
                  Left = 12
                  Top = 588
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
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  TabOrder = 37
                  ItemIndex = -1
                  Items.Strings = (
                    'item 1'
                    'item 2'
                    'item 3'
                    'item 4')
                  FriendlyName = 'IWBSComboBox1'
                  Caption = ''
                  NoSelectionText = '-- No Selection --'
                end
                object IWBSButton21: TIWBSButton
                  Left = 600
                  Top = 3
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  StyleRenderOptions.RenderPosition = False
                  StyleRenderOptions.RenderFont = False
                  StyleRenderOptions.RenderStatus = False
                  StyleRenderOptions.RenderAbsolute = False
                  StyleRenderOptions.RenderPadding = False
                  StyleRenderOptions.RenderBorder = False
                  Caption = 'IWBSButton21'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton21'
                  TabOrder = 46
                end
              end
            end
          end
          object IWTabControl21Page5: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 783
            RenderInvisibleControls = True
            TabOrder = 5
            Title = 'Create components at runtime'
            BorderOptions.NumericWidth = 0
            BorderOptions.BorderWidth = cbwNumeric
            BorderOptions.Style = cbsNone
            BorderOptions.Color = clNone
            Color = clWebWHITE
            object IWBSButton26: TIWBSButton
              Left = 24
              Top = 19
              Width = 265
              Height = 25
              RenderSize = False
              StyleRenderOptions.RenderSize = False
              StyleRenderOptions.RenderPosition = False
              StyleRenderOptions.RenderFont = False
              StyleRenderOptions.RenderStatus = False
              StyleRenderOptions.RenderAbsolute = False
              StyleRenderOptions.RenderPadding = False
              StyleRenderOptions.RenderBorder = False
              Caption = 'Dinamically create frame with inputs'
              Color = clBtnFace
              Font.Color = clNone
              Font.Size = 10
              Font.Style = []
              FriendlyName = 'IWBSButton26'
              TabOrder = 68
              OnAsyncClick = IWBSButton26AsyncClick
            end
            object IWBSButton27: TIWBSButton
              Left = 371
              Top = 19
              Width = 265
              Height = 25
              RenderSize = False
              StyleRenderOptions.RenderSize = False
              StyleRenderOptions.RenderPosition = False
              StyleRenderOptions.RenderFont = False
              StyleRenderOptions.RenderStatus = False
              StyleRenderOptions.RenderAbsolute = False
              StyleRenderOptions.RenderPadding = False
              StyleRenderOptions.RenderBorder = False
              Caption = 'Dinamically create modal dialog'
              Color = clBtnFace
              Font.Color = clNone
              Font.Size = 10
              Font.Style = []
              FriendlyName = 'IWBSButton26'
              TabOrder = 69
              OnAsyncClick = IWBSButton27AsyncClick
            end
            object IWBSRegion17: TIWBSRegion
              Left = 24
              Top = 50
              Width = 657
              Height = 444
              RenderInvisibleControls = True
            end
          end
        end
      end
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    BSFormType = bsftNoForm
    Left = 964
    Top = 20
  end
end
