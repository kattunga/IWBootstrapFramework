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
    object IWBSInputForm1: TIWBSInputForm
      Left = 28
      Top = 72
      Width = 493
      Height = 473
      object IWBSButton2: TIWBSButton
        Left = 3
        Top = 68
        Width = 200
        Height = 25
        FriendlyName = 'IWBSButton2'
        ScriptEvents = <
          item
            EventCode.Strings = (
              '$("#IWBSINPUT1").val("pepe");'
              '$("#IWBSINPUT1").change();')
            Event = 'onClick'
          end>
        TabOrder = -1
        Caption = 'IWBSButton2'
      end
      object IWBSInput1: TIWBSInput
        Left = 3
        Top = 24
        Width = 229
        Height = 25
        FriendlyName = 'IWBSInput1'
        TabOrder = -1
        Caption = ''
        Text = ''
      end
      object IWBSButton1: TIWBSButton
        Left = 3
        Top = 108
        Width = 200
        Height = 25
        FriendlyName = 'IWBSButton1'
        TabOrder = -1
        OnAsyncClick = IWBSButton1AsyncClick
        Caption = 'IWBSButton1'
      end
      object IWBSTabControl1: TIWBSTabControl
        Left = 1
        Top = 192
        Width = 505
        Height = 265
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
        ActivePage = 1
        BorderOptions.NumericWidth = 0
        BorderOptions.BorderWidth = cbwNumeric
        BorderOptions.Style = cbsNone
        BorderOptions.Color = clNone
        Color = clWebSILVER
        ZIndex = 1000
        DesignSize = (
          505
          265)
        object IWBSTabControl1Page0: TIWTabPage
          Left = 0
          Top = 20
          Width = 505
          Height = 245
          RenderInvisibleControls = True
          TabOrder = 0
          Title = 'Page0'
          BorderOptions.NumericWidth = 0
          BorderOptions.BorderWidth = cbwNumeric
          BorderOptions.Style = cbsNone
          BorderOptions.Color = clNone
          Color = clWebWHITE
          ExplicitHeight = 329
        end
        object IWBSTabControl1Page1: TIWTabPage
          Left = 0
          Top = 20
          Width = 505
          Height = 245
          RenderInvisibleControls = True
          TabOrder = 1
          Title = 'Page1'
          BorderOptions.NumericWidth = 0
          BorderOptions.BorderWidth = cbwNumeric
          BorderOptions.Style = cbsNone
          BorderOptions.Color = clNone
          Color = clWebWHITE
          ExplicitHeight = 329
        end
      end
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 420
    Top = 24
  end
end
