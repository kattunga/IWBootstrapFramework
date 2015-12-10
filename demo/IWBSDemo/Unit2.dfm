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
  DesignTop = 8
  object IWBSRegion40: TIWBSRegion
    Left = 0
    Top = 0
    Width = 1084
    Height = 1600
    Align = alClient
    Style.Strings = (
      'padding-top: 70px;')
    object IWBSNavBar1: TIWBSNavBar
      Left = 1
      Top = 1
      Width = 1082
      Height = 60
      Align = alTop
      Brand = 'IWBootstrap Framework'
      BrandLink = 'https://github.com/kattunga/IWBootstrapFramework'
      BSFixed = bsnvfxTop
      object IWBSUnorderedList1: TIWBSUnorderedList
        Left = 244
        Top = 8
        Width = 432
        Height = 48
        Css = 'navbar-right'
        object IWBSButton46: TIWBSButton
          Left = 229
          Top = 20
          Width = 155
          Height = 25
          FriendlyName = 'IWBSButton46'
          OnAsyncClick = IWBSButton46AsyncClick
          BSBlockLevel = False
          Caption = 'Toggle Container'
          Anchor = True
        end
        object IWBSDropDown2: TIWBSDropDown
          Left = 16
          Top = 20
          Width = 200
          Height = 25
          FriendlyName = 'IWBSDropDown2'
          BSBlockLevel = False
          Caption = 'More Demos'
          DropDownItems = <
            item
              Caption = 'Data Aware Form'
              OnAsyncClick = IWBSDropDown2DropDownItems0AsyncClick
            end
            item
              Caption = '-'
            end
            item
              Caption = 'This is a Header'
              Header = True
            end
            item
              Caption = 'Third Party Plugins'
              DropDownItems = <
                item
                  Caption = 'Bootstrap Table'
                  OnAsyncClick = IWBSDropDown2DropDownItems1DropDownItems0AsyncClick
                end
                item
                  Caption = 'JQgrid'
                  OnAsyncClick = IWBSDropDown2DropDownItems1DropDownItems1AsyncClick
                end
                item
                  Caption = 'Bootstrap File Input'
                  OnAsyncClick = IWBSDropDown2DropDownItems1DropDownItems2AsyncClick
                end>
            end>
        end
      end
    end
    object IWBSRegion3: TIWBSRegion
      Left = 1
      Top = 61
      Width = 1082
      Height = 1538
      Align = alClient
      BSRegionType = bsrtContainer
      object IWBSRegion5: TIWBSRegion
        Left = 1
        Top = 1
        Width = 1080
        Height = 1536
        Align = alClient
        BSRegionType = bsrtRow
        object IWBSRegion8: TIWBSRegion
          Left = 1
          Top = 1
          Width = 1078
          Height = 1534
          Align = alClient
          BSRegionType = bsrtColumn
          object IWTabControl21: TIWBSTabControl
            Left = 1
            Top = 1
            Width = 1076
            Height = 1532
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
            ZIndex = 1000
            BSTabOptions.Pills = True
            DesignSize = (
              1076
              1532)
            object IWTabControl21Page3: TIWTabPage
              Left = 0
              Top = 20
              Width = 1076
              Height = 1512
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
                      FriendlyName = 'IWBSButton1'
                      BSBlockLevel = False
                      BSButtonSize = bsszLg
                      BSGlyphicon = 'align-left'
                      Caption = 'Left'
                    end
                    object IWBSButton2: TIWBSButton
                      Left = 91
                      Top = 17
                      Width = 85
                      Height = 30
                      Hint = 'This is a hint'
                      RenderSize = False
                      StyleRenderOptions.RenderSize = False
                      FriendlyName = 'IWBSButton1'
                      BSBlockLevel = False
                      BSButtonSize = bsszMd
                      BSGlyphicon = 'align-center'
                      Caption = 'Center'
                    end
                    object IWBSButton3: TIWBSButton
                      Left = 182
                      Top = 18
                      Width = 75
                      Height = 30
                      Hint = 'This is a hint'
                      RenderSize = False
                      StyleRenderOptions.RenderSize = False
                      FriendlyName = 'IWBSButton1'
                      BSBlockLevel = False
                      BSButtonSize = bsszSm
                      BSGlyphicon = 'align-right'
                      Caption = 'Rigth'
                    end
                    object IWBSButton4: TIWBSButton
                      Left = 267
                      Top = 17
                      Width = 82
                      Height = 30
                      Hint = 'This is a hint'
                      RenderSize = False
                      StyleRenderOptions.RenderSize = False
                      FriendlyName = 'IWBSButton1'
                      BSBlockLevel = False
                      BSButtonSize = bsszXs
                      BSGlyphicon = 'align-justify'
                      Caption = 'Justify'
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
                      FriendlyName = 'IWBSButton1'
                      BSBlockLevel = False
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
                      FriendlyName = 'IWBSButton1'
                      BSBlockLevel = False
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
                      FriendlyName = 'IWBSButton1'
                      BSBlockLevel = False
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
                      FriendlyName = 'IWBSButton1'
                      BSBlockLevel = False
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
                      FriendlyName = 'IWBSButton1'
                      BSBlockLevel = False
                      BSButtonSize = bsszLg
                      BSGlyphicon = 'align-left'
                      Caption = 'Left'
                    end
                    object IWBSButton10: TIWBSButton
                      Left = 97
                      Top = 17
                      Width = 86
                      Height = 30
                      Hint = 'This is a hint'
                      RenderSize = False
                      StyleRenderOptions.RenderSize = False
                      FriendlyName = 'IWBSButton1'
                      BSBlockLevel = False
                      BSButtonSize = bsszMd
                      BSGlyphicon = 'align-center'
                      Caption = 'Center'
                    end
                    object IWBSButton11: TIWBSButton
                      Left = 189
                      Top = 17
                      Width = 76
                      Height = 30
                      Hint = 'This is a hint'
                      RenderSize = False
                      StyleRenderOptions.RenderSize = False
                      FriendlyName = 'IWBSButton1'
                      BSBlockLevel = False
                      BSButtonSize = bsszSm
                      BSGlyphicon = 'align-right'
                      Caption = 'Rigth'
                    end
                    object IWBSButton12: TIWBSButton
                      Left = 271
                      Top = 17
                      Width = 76
                      Height = 30
                      Hint = 'This is a hint'
                      RenderSize = False
                      StyleRenderOptions.RenderSize = False
                      FriendlyName = 'IWBSButton1'
                      BSBlockLevel = False
                      BSButtonSize = bsszXs
                      BSGlyphicon = 'align-justify'
                      Caption = 'Justify'
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
                    FriendlyName = 'IWBSButton13'
                    BSBlockLevel = False
                    Caption = 'Default'
                  end
                  object IWBSButton14: TIWBSButton
                    Left = 94
                    Top = 20
                    Width = 75
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSButton13'
                    BSBlockLevel = False
                    BSButtonStyle = bsbsInfo
                    Caption = 'Info'
                  end
                  object IWBSButton15: TIWBSButton
                    Left = 175
                    Top = 20
                    Width = 75
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSButton13'
                    BSBlockLevel = False
                    BSButtonStyle = bsbsLink
                    Caption = 'Link'
                  end
                  object IWBSButton16: TIWBSButton
                    Left = 256
                    Top = 20
                    Width = 75
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSButton13'
                    BSBlockLevel = False
                    BSButtonStyle = bsbsPrimary
                    Caption = 'Primary'
                  end
                  object IWBSButton17: TIWBSButton
                    Left = 337
                    Top = 20
                    Width = 75
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSButton13'
                    BSBlockLevel = False
                    BSButtonStyle = bsbsSuccess
                    Caption = 'Success'
                  end
                  object IWBSButton18: TIWBSButton
                    Left = 418
                    Top = 20
                    Width = 75
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSButton13'
                    BSBlockLevel = False
                    BSButtonStyle = bsbsWarning
                    Caption = 'Warning'
                  end
                  object IWBSButton19: TIWBSButton
                    Left = 499
                    Top = 20
                    Width = 75
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSButton13'
                    BSBlockLevel = False
                    BSButtonStyle = bsbsDanger
                    Caption = 'Danger'
                  end
                  object IWBSButton29: TIWBSButton
                    Left = 580
                    Top = 18
                    Width = 75
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSButton13'
                    BSBlockLevel = False
                    BSButtonStyle = bsbsClose
                    Caption = 'Close'
                  end
                end
              end
            end
            object IWTabControl21Page5: TIWTabPage
              Left = 0
              Top = 20
              Width = 1076
              Height = 1512
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
                Width = 1076
                Height = 1512
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
                      Left = 12
                      Top = 23
                      Width = 393
                      Height = 25
                      RenderSize = False
                      StyleRenderOptions.RenderSize = False
                      LockOnAsyncEvents = [aeClick]
                      FriendlyName = 'IWBSButton26'
                      OnAsyncClick = IWBSButton27AsyncClick
                      BSBlockLevel = False
                      Caption = 'Dinamically create modal dialog from TIWFrame'
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
                      FriendlyName = 'IWBSButton26'
                      OnAsyncClick = IWBSButton28AsyncClick
                      BSBlockLevel = False
                      Caption = 'Dinamically create dialog from code'
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
                      FriendlyName = 'IWBSButton26'
                      OnAsyncClick = IWBSButton31AsyncClick
                      BSBlockLevel = False
                      Caption = 'Dinamically create advanced dialog from code'
                    end
                    object IWBSInput23: TIWBSInput
                      Left = 12
                      Top = 47
                      Width = 121
                      Height = 21
                      FriendlyName = 'IWBSInput6'
                      Caption = ''
                      Text = ''
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
                      FriendlyName = 'IWBSButton26'
                      OnAsyncClick = IWBSButton26AsyncClick
                      BSBlockLevel = False
                      Caption = 'Dinamically create frame with inputs'
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
                      FriendlyName = 'IWBSButton26'
                      OnAsyncClick = IWBSButton21AsyncClick
                      BSBlockLevel = False
                      Caption = 'Dinamically create button with anonymous proc'
                    end
                    object IWBSInput6: TIWBSInput
                      Left = 12
                      Top = 38
                      Width = 121
                      Height = 21
                      FriendlyName = 'IWBSInput6'
                      Caption = ''
                      Text = ''
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
                      FriendlyName = 'IWBSButton26'
                      OnAsyncClick = IWBSButton32AsyncClick
                      BSBlockLevel = False
                      Caption = 'Dinamically create Alert'
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
                      FriendlyName = 'IWBSButton26'
                      OnAsyncClick = IWBSButton33AsyncClick
                      BSBlockLevel = False
                      Caption = 'Dinamically create complex Alert'
                    end
                    object IWBSInput24: TIWBSInput
                      Left = 9
                      Top = 49
                      Width = 121
                      Height = 21
                      FriendlyName = 'IWBSInput6'
                      Caption = ''
                      Text = ''
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
                      FriendlyName = 'IWBSButton26'
                      OnAsyncClick = IWBSButton34AsyncClick
                      BSBlockLevel = False
                      Caption = 'Raise an exception'
                    end
                  end
                end
              end
            end
            object IWTabControl21Page2: TIWTabPage
              Left = 0
              Top = 20
              Width = 1076
              Height = 1512
              RenderInvisibleControls = True
              TabOrder = 5
              Title = 'TabControl Options'
              BorderOptions.NumericWidth = 0
              BorderOptions.BorderWidth = cbwNumeric
              BorderOptions.Style = cbsNone
              BorderOptions.Color = clNone
              Color = clWebWHITE
              object IWBSRegion37: TIWBSRegion
                Left = 29
                Top = 5
                Width = 561
                Height = 637
                BSGridOptions.GridSMSpan = 6
                Style.Strings = (
                  'margin: 1em')
                object IWBSRegion7: TIWBSRegion
                  Left = 15
                  Top = 6
                  Width = 433
                  Height = 303
                  BSRegionType = bsrtWell
                  object IWBSInputForm1: TIWBSInputForm
                    Left = 16
                    Top = 13
                    Width = 293
                    Height = 206
                    object IWBSButton30: TIWBSButton
                      Left = 26
                      Top = 148
                      Width = 184
                      Height = 25
                      RenderSize = False
                      StyleRenderOptions.RenderSize = False
                      FriendlyName = 'IWBSButton20aaaaaa'
                      OnAsyncClick = IWBSButton30AsyncClick
                      BSBlockLevel = False
                      Caption = 'Apply settings'
                    end
                    object chkTabsJust: TIWBSCheckBox
                      Left = 25
                      Top = 30
                      Width = 121
                      Height = 21
                      FriendlyName = 'chkTabsJust'
                      Caption = 'Tabs Justified'
                      Text = 'false'
                      ValueChecked = 'true'
                      ValueUnchecked = 'false'
                    end
                    object chkTabsStacked: TIWBSCheckBox
                      Left = 25
                      Top = 57
                      Width = 121
                      Height = 21
                      FriendlyName = 'chkTabsStacked'
                      Caption = 'Tabs Stacked'
                      Text = 'false'
                      ValueChecked = 'true'
                      ValueUnchecked = 'false'
                    end
                    object chkTabsPills: TIWBSCheckBox
                      Left = 25
                      Top = 88
                      Width = 121
                      Height = 21
                      FriendlyName = 'chkTabsPills'
                      Caption = 'Tabs Pills'
                      Text = 'true'
                      Checked = True
                      ValueChecked = 'true'
                      ValueUnchecked = 'false'
                    end
                    object chkTabsFade: TIWBSCheckBox
                      Left = 26
                      Top = 115
                      Width = 121
                      Height = 21
                      FriendlyName = 'chkTabsFade'
                      Caption = 'Tabs Fade'
                      Text = 'false'
                      ValueChecked = 'true'
                      ValueUnchecked = 'false'
                    end
                  end
                end
                object IWBSRegion36: TIWBSRegion
                  Left = 12
                  Top = 326
                  Width = 438
                  Height = 60
                  BSRegionType = bsrtWell
                  object IWBSButton42: TIWBSButton
                    Left = 26
                    Top = 18
                    Width = 329
                    Height = 25
                    FriendlyName = 'IWBSButton42'
                    OnAsyncClick = IWBSButton42AsyncClick
                    BSBlockLevel = False
                    Caption = 'Toggle TabPage visibility'
                  end
                end
              end
            end
            object IWTabControl21Page1: TIWTabPage
              Left = 0
              Top = 20
              Width = 1076
              Height = 1512
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
                Height = 640
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
                    FriendlyName = 'IWBSButton22'
                    OnAsyncClick = IWBSButton22AsyncClick
                    BSBlockLevel = False
                    Caption = 'IWBSButton22'
                  end
                  object IWBSInput8: TIWBSInput
                    Left = 101
                    Top = 12
                    Width = 121
                    Height = 21
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSInput8'
                    Caption = ''
                    Text = ''
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
                    FriendlyName = 'IWBSButton22'
                    BSBlockLevel = False
                    Caption = 'IWBSButton22'
                  end
                  object IWBSInput9: TIWBSInput
                    Left = 99
                    Top = 8
                    Width = 121
                    Height = 21
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSInput8'
                    Caption = ''
                    Text = ''
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
                    Top = 13
                    Width = 91
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSButton22'
                    BSBlockLevel = False
                    BSGlyphicon = 'arrow-down'
                    Caption = 'IWBSButton22'
                  end
                  object IWBSInput10: TIWBSInput
                    Left = 101
                    Top = 13
                    Width = 121
                    Height = 24
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSInput8'
                    Caption = ''
                    Text = ''
                  end
                  object IWBSButton25: TIWBSButton
                    Left = 12
                    Top = 13
                    Width = 75
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSButton22'
                    BSBlockLevel = False
                    BSGlyphicon = 'align-center'
                    Caption = 'IWBSButton22'
                  end
                end
                object IWBSRegion16: TIWBSRegion
                  Left = 33
                  Top = 10
                  Width = 532
                  Height = 92
                  BSRegionType = bsrtPageHeader
                  object IWText5: TIWBSText
                    Left = 12
                    Top = 15
                    Width = 258
                    Height = 24
                    FriendlyName = 'IWText5'
                    Lines.Strings = (
                      '<h2>This are input groups</h2>')
                    RawText = True
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
                    FriendlyName = 'IWBSInput8'
                    Caption = ''
                    Text = ''
                  end
                  object IWBSCheckBox3: TIWBSCheckBox
                    Left = 21
                    Top = 16
                    Width = 121
                    Height = 21
                    FriendlyName = 'IWBSCheckBox3'
                    AutoEditable = False
                    Caption = 'IWBSCheckBox3'
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
                    FriendlyName = 'IWBSInput8'
                    Caption = ''
                    Text = ''
                  end
                  object IWBSRadioButton5: TIWBSRadioButton
                    Left = 21
                    Top = 16
                    Width = 121
                    Height = 21
                    FriendlyName = 'IWBSRadioButton5'
                    Caption = 'IWBSRadioButton5'
                    Text = 'false'
                    Group = 'no group'
                    ValueChecked = 'true'
                    ValueUnchecked = 'false'
                  end
                end
                object IWBSInputGroup6: TIWBSInputGroup
                  Left = 33
                  Top = 514
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
                    FriendlyName = 'IWBSInput8'
                    Caption = ''
                    Text = ''
                  end
                  object IWBSGlyphicon1: TIWBSGlyphicon
                    Left = 12
                    Top = 12
                    Width = 29
                    Height = 21
                    FriendlyName = 'IWBSGlyphicon1'
                    BSGlyphicon = 'align-center'
                  end
                  object IWBSGlyphicon2: TIWBSGlyphicon
                    Left = 292
                    Top = 12
                    Width = 21
                    Height = 21
                    FriendlyName = 'IWBSGlyphicon2'
                  end
                end
                object IWBSInputGroup7: TIWBSInputGroup
                  Left = 33
                  Top = 563
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
                    FriendlyName = 'IWBSInput8'
                    Caption = ''
                    Text = ''
                  end
                  object IWBSLabel1: TIWBSLabel
                    Left = 11
                    Top = 12
                    Width = 40
                    Height = 16
                    FriendlyName = 'IWBSLabel1'
                    Caption = 'Before'
                  end
                  object IWBSLabel2: TIWBSLabel
                    Left = 248
                    Top = 12
                    Width = 30
                    Height = 16
                    FriendlyName = 'IWBSLabel2'
                    Caption = 'After'
                  end
                end
                object IWBSInputGroup8: TIWBSInputGroup
                  Left = 33
                  Top = 449
                  Width = 360
                  Height = 58
                  Caption = 'Radio AddOn'
                  object IWBSInput27: TIWBSInput
                    Left = 21
                    Top = 21
                    Width = 121
                    Height = 26
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSInput8'
                    Caption = ''
                    Text = ''
                  end
                  object IWBSDropDown1: TIWBSDropDown
                    Left = 148
                    Top = 22
                    Width = 114
                    Height = 25
                    FriendlyName = 'IWBSDropDown1'
                    BSBlockLevel = False
                    Caption = 'DropDown'
                    DropDownItems = <
                      item
                        Caption = 'Item 1'
                      end
                      item
                        Caption = 'Item 2'
                      end
                      item
                        Caption = 'SubMenu'
                        DropDownItems = <
                          item
                            Caption = 'SubItem 1'
                          end
                          item
                            Caption = 'SubItem 2'
                          end
                          item
                            Caption = 'SubItem 2'
                          end>
                      end>
                    DropUp = True
                    DropDownRight = True
                  end
                end
              end
            end
            object IWTabControl21Page6: TIWTabPage
              Left = 0
              Top = 20
              Width = 1076
              Height = 1512
              RenderInvisibleControls = True
              TabOrder = 4
              Title = 'Funtionality'
              BorderOptions.NumericWidth = 0
              BorderOptions.BorderWidth = cbwNumeric
              BorderOptions.Style = cbsNone
              BorderOptions.Color = clNone
              Color = clWebWHITE
              object IWBSButton37: TIWBSButton
                Left = 39
                Top = 13
                Width = 205
                Height = 25
                FriendlyName = 'IWBSButton37'
                OnAsyncClick = IWBSButton37AsyncClick
                BSBlockLevel = False
                Caption = 'Toggle Visibility'
              end
              object IWBSButton36: TIWBSButton
                Left = 40
                Top = 44
                Width = 204
                Height = 25
                FriendlyName = 'IWBSButton36'
                BSBlockLevel = False
                Caption = 'Toggle Collapse'
                DataTarget = IWBSRegion29
              end
              object IWBSRegion32: TIWBSRegion
                Left = 40
                Top = 78
                Width = 698
                Height = 72
                BSRegionType = bsrtWell
                object IWText11: TIWBSText
                  Left = 20
                  Top = 8
                  Width = 540
                  Height = 38
                  FriendlyName = 'IWText11'
                  Lines.Strings = (
                    '<h1>This is a Well</h1>'
                    '<h2>Example page header <small>Subtext for header</small></h2>')
                  RawText = True
                end
              end
              object IWBSRegion33: TIWBSRegion
                Left = 38
                Top = 163
                Width = 700
                Height = 91
                BSRegionType = bsrtWell
                object IWBSInput25: TIWBSInput
                  Left = 19
                  Top = 21
                  Width = 201
                  Height = 25
                  ExtraTagParams.Strings = (
                    '')
                  FriendlyName = 'IWBSInput1'
                  Caption = 'Input Type Text'
                  Text = ''
                  BSTextAlignment = bstaCenter
                  PlaceHolder = 'Name'
                end
                object IWBSButton41: TIWBSButton
                  Left = 16
                  Top = 55
                  Width = 223
                  Height = 25
                  FriendlyName = 'IWBSButton41'
                  ScriptEvents = <
                    item
                      EventCode.Strings = (
                        '$("#IWBSINPUT25").val("this text was setted with ScriptEvents");')
                      Event = 'onClick'
                    end>
                  BSBlockLevel = False
                  Caption = 'OnClick scriptEvent'
                end
              end
              object IWBSRegion29: TIWBSRegion
                Left = 35
                Top = 272
                Width = 702
                Height = 381
                BSRegionType = bsrtWell
                Collapse = True
                CollapseVisible = True
                object IWBSLabel3: TIWBSLabel
                  Left = 20
                  Top = 12
                  Width = 361
                  Height = 24
                  FriendlyName = 'IWBSLabel3'
                  Caption = 'File upload using Form Custom Submit event, (select a text file)'
                end
                object IWBSText2: TIWBSText
                  Left = 20
                  Top = 46
                  Width = 635
                  Height = 123
                  FriendlyName = 'IWBSText2'
                end
                object IWBSInputForm5: TIWBSInputForm
                  Left = 20
                  Top = 203
                  Width = 635
                  Height = 138
                  EncType = iwbsfeMultipart
                  OnSubmit = IWBSInputForm5Submit
                  object IWBSButton45: TIWBSButton
                    Left = 22
                    Top = 101
                    Width = 200
                    Height = 25
                    FriendlyName = 'IWBSButton45'
                    BSBlockLevel = False
                    Caption = 'Submit File'
                    ButtonType = iwbsbtSubmit
                  end
                  object IWBSInput26: TIWBSFile
                    Left = 22
                    Top = 55
                    Width = 151
                    Height = 25
                    FriendlyName = 'IWBSInput26'
                  end
                end
              end
            end
            object IWTabControl21Page4: TIWTabPage
              Left = 0
              Top = 20
              Width = 1076
              Height = 1512
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
                Width = 1076
                Height = 1512
                Align = alClient
                Style.Strings = (
                  'margin: 1em')
                object IWBSLabel4: TIWBSLabel
                  Left = 15
                  Top = 598
                  Width = 432
                  Height = 24
                  FriendlyName = 'IWBSLabel4'
                  Caption = '<h2>This is an accordion</h2>'
                  RawText = True
                end
                object IWBSRegion9: TIWBSRegion
                  Left = 15
                  Top = 97
                  Width = 698
                  Height = 60
                  BSRegionType = bsrtJumbotron
                  object IWText1: TIWBSText
                    Left = 20
                    Top = 11
                    Width = 540
                    Height = 38
                    FriendlyName = 'IWText1'
                    Lines.Strings = (
                      '<h1>This is a Jumbotron</h1>'
                      '<h2>Example page header <small>Subtext for header</small></h2>')
                    RawText = True
                  end
                end
                object IWBSRegion14: TIWBSRegion
                  Left = 15
                  Top = 163
                  Width = 698
                  Height = 60
                  BSRegionType = bsrtPageHeader
                  object IWText4: TIWBSText
                    Left = 20
                    Top = 11
                    Width = 540
                    Height = 38
                    FriendlyName = 'IWText4'
                    Lines.Strings = (
                      '<h1>This is a Page Header</h1>'
                      '<h2>Example page header <small>Subtext for header</small></h2>')
                    RawText = True
                  end
                end
                object IWBSRegion24: TIWBSRegion
                  Left = 15
                  Top = 236
                  Width = 698
                  Height = 60
                  BSRegionType = bsrtWell
                  BSRelativeSize = bsrzLg
                  object IWText10: TIWBSText
                    Left = 20
                    Top = 11
                    Width = 540
                    Height = 38
                    FriendlyName = 'IWText10'
                    Lines.Strings = (
                      '<h1>This is a Well</h1>'
                      '<h2>Example page header <small>Subtext for header</small></h2>')
                    RawText = True
                  end
                end
                object IWBSRegion19: TIWBSRegion
                  Left = 16
                  Top = 304
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
                    object IWBSLabel5: TIWBSLabel
                      Left = 25
                      Top = 28
                      Width = 278
                      Height = 25
                      FriendlyName = 'IWBSLabel5'
                      Caption = 'this is panel title'
                      TagType = 'h4'
                    end
                  end
                  object IWBSRegion21: TIWBSRegion
                    Left = 8
                    Top = 193
                    Width = 681
                    Height = 60
                    BSRegionType = bsrtPanelFooter
                    object IWText9: TIWBSText
                      Left = 24
                      Top = 20
                      Width = 269
                      Height = 22
                      FriendlyName = 'IWText9'
                      Lines.Strings = (
                        '<h2>this is panel footer</h2>')
                      RawText = True
                    end
                  end
                  object IWBSRegion22: TIWBSRegion
                    Left = 8
                    Top = 108
                    Width = 681
                    Height = 79
                    BSRegionType = bsrtPanelBody
                    object IWText6: TIWBSText
                      Left = 155
                      Top = 37
                      Width = 269
                      Height = 22
                      FriendlyName = 'IWText6'
                      Lines.Strings = (
                        '<h2>this is panel body</h2>')
                      RawText = True
                    end
                  end
                end
                object IWBSRegion34: TIWBSRegion
                  Left = 16
                  Top = 24
                  Width = 697
                  Height = 60
                  BSRegionType = bsrtWell
                  object IWBSButton40: TIWBSButton
                    Left = 16
                    Top = 20
                    Width = 173
                    Height = 25
                    FriendlyName = 'IWBSButton40'
                    OnAsyncClick = IWBSButton40AsyncClick
                    BSBlockLevel = False
                    Caption = 'Show Modal Window'
                  end
                end
                object IWBSModal1: TIWBSModal
                  Left = 728
                  Top = 99
                  Width = 353
                  Height = 261
                  object IWBSRegion35: TIWBSRegion
                    Left = 8
                    Top = 22
                    Width = 325
                    Height = 227
                    BSRegionType = bsrtWell
                    object IWBSText1: TIWBSText
                      Left = 24
                      Top = 24
                      Width = 289
                      Height = 117
                      FriendlyName = 'IWBSText1'
                      Lines.Strings = (
                        'This is a modal window'
                        'There are 2 buttons'
                        
                          'One button do an async callback and close modal windows setting ' +
                          'BSModalVisible := False'
                        
                          'The other button automatically close because it have property BS' +
                          'DataDismiss := bsbdModal'
                        'The Modal window have an event that fires when modal close.'
                        ''
                        '')
                    end
                    object IWBSButton39: TIWBSButton
                      Left = 21
                      Top = 147
                      Width = 293
                      Height = 29
                      FriendlyName = 'IWBSButton39'
                      OnAsyncClick = IWBSButton39AsyncClick
                      BSBlockLevel = False
                      Caption = 'AsyncClick to close modal'
                    end
                    object IWBSButton38: TIWBSButton
                      Left = 23
                      Top = 189
                      Width = 294
                      Height = 25
                      FriendlyName = 'IWBSButton38'
                      BSBlockLevel = False
                      Caption = 'Close Modal by data-dismiss'
                      DataDismiss = bsbdModal
                    end
                  end
                end
                object IWBSRegion4: TIWBSRegion
                  Left = 15
                  Top = 636
                  Width = 698
                  Height = 849
                  BSRegionType = bsrtPanelGroup
                  object IWBSRegion38: TIWBSRegion
                    Left = 22
                    Top = 22
                    Width = 659
                    Height = 255
                    BSRegionType = bsrtPanel
                    object IWBSRegion39: TIWBSRegion
                      Left = 20
                      Top = 24
                      Width = 621
                      Height = 81
                      BSRegionType = bsrtPanelHeading
                      object IWBSButton43: TIWBSButton
                        Left = 20
                        Top = 28
                        Width = 200
                        Height = 25
                        FriendlyName = 'IWBSButton43'
                        BSBlockLevel = False
                        Caption = 'Collapsible Group Item #1'
                        Anchor = True
                        DataParent = IWBSRegion4
                        DataTarget = IWBSRegion42
                      end
                    end
                    object IWBSRegion42: TIWBSRegion
                      Left = 19
                      Top = 108
                      Width = 622
                      Height = 121
                      BSRegionType = bsrtPanelBody
                      Collapse = True
                      CollapseVisible = True
                      object IWBSText3: TIWBSText
                        Left = 12
                        Top = 40
                        Width = 593
                        Height = 76
                        FriendlyName = 'IWBSText3'
                        Lines.Strings = (
                          
                            'Anim pariatur cliche reprehenderit, enim eiusmod high life accus' +
                            'amus terry richardson ad squid. 3 wolf moon officia aute, non cu' +
                            'pidatat skateboard dolor brunch. Food truck quinoa nesciunt labo' +
                            'rum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird o' +
                            'n it squid single-origin coffee nulla assumenda shoreditch et. N' +
                            'ihil anim keffiyeh helvetica, craft beer labore wes anderson cre' +
                            'd nesciunt sapiente ea proident. Ad vegan excepteur butcher vice' +
                            ' lomo. Leggings occaecat craft beer farm-to-table, raw denim aes' +
                            'thetic synth nesciunt you probably haven'#39't heard of them accusam' +
                            'us labore sustainable VHS.')
                      end
                    end
                  end
                  object IWBSRegion43: TIWBSRegion
                    Left = 22
                    Top = 289
                    Width = 659
                    Height = 255
                    BSRegionType = bsrtPanel
                    object IWBSRegion44: TIWBSRegion
                      Left = 20
                      Top = 24
                      Width = 621
                      Height = 81
                      BSRegionType = bsrtPanelHeading
                      object IWBSButton44: TIWBSButton
                        Left = 24
                        Top = 32
                        Width = 200
                        Height = 25
                        FriendlyName = 'IWBSButton43'
                        BSBlockLevel = False
                        Caption = 'Collapsible Group Item #2'
                        Anchor = True
                        DataParent = IWBSRegion4
                        DataTarget = IWBSRegion46
                      end
                    end
                    object IWBSRegion46: TIWBSRegion
                      Left = 19
                      Top = 108
                      Width = 622
                      Height = 121
                      BSRegionType = bsrtPanelBody
                      Collapse = True
                      object IWBSText4: TIWBSText
                        Left = 12
                        Top = 40
                        Width = 593
                        Height = 76
                        FriendlyName = 'IWBSText3'
                        Lines.Strings = (
                          
                            'Anim pariatur cliche reprehenderit, enim eiusmod high life accus' +
                            'amus terry richardson ad squid. 3 wolf moon officia aute, non cu' +
                            'pidatat skateboard dolor brunch. Food truck quinoa nesciunt labo' +
                            'rum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird o' +
                            'n it squid single-origin coffee nulla assumenda shoreditch et. N' +
                            'ihil anim keffiyeh helvetica, craft beer labore wes anderson cre' +
                            'd nesciunt sapiente ea proident. Ad vegan excepteur butcher vice' +
                            ' lomo. Leggings occaecat craft beer farm-to-table, raw denim aes' +
                            'thetic synth nesciunt you probably haven'#39't heard of them accusam' +
                            'us labore sustainable VHS.')
                      end
                    end
                  end
                  object IWBSRegion47: TIWBSRegion
                    Left = 22
                    Top = 558
                    Width = 659
                    Height = 255
                    BSRegionType = bsrtPanel
                    object IWBSRegion48: TIWBSRegion
                      Left = 20
                      Top = 24
                      Width = 621
                      Height = 81
                      BSRegionType = bsrtPanelHeading
                      object IWBSButton47: TIWBSButton
                        Left = 12
                        Top = 20
                        Width = 200
                        Height = 25
                        FriendlyName = 'IWBSButton43'
                        BSBlockLevel = False
                        Caption = 'Collapsible Group Item #3'
                        Anchor = True
                        DataParent = IWBSRegion4
                        DataTarget = IWBSRegion50
                      end
                    end
                    object IWBSRegion50: TIWBSRegion
                      Left = 19
                      Top = 108
                      Width = 622
                      Height = 121
                      BSRegionType = bsrtPanelBody
                      Collapse = True
                      object IWBSText5: TIWBSText
                        Left = 12
                        Top = 40
                        Width = 593
                        Height = 76
                        FriendlyName = 'IWBSText3'
                        Lines.Strings = (
                          
                            'Anim pariatur cliche reprehenderit, enim eiusmod high life accus' +
                            'amus terry richardson ad squid. 3 wolf moon officia aute, non cu' +
                            'pidatat skateboard dolor brunch. Food truck quinoa nesciunt labo' +
                            'rum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird o' +
                            'n it squid single-origin coffee nulla assumenda shoreditch et. N' +
                            'ihil anim keffiyeh helvetica, craft beer labore wes anderson cre' +
                            'd nesciunt sapiente ea proident. Ad vegan excepteur butcher vice' +
                            ' lomo. Leggings occaecat craft beer farm-to-table, raw denim aes' +
                            'thetic synth nesciunt you probably haven'#39't heard of them accusam' +
                            'us labore sustainable VHS.')
                      end
                    end
                  end
                end
              end
            end
            object IWTabControl21Page0: TIWTabPage
              Left = 0
              Top = 20
              Width = 1076
              Height = 1512
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
                Width = 1076
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
                    Left = 12
                    Top = 27
                    Width = 245
                    Height = 195
                    BSRegionType = bsrtWell
                    object IWBSInputForm3: TIWBSInputForm
                      Left = 4
                      Top = 24
                      Width = 234
                      Height = 159
                      object LstFormType: TIWBSRadioGroup
                        Left = 10
                        Top = 47
                        Width = 128
                        Height = 64
                        FriendlyName = 'LstFormType'
                        Caption = ''
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
                        FriendlyName = 'IWBSButton20'
                        OnAsyncClick = IWBSButton35AsyncClick
                        BSBlockLevel = False
                        Caption = 'Apply change'
                      end
                      object IWText2: TIWBSText
                        Left = 10
                        Top = 16
                        Width = 201
                        Height = 19
                        FriendlyName = 'IWText2'
                        Lines.Strings = (
                          '<h3>Form Layout</h3>')
                        RawText = True
                      end
                    end
                  end
                end
                object IWBSInputForm2: TIWBSInputForm
                  Left = 335
                  Top = 1
                  Width = 740
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
                    Cursor = crWait
                    ExtraTagParams.Strings = (
                      '')
                    FriendlyName = 'IWBSInput1'
                    Caption = 'Input Type Text'
                    Text = ''
                    BSTextAlignment = bstaCenter
                    PlaceHolder = 'Name'
                  end
                  object IWBSInput2: TIWBSInput
                    Left = 12
                    Top = 220
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput2'
                    Caption = 'Input Type Numer'
                    Text = ''
                    PlaceHolder = 'Amount'
                    InputType = bsitNumber
                  end
                  object IWBSInput3: TIWBSInput
                    Left = 12
                    Top = 62
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput3'
                    Caption = 'Input Type Password'
                    Text = ''
                    PlaceHolder = 'Password'
                    InputType = bsitPassword
                  end
                  object IWBSMemo2: TIWBSMemo
                    Left = 14
                    Top = 447
                    Width = 433
                    Height = 121
                    FriendlyName = 'IWBSMemo2'
                    Caption = 'This is a Memo'
                    Text = ''
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
                    FriendlyName = 'IWBSButton20'
                    OnAsyncClick = IWBSButton20AsyncClick
                    BSBlockLevel = False
                    BSGlyphicon = 'check'
                    Caption = 'Ajax Click (see input values in memo)'
                  end
                  object IWBSInput7: TIWBSInput
                    Left = 12
                    Top = 113
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput3'
                    Caption = 'Input Type Date'
                    Text = ''
                    PlaceHolder = 'Date'
                    InputType = bsitDate
                  end
                  object IWBSInput14: TIWBSInput
                    Left = 12
                    Top = 89
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput3'
                    Caption = 'Input Type DateTimeLocal'
                    Text = ''
                    PlaceHolder = 'DateTimeLocal'
                    InputType = bsitDateTimeLocal
                  end
                  object IWBSInput15: TIWBSInput
                    Left = 12
                    Top = 139
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput3'
                    Caption = 'Input Type Month'
                    Text = ''
                    PlaceHolder = 'Month'
                    InputType = bsitMonth
                  end
                  object IWBSInput16: TIWBSInput
                    Left = 12
                    Top = 166
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput3'
                    Caption = 'Input Type Time'
                    Text = ''
                    PlaceHolder = 'Time'
                    InputType = bsitTime
                  end
                  object IWBSInput17: TIWBSInput
                    Left = 12
                    Top = 193
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput3'
                    Caption = 'Input Type Week'
                    Text = ''
                    PlaceHolder = 'Week'
                    InputType = bsitWeek
                  end
                  object IWBSInput18: TIWBSInput
                    Left = 12
                    Top = 244
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput2'
                    Caption = 'Input Type Email'
                    Text = ''
                    PlaceHolder = 'Email'
                    InputType = bsitEmail
                  end
                  object IWBSInput19: TIWBSInput
                    Left = 12
                    Top = 270
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput2'
                    Caption = 'Input Type Url'
                    Text = ''
                    PlaceHolder = 'home page'
                    InputType = bsitUrl
                  end
                  object IWBSInput20: TIWBSInput
                    Left = 12
                    Top = 297
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput2'
                    Caption = 'Input Type Search'
                    Text = ''
                    PlaceHolder = 'Search'
                    InputType = bsitSearch
                  end
                  object IWBSInput21: TIWBSInput
                    Left = 12
                    Top = 324
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput2'
                    Caption = 'Input Type Tel'
                    Text = ''
                    PlaceHolder = 'Telephone'
                    InputType = bsitTel
                  end
                  object IWBSInput22: TIWBSInput
                    Left = 12
                    Top = 351
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput2'
                    Caption = 'Input Type Color'
                    Text = ''
                    PlaceHolder = 'Pick a Color'
                    InputType = bsitColor
                  end
                  object IWBSInput13: TIWBSInput
                    Left = 12
                    Top = 382
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput2'
                    Caption = 'Input NonEditableAsLabel'
                    Editable = False
                    NonEditableAsLabel = True
                    Text = 'This is a static text'
                    PlaceHolder = 'Pick a Color'
                  end
                  object IWBSRadioGroup1: TIWBSRadioGroup
                    Left = 15
                    Top = 932
                    Width = 237
                    Height = 125
                    FriendlyName = 'IWBSRadioGroup1'
                    Caption = 'This is a radio group'
                    Text = 'item 1'
                    ItemIndex = 0
                    Items.Strings = (
                      'item 1'
                      'item 2'
                      'item 3'
                      'item 4')
                  end
                  object IWBSComboBox2: TIWBSSelect
                    Left = 15
                    Top = 755
                    Width = 291
                    Height = 25
                    FriendlyName = 'IWBSComboBox1'
                    Caption = 'This is a Select (Size = 1)'
                    Text = ''
                    Items.Strings = (
                      'item 1'
                      'item 2'
                      'item 3'
                      'item 4')
                  end
                  object IWBSListbox2: TIWBSSelect
                    Left = 14
                    Top = 575
                    Width = 291
                    Height = 82
                    FriendlyName = 'IWBSListbox1'
                    Caption = 'This is a ListBox with multi select'
                    Text = ''
                    Items.Strings = (
                      'item 1'
                      'item 2'
                      'item 3'
                      'item 4')
                    MultiSelect = True
                    Size = 4
                  end
                  object IWBSListbox3: TIWBSSelect
                    Left = 15
                    Top = 663
                    Width = 291
                    Height = 77
                    FriendlyName = 'IWBSListbox1'
                    Caption = 'This is a Select (Size <> 1)'
                    Text = ''
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
                    FriendlyName = 'IWBSCheckBox1'
                    Caption = 'IWBSCheckBox1'
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
                      FriendlyName = 'IWBSRadioButton6'
                      Caption = 'Radio Button 1'
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
                      FriendlyName = 'IWBSRadioButton6'
                      Caption = 'Radio Button 2'
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
                      FriendlyName = 'IWBSRadioButton6'
                      Caption = 'Radio Button 3'
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
                      FriendlyName = 'IWBSRadioButton6'
                      Caption = 'Radio Button 4'
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
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 720
    Top = 115
  end
end
