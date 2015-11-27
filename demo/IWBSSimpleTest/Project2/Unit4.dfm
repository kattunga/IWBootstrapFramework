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
  object IWBSRegion3: TIWBSRegion
    Left = 0
    Top = 0
    Width = 555
    Height = 593
    Align = alClient
    BSRegionType = bsrtContainer
    object IWBSButton1: TIWBSButton
      Left = 20
      Top = 115
      Width = 200
      Height = 25
      FriendlyName = 'IWBSButton1'
      TabOrder = -1
      OnAsyncClick = IWBSButton1AsyncClick
      BSBlockLevel = False
      Caption = 'IWBSButton1'
    end
    object IWBSButton3: TIWBSButton
      Left = 284
      Top = 115
      Width = 200
      Height = 25
      FriendlyName = 'IWBSButton3'
      TabOrder = -1
      OnAsyncClick = IWBSButton3AsyncClick
      BSBlockLevel = False
      Caption = 'IWBSButton3'
    end
    object IWBSLabel1: TIWBSLabel
      Left = 20
      Top = 152
      Width = 200
      Height = 25
      FriendlyName = 'IWBSLabel1'
      TabOrder = -1
      Caption = 'IWBSLabel1'
    end
    object IWBSNavBar1: TIWBSNavBar
      Left = 20
      Top = 16
      Width = 485
      Height = 93
      object IWBSUnorderedList1: TIWBSUnorderedList
        Left = 15
        Top = 23
        Width = 438
        Height = 60
        object IWBSDropDown1: TIWBSDropDown
          Left = 17
          Top = 27
          Width = 173
          Height = 25
          FriendlyName = 'IWBSDropDown1'
          TabOrder = -1
          BSBlockLevel = False
          Caption = 'IWBSDropDown1'
          DropDownItems = <
            item
              Caption = 'item 1'
            end
            item
              Caption = 'pepe'
              DropDownItems = <
                item
                  Caption = 'pepe1'
                end
                item
                  Caption = 'pepe2'
                end
                item
                  Caption = 'pepe3'
                end>
            end
            item
              Caption = 'pepe2'
              DropDownItems = <
                item
                  Caption = 'item a'
                end
                item
                  Caption = 'item b'
                  DropDownItems = <
                    item
                      Caption = 'aa'
                    end
                    item
                      Caption = 'bb'
                    end
                    item
                      Caption = 'cc'
                    end>
                end
                item
                  Caption = 'item c'
                end>
            end>
        end
        object IWBSDropDown3: TIWBSDropDown
          Left = 196
          Top = 27
          Width = 169
          Height = 25
          FriendlyName = 'IWBSDropDown1'
          TabOrder = -1
          BSBlockLevel = False
          Caption = 'IWBSDropDown1'
          DropDownItems = <
            item
              Caption = 'item 1'
            end
            item
              Caption = 'pepe'
              DropDownItems = <
                item
                  Caption = 'pepe1'
                end
                item
                  Caption = 'pepe2'
                end
                item
                  Caption = 'pepe3'
                end>
            end
            item
              Caption = 'pepe2'
              DropDownItems = <
                item
                  Caption = 'item a'
                end
                item
                  Caption = 'item b'
                end
                item
                  Caption = 'item c'
                end>
            end>
        end
      end
    end
    object IWBSRegion1: TIWBSRegion
      Left = 24
      Top = 456
      Width = 481
      Height = 73
      BSRegionType = bsrtWell
      Collapse = True
      object IWBSDropDown2: TIWBSDropDown
        Left = 24
        Top = 24
        Width = 169
        Height = 25
        Css = 'btn-default'
        FriendlyName = 'IWBSDropDown1'
        TabOrder = -1
        BSBlockLevel = False
        Caption = 'IWBSDropDown1'
        DropDownItems = <
          item
            Caption = 'pepe'
            DropDownItems = <
              item
                Caption = 'pepe1'
              end
              item
                Caption = 'pepe2'
              end
              item
                Caption = 'pepe3'
              end>
          end>
      end
    end
    object IWBSInputGroup1: TIWBSInputGroup
      Left = 24
      Top = 390
      Width = 397
      Height = 60
      Caption = ''
      object IWBSInput1: TIWBSInput
        Left = 24
        Top = 20
        Width = 121
        Height = 25
        FriendlyName = 'IWBSInput1'
        TabOrder = -1
        Caption = ''
        Text = ''
      end
      object IWBSDropDown4: TIWBSDropDown
        Left = 164
        Top = 20
        Width = 169
        Height = 25
        Css = 'btn-default'
        FriendlyName = 'IWBSDropDown1'
        TabOrder = -1
        BSBlockLevel = False
        Caption = 'IWBSDropDown1'
        DropDownItems = <
          item
            Caption = 'pepe'
            DropDownItems = <
              item
                Caption = 'pepe1'
              end
              item
                Caption = 'pepe2'
              end
              item
                Caption = 'pepe3'
              end>
          end>
      end
    end
    object IWBSTabControl1: TIWBSTabControl
      Left = 20
      Top = 200
      Width = 493
      Height = 161
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
      BorderOptions.NumericWidth = 0
      BorderOptions.BorderWidth = cbwNumeric
      BorderOptions.Style = cbsNone
      BorderOptions.Color = clNone
      Color = clWebSILVER
      ZIndex = 1000
      DesignSize = (
        493
        161)
      object IWBSTabControl1Page1: TIWTabPage
        Left = 0
        Top = 20
        Width = 493
        Height = 141
        RenderInvisibleControls = True
        TabOrder = 1
        Title = 'Page1'
        BorderOptions.NumericWidth = 0
        BorderOptions.BorderWidth = cbwNumeric
        BorderOptions.Style = cbsNone
        BorderOptions.Color = clNone
        Color = clWebWHITE
        ExplicitHeight = 185
        object IWBSInput2: TIWBSInput
          Left = 72
          Top = 24
          Width = 121
          Height = 25
          FriendlyName = 'IWBSInput2'
          TabOrder = -1
          Caption = ''
          Text = ''
        end
      end
      object IWBSTabControl1Page2: TIWTabPage
        Left = 0
        Top = 20
        Width = 493
        Height = 141
        RenderInvisibleControls = True
        TabOrder = 2
        Title = 'Page2'
        BorderOptions.NumericWidth = 0
        BorderOptions.BorderWidth = cbwNumeric
        BorderOptions.Style = cbsNone
        BorderOptions.Color = clNone
        Color = clWebWHITE
        ExplicitHeight = 185
        object IWBSButton2: TIWBSButton
          Left = 80
          Top = 68
          Width = 200
          Height = 25
          FriendlyName = 'IWBSButton2'
          TabOrder = -1
          BSBlockLevel = False
          Caption = 'IWBSButton2'
        end
      end
      object IWBSTabControl1Page0: TIWTabPage
        Left = 0
        Top = 20
        Width = 493
        Height = 141
        RenderInvisibleControls = True
        TabOrder = 0
        Title = 'Page0'
        BorderOptions.NumericWidth = 0
        BorderOptions.BorderWidth = cbwNumeric
        BorderOptions.Style = cbsNone
        BorderOptions.Color = clNone
        Color = clWebWHITE
        ExplicitHeight = 185
        object IWBSInput3: TIWBSInput
          Left = 56
          Top = 48
          Width = 121
          Height = 25
          FriendlyName = 'IWBSInput3'
          TabOrder = -1
          Caption = ''
          Text = ''
        end
      end
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 516
    Top = 24
  end
end
