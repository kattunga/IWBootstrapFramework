object IWForm4: TIWForm4
  Left = 0
  Top = 0
  Width = 823
  Height = 614
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
  object IWBSRegion1: TIWBSRegion
    Left = 0
    Top = 0
    Width = 823
    Height = 614
    Align = alClient
    Text = ''
    BSRegionType = bsrtContainer
    object IWBSMemoHtml1: TIWBSMemoHtml
      Left = 24
      Top = 244
      Width = 697
      Height = 237
      FriendlyName = 'IWBSMemoHtml1'
      Caption = ''
      Text = ''
    end
    object IWBSMemo1: TIWBSMemo
      Left = 24
      Top = 83
      Width = 697
      Height = 101
      FriendlyName = 'IWBSMemo1'
      Caption = ''
      Text = 
        '<p>This text is normal.</p>'#13#10'<p><strong>This text is strong.</st' +
        'rong></p>'#13#10
      Lines.Strings = (
        '<p>This text is normal.</p>'
        '<p><strong>This text is strong.</strong></p>')
    end
    object IWBSNavBar1: TIWBSNavBar
      Left = 1
      Top = 1
      Width = 821
      Height = 76
      Align = alTop
      Text = ''
      object IWBSList1: TIWBSList
        Left = 3
        Top = 21
        Width = 786
        Height = 52
        Text = ''
        BSListType = bsltNav
        object IWBSButton1: TIWBSButton
          Left = 20
          Top = 12
          Width = 200
          Height = 25
          FriendlyName = 'IWBSButton1'
          OnAsyncClick = IWBSButton1AsyncClick
          Caption = 'Set content'
        end
        object IWBSButton2: TIWBSButton
          Left = 256
          Top = 12
          Width = 200
          Height = 25
          FriendlyName = 'IWBSButton2'
          OnAsyncClick = IWBSButton2AsyncClick
          Caption = 'Get Content'
        end
      end
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 689
    Top = 105
  end
end
