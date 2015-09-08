object formMain: TformMain
  Left = 0
  Top = 0
  Width = 1410
  Height = 680
  Visible = False
  RenderInvisibleControls = False
  AllowPageAccess = True
  ConnectionMode = cmAny
  Title = 'FishFact Edit Demo'
  OnCreate = IWFormModuleBaseCreate
  OnDestroy = IWAppFormDestroy
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
    Width = 1410
    Height = 680
    RenderInvisibleControls = True
    Align = alClient
    BSRegionType = bsrtContainer
    object IWBSInputForm1: TIWBSInputForm
      Left = 1
      Top = 1
      Width = 1408
      Height = 678
      RenderInvisibleControls = True
      Align = alClient
      BSFormType = bsftHorizontal
      BSFormOptions.CaptionsSize.GridMDSpan = 4
      BSFormOptions.InputsSize.GridMDSpan = 8
      object IWBSRegion2: TIWBSRegion
        Left = 1
        Top = 1
        Width = 1406
        Height = 676
        RenderInvisibleControls = True
        Align = alClient
        BSRegionType = bsrtRow
        object IWBSRegion3: TIWBSRegion
          Left = 20
          Top = 16
          Width = 401
          Height = 585
          RenderInvisibleControls = True
          BSGridOptions.GridMDSpan = 4
          BSRegionType = bsrtColumn
          object IWBSInput1: TIWBSInput
            Left = 20
            Top = 230
            Width = 121
            Height = 21
            Hint = 'Length in Inches'
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            FriendlyName = 'IWBSInput1'
            SubmitOnAsyncEvent = True
            TabOrder = 0
            BSTextAlignment = bstaRight
            Caption = 'Length (inches)'
            DataSource = dsrcMain
            DataField = 'Length_In'
          end
          object IWBSInput2: TIWBSInput
            Left = 20
            Top = 257
            Width = 121
            Height = 21
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            FriendlyName = 'IWBSInput2'
            SubmitOnAsyncEvent = True
            TabOrder = 1
            BSInputType = bsitNumber
            Caption = 'Length (cm)'
            DataSource = dsrcMain
            DataField = 'Length (cm)'
          end
          object IWBSInput3: TIWBSInput
            Left = 20
            Top = 284
            Width = 121
            Height = 21
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            FriendlyName = 'IWBSInput2'
            SubmitOnAsyncEvent = True
            TabOrder = 2
            Caption = 'Species Name'
            DataSource = dsrcMain
            DataField = 'Species Name'
          end
          object IWBSInput4: TIWBSInput
            Left = 20
            Top = 313
            Width = 121
            Height = 21
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            FriendlyName = 'IWBSInput2'
            SubmitOnAsyncEvent = True
            TabOrder = 3
            Caption = 'Common Name'
            DataSource = dsrcMain
            DataField = 'Common_Name'
          end
          object IWBSInput5: TIWBSInput
            Left = 20
            Top = 345
            Width = 121
            Height = 21
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            FriendlyName = 'IWBSInput2'
            SubmitOnAsyncEvent = True
            TabOrder = 4
            Caption = 'Category'
            DataSource = dsrcMain
            DataField = 'Category'
          end
          object IWBSInput6: TIWBSInput
            Left = 20
            Top = 377
            Width = 121
            Height = 21
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            FriendlyName = 'IWBSInput2'
            SubmitOnAsyncEvent = True
            TabOrder = 5
            Caption = 'Species No'
            DataSource = dsrcMain
            DataField = 'Species No'
          end
          object DBMemo1: TIWDBMemo
            Left = 19
            Top = 409
            Width = 281
            Height = 133
            BGColor = clNone
            Editable = False
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            InvisibleBorder = False
            HorizScrollBar = False
            VertScrollBar = True
            Required = True
            TabOrder = 6
            SubmitOnAsyncEvent = True
            AutoEditable = True
            DataField = 'Notes'
            DataSource = dsrcMain
            FriendlyName = 'DBMemo1'
          end
          object IWButton1: TIWButton
            Left = 20
            Top = 557
            Width = 75
            Height = 25
            Caption = 'IWButton1'
            DoSubmitValidation = False
            Color = clBtnFace
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            FriendlyName = 'IWButton1'
            TabOrder = 15
            OnAsyncClick = IWButton1AsyncClick
          end
          object IWBSRegion5: TIWBSRegion
            Left = 20
            Top = 8
            Width = 333
            Height = 42
            RenderInvisibleControls = True
            BSRegionType = bsrtButtonGroup
            object IWBSButton1: TIWBSButton
              Left = 200
              Top = 14
              Width = 37
              Height = 25
              Hint = 'Edit'
              Color = clBtnFace
              Font.Color = clNone
              Font.Size = 10
              Font.Style = []
              FriendlyName = 'IWBSButton1'
              TabOrder = 7
              OnAsyncClick = IWBSButton1AsyncClick
              BSGlyphicon = 'edit'
            end
            object IWBSButton2: TIWBSButton
              Left = 243
              Top = 14
              Width = 37
              Height = 25
              Hint = 'Post'
              Color = clBtnFace
              Font.Color = clNone
              Font.Size = 10
              Font.Style = []
              FriendlyName = 'IWBSButton1'
              TabOrder = 8
              OnAsyncClick = IWBSButton2AsyncClick
              BSGlyphicon = 'check'
            end
            object IWBSButton3: TIWBSButton
              Left = 286
              Top = 14
              Width = 37
              Height = 25
              Hint = 'Cancel'
              Color = clBtnFace
              Font.Color = clNone
              Font.Size = 10
              Font.Style = []
              FriendlyName = 'IWBSButton1'
              TabOrder = 9
              OnAsyncClick = IWBSButton3AsyncClick
              BSGlyphicon = 'remove'
            end
            object IWBSButton4: TIWBSButton
              Left = 3
              Top = 14
              Width = 37
              Height = 25
              Hint = 'First'
              Color = clBtnFace
              Font.Color = clNone
              Font.Size = 10
              Font.Style = []
              FriendlyName = 'IWBSButton1'
              TabOrder = 10
              OnAsyncClick = IWBSButton4AsyncClick
              BSGlyphicon = 'fast-backward'
            end
            object IWBSButton5: TIWBSButton
              Left = 46
              Top = 14
              Width = 37
              Height = 25
              Hint = 'Prior'
              Color = clBtnFace
              Font.Color = clNone
              Font.Size = 10
              Font.Style = []
              FriendlyName = 'IWBSButton1'
              TabOrder = 11
              OnAsyncClick = IWBSButton5AsyncClick
              BSGlyphicon = 'backward'
            end
            object IWBSButton6: TIWBSButton
              Left = 89
              Top = 14
              Width = 37
              Height = 25
              Hint = 'Next'
              Color = clBtnFace
              Font.Color = clNone
              Font.Size = 10
              Font.Style = []
              FriendlyName = 'IWBSButton1'
              TabOrder = 12
              OnAsyncClick = IWBSButton6AsyncClick
              BSGlyphicon = 'forward'
            end
            object IWBSButton7: TIWBSButton
              Left = 132
              Top = 14
              Width = 37
              Height = 25
              Hint = 'Last'
              Color = clBtnFace
              Font.Color = clNone
              Font.Size = 10
              Font.Style = []
              FriendlyName = 'IWBSButton1'
              TabOrder = 13
              OnAsyncClick = IWBSButton7AsyncClick
              BSGlyphicon = 'fast-forward'
            end
          end
          object IWBSRegion6: TIWBSRegion
            Left = 20
            Top = 56
            Width = 317
            Height = 165
            RenderInvisibleControls = True
            BSRegionType = bsrtPageHeader
            object IWDBImage1: TIWDBImage
              Left = 12
              Top = 8
              Width = 281
              Height = 145
              BorderOptions.Width = 0
              TabOrder = -1
              UseSize = True
              FriendlyName = 'IWDBImage1'
              DataField = 'Graphic'
              DataSource = dsrcMain
            end
          end
        end
        object IWBSRegion4: TIWBSRegion
          Left = 436
          Top = 16
          Width = 553
          Height = 585
          RenderInvisibleControls = False
          BSGridOptions.GridMDSpan = 8
          BSRegionType = bsrtColumn
          object dgrdFish: TIWDBGrid
            Left = 1
            Top = 64
            Width = 551
            Height = 520
            Visible = False
            Align = alBottom
            BorderColors.Color = clNone
            BorderColors.Light = clNone
            BorderColors.Dark = clNone
            BGColor = clNone
            BorderSize = 1
            BorderStyle = tfDefault
            CellPadding = 0
            CellSpacing = 0
            Font.Color = clWindowText
            Font.Size = 10
            Font.Style = []
            FrameBuffer = 40
            Lines = tlAll
            OnRenderCell = dgrdFishRenderCell
            UseFrame = True
            UseSize = True
            ScrollToCurrentRow = False
            Columns = <
              item
                Alignment = taLeftJustify
                BGColor = clNone
                DoSubmitValidation = True
                Font.Color = clWindowText
                Font.Size = 10
                Font.Style = []
                Header = False
                Height = '0'
                ShowHint = True
                VAlign = vaMiddle
                Visible = True
                Width = '35%'
                Wrap = False
                RawText = False
                Css = ''
                BlobCharLimit = 0
                CompareHighlight = hcNone
                DataField = 'Common_Name'
                LinkField = 'Species No'
                OnClick = dgrdFishColumns0Click
                OnTitleClick = dgrdFishColumns0TitleClick
                Title.Alignment = taCenter
                Title.BGColor = clNone
                Title.DoSubmitValidation = True
                Title.Font.Color = clWindowText
                Title.Font.Size = 10
                Title.Font.Style = [fsBold]
                Title.Header = True
                Title.Height = '0'
                Title.ShowHint = True
                Title.Text = 'Common Name'
                Title.VAlign = vaMiddle
                Title.Visible = True
                Title.Width = '0'
                Title.Wrap = False
                Title.RawText = True
              end
              item
                Alignment = taLeftJustify
                BGColor = clNone
                DoSubmitValidation = True
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                Header = False
                Height = '0'
                ShowHint = True
                VAlign = vaMiddle
                Visible = True
                Width = '0'
                Wrap = False
                RawText = False
                Css = ''
                BlobCharLimit = 0
                CompareHighlight = hcNone
                Title.Alignment = taCenter
                Title.BGColor = clNone
                Title.DoSubmitValidation = True
                Title.Font.Color = clNone
                Title.Font.Size = 10
                Title.Font.Style = []
                Title.Header = False
                Title.Height = '0'
                Title.ShowHint = True
                Title.Text = 'Type some text'
                Title.VAlign = vaMiddle
                Title.Visible = True
                Title.Width = '0'
                Title.Wrap = False
                Title.RawText = True
              end
              item
                Alignment = taLeftJustify
                BGColor = clNone
                DoSubmitValidation = True
                Font.Color = clWindowText
                Font.Size = 10
                Font.Style = []
                Header = False
                Height = '0'
                ShowHint = True
                VAlign = vaMiddle
                Visible = True
                Width = '25%'
                Wrap = False
                RawText = False
                Css = ''
                BlobCharLimit = 0
                CompareHighlight = hcNone
                DataField = 'Category'
                Title.Alignment = taCenter
                Title.BGColor = clNone
                Title.DoSubmitValidation = True
                Title.Font.Color = clWindowText
                Title.Font.Size = 10
                Title.Font.Style = [fsBold]
                Title.Header = True
                Title.Height = '0'
                Title.ShowHint = True
                Title.Text = 'Category'
                Title.VAlign = vaMiddle
                Title.Visible = True
                Title.Width = '0'
                Title.Wrap = False
                Title.RawText = True
              end
              item
                Alignment = taLeftJustify
                BGColor = clNone
                DoSubmitValidation = True
                Font.Color = clWindowText
                Font.Size = 10
                Font.Style = []
                Header = False
                Height = '0'
                ShowHint = True
                VAlign = vaMiddle
                Visible = True
                Width = '40%'
                Wrap = False
                RawText = False
                Css = ''
                BlobCharLimit = 0
                CompareHighlight = hcNone
                DataField = 'Species Name'
                Title.Alignment = taCenter
                Title.BGColor = clNone
                Title.DoSubmitValidation = True
                Title.Font.Color = clWindowText
                Title.Font.Size = 10
                Title.Font.Style = [fsBold]
                Title.Header = True
                Title.Height = '0'
                Title.ShowHint = True
                Title.Text = 'Species Name'
                Title.VAlign = vaMiddle
                Title.Visible = True
                Title.Width = '0'
                Title.Wrap = False
                Title.RawText = True
              end
              item
                Alignment = taLeftJustify
                BGColor = clNone
                DoSubmitValidation = True
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                Header = False
                Height = '0'
                ShowHint = True
                VAlign = vaMiddle
                Visible = True
                Width = '0'
                Wrap = False
                RawText = False
                Css = ''
                BlobCharLimit = 0
                CompareHighlight = hcNone
                Title.Alignment = taCenter
                Title.BGColor = clNone
                Title.DoSubmitValidation = True
                Title.Font.Color = clNone
                Title.Font.Size = 10
                Title.Font.Style = []
                Title.Header = False
                Title.Height = '0'
                Title.ShowHint = True
                Title.Text = 'Graphic'
                Title.VAlign = vaMiddle
                Title.Visible = True
                Title.Width = '0'
                Title.Wrap = False
                Title.RawText = True
              end>
            DataSource = dsrcMain
            FooterRowCount = 1
            FriendlyName = 'dgrdFish'
            FromStart = True
            HighlightColor = clHighlightText
            HighlightRows = False
            Options = [dgShowTitles]
            RefreshMode = rmAutomatic
            RowLimit = 0
            RollOver = False
            RowClick = False
            RollOverColor = clHighlight
            RowHeaderColor = clNone
            RowAlternateColor = clNone
            RowCurrentColor = clNone
            TabOrder = -1
          end
          object IWLabelUpdate: TIWLabel
            Left = 13
            Top = 3
            Width = 33
            Height = 16
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            HasTabOrder = False
            FriendlyName = 'IWLabelUpdate'
            Caption = 'HERE'
          end
          object IWDBNavigator1: TIWDBNavigator
            Left = 13
            Top = 25
            Width = 300
            Height = 28
            Confirmations.Delete = 'Are you sure you want to delete this record?'
            Confirmations.Post = 'Are you sure you want to update this record?'
            Confirmations.Cancel = 'Are you sure you want to cancel your changes to this record?'
            DataSource = dsrcMain
            FriendlyName = 'IWDBNavigator1'
            ImageHeight = 24
            ImageWidth = 24
            VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh]
            Orientation = orHorizontal
          end
        end
      end
    end
  end
  object dsrcMain: TDataSource
    DataSet = ClientDataSet1
    Left = 492
    Top = 112
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    IndexName = 'DEFAULT_ORDER'
    Params = <>
    Left = 420
    Top = 92
    object ClientDataSet1SpeciesNo: TFloatField
      FieldName = 'Species No'
      Origin = 'DBDEMOS."biolife.DB".Species No'
    end
    object ClientDataSet1Notes: TMemoField
      FieldName = 'Notes'
      Origin = 'DBDEMOS."biolife.DB".Notes'
      BlobType = ftMemo
      Size = 50
    end
    object ClientDataSet1Length_In: TFloatField
      FieldName = 'Length_In'
      Origin = 'DBDEMOS."biolife.DB".Length_In'
    end
    object ClientDataSet1Lengthcm: TFloatField
      FieldName = 'Length (cm)'
      Origin = 'DBDEMOS."biolife.DB".Length (cm)'
    end
    object ClientDataSet1SpeciesName: TStringField
      FieldName = 'Species Name'
      Origin = 'DBDEMOS."biolife.DB".Species Name'
      Size = 40
    end
    object ClientDataSet1Common_Name: TStringField
      FieldName = 'Common_Name'
      Origin = 'DBDEMOS."biolife.DB".Common_Name'
      Size = 30
    end
    object ClientDataSet1Category: TStringField
      FieldName = 'Category'
      Origin = 'DBDEMOS."biolife.DB".Category'
      Size = 15
    end
    object ClientDataSet1Graphic: TGraphicField
      FieldName = 'Graphic'
      Origin = 'DBDEMOS."biolife.DB".Graphic'
      BlobType = ftGraphic
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 366
    Top = 86
  end
end
