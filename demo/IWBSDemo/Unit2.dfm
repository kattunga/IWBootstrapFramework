object IWForm2: TIWForm2
  Left = 0
  Top = 0
  Width = 1400
  Height = 1600
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
  KeepAlive = True
  DesignLeft = 8
  DesignTop = 8
  object IWBSRegion40: TIWBSRegion
    Left = 0
    Top = 0
    Width = 1400
    Height = 1600
    Align = alClient
    Css = ''
    Style.Strings = (
      'padding-top: 70px;'
      'padding-bottom: 70px;')
    Text = ''
    object IWBSNavBar1: TIWBSNavBar
      Left = 1
      Top = 1
      Width = 1398
      Height = 118
      Align = alTop
      Css = ''
      Text = ''
      BSFixed = bsnvfxTop
      object IWBSNavBarHeader1: TIWBSNavBarHeader
        Left = 8
        Top = 22
        Width = 401
        Height = 83
        Css = ''
        Text = ''
        object IWBSButton48: TIWBSButton
          Left = 8
          Top = 42
          Width = 241
          Height = 25
          Css = 'navbar-brand'
          FriendlyName = 'IWBSButton48'
          Caption = 'IWBootstrap Framework v2.0'
          ElementType = bsetAnchor
          Href = 'https://github.com/kattunga/IWBootstrapFramework'
          Target = '_blank'
        end
        object IWBSButton49: TIWBSButton
          Left = 317
          Top = 42
          Width = 68
          Height = 25
          FriendlyName = 'IWBSButton49'
          Caption = ''
          DataTarget = IWBSNavBarCollapse1
        end
      end
      object IWBSNavBarCollapse1: TIWBSNavBarCollapse
        Left = 415
        Top = 22
        Width = 658
        Height = 83
        Css = ''
        Text = ''
        object IWBSList2: TIWBSList
          Left = 39
          Top = 26
          Width = 602
          Height = 54
          BSGridOptions.Float = bsgfRight
          Css = ''
          Text = ''
          BSListType = bsltNav
          object IWBSButton46: TIWBSButton
            Left = 253
            Top = 20
            Width = 155
            Height = 25
            FriendlyName = 'IWBSButton46'
            OnAsyncClick = IWBSButton46AsyncClick
            Caption = 'Toggle Container'
          end
          object IWBSDropDown2: TIWBSDropDown
            Left = 32
            Top = 20
            Width = 200
            Height = 25
            FriendlyName = 'IWBSDropDown2'
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
                    OnAsyncClick = AsyncClickBootstrapTable
                  end
                  item
                    Caption = 'JQgrid'
                    OnAsyncClick = AsyncClickJQGrid
                  end
                  item
                    Caption = 'Bootstrap File Input'
                    OnAsyncClick = AsyncClickBootstrapFileInput
                  end>
              end>
          end
          object IWBSButton61: TIWBSButton
            Left = 432
            Top = 20
            Width = 158
            Height = 25
            FriendlyName = 'IWBSButton61'
            Caption = 'Bootstrap Help'
            Href = 'http://www.w3schools.com/bootstrap/default.asp'
          end
        end
      end
    end
    object IWBSRegion3: TIWBSRegion
      Left = 1
      Top = 119
      Width = 1398
      Height = 1480
      Align = alClient
      Css = ''
      Text = ''
      BSRegionType = bsrtContainer
      object IWBSRegion5: TIWBSRegion
        Left = 1
        Top = 1
        Width = 1396
        Height = 1478
        Align = alClient
        Css = ''
        Text = ''
        BSRegionType = bsrtRow
        object IWBSRegion8: TIWBSRegion
          Left = 1
          Top = 1
          Width = 1394
          Height = 1476
          Align = alClient
          Css = ''
          Text = ''
          BSRegionType = bsrtColumn
          object IWTabControl21: TIWBSTabControl
            Left = 1
            Top = 1
            Width = 1392
            Height = 1474
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
            TabPadding = 0
            ActiveTabBorder.Color = clWebBLACK
            ActiveTabBorder.Width = 0
            InactiveTabBorder.Color = clWebBLACK
            InactiveTabBorder.Width = 0
            BSTabOptions.Pills = True
            DesignSize = (
              1392
              1474)
            object IWTabControl21Page8: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
              RenderInvisibleControls = True
              TabOrder = 8
              Title = 'List Groups / Pager / Pagination'
              BorderOptions.NumericWidth = 0
              BorderOptions.BorderWidth = cbwNumeric
              BorderOptions.Style = cbsNone
              BorderOptions.Color = clNone
              Color = clWebWHITE
              object IWBSList3: TIWBSList
                Left = 17
                Top = 648
                Width = 276
                Height = 165
                Css = ''
                Text = ''
                BSListType = bsltPagination
                object IWBSButton57: TIWBSButton
                  Left = 18
                  Top = 20
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '1'
                end
                object IWBSButton58: TIWBSButton
                  Left = 19
                  Top = 55
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '2'
                end
                object IWBSButton59: TIWBSButton
                  Left = 19
                  Top = 92
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '3'
                end
                object IWBSButton60: TIWBSButton
                  Left = 18
                  Top = 131
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '4'
                end
              end
              object IWBSRegion30: TIWBSRegion
                Left = 17
                Top = 24
                Width = 581
                Height = 37
                Css = ''
                Text = 'List Groups'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSList4: TIWBSList
                Left = 16
                Top = 69
                Width = 393
                Height = 119
                Css = ''
                Text = ''
                BSListType = bsltGroup
                object IWBSLabel6: TIWBSLabel
                  Left = 14
                  Top = 32
                  Width = 322
                  Height = 25
                  FriendlyName = 'IWBSLabel6'
                  Caption = 'Item 1 with badge<span class="badge">23</span>'
                  RawText = True
                end
                object IWBSLabel7: TIWBSLabel
                  Left = 14
                  Top = 56
                  Width = 322
                  Height = 25
                  FriendlyName = 'IWBSLabel6'
                  Caption = 'Item 2 with badge<span class="badge">0</span>'
                  RawText = True
                end
                object IWBSLabel16: TIWBSLabel
                  Left = 14
                  Top = 81
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSLabel16'
                  Caption = 'Item 3'
                end
              end
              object IWBSRegion41: TIWBSRegion
                Left = 17
                Top = 203
                Width = 581
                Height = 37
                Css = ''
                Text = 'Contextual Classes'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSList5: TIWBSList
                Left = 17
                Top = 249
                Width = 393
                Height = 138
                Css = ''
                Text = ''
                BSListType = bsltGroup
                object IWBSLabel4: TIWBSLabel
                  Left = 14
                  Top = 32
                  Width = 322
                  Height = 25
                  FriendlyName = 'IWBSLabel6'
                  Caption = 'Item 1 with badge<span class="badge">23</span>'
                  BSLabelStyle = bslsSuccess
                  RawText = True
                end
                object IWBSLabel17: TIWBSLabel
                  Left = 14
                  Top = 56
                  Width = 322
                  Height = 25
                  FriendlyName = 'IWBSLabel6'
                  Caption = 'Item 2 with badge<span class="badge">0</span>'
                  BSLabelStyle = bslsInfo
                  RawText = True
                end
                object IWBSLabel18: TIWBSLabel
                  Left = 14
                  Top = 81
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSLabel16'
                  Caption = 'Item 3'
                  BSLabelStyle = bslsWarning
                end
                object IWBSLabel19: TIWBSLabel
                  Left = 14
                  Top = 105
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSLabel16'
                  Caption = 'Item 4'
                  BSLabelStyle = bslsDanger
                end
              end
              object IWBSRegion68: TIWBSRegion
                Left = 17
                Top = 403
                Width = 581
                Height = 37
                Css = ''
                Text = 'List Group With Linked Items'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion69: TIWBSRegion
                Left = 16
                Top = 448
                Width = 582
                Height = 139
                Css = ''
                Text = ''
                BSRegionType = bsrtListGroup
                object IWBSButton56: TIWBSButton
                  Left = 15
                  Top = 18
                  Width = 375
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = 'First Item'
                end
                object IWBSButton77: TIWBSButton
                  Left = 16
                  Top = 53
                  Width = 374
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = 'Second Item<span class="badge">45</span>'
                  RawText = True
                end
                object IWBSButton78: TIWBSButton
                  Left = 16
                  Top = 90
                  Width = 374
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = 'Third Item'
                end
              end
              object IWBSRegion70: TIWBSRegion
                Left = 16
                Top = 605
                Width = 581
                Height = 37
                Css = ''
                Text = 'Pagination'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSList6: TIWBSList
                Left = 322
                Top = 648
                Width = 267
                Height = 165
                Css = ''
                Text = ''
                BSListType = bsltPaginationSm
                object IWBSButton79: TIWBSButton
                  Left = 18
                  Top = 20
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '1'
                end
                object IWBSButton80: TIWBSButton
                  Left = 19
                  Top = 55
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '2'
                end
                object IWBSButton81: TIWBSButton
                  Left = 19
                  Top = 92
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '3'
                end
                object IWBSButton82: TIWBSButton
                  Left = 18
                  Top = 131
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '4'
                end
              end
              object IWBSRegion71: TIWBSRegion
                Left = 17
                Top = 836
                Width = 581
                Height = 37
                Css = ''
                Text = 'Pager'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSList7: TIWBSList
                Left = 17
                Top = 879
                Width = 335
                Height = 106
                Css = ''
                Text = ''
                BSListType = bsltPager
                object IWBSButton83: TIWBSButton
                  Left = 18
                  Top = 20
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '1'
                end
                object IWBSButton84: TIWBSButton
                  Left = 19
                  Top = 55
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '2'
                end
              end
              object IWBSList8: TIWBSList
                Left = 606
                Top = 648
                Width = 267
                Height = 165
                Css = ''
                Text = ''
                BSListType = bsltPaginationLg
                object IWBSButton85: TIWBSButton
                  Left = 18
                  Top = 20
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '1'
                end
                object IWBSButton86: TIWBSButton
                  Left = 19
                  Top = 55
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '2'
                end
                object IWBSButton87: TIWBSButton
                  Left = 19
                  Top = 92
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '3'
                end
                object IWBSButton88: TIWBSButton
                  Left = 18
                  Top = 131
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = '4'
                end
              end
              object IWBSRegion72: TIWBSRegion
                Left = 17
                Top = 1005
                Width = 581
                Height = 37
                Css = ''
                Text = 'Breadcrumbs'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSList9: TIWBSList
                Left = 16
                Top = 1048
                Width = 276
                Height = 165
                Css = ''
                Text = ''
                BSListType = bsltBreadcrumb
                object IWBSButton89: TIWBSButton
                  Left = 18
                  Top = 20
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = 'Page 1'
                end
                object IWBSButton90: TIWBSButton
                  Left = 19
                  Top = 55
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = 'Page 2'
                end
                object IWBSButton91: TIWBSButton
                  Left = 19
                  Top = 92
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = 'Page 3'
                end
                object IWBSButton92: TIWBSButton
                  Left = 18
                  Top = 131
                  Width = 200
                  Height = 25
                  FriendlyName = 'IWBSButton57'
                  Caption = 'Page 4'
                end
              end
            end
            object IWTabControl21Page5: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
              RenderInvisibleControls = True
              TabOrder = 12
              Title = 'Dialogs / Alerts'
              BorderOptions.NumericWidth = 0
              BorderOptions.BorderWidth = cbwNumeric
              BorderOptions.Style = cbsNone
              BorderOptions.Color = clNone
              Color = clWebWHITE
              object IWBSRegion6: TIWBSRegion
                Left = 0
                Top = 0
                Width = 1392
                Height = 1454
                Align = alClient
                Css = ''
                Style.Strings = (
                  'margin: 1em')
                Text = ''
                object IWBSInputForm4: TIWBSInputForm
                  Left = 15
                  Top = 12
                  Width = 1020
                  Height = 1029
                  Css = ''
                  Text = ''
                  object IWBSRegion12: TIWBSRegion
                    Left = 27
                    Top = 12
                    Width = 538
                    Height = 60
                    Css = ''
                    Text = ''
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
                      Caption = 'Dinamically create modal dialog from TIWFrame'
                    end
                  end
                  object IWBSRegion26: TIWBSRegion
                    Left = 27
                    Top = 85
                    Width = 538
                    Height = 60
                    Css = ''
                    Text = ''
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
                      Caption = 'Dinamically create dialog from code'
                    end
                  end
                  object IWBSRegion13: TIWBSRegion
                    Left = 27
                    Top = 163
                    Width = 538
                    Height = 91
                    Css = ''
                    Text = ''
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
                      Caption = 'Dinamically create advanced dialog from code'
                    end
                    object IWBSInput23: TIWBSInput
                      Left = 12
                      Top = 47
                      Width = 121
                      Height = 21
                      FriendlyName = 'IWBSInput6'
                      ScriptInsideTag = True
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
                    Css = ''
                    Text = ''
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
                      Caption = 'Dinamically create frame with inputs'
                    end
                  end
                  object IWBSRegion11: TIWBSRegion
                    Left = 27
                    Top = 335
                    Width = 538
                    Height = 76
                    Css = ''
                    Text = ''
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
                      Caption = 'Dinamically create button with anonymous proc'
                    end
                    object IWBSInput6: TIWBSInput
                      Left = 12
                      Top = 38
                      Width = 121
                      Height = 21
                      FriendlyName = 'IWBSInput6'
                      ScriptInsideTag = True
                      Caption = ''
                      Text = ''
                    end
                  end
                  object IWBSRegion27: TIWBSRegion
                    Left = 27
                    Top = 428
                    Width = 538
                    Height = 60
                    Css = ''
                    Text = ''
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
                      Caption = 'Dinamically create Alert'
                    end
                  end
                  object IWBSRegion28: TIWBSRegion
                    Left = 27
                    Top = 505
                    Width = 538
                    Height = 104
                    Css = ''
                    Text = ''
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
                      Caption = 'Dinamically create complex Alert'
                    end
                    object IWBSInput24: TIWBSInput
                      Left = 9
                      Top = 49
                      Width = 121
                      Height = 21
                      FriendlyName = 'IWBSInput6'
                      ScriptInsideTag = True
                      Caption = ''
                      Text = ''
                    end
                  end
                  object IWBSRegion31: TIWBSRegion
                    Left = 27
                    Top = 616
                    Width = 538
                    Height = 60
                    Css = ''
                    Text = ''
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
                      Caption = 'Raise an exception'
                    end
                  end
                end
              end
            end
            object IWTabControl21Page7: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
              RenderInvisibleControls = True
              TabOrder = 4
              Title = 'Badges / Labels'
              BorderOptions.NumericWidth = 0
              BorderOptions.BorderWidth = cbwNumeric
              BorderOptions.Style = cbsNone
              BorderOptions.Color = clNone
              Color = clWebWHITE
              object IWBSRegion49: TIWBSRegion
                Left = 19
                Top = 326
                Width = 805
                Height = 51
                Css = ''
                Text = ''
                object IWBSLabel10: TIWBSLabel
                  Left = 92
                  Top = 20
                  Width = 77
                  Height = 25
                  FriendlyName = 'IWBSLabel10'
                  Caption = 'Primary'
                  BSLabelStyle = bslsPrimary
                end
                object IWBSLabel11: TIWBSLabel
                  Left = 192
                  Top = 20
                  Width = 69
                  Height = 25
                  FriendlyName = 'IWBSLabel10'
                  Caption = 'Success'
                  BSLabelStyle = bslsSuccess
                end
                object IWBSLabel12: TIWBSLabel
                  Left = 288
                  Top = 20
                  Width = 69
                  Height = 25
                  FriendlyName = 'IWBSLabel10'
                  Caption = 'Warning'
                  BSLabelStyle = bslsWarning
                end
                object IWBSLabel13: TIWBSLabel
                  Left = 386
                  Top = 20
                  Width = 71
                  Height = 25
                  FriendlyName = 'IWBSLabel10'
                  Caption = 'Danger'
                  BSLabelStyle = bslsDanger
                end
                object IWBSLabel14: TIWBSLabel
                  Left = 12
                  Top = 20
                  Width = 74
                  Height = 25
                  FriendlyName = 'IWBSLabel10'
                  Caption = 'Default'
                  BSLabelStyle = bslsDefault
                end
                object IWBSLabel15: TIWBSLabel
                  Left = 484
                  Top = 20
                  Width = 61
                  Height = 25
                  FriendlyName = 'IWBSLabel10'
                  Caption = 'Info'
                  BSLabelStyle = bslsInfo
                end
              end
              object IWBSRegion51: TIWBSRegion
                Left = 19
                Top = 26
                Width = 581
                Height = 37
                Css = ''
                Text = 'Labels'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion52: TIWBSRegion
                Left = 19
                Top = 275
                Width = 581
                Height = 37
                Css = ''
                Text = 'Contextual Label Classes'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion53: TIWBSRegion
                Left = 19
                Top = 75
                Width = 806
                Height = 43
                Css = ''
                Text = 'This is embeded text'
                TagType = bsttH3
                object IWBSLabel20: TIWBSLabel
                  Left = 162
                  Top = 15
                  Width = 112
                  Height = 25
                  FriendlyName = 'IWBSLabel7'
                  Caption = 'This a Label'
                  BSLabelStyle = bslsDefault
                end
              end
              object IWBSRegion73: TIWBSRegion
                Left = 19
                Top = 144
                Width = 581
                Height = 37
                Css = ''
                Text = 'Badges'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion74: TIWBSRegion
                Left = 20
                Top = 192
                Width = 805
                Height = 41
                Css = ''
                Text = ''
                object IWBSLabel8: TIWBSLabel
                  Left = 5
                  Top = 11
                  Width = 112
                  Height = 25
                  FriendlyName = 'IWBSLabel7'
                  Caption = 'This a Label'
                end
                object IWBSLabel9: TIWBSLabel
                  Left = 123
                  Top = 11
                  Width = 94
                  Height = 16
                  FriendlyName = 'IWBSLabel7'
                  Caption = '10'
                  BSLabelStyle = bslsBadget
                end
              end
            end
            object IWTabControl21Page9: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
              RenderInvisibleControls = True
              TabOrder = 9
              Title = 'Jumbotron / PageHeader / Weel'
              BorderOptions.NumericWidth = 0
              BorderOptions.BorderWidth = cbwNumeric
              BorderOptions.Style = cbsNone
              BorderOptions.Color = clNone
              Color = clWebWHITE
              object IWBSRegion9: TIWBSRegion
                Left = 19
                Top = 24
                Width = 698
                Height = 110
                Css = ''
                RawText = True
                Text = 
                  '<h1>This is a Jumbotron</h1>'#13#10'<h2>Example page header <small>Sub' +
                  'text for header</small></h2>'
                BSRegionType = bsrtJumbotron
              end
              object IWBSRegion14: TIWBSRegion
                Left = 19
                Top = 141
                Width = 698
                Height = 126
                Css = ''
                RawText = True
                Text = 
                  '<h1>This is a Page Header</h1>'#13#10'<h2>Example page header <small>S' +
                  'ubtext for header</small></h2>'
                BSRegionType = bsrtPageHeader
              end
              object IWBSRegion24: TIWBSRegion
                Left = 19
                Top = 278
                Width = 698
                Height = 133
                Css = ''
                RawText = True
                Text = 
                  '<h1>This is a Well</h1>'#13#10'<h2>Example page header <small>Subtext ' +
                  'for header</small></h2>'
                BSRegionType = bsrtWell
              end
            end
            object IWTabControl21Page11: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
              RenderInvisibleControls = True
              TabOrder = 10
              Title = 'Collapse'
              BorderOptions.NumericWidth = 0
              BorderOptions.BorderWidth = cbwNumeric
              BorderOptions.Style = cbsNone
              BorderOptions.Color = clNone
              Color = clWebWHITE
              object IWBSButton36: TIWBSButton
                Left = 15
                Top = 75
                Width = 204
                Height = 25
                FriendlyName = 'IWBSButton36'
                Caption = 'Click Me'
                DataTarget = IWBSRegion76
              end
              object IWBSRegion75: TIWBSRegion
                Left = 15
                Top = 26
                Width = 581
                Height = 37
                Css = ''
                Text = 'Basic Collapse'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion76: TIWBSRegion
                Left = 16
                Top = 112
                Width = 695
                Height = 291
                Css = ''
                Collapse = True
                Text = 
                  'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do' +
                  ' eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ' +
                  'enim ad minim veniam, quis nostrud exercitation ullamco laboris ' +
                  'nisi ut aliquip ex ea commodo consequat.'
              end
            end
            object IWTabControl21Page4: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
              RenderInvisibleControls = True
              TabOrder = 11
              Title = 'Modal'
              BorderOptions.NumericWidth = 0
              BorderOptions.BorderWidth = cbwNumeric
              BorderOptions.Style = cbsNone
              BorderOptions.Color = clNone
              Color = clWebWHITE
              object IWBSButton40: TIWBSButton
                Left = 16
                Top = 93
                Width = 173
                Height = 25
                FriendlyName = 'IWBSButton40'
                OnAsyncClick = IWBSButton40AsyncClick
                BSButtonStyle = bsbsSuccess
                Caption = 'Show Modal Window'
              end
              object IWBSRegion34: TIWBSRegion
                Left = 16
                Top = 24
                Width = 697
                Height = 60
                Css = ''
                Text = 'Modal Window'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSModal1: TIWBSModal
                Left = 15
                Top = 141
                Width = 698
                Height = 261
                Css = ''
                Text = ''
                object IWBSRegion35: TIWBSRegion
                  Left = 8
                  Top = 22
                  Width = 655
                  Height = 227
                  Css = ''
                  Text = ''
                  BSRegionType = bsrtWell
                  object IWBSText1: TIWBSText
                    Left = 22
                    Top = 24
                    Width = 527
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
                    Caption = 'AsyncClick to close modal'
                  end
                  object IWBSButton38: TIWBSButton
                    Left = 21
                    Top = 189
                    Width = 297
                    Height = 25
                    FriendlyName = 'IWBSButton38'
                    Caption = 'Close Modal by data-dismiss'
                    DataDismiss = bsbdModal
                  end
                end
              end
            end
            object IWTabControl21Page10: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
              RenderInvisibleControls = True
              TabOrder = 10
              Title = 'Panels / Accordion'
              BorderOptions.NumericWidth = 0
              BorderOptions.BorderWidth = cbwNumeric
              BorderOptions.Style = cbsNone
              BorderOptions.Color = clNone
              Color = clWebWHITE
              object IWBSRegion19: TIWBSRegion
                Left = 13
                Top = 51
                Width = 698
                Height = 268
                Css = ''
                Text = ''
                BSBackground = bsrbPrimary
                BSRegionType = bsrtPanel
                object IWBSRegion20: TIWBSRegion
                  Left = 8
                  Top = 22
                  Width = 681
                  Height = 80
                  Css = ''
                  Text = ''
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
                  Css = ''
                  Text = ''
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
                  Css = ''
                  Text = ''
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
              object IWBSRegion66: TIWBSRegion
                Left = 13
                Top = 8
                Width = 581
                Height = 37
                Css = ''
                Text = 'Panel'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion67: TIWBSRegion
                Left = 13
                Top = 329
                Width = 698
                Height = 37
                Css = ''
                Text = 'Accordion'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion4: TIWBSRegion
                Left = 13
                Top = 372
                Width = 698
                Height = 849
                Css = ''
                Text = ''
                BSRegionType = bsrtPanelGroup
                object IWBSRegion38: TIWBSRegion
                  Left = 22
                  Top = 22
                  Width = 659
                  Height = 255
                  Css = ''
                  Text = ''
                  BSRegionType = bsrtPanel
                  object IWBSRegion39: TIWBSRegion
                    Left = 20
                    Top = 24
                    Width = 621
                    Height = 81
                    Css = ''
                    Text = ''
                    BSRegionType = bsrtPanelHeading
                    object IWBSButton43: TIWBSButton
                      Left = 20
                      Top = 28
                      Width = 200
                      Height = 25
                      FriendlyName = 'IWBSButton43'
                      Caption = 'Collapsible Group Item #1'
                      DataParent = IWBSRegion4
                      DataTarget = IWBSRegion42
                    end
                  end
                  object IWBSRegion42: TIWBSRegion
                    Left = 19
                    Top = 108
                    Width = 622
                    Height = 121
                    Css = ''
                    Collapse = True
                    CollapseVisible = True
                    Text = ''
                    BSRegionType = bsrtPanelBody
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
                  Css = ''
                  Text = ''
                  BSRegionType = bsrtPanel
                  object IWBSRegion44: TIWBSRegion
                    Left = 20
                    Top = 24
                    Width = 621
                    Height = 81
                    Css = ''
                    Text = ''
                    BSRegionType = bsrtPanelHeading
                    object IWBSButton44: TIWBSButton
                      Left = 24
                      Top = 32
                      Width = 200
                      Height = 25
                      FriendlyName = 'IWBSButton43'
                      Caption = 'Collapsible Group Item #2'
                      DataParent = IWBSRegion4
                      DataTarget = IWBSRegion46
                    end
                  end
                  object IWBSRegion46: TIWBSRegion
                    Left = 19
                    Top = 108
                    Width = 622
                    Height = 121
                    Css = ''
                    Collapse = True
                    Text = ''
                    BSRegionType = bsrtPanelBody
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
                  Css = ''
                  Text = ''
                  BSRegionType = bsrtPanel
                  object IWBSRegion48: TIWBSRegion
                    Left = 20
                    Top = 24
                    Width = 621
                    Height = 81
                    Css = ''
                    Text = ''
                    BSRegionType = bsrtPanelHeading
                    object IWBSButton47: TIWBSButton
                      Left = 12
                      Top = 20
                      Width = 200
                      Height = 25
                      FriendlyName = 'IWBSButton43'
                      Caption = 'Collapsible Group Item #3'
                      DataParent = IWBSRegion4
                      DataTarget = IWBSRegion50
                    end
                  end
                  object IWBSRegion50: TIWBSRegion
                    Left = 19
                    Top = 108
                    Width = 622
                    Height = 121
                    Css = ''
                    Collapse = True
                    Text = ''
                    BSRegionType = bsrtPanelBody
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
                      RawText = True
                    end
                  end
                end
              end
            end
            object IWTabControl21Page12: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
              RenderInvisibleControls = True
              TabOrder = 10
              Title = 'Responsive'
              BorderOptions.NumericWidth = 0
              BorderOptions.BorderWidth = cbwNumeric
              BorderOptions.Style = cbsNone
              BorderOptions.Color = clNone
              Color = clWebWHITE
              object IWBSRegion23: TIWBSRegion
                Left = 21
                Top = 25
                Width = 803
                Height = 59
                Css = ''
                Text = 'Showing and Hiding'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion78: TIWBSRegion
                Left = 20
                Top = 108
                Width = 803
                Height = 50
                BSGridOptions.VisibilityXs = bsgvBlock
                Css = ''
                Text = 'This text is shown only on an EXTRA SMALL screen.'
                TagType = bsttH4
              end
              object IWBSRegion79: TIWBSRegion
                Left = 20
                Top = 159
                Width = 803
                Height = 50
                BSGridOptions.VisibilitySm = bsgvBlock
                Css = ''
                Text = 'This text is shown only on a SMALL screen.'
                TagType = bsttH4
              end
              object IWBSRegion80: TIWBSRegion
                Left = 20
                Top = 208
                Width = 803
                Height = 50
                BSGridOptions.VisibilityMd = bsgvBlock
                Css = ''
                Text = 'This text is shown only on a MEDIUM screen.'
                TagType = bsttH4
              end
              object IWBSRegion81: TIWBSRegion
                Left = 20
                Top = 261
                Width = 803
                Height = 50
                BSGridOptions.VisibilityLg = bsgvBlock
                Css = ''
                Text = 'This text is shown only on a LARGE screen.'
                TagType = bsttH4
              end
              object IWBSRegion82: TIWBSRegion
                Left = 19
                Top = 314
                Width = 803
                Height = 50
                BSGridOptions.VisibilityXs = bsgvBlock
                BSGridOptions.VisibilityLg = bsgvBlock
                Css = ''
                Text = 'This text is shown only on a EXTRA SMALL and LARGE screen.'
                TagType = bsttH4
              end
              object IWBSRegion83: TIWBSRegion
                Left = 20
                Top = 370
                Width = 803
                Height = 50
                BSGridOptions.VisibilityXs = bsgvHidden
                Css = ''
                Text = 'This text is hidden on an EXTRA SMALL screen.'
                TagType = bsttH4
              end
              object IWBSRegion84: TIWBSRegion
                Left = 19
                Top = 610
                Width = 949
                Height = 206
                Css = ''
                Text = ''
                object IWBSRegion86: TIWBSRegion
                  Left = 14
                  Top = 22
                  Width = 875
                  Height = 50
                  BSGridOptions.VisibilityXs = bsgvBlock
                  BSGridOptions.VisibilitySm = bsgvBlock
                  BSGridOptions.VisibilityMd = bsgvInline
                  BSGridOptions.VisibilityLg = bsgvInline
                  Css = ''
                  Text = 'This regions are display:inline'
                  BSBackground = bsrbDanger
                  BSRegionType = bsrtWellSmall
                  TagType = bsttH4
                end
                object IWBSRegion87: TIWBSRegion
                  Left = 14
                  Top = 89
                  Width = 875
                  Height = 50
                  BSGridOptions.VisibilityXs = bsgvBlock
                  BSGridOptions.VisibilitySm = bsgvBlock
                  BSGridOptions.VisibilityMd = bsgvInline
                  BSGridOptions.VisibilityLg = bsgvInline
                  Css = ''
                  Text = ' in medium an large screens'
                  BSBackground = bsrbDanger
                  BSRegionType = bsrtWellSmall
                  TagType = bsttH4
                end
                object IWBSRegion88: TIWBSRegion
                  Left = 15
                  Top = 150
                  Width = 875
                  Height = 50
                  BSGridOptions.VisibilityXs = bsgvBlock
                  BSGridOptions.VisibilitySm = bsgvBlock
                  BSGridOptions.VisibilityMd = bsgvInline
                  BSGridOptions.VisibilityLg = bsgvInline
                  Css = ''
                  Text = ' but display:block in small and xmall screens'
                  BSBackground = bsrbDanger
                  BSRegionType = bsrtWellSmall
                  TagType = bsttH4
                end
              end
              object IWBSRegion85: TIWBSRegion
                Left = 19
                Top = 540
                Width = 803
                Height = 64
                Css = ''
                Text = 'Block vs Inline'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion89: TIWBSRegion
                Left = 20
                Top = 426
                Width = 803
                Height = 50
                BSGridOptions.VisibilityPrint = bsgvBlock
                Css = ''
                Text = 'This text is shown only in print view'
                TagType = bsttH4
              end
              object IWBSRegion90: TIWBSRegion
                Left = 19
                Top = 479
                Width = 803
                Height = 50
                BSGridOptions.VisibilityPrint = bsgvHidden
                Css = ''
                Text = 'This text is hidden in print view'
                TagType = bsttH4
              end
              object IWBSRegion91: TIWBSRegion
                Left = 19
                Top = 831
                Width = 581
                Height = 55
                Css = ''
                Text = 'Quick Floats'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion92: TIWBSRegion
                Left = 19
                Top = 891
                Width = 950
                Height = 84
                Css = ''
                Text = ''
                object IWBSRegion93: TIWBSRegion
                  Left = 16
                  Top = 17
                  Width = 300
                  Height = 56
                  BSGridOptions.Float = bsgfLeft
                  Css = ''
                  Text = 'This float Left'
                  BSBackground = bsrbPrimary
                  BSRegionType = bsrtWellSmall
                  TagType = bsttH4
                end
                object IWBSRegion94: TIWBSRegion
                  Left = 475
                  Top = 17
                  Width = 300
                  Height = 56
                  BSGridOptions.Float = bsgfRight
                  Css = ''
                  Text = 'This float Rigth'
                  BSBackground = bsrbPrimary
                  BSRegionType = bsrtWellSmall
                  TagType = bsttH4
                end
              end
            end
            object IWTabControl21Page2: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
              RenderInvisibleControls = True
              TabOrder = 12
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
                BSGridOptions.GridSmSpan = 6
                Css = ''
                Style.Strings = (
                  'margin: 1em')
                Text = ''
                object IWBSRegion7: TIWBSRegion
                  Left = 15
                  Top = 6
                  Width = 433
                  Height = 303
                  Css = ''
                  Text = ''
                  BSRegionType = bsrtWell
                  object IWBSInputForm1: TIWBSInputForm
                    Left = 16
                    Top = 13
                    Width = 293
                    Height = 206
                    Css = ''
                    Text = ''
                    object IWBSButton30: TIWBSButton
                      Left = 26
                      Top = 148
                      Width = 184
                      Height = 25
                      RenderSize = False
                      StyleRenderOptions.RenderSize = False
                      FriendlyName = 'IWBSButton20aaaaaa'
                      OnAsyncClick = IWBSButton30AsyncClick
                      Caption = 'Apply settings'
                    end
                    object chkTabsJust: TIWBSCheckBox
                      Left = 25
                      Top = 30
                      Width = 121
                      Height = 21
                      FriendlyName = 'chkTabsJust'
                      ScriptInsideTag = True
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
                      ScriptInsideTag = True
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
                      ScriptInsideTag = True
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
                      ScriptInsideTag = True
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
                  Css = ''
                  Text = ''
                  BSRegionType = bsrtWell
                  object IWBSButton42: TIWBSButton
                    Left = 26
                    Top = 18
                    Width = 329
                    Height = 25
                    FriendlyName = 'IWBSButton42'
                    OnAsyncClick = IWBSButton42AsyncClick
                    Caption = 'Toggle TabPage visibility'
                  end
                end
              end
            end
            object IWTabControl21Page3: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
              RenderInvisibleControls = True
              TabOrder = 2
              Title = 'Buttons / Buttons Groups'
              BorderOptions.NumericWidth = 0
              BorderOptions.BorderWidth = cbwNumeric
              BorderOptions.Style = cbsNone
              BorderOptions.Color = clNone
              Color = clWebWHITE
              object IWBSRegion55: TIWBSRegion
                Left = 13
                Top = 20
                Width = 581
                Height = 37
                Css = ''
                Text = 'Button Styles'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion45: TIWBSRegion
                Left = 13
                Top = 124
                Width = 581
                Height = 37
                Css = ''
                Text = 'Button Sizes'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion54: TIWBSRegion
                Left = 13
                Top = 166
                Width = 948
                Height = 49
                Css = ''
                Text = ''
                object IWBSButton62: TIWBSButton
                  Left = 8
                  Top = 9
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonSize = bsszLg
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Large'
                end
                object IWBSButton63: TIWBSButton
                  Left = 107
                  Top = 9
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonSize = bsszMd
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Medium'
                end
                object IWBSButton64: TIWBSButton
                  Left = 206
                  Top = 9
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonSize = bsszSm
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Small'
                end
                object IWBSButton65: TIWBSButton
                  Left = 305
                  Top = 9
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonSize = bsszXs
                  BSButtonStyle = bsbsPrimary
                  Caption = 'XSmall'
                end
              end
              object IWBSRegion10: TIWBSRegion
                Left = 13
                Top = 229
                Width = 581
                Height = 37
                Css = ''
                Text = 'Block Level Buttons'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion56: TIWBSRegion
                Left = 13
                Top = 270
                Width = 948
                Height = 49
                Css = ''
                Text = ''
                object IWBSButton66: TIWBSButton
                  Left = 8
                  Top = 9
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSBlockLevel = True
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 1'
                end
                object IWBSButton67: TIWBSButton
                  Left = 107
                  Top = 9
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSBlockLevel = True
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 2'
                end
              end
              object IWBSRegion57: TIWBSRegion
                Left = 13
                Top = 574
                Width = 581
                Height = 37
                Css = ''
                Text = 'Button Groups'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSButtonGroup1: TIWBSButtonGroup
                Left = 13
                Top = 617
                Width = 948
                Height = 52
                Css = ''
                Style.Strings = (
                  '')
                Text = ''
                object IWBSButton68: TIWBSButton
                  Left = 12
                  Top = 14
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 1'
                end
                object IWBSButton69: TIWBSButton
                  Left = 111
                  Top = 13
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 2'
                end
                object IWBSButton70: TIWBSButton
                  Left = 210
                  Top = 14
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 3'
                end
              end
              object IWBSButtonGroup2: TIWBSButtonGroup
                Left = 13
                Top = 675
                Width = 948
                Height = 52
                Css = ''
                Style.Strings = (
                  '')
                Text = ''
                BSButtonSize = bsszSm
                object IWBSButton71: TIWBSButton
                  Left = 12
                  Top = 14
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 1'
                end
                object IWBSButton72: TIWBSButton
                  Left = 111
                  Top = 13
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 2'
                end
                object IWBSButton73: TIWBSButton
                  Left = 210
                  Top = 14
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 3'
                end
              end
              object IWBSRegion58: TIWBSRegion
                Left = 13
                Top = 749
                Width = 581
                Height = 37
                Css = ''
                Text = 'Vertical Button Groups'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSButtonGroup3: TIWBSButtonGroup
                Left = 13
                Top = 791
                Width = 948
                Height = 52
                Css = ''
                Text = ''
                BSVertical = True
                object IWBSButton74: TIWBSButton
                  Left = 12
                  Top = 14
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 1'
                end
                object IWBSButton75: TIWBSButton
                  Left = 111
                  Top = 14
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 2'
                end
                object IWBSButton76: TIWBSButton
                  Left = 210
                  Top = 14
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 3'
                end
              end
              object IWBSRegion59: TIWBSRegion
                Left = 13
                Top = 335
                Width = 581
                Height = 37
                Css = ''
                Text = 'Glyphicons'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion60: TIWBSRegion
                Left = 13
                Top = 378
                Width = 948
                Height = 56
                Css = ''
                Text = ''
                object IWBSButton1: TIWBSButton
                  Left = 3
                  Top = 15
                  Width = 82
                  Height = 30
                  Hint = 'This is a hint'
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton1'
                  BSButtonSize = bsszLg
                  BSGlyphicon = 'align-left'
                  Caption = 'Left'
                end
                object IWBSButton2: TIWBSButton
                  Left = 91
                  Top = 15
                  Width = 85
                  Height = 30
                  Hint = 'This is a hint'
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton1'
                  BSButtonSize = bsszMd
                  BSGlyphicon = 'align-center'
                  Caption = 'Center'
                end
                object IWBSButton3: TIWBSButton
                  Left = 182
                  Top = 15
                  Width = 75
                  Height = 30
                  Hint = 'This is a hint'
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton1'
                  BSButtonSize = bsszSm
                  BSGlyphicon = 'align-right'
                  Caption = 'Rigth'
                end
                object IWBSButton4: TIWBSButton
                  Left = 267
                  Top = 15
                  Width = 82
                  Height = 30
                  Hint = 'This is a hint'
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton1'
                  BSButtonSize = bsszXs
                  BSGlyphicon = 'align-justify'
                  Caption = 'Justify'
                end
              end
              object IWBSRegion61: TIWBSRegion
                Left = 13
                Top = 63
                Width = 948
                Height = 49
                Css = ''
                Text = ''
                object IWBSButton13: TIWBSButton
                  Left = 6
                  Top = 12
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton13'
                  Caption = 'Default'
                end
                object IWBSButton14: TIWBSButton
                  Left = 87
                  Top = 14
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton13'
                  BSButtonStyle = bsbsInfo
                  Caption = 'Info'
                end
                object IWBSButton15: TIWBSButton
                  Left = 168
                  Top = 14
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton13'
                  BSButtonStyle = bsbsLink
                  Caption = 'Link'
                end
                object IWBSButton16: TIWBSButton
                  Left = 249
                  Top = 14
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton13'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Primary'
                end
                object IWBSButton17: TIWBSButton
                  Left = 330
                  Top = 14
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton13'
                  BSButtonStyle = bsbsSuccess
                  Caption = 'Success'
                end
                object IWBSButton18: TIWBSButton
                  Left = 411
                  Top = 14
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton13'
                  BSButtonStyle = bsbsWarning
                  Caption = 'Warning'
                end
                object IWBSButton19: TIWBSButton
                  Left = 492
                  Top = 14
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton13'
                  BSButtonStyle = bsbsDanger
                  Caption = 'Danger'
                end
                object IWBSButton29: TIWBSButton
                  Left = 573
                  Top = 12
                  Width = 75
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton13'
                  BSButtonStyle = bsbsClose
                  Caption = 'Close'
                end
              end
              object IWBSRegion62: TIWBSRegion
                Left = 13
                Top = 856
                Width = 581
                Height = 37
                Css = ''
                Text = 'Justified Button Groups'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSButtonGroup4: TIWBSButtonGroup
                Left = 13
                Top = 899
                Width = 948
                Height = 52
                Css = ''
                Text = ''
                BSJustified = True
                object IWBSButton5: TIWBSButton
                  Left = 12
                  Top = 14
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 1'
                end
                object IWBSButton6: TIWBSButton
                  Left = 111
                  Top = 13
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 2'
                end
                object IWBSButton7: TIWBSButton
                  Left = 210
                  Top = 14
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 3'
                end
              end
              object IWBSRegion63: TIWBSRegion
                Left = 13
                Top = 969
                Width = 581
                Height = 37
                Css = ''
                Text = 'Nesting Button Groups & Dropdown Menus'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSButtonGroup5: TIWBSButtonGroup
                Left = 13
                Top = 1018
                Width = 948
                Height = 52
                Css = ''
                Style.Strings = (
                  '')
                Text = ''
                object IWBSButton8: TIWBSButton
                  Left = 12
                  Top = 14
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 1'
                end
                object IWBSButton9: TIWBSButton
                  Left = 111
                  Top = 13
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button 2'
                end
                object IWBSDropDown3: TIWBSDropDown
                  Left = 210
                  Top = 16
                  Width = 121
                  Height = 25
                  FriendlyName = 'IWBSDropDown3'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'DropDown'
                  DropDownItems = <
                    item
                      Caption = 'Option 1'
                    end
                    item
                      Caption = 'Option 2'
                    end
                    item
                      Caption = 'Option 3'
                    end>
                end
              end
              object IWBSButtonGroup6: TIWBSButtonGroup
                Left = 13
                Top = 1076
                Width = 948
                Height = 52
                Css = ''
                Style.Strings = (
                  '')
                Text = ''
                object IWBSButton11: TIWBSButton
                  Left = 11
                  Top = 13
                  Width = 93
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button'
                end
                object IWBSDropDown4: TIWBSDropDown
                  Left = 110
                  Top = 12
                  Width = 49
                  Height = 25
                  FriendlyName = 'IWBSDropDown3'
                  BSButtonStyle = bsbsPrimary
                  Caption = ''
                  DropDownItems = <
                    item
                      Caption = 'Option 1'
                    end
                    item
                      Caption = 'Option 2'
                    end
                    item
                      Caption = 'Option 3'
                    end>
                end
              end
              object IWBSRegion64: TIWBSRegion
                Left = 13
                Top = 449
                Width = 581
                Height = 37
                Css = ''
                Text = 'RawText Caption'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion65: TIWBSRegion
                Left = 13
                Top = 497
                Width = 948
                Height = 49
                Css = ''
                Text = ''
                object IWBSButton10: TIWBSButton
                  Left = 11
                  Top = 18
                  Width = 394
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsPrimary
                  Caption = 'Button with Badge'#13#10'<span class="badge">23</span>'
                  RawText = True
                end
                object IWBSButton12: TIWBSButton
                  Left = 418
                  Top = 21
                  Width = 394
                  Height = 25
                  FriendlyName = 'IWBSButton62'
                  BSButtonStyle = bsbsLink
                  Caption = 'Button with Badge'#13#10'<span class="badge">23</span>'
                  RawText = True
                end
              end
            end
            object IWTabControl21Page6: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
              RenderInvisibleControls = True
              TabOrder = 15
              Title = 'Miscellaneous'
              BorderOptions.NumericWidth = 0
              BorderOptions.BorderWidth = cbwNumeric
              BorderOptions.Style = cbsNone
              BorderOptions.Color = clNone
              Color = clWebWHITE
              object IWBSRegion33: TIWBSRegion
                Left = 35
                Top = 121
                Width = 700
                Height = 91
                Css = ''
                Text = ''
                BSRegionType = bsrtWell
                object IWBSInput25: TIWBSInput
                  Left = 17
                  Top = 18
                  Width = 201
                  Height = 25
                  ExtraTagParams.Strings = (
                    '')
                  FriendlyName = 'IWBSInput1'
                  ScriptInsideTag = True
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
                  Caption = 'OnClick scriptEvent'
                end
              end
              object IWBSRegion29: TIWBSRegion
                Left = 35
                Top = 325
                Width = 702
                Height = 381
                Css = ''
                Collapse = True
                CollapseVisible = True
                Text = ''
                BSRegionType = bsrtWell
                object IWBSLabel3: TIWBSLabel
                  Left = 20
                  Top = 13
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
                  Css = ''
                  Text = ''
                  OnSubmit = IWBSInputForm5Submit
                  object IWBSButton45: TIWBSButton
                    Left = 22
                    Top = 101
                    Width = 200
                    Height = 25
                    FriendlyName = 'IWBSButton45'
                    Caption = 'Submit File'
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
              object IWBSRegion77: TIWBSRegion
                Left = 35
                Top = 234
                Width = 581
                Height = 79
                Css = ''
                Text = 'Basic File Upload'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion32: TIWBSRegion
                Left = 35
                Top = 29
                Width = 581
                Height = 73
                Css = ''
                Text = 'Direct JS'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion95: TIWBSRegion
                Left = 37
                Top = 724
                Width = 581
                Height = 79
                Css = ''
                Text = 'Ajax File Download'
                BSRegionType = bsrtPageHeader
                TagType = bsttH2
              end
              object IWBSRegion96: TIWBSRegion
                Left = 37
                Top = 815
                Width = 716
                Height = 78
                Css = ''
                Text = ''
                BSRegionType = bsrtWell
                object IWBSButton99: TIWBSButton
                  Left = 21
                  Top = 34
                  Width = 223
                  Height = 25
                  CustomRestEvents = <
                    item
                      EventName = 'downloadfile'
                      OnRestEvent = IWBSButton99CustomRestEvents0RestEvent
                    end>
                  FriendlyName = 'IWBSButton41'
                  OnAsyncClick = IWBSButton99AsyncClick
                  Caption = 'Download via ajax'
                end
              end
            end
            object IWTabControl21Page1: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
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
                Width = 849
                Height = 640
                BSGridOptions.GridMdSpan = 6
                Css = ''
                Text = ''
                object IWBSInputGroup1: TIWBSInputGroup
                  Left = 33
                  Top = 119
                  Width = 784
                  Height = 43
                  Css = ''
                  Text = ''
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
                    ScriptInsideTag = True
                    Caption = ''
                    Text = ''
                  end
                end
                object IWBSInputGroup2: TIWBSInputGroup
                  Left = 33
                  Top = 177
                  Width = 784
                  Height = 43
                  Css = ''
                  Text = ''
                  Caption = 'Button Right'
                  object IWBSButton23: TIWBSButton
                    Left = 231
                    Top = 8
                    Width = 98
                    Height = 25
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSButton22'
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
                    ScriptInsideTag = True
                    Caption = ''
                    Text = ''
                  end
                end
                object IWBSInputGroup3: TIWBSInputGroup
                  Left = 33
                  Top = 234
                  Width = 784
                  Height = 51
                  Css = ''
                  Text = ''
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
                    ScriptInsideTag = True
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
                    BSGlyphicon = 'align-center'
                    Caption = 'IWBSButton22'
                  end
                end
                object IWBSRegion16: TIWBSRegion
                  Left = 32
                  Top = 38
                  Width = 785
                  Height = 44
                  Css = ''
                  Text = 'Iinput groups'
                  BSRegionType = bsrtPageHeader
                  TagType = bsttH2
                end
                object IWBSInputGroup4: TIWBSInputGroup
                  Left = 33
                  Top = 306
                  Width = 784
                  Height = 58
                  Css = ''
                  Text = ''
                  Caption = 'CheckBox AddOn'
                  object IWBSInput11: TIWBSInput
                    Left = 169
                    Top = 17
                    Width = 121
                    Height = 21
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSInput8'
                    ScriptInsideTag = True
                    Caption = ''
                    Text = ''
                  end
                  object IWBSCheckBox3: TIWBSCheckBox
                    Left = 21
                    Top = 16
                    Width = 121
                    Height = 21
                    FriendlyName = 'IWBSCheckBox3'
                    ScriptInsideTag = True
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
                  Width = 784
                  Height = 58
                  Css = ''
                  Text = ''
                  Caption = 'Radio AddOn'
                  object IWBSInput12: TIWBSInput
                    Left = 169
                    Top = 17
                    Width = 121
                    Height = 21
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSInput8'
                    ScriptInsideTag = True
                    Caption = ''
                    Text = ''
                  end
                  object IWBSRadioButton5: TIWBSRadioButton
                    Left = 21
                    Top = 16
                    Width = 121
                    Height = 21
                    FriendlyName = 'IWBSRadioButton5'
                    ScriptInsideTag = True
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
                  Width = 784
                  Height = 43
                  Css = ''
                  Text = ''
                  Caption = 'Glyphicons'
                  object IWBSInput4: TIWBSInput
                    Left = 101
                    Top = 12
                    Width = 121
                    Height = 21
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSInput8'
                    ScriptInsideTag = True
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
                  Left = 34
                  Top = 563
                  Width = 783
                  Height = 43
                  Css = ''
                  Text = ''
                  Caption = 'Labels'
                  object IWBSInput5: TIWBSInput
                    Left = 101
                    Top = 12
                    Width = 121
                    Height = 21
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSInput8'
                    ScriptInsideTag = True
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
                  Width = 784
                  Height = 58
                  Css = ''
                  Text = ''
                  Caption = 'Radio AddOn'
                  object IWBSInput27: TIWBSInput
                    Left = 21
                    Top = 21
                    Width = 121
                    Height = 26
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    FriendlyName = 'IWBSInput8'
                    ScriptInsideTag = True
                    Caption = ''
                    Text = ''
                  end
                  object IWBSDropDown1: TIWBSDropDown
                    Left = 148
                    Top = 22
                    Width = 114
                    Height = 25
                    FriendlyName = 'IWBSDropDown1'
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
            object IWTabControl21Page0: TIWTabPage
              Left = 0
              Top = 20
              Width = 1392
              Height = 1454
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
                Width = 1392
                Height = 1305
                Align = alTop
                Css = ''
                Style.Strings = (
                  'margin: 1em')
                Text = ''
                BSRegionType = bsrtRow
                object IWBSRegion2: TIWBSRegion
                  Left = 1
                  Top = 1
                  Width = 334
                  Height = 1303
                  Align = alLeft
                  BSGridOptions.GridMdSpan = 4
                  Css = ''
                  Text = ''
                  BSRegionType = bsrtColumn
                  object IWBSRegion18: TIWBSRegion
                    Left = 12
                    Top = 34
                    Width = 245
                    Height = 195
                    Css = ''
                    Text = ''
                    BSRegionType = bsrtWellLarge
                    object IWBSInputForm3: TIWBSInputForm
                      Left = 4
                      Top = 24
                      Width = 234
                      Height = 159
                      Css = ''
                      Text = ''
                      object LstFormType: TIWBSRadioGroup
                        Left = 10
                        Top = 47
                        Width = 128
                        Height = 64
                        FriendlyName = 'LstFormType'
                        ScriptInsideTag = True
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
                        CustomAsyncEvents = <
                          item
                          end>
                        FriendlyName = 'IWBSButton20'
                        OnAsyncClick = IWBSButton35AsyncClick
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
                  Width = 1056
                  Height = 1303
                  Align = alClient
                  BSGridOptions.GridMdSpan = 8
                  Css = ''
                  Text = ''
                  BSFormOptions.CaptionsSize.GridMdSpan = 4
                  BSFormOptions.InputsSize.GridMdSpan = 8
                  object IWBSInput1: TIWBSInput
                    Left = 12
                    Top = 35
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput1'
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
                    Caption = 'Input Type Password'
                    Text = ''
                    PlaceHolder = 'Password'
                    InputType = bsitPassword
                  end
                  object IWBSMemo2: TIWBSMemo
                    Left = 12
                    Top = 447
                    Width = 435
                    Height = 121
                    FriendlyName = 'IWBSMemo2'
                    ScriptInsideTag = True
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
                    BSGlyphicon = 'check'
                    Caption = 'Ajax Click (see input values in memo)'
                  end
                  object IWBSInput7: TIWBSInput
                    Left = 12
                    Top = 113
                    Width = 201
                    Height = 25
                    FriendlyName = 'IWBSInput3'
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
                    Caption = 'This is a Select (Size = 1)'
                    Text = 'item 1'
                    ItemIndex = 0
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
                    ScriptInsideTag = True
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
                    ScriptInsideTag = True
                    Caption = 'This is a Select (Size <> 1)'
                    Text = 'item 1'
                    ItemIndex = 0
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
                    ScriptInsideTag = True
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
                    Css = ''
                    Text = ''
                    BSRegionType = bsrtFormGroup
                    object IWBSRadioButton6: TIWBSRadioButton
                      Left = 8
                      Top = 12
                      Width = 121
                      Height = 21
                      FriendlyName = 'IWBSRadioButton6'
                      ScriptInsideTag = True
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
                      ScriptInsideTag = True
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
                      ScriptInsideTag = True
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
                      ScriptInsideTag = True
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
    Left = 672
    Top = 203
  end
end
