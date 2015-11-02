object IWForm2: TIWForm2
  Left = 0
  Top = 0
  Width = 1084
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
          ZIndex = 1000
          BSTabOptions.Pills = True
          DesignSize = (
            1078
            1533)
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
                object chkContFluid: TIWCheckBox
                  Left = 15
                  Top = 41
                  Width = 121
                  Height = 21
                  Css = 'iwcheckbox'
                  ShowHint = False
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
                object chkTabsJust: TIWCheckBox
                  Left = 15
                  Top = 76
                  Width = 121
                  Height = 21
                  Css = 'iwcheckbox'
                  Caption = 'Tabs Justified'
                  Editable = True
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  SubmitOnAsyncEvent = True
                  Style = stNormal
                  TabOrder = 11
                  Checked = False
                  FriendlyName = 'chkTabsJust'
                end
                object chkTabsStacked: TIWCheckBox
                  Left = 15
                  Top = 103
                  Width = 121
                  Height = 21
                  Css = 'iwcheckbox'
                  Caption = 'Tabs Stacked'
                  Editable = True
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  SubmitOnAsyncEvent = True
                  Style = stNormal
                  TabOrder = 12
                  Checked = False
                  FriendlyName = 'chkTabsStacked'
                end
                object chkTabsPills: TIWCheckBox
                  Left = 15
                  Top = 134
                  Width = 121
                  Height = 21
                  Css = 'iwcheckbox'
                  Caption = 'Tabs Pills'
                  Editable = True
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  SubmitOnAsyncEvent = True
                  Style = stNormal
                  TabOrder = 13
                  Checked = True
                  FriendlyName = 'chkTabsPills'
                end
                object chkTabsFade: TIWCheckBox
                  Left = 16
                  Top = 161
                  Width = 121
                  Height = 21
                  Css = 'iwcheckbox'
                  Caption = 'Tabs Fade'
                  Editable = True
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  SubmitOnAsyncEvent = True
                  Style = stNormal
                  TabOrder = 14
                  Checked = False
                  FriendlyName = 'chkTabsFade'
                end
                object IWBSButton30: TIWButton
                  Left = 17
                  Top = 229
                  Width = 184
                  Height = 25
                  Css = 'btn'
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  Caption = 'Apply settings'
                  Color = clBtnFace
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  FriendlyName = 'IWBSButton20aaaaaa'
                  TabOrder = 9
                  OnClick = IWBSButton30Click
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
            Title = 'Functionality'
            BorderOptions.NumericWidth = 0
            BorderOptions.BorderWidth = cbwNumeric
            BorderOptions.Style = cbsNone
            BorderOptions.Color = clNone
            Color = clWebWHITE
            object IWBSRegion9: TIWBSRegion
              Left = 15
              Top = 14
              Width = 685
              Height = 89
              RenderInvisibleControls = True
              BSRegionType = bsrtWell
              object IWButton1: TIWButton
                Left = 16
                Top = 14
                Width = 149
                Height = 25
                Css = 'btn btn-success'
                Caption = 'Toggle Visibility'
                Color = clBtnFace
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWButton1'
                TabOrder = 21
                OnAsyncClick = IWButton1AsyncClick
              end
              object IWEdit1: TIWEdit
                Left = 16
                Top = 53
                Width = 249
                Height = 21
                Css = 'form-control'
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
                FriendlyName = 'IWEdit1'
                SubmitOnAsyncEvent = True
                TabOrder = 22
                Text = 'IWEdit1'
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
                  object IWBSButton27: TIWButton
                    Left = 16
                    Top = 23
                    Width = 389
                    Height = 25
                    Css = 'btn btn-default'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    LockOnAsyncEvents = [aeClick]
                    Caption = 'Dinamically create modal dialog from TIWFrame'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 15
                    OnAsyncClick = IWBSButton27AsyncClick
                  end
                end
                object IWBSRegion26: TIWBSRegion
                  Left = 27
                  Top = 85
                  Width = 538
                  Height = 60
                  BSRegionType = bsrtWell
                  object IWBSButton28: TIWButton
                    Left = 12
                    Top = 24
                    Width = 393
                    Height = 25
                    Css = 'btn btn-default'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    LockOnAsyncEvents = [aeClick]
                    Caption = 'Dinamically create dialog from code'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 16
                    OnAsyncClick = IWBSButton28AsyncClick
                  end
                end
                object IWBSRegion13: TIWBSRegion
                  Left = 27
                  Top = 163
                  Width = 538
                  Height = 91
                  BSRegionType = bsrtWell
                  object IWBSInput23: TIWEdit
                    Left = 12
                    Top = 47
                    Width = 393
                    Height = 21
                    Css = 'form-control'
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSInput6'
                    SubmitOnAsyncEvent = True
                    TabOrder = 18
                  end
                  object IWBSButton31: TIWButton
                    Left = 12
                    Top = 16
                    Width = 393
                    Height = 25
                    Css = 'btn btn-default'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    LockOnAsyncEvents = [aeClick]
                    Caption = 'Dinamically create advanced dialog from code'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 17
                    OnAsyncClick = IWBSButton31AsyncClick
                  end
                end
                object IWBSRegion17: TIWBSRegion
                  Left = 27
                  Top = 260
                  Width = 538
                  Height = 66
                  BSRegionType = bsrtWell
                  object IWBSButton26: TIWButton
                    Left = 12
                    Top = 13
                    Width = 393
                    Height = 25
                    Css = 'btn btn-default'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Dinamically create frame with inputs'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 19
                    OnAsyncClick = IWBSButton26AsyncClick
                  end
                end
                object IWBSRegion31: TIWBSRegion
                  Left = 27
                  Top = 616
                  Width = 538
                  Height = 60
                  BSRegionType = bsrtWell
                  object IWBSButton34: TIWButton
                    Left = 9
                    Top = 20
                    Width = 393
                    Height = 25
                    Css = 'btn btn-default'
                    RenderSize = False
                    StyleRenderOptions.RenderSize = False
                    Caption = 'Raise an exception'
                    Color = clBtnFace
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSButton26'
                    TabOrder = 20
                    OnAsyncClick = IWBSButton34AsyncClick
                  end
                end
              end
            end
          end
          object IWTabControl21Page4: TIWTabPage
            Left = 0
            Top = 20
            Width = 1078
            Height = 1513
            RenderInvisibleControls = True
            TabOrder = 3
            Title = 'Other Controls'
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
              object IWImageFile1: TIWImageFile
                Left = 13
                Top = 14
                Width = 485
                Height = 238
                Css = 'img-responsive'
                RenderSize = False
                StyleRenderOptions.RenderSize = False
                BorderOptions.Width = 0
                TabOrder = -1
                UseSize = False
                Cacheable = True
                FriendlyName = 'IWImageFile1'
                ImageFile.URL = 'http://img.gawkerassets.com/img/198haup5wt5g9jpg/original.jpg'
              end
              object IWFileUploader1: TIWFileUploader
                Left = 13
                Top = 437
                Width = 400
                Height = 60
                TabOrder = 30
                TextStrings.DragText = 'Drop files here to upload'
                TextStrings.UploadButtonText = 'Upload a Text file'
                TextStrings.CancelButtonText = 'Cancel'
                TextStrings.UploadErrorText = 'Upload failed'
                TextStrings.MultipleFileDropNotAllowedText = 'You may only drop a single file'
                TextStrings.OfTotalText = 'of'
                TextStrings.RemoveButtonText = 'Remove'
                TextStrings.TypeErrorText = 
                  '{file} has an invalid extension. Only {extensions} files are all' +
                  'owed.'
                TextStrings.SizeErrorText = '{file} is too large, maximum file size is {sizeLimit}.'
                TextStrings.MinSizeErrorText = '{file} is too small, minimum file size is {minSizeLimit}.'
                TextStrings.EmptyErrorText = '{file} is empty, please select files again without it.'
                TextStrings.NoFilesErrorText = 'No files to upload.'
                TextStrings.OnLeaveWarningText = 
                  'The files are being uploaded, if you leave now the upload will b' +
                  'e cancelled.'
                Style.ButtonOptions.Alignment = taCenter
                Style.ButtonOptions.Font.Color = clWebWHITE
                Style.ButtonOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
                Style.ButtonOptions.Font.Size = 10
                Style.ButtonOptions.Font.Style = []
                Style.ButtonOptions.FromColor = clWebMAROON
                Style.ButtonOptions.ToColor = clWebMAROON
                Style.ButtonOptions.Height = 30
                Style.ButtonOptions.Width = 200
                Style.ButtonHoverOptions.Alignment = taCenter
                Style.ButtonHoverOptions.Font.Color = clWebWHITE
                Style.ButtonHoverOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
                Style.ButtonHoverOptions.Font.Size = 10
                Style.ButtonHoverOptions.Font.Style = []
                Style.ButtonHoverOptions.FromColor = 214
                Style.ButtonHoverOptions.ToColor = 214
                Style.ListOptions.Alignment = taLeftJustify
                Style.ListOptions.Font.Color = clWebBLACK
                Style.ListOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
                Style.ListOptions.Font.Size = 10
                Style.ListOptions.Font.Style = []
                Style.ListOptions.FromColor = clWebGOLD
                Style.ListOptions.ToColor = clWebGOLD
                Style.ListOptions.Height = 30
                Style.ListOptions.Width = 0
                Style.ListSuccessOptions.Alignment = taLeftJustify
                Style.ListSuccessOptions.Font.Color = clWebWHITE
                Style.ListSuccessOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
                Style.ListSuccessOptions.Font.Size = 10
                Style.ListSuccessOptions.Font.Style = []
                Style.ListSuccessOptions.FromColor = clWebFORESTGREEN
                Style.ListSuccessOptions.ToColor = clWebFORESTGREEN
                Style.ListErrorOptions.Alignment = taLeftJustify
                Style.ListErrorOptions.Font.Color = clWebWHITE
                Style.ListErrorOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
                Style.ListErrorOptions.Font.Size = 10
                Style.ListErrorOptions.Font.Style = []
                Style.ListErrorOptions.FromColor = clWebRED
                Style.ListErrorOptions.ToColor = clWebRED
                Style.DropAreaOptions.Alignment = taCenter
                Style.DropAreaOptions.Font.Color = clWebWHITE
                Style.DropAreaOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
                Style.DropAreaOptions.Font.Size = 10
                Style.DropAreaOptions.Font.Style = []
                Style.DropAreaOptions.FromColor = clWebDARKORANGE
                Style.DropAreaOptions.ToColor = clWebDARKORANGE
                Style.DropAreaOptions.Height = 60
                Style.DropAreaOptions.Width = 0
                Style.DropAreaActiveOptions.Alignment = taCenter
                Style.DropAreaActiveOptions.Font.Color = clWebWHITE
                Style.DropAreaActiveOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
                Style.DropAreaActiveOptions.Font.Size = 10
                Style.DropAreaActiveOptions.Font.Style = []
                Style.DropAreaActiveOptions.FromColor = clWebLIMEGREEN
                Style.DropAreaActiveOptions.ToColor = clWebLIMEGREEN
                Style.DropAreaActiveOptions.Height = 60
                Style.DropAreaActiveOptions.Width = 0
                CssClasses.Strings = (
                  'button='
                  'button-hover='
                  'drop-area='
                  'drop-area-active='
                  'drop-area-disabled='
                  'list='
                  'upload-spinner='
                  'progress-bar='
                  'upload-file='
                  'upload-size='
                  'upload-listItem='
                  'upload-cancel='
                  'upload-success='
                  'upload-fail='
                  'success-icon='
                  'fail-icon=')
                OnAsyncUploadCompleted = IWFileUploader1AsyncUploadCompleted
                OnAsyncUploadSuccess = IWFileUploader1AsyncUploadSuccess
                FriendlyName = 'IWFileUploader1'
                Font.Color = clNone
                Font.Size = 10
                Font.Style = []
              end
              object IWBSFormControl8: TIWBSFormControl
                Left = 13
                Top = 258
                Width = 527
                Height = 161
                Caption = ''
                object IWMemo1: TIWMemo
                  Left = 13
                  Top = 24
                  Width = 485
                  Height = 121
                  Css = 'form-control'
                  BGColor = clNone
                  Editable = True
                  Font.Color = clNone
                  Font.Size = 10
                  Font.Style = []
                  InvisibleBorder = False
                  HorizScrollBar = False
                  VertScrollBar = True
                  Required = False
                  TabOrder = 31
                  SubmitOnAsyncEvent = True
                  FriendlyName = 'IWMemo1'
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
                  Left = 12
                  Top = 28
                  Width = 245
                  Height = 237
                  BSRegionType = bsrtWell
                  object IWBSInputForm3: TIWBSInputForm
                    Left = 11
                    Top = 26
                    Width = 217
                    Height = 194
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
                    object IWBSButton35: TIWButton
                      Left = 12
                      Top = 144
                      Width = 127
                      Height = 25
                      Css = 'btn btn-default'
                      RenderSize = False
                      StyleRenderOptions.RenderSize = False
                      Caption = 'Apply change'
                      Color = clBtnFace
                      Font.Color = clNone
                      Font.Size = 10
                      Font.Style = []
                      FriendlyName = 'IWBSButton20'
                      TabOrder = 0
                      OnClick = IWBSButton35Click
                    end
                    object rbFormVertical: TIWRadioButton
                      Left = 12
                      Top = 43
                      Width = 121
                      Height = 21
                      Css = 'iwradio'
                      Caption = 'Form Vertical'
                      Font.Color = clNone
                      Font.Size = 10
                      Font.Style = []
                      Checked = True
                      Group = 'formlayout'
                      Value = 'rbFormVertical'
                      FriendlyName = 'rbFormVertical'
                      SubmitOnAsyncEvent = True
                    end
                    object rbFormHorizontal: TIWRadioButton
                      Left = 12
                      Top = 70
                      Width = 121
                      Height = 21
                      Css = 'iwradio'
                      Caption = 'Form Horizontal'
                      Font.Color = clNone
                      Font.Size = 10
                      Font.Style = []
                      Group = 'formlayout'
                      Value = 'rbFormVertical'
                      FriendlyName = 'rbFormVertical'
                      SubmitOnAsyncEvent = True
                    end
                    object rbFormInline: TIWRadioButton
                      Left = 12
                      Top = 101
                      Width = 121
                      Height = 21
                      Css = 'iwradio'
                      Caption = 'Form Inline'
                      Font.Color = clNone
                      Font.Size = 10
                      Font.Style = []
                      Group = 'formlayout'
                      Value = 'rbFormVertical'
                      FriendlyName = 'rbFormVertical'
                      SubmitOnAsyncEvent = True
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
                object IWBSButton20: TIWBSButton
                  Left = 12
                  Top = 4
                  Width = 341
                  Height = 25
                  RenderSize = False
                  StyleRenderOptions.RenderSize = False
                  FriendlyName = 'IWBSButton20'
                  TabOrder = -1
                  OnAsyncClick = IWBSButton20AsyncClick
                  BSGlyphicon = 'check'
                  Caption = 'Ajax Click (see input values in memo)'
                end
                object IWBSFormControl1: TIWBSFormControl
                  Left = 12
                  Top = 35
                  Width = 341
                  Height = 45
                  Caption = 'Standard Edit'
                  object IWBSInput1: TIWEdit
                    Left = 10
                    Top = 12
                    Width = 201
                    Height = 25
                    ExtraTagParams.Strings = (
                      '')
                    Css = 'form-control'
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSInput1'
                    SubmitOnAsyncEvent = True
                    TabOrder = 23
                  end
                end
                object IWBSFormControl2: TIWBSFormControl
                  Left = 12
                  Top = 86
                  Width = 341
                  Height = 45
                  Caption = 'Standard Edit password'
                  object IWBSInput3: TIWEdit
                    Left = 11
                    Top = 12
                    Width = 201
                    Height = 25
                    Css = 'form-control'
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSInput3'
                    SubmitOnAsyncEvent = True
                    TabOrder = 24
                    PasswordPrompt = True
                  end
                end
                object IWBSFormControl3: TIWBSFormControl
                  Left = 12
                  Top = 139
                  Width = 341
                  Height = 45
                  Caption = 'Static Text'
                  object IWBSInput13: TIWEdit
                    Left = 10
                    Top = 12
                    Width = 201
                    Height = 25
                    Css = 'form-control'
                    Editable = False
                    NonEditableAsLabel = True
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    FriendlyName = 'IWBSInput2'
                    SubmitOnAsyncEvent = True
                    TabOrder = 25
                    Text = 'This is a static text'
                  end
                end
                object IWBSFormControl4: TIWBSFormControl
                  Left = 12
                  Top = 227
                  Width = 341
                  Height = 184
                  Caption = 'This is a Memo'
                  object IWBSMemo2: TIWMemo
                    Left = 12
                    Top = 20
                    Width = 313
                    Height = 153
                    Css = 'form-control'
                    BGColor = clNone
                    Editable = True
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    InvisibleBorder = False
                    HorizScrollBar = False
                    VertScrollBar = True
                    Required = False
                    TabOrder = 26
                    SubmitOnAsyncEvent = True
                    FriendlyName = 'IWBSMemo2'
                  end
                end
                object IWBSFormControl5: TIWBSFormControl
                  Left = 12
                  Top = 417
                  Width = 341
                  Height = 60
                  Caption = ''
                  object IWBSListbox2: TIWComboBox
                    Left = 12
                    Top = 19
                    Width = 291
                    Height = 29
                    Css = 'form-control'
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    RequireSelection = False
                    TabOrder = 27
                    ItemIndex = -1
                    Items.Strings = (
                      'item 1'
                      'item 2'
                      'item 3'
                      'item 4')
                    FriendlyName = 'IWBSListbox1'
                    NoSelectionText = '-- No Selection --'
                  end
                end
                object IWBSFormControl6: TIWBSFormControl
                  Left = 12
                  Top = 490
                  Width = 341
                  Height = 119
                  Caption = ''
                  object IWBSListbox3: TIWListbox
                    Left = 9
                    Top = 21
                    Width = 291
                    Height = 77
                    Css = 'form-control'
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    TabOrder = 28
                    MaxItems = 0
                    FriendlyName = 'IWBSListbox1'
                    Items.Strings = (
                      'item 1'
                      'item 2'
                      'item 3'
                      'item 4')
                    NoSelectionText = '-- No Selection --'
                  end
                end
                object IWBSFormControl7: TIWBSFormControl
                  Left = 12
                  Top = 190
                  Width = 341
                  Height = 31
                  Caption = ''
                  object IWBSCheckBox1: TIWCheckBox
                    Left = 10
                    Top = 6
                    Width = 201
                    Height = 25
                    Caption = 'IWBSCheckBox1'
                    Editable = True
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    SubmitOnAsyncEvent = True
                    Style = stNormal
                    TabOrder = 29
                    Checked = False
                    FriendlyName = 'IWBSCheckBox1'
                  end
                end
                object IWBSFormControl12: TIWBSFormControl
                  Left = 6
                  Top = 615
                  Width = 347
                  Height = 134
                  Caption = 'This are standard radio buttons'
                  object IWRadioButton1: TIWRadioButton
                    Left = 7
                    Top = 12
                    Width = 121
                    Height = 21
                    Css = 'iwradio'
                    Caption = 'Radio Button 1'
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    Checked = True
                    Group = 'group1'
                    Value = 'IWBSRadioButton6'
                    FriendlyName = 'IWBSRadioButton6'
                    SubmitOnAsyncEvent = True
                  end
                  object IWRadioButton2: TIWRadioButton
                    Left = 8
                    Top = 39
                    Width = 121
                    Height = 21
                    Css = 'iwradio'
                    Caption = 'Radio Button 2'
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    Group = 'group1'
                    Value = 'IWBSRadioButton7'
                    FriendlyName = 'IWBSRadioButton6'
                    SubmitOnAsyncEvent = True
                  end
                  object IWRadioButton3: TIWRadioButton
                    Left = 8
                    Top = 66
                    Width = 121
                    Height = 21
                    Css = 'iwradio'
                    Caption = 'Radio Button 3'
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    Group = 'group1'
                    Value = 'IWBSRadioButton8'
                    FriendlyName = 'IWBSRadioButton6'
                    SubmitOnAsyncEvent = True
                  end
                  object IWRadioButton4: TIWRadioButton
                    Left = 8
                    Top = 93
                    Width = 121
                    Height = 21
                    Css = 'iwradio'
                    Caption = 'Radio Button 4'
                    Font.Color = clNone
                    Font.Size = 10
                    Font.Style = []
                    Group = 'group1'
                    Value = 'IWBSRadioButton9'
                    FriendlyName = 'IWBSRadioButton6'
                    SubmitOnAsyncEvent = True
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
        object IWBSButton36: TIWButton
          Left = 617
          Top = 15
          Width = 242
          Height = 25
          Css = 'btn btn-default pull-right'
          Caption = 'Switch to Data Aware Demo'
          Color = clBtnFace
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'IWBSButton1'
          TabOrder = 8
          OnClick = IWBSButton36Click
        end
        object IWText3: TIWText
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
          FriendlyName = 'IWText3'
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
