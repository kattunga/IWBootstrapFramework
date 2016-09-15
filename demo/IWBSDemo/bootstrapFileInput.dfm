object FBootstrapFileInput: TFBootstrapFileInput
  Left = 0
  Top = 0
  Width = 1050
  Height = 1180
  Visible = False
  RenderInvisibleControls = False
  AllowPageAccess = True
  ConnectionMode = cmAny
  Title = 'FishFact Edit Demo'
  OnCreate = IWFormModuleBaseCreate
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
  object IWBSRegion4: TIWBSRegion
    Left = 0
    Top = 0
    Width = 1050
    Height = 1180
    Align = alClient
    Style.Strings = (
      '')
    object IWBSRegion1: TIWBSRegion
      Left = 1
      Top = 78
      Width = 1048
      Height = 1101
      Align = alClient
      BSRegionType = bsrtContainer
      object IWBSRegion2: TIWBSRegion
        Left = 1
        Top = 1
        Width = 1046
        Height = 1099
        Align = alClient
        BSRegionType = bsrtRow
        object IWBSRegion3: TIWBSRegion
          Left = 1
          Top = 1
          Width = 1044
          Height = 1097
          Align = alClient
          BSRegionType = bsrtColumn
          object IWText1: TIWBSText
            Left = 10
            Top = 19
            Width = 1019
            Height = 198
            FriendlyName = 'IWText1'
            Lines.Strings = (
              
                '<h4> An enhanced HTML 5 file input for Bootstrap 3.x with file p' +
                'review, multiple selection, and more features.</h4>'
              '<h5>Select and upload a jpeg file to test it</h5>'
              'Check properties of "File Input" button.<br> '
              'All is implemented in that control using properties:<br>'
              'script,'
              'CustomAsynEvents,'
              'CustomRestEvents.'
              ''
              
                'File size are limited to 48kb for security reasons, if you try t' +
                'o post a bigger file you will be blocked.')
            RawText = True
          end
          object IWBSInput1: TIWBSFile
            Left = 10
            Top = 463
            Width = 121
            Height = 25
            ExtraTagParams.Strings = (
              '')
            CustomAsyncEvents = <
              item
                EventName = 'fileuploaded'
                OnAsyncEvent = IWBSInput1CustomAsyncEvents0AsyncEvent
              end>
            CustomRestEvents = <
              item
                EventName = 'uploadUrl'
                OnRestEvent = IWBSInput1CustomRestEvents0RestEvent
                ParseFileUpload = True
              end>
            FriendlyName = 'IWBSInput1'
            Script.Strings = (
              
                '$("#{%htmlname%}").fileinput({uploadUrl: "{%uploadUrl%}", "maxFi' +
                'leSize": 48, "allowedFileTypes": ["image"]});'
              
                '$("#{%htmlname%}").off("fileuploaded").on("fileuploaded", functi' +
                'on() {{%fileuploaded%}});')
            Multiple = True
          end
          object IWBSRegion5: TIWBSRegion
            Left = 10
            Top = 256
            Width = 1019
            Height = 201
          end
        end
      end
    end
    object IWBSRegion8: TIWBSNavBar
      Left = 1
      Top = 1
      Width = 1048
      Height = 77
      Align = alTop
      BSInverse = True
      object IWBSButton1: TIWBSButton
        Left = 516
        Top = 28
        Width = 218
        Height = 25
        Css = 'navbar-btn navbar-right'
        FriendlyName = 'IWBSButton1'
        OnAsyncClick = IWBSButton1AsyncClick
        BSBlockLevel = False
        BSGlyphicon = 'arrow-left'
        Caption = 'Switch to Standard Demo'
      end
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 54
    Top = 26
  end
end
