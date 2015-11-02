object IWFrame2: TIWFrame2
  Left = 0
  Top = 0
  Width = 576
  Height = 450
  TabOrder = 0
  object IWBSModal1: TIWBSModal
    Left = 8
    Top = 12
    Width = 557
    Height = 401
    RenderInvisibleControls = True
    TabOrder = 0
    BSFade = True
    BSModalVisible = True
    DestroyOnHide = True
    object rgn1: TIWBSRegion
      Left = 48
      Top = 136
      Width = 472
      Height = 233
      BSRegionType = bsrtModalContent
      object btn1: TIWBSButton
        Left = 200
        Top = 160
        Width = 200
        Height = 25
        FriendlyName = 'btn1'
        TabOrder = -1
        OnAsyncClick = btn1AsyncClick
        Caption = 'ShowMessage'
      end
      object inp1: TIWBSMemo
        Left = 200
        Top = 40
        Width = 121
        Height = 101
        FriendlyName = 'inp1'
        TabOrder = -1
        Caption = 'IWBSMemo'
        Text = ''
        PlaceHolder = 'Insert text here'
      end
    end
  end
end
