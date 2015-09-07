unit IWBSLayoutMgr;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Vcl.Controls,
  IWContainerLayout, IWRenderContext, IWBaseHTMLInterfaces, IWBaseRenderContext, IW.Common.RenderStream, IWHTMLTag,
  IWBSCommon, IWBSRegionCommon;

type

  TIWBSPageOption = (bslyNoConflictButton, bslyEnablePolyfill);

  TIWBSPageOptions = set of TIWBSPageOption;

  TIWBSLayoutMgr = class(TIWContainerLayout)
  private
    FFormType: TIWBSFormType;
    FPageOptions: TIWBSPageOptions;
  protected
    procedure InitControl; override;
  public
    constructor Create(AOnwer: TComponent); override;
    procedure ProcessControl(AContainerContext: TIWContainerContext; APageContext: TIWBaseHTMLPageContext; AControl: IIWBaseHTMLComponent); override;
    procedure ProcessForm(ABuffer, ATmpBuf: TIWRenderStream; APage: TIWBasePageContext);
    procedure Process(ABuffer: TIWRenderStream; AContainerContext: TIWContainerContext; aPage: TIWBasePageContext); override;
  published
    property BSFormType: TIWBSFormType read FFormType write FFormType default bsftNoForm;
    property BSPageOptions: TIWBSPageOptions read FPageOptions write FPageOptions default [bslyEnablePolyfill];
  end;

var
  IWBSLibraryPath: string = '/iwbs';
  IWBSRefreshCacheParam: string;
  IWBSjqlibversion: string = '1.11.3';
  IWBSbslibversion: string = '3.3.5';

implementation

uses
  IWBaseForm, IWGlobal, IWHTML40Interfaces, IWTypes, IWHTMLContainer, IWBaseInterfaces, IWBaseControl, IWLists,
  IWRegion, IW.Common.Strings,
  IWBSRegion;

constructor TIWBSLayoutMgr.Create(AOnwer: TComponent);
begin
  inherited;
  FFormType := bsftNoForm;
  FPageOptions := [bslyEnablePolyfill];
end;

procedure TIWBSLayoutMgr.InitControl;
begin
  inherited;
  SetAllowFrames(true);
  SetLayoutType(ltFlow);
end;

procedure TIWBSLayoutMgr.ProcessForm(ABuffer, ATmpBuf: TIWRenderStream; APage: TIWBasePageContext);
var
  LPageContext: TIWPageContext40;
  LTerminated: Boolean;
  FLibPath: string;
begin

  // get library path
  if AnsiEndsStr('/', gSC.URLBase) then
    FLibPath := Copy(gSC.URLBase, 1, Length(gSC.URLBase)-1)
  else
    FLibPath := gSC.URLBase;
  if IWBSLibraryPath <> '' then begin
    TString.ForcePreFix(IWBSLibraryPath, '/');
    FLibPath := FLibPath + IWBSLibraryPath;
  end;
  TString.ForcePreFix(FLibPath, '/');
  TString.ForceSuffix(FLibPath, '/');

  LPageContext := TIWPageContext40(APage);
  LTerminated := Assigned(LPageContext.WebApplication) and LPageContext.WebApplication.Terminated;

  // check if internal jquery is disable and also check if IW version is 14.0.38 or above.
  if gSC.JavaScriptOptions.RenderjQuery then
    raise Exception.Create('Please, disable JavaScriptOptions.RenderjQuery option in server controler');

  ABuffer.WriteLine(LPageContext.DocType);
  ABuffer.WriteLine(gHtmlStart);
  ABuffer.WriteLine('<title>' + LPageContext.Title + '</title>');

  ABuffer.WriteLine('<meta name="viewport" content="width=device-width, initial-scale=1">');

  ABuffer.WriteLine(PreHeadContent);

  ABuffer.WriteLine('<link rel="stylesheet" type="text/css" href="'+FLibPath+'bootstrap-'+IWBSbslibversion+'/css/bootstrap.min.css">');
  ABuffer.WriteLine('<link rel="stylesheet" type="text/css" href="'+FLibPath+'iwbs.css?v='+IWBSRefreshCacheParam+'">');
  ABuffer.WriteLine('<script type="text/javascript" src="'+FLibPath+'jquery-'+IWBSjqlibversion+'.min.js"></script>');
  ABuffer.WriteLine('<script type="text/javascript" src="'+FLibPath+'bootstrap-'+IWBSbslibversion+'/js/bootstrap.min.js"></script>');
  ABuffer.WriteLine('<script type="text/javascript" src="'+FLibPath+'iwbs.js?v='+IWBSRefreshCacheParam+'"></script>');

  // add missing html5 functionality to most browsers
  // http://afarkas.github.io/webshim/demos/index.html
  // see also http://modernizr.com/
  if bslyEnablePolyfill in FPageOptions then
    ABuffer.WriteLine('<script type="text/javascript" src="'+FLibPath+'webshim-1.15.8/js-webshim/minified/polyfiller.js"></script>');

  // disable bootstap button plugin for no conflict with jqButton of jQueryUI framework, required if use CGDevtools buttons
  if bslyNoConflictButton in FPageOptions then
    ABuffer.WriteLine('<script type="text/javascript">$.fn.button.noConflict();</script>');

  ABuffer.WriteLine(ScriptSection(LPageContext));
  ABuffer.WriteLine(HeadContent);
  if LPageContext.StyleTag.Contents.Count > 0 then
    LPageContext.StyleTag.Render(ABuffer);
  ABuffer.WriteLine('</head>');
  if not LTerminated then
    LPageContext.FormTag.Render(ATmpBuf);
  LPageContext.BodyTag.Contents.AddBuffer(ATmpBuf);
  LPageContext.BodyTag.Render(ABuffer);
  ABuffer.WriteLine('</html>');
end;

function ControlRenderingSort(AItem1: Pointer; AItem2: Pointer): Integer;
var
  LTop1, LLeft1, LTop2, LLeft2, LIdx1, LIdx2: integer;
begin
  if TComponent(AItem1) is TControl then
    begin
      LTop1 := TControl(AItem1).Top;
      LLeft1 := TControl(AItem1).Left;
      LIdx1 := TControl(AItem1).ComponentIndex;
    end
  else
    begin
      LTop1 := -1;
      LLeft1 := -1;
      LIdx1 := -1;
    end;
  if TComponent(AItem2) is TControl then
    begin
      LTop2 := TControl(AItem2).Top;
      LLeft2 := TControl(AItem2).Left;
      LIdx2 := TControl(AItem2).ComponentIndex;
    end
  else
    begin
      LTop2 := -1;
      LLeft2 := -1;
      LIdx2 := -1;
    end;

  if aIWBSRenderingSortMethod = bsrmSortYX then
    begin
      Result := LTop1 - LTop2;
      if Abs(Result) < aIWBSRenderingGridPrecision then
        Result := LLeft1 - LLeft2;
    end
  else
    begin
      Result := LLeft1 - LLeft2;
      if Abs(Result) < aIWBSRenderingGridPrecision then
        Result := LTop1 - LTop2;
    end;

  if Result = 0 then
    Result := LIdx1 - LIdx2;
end;

procedure TIWBSLayoutMgr.Process(ABuffer: TIWRenderStream; AContainerContext: TIWContainerContext; aPage: TIWBasePageContext);
var
  LTmp: TIWRenderStream;
  LControls: TList;
  i: Integer;
  LComponent: IIWBaseHTMLComponent;
  xCompContext: TIWCompContext;
  LHTML: TIWHTMLTag;
begin
  LTmp := TIWRenderStream.Create(True, True);
  try

    // TIWBSTabControl
    if Container.InterfaceInstance.ClassNameIs('TIWBSTabControl') then
      LTmp.WriteLine('<div class="tab-content">');

    // input form
    if FFormType <> bsftNoForm then begin
      LTmp.Write('<form ');
      if FFormType = bsftInline then
        Ltmp.Write('class="form-inline" ')
      else if FFormType = bsftHorizontal then
        Ltmp.Write('class="form-horizontal" ');
      LTmp.Write(' role="form" onSubmit="return FormDefaultSubmit();">');
    end;

    // render controls
    LControls := TList.Create;
    try
      for i := 0 to AContainerContext.ComponentsCount - 1 do
        LControls.Add(AContainerContext.ComponentsList[i]);
      MergeSortList(LControls, ControlRenderingSort);

      for i := 0 to LControls.Count - 1 do begin
        if isBaseComponent(LControls[i]) then begin
          LComponent := BaseHTMLComponentInterface(LControls[I]);

          xCompContext := TIWCompContext(AContainerContext.ComponentContext[LComponent.HTMLName]);
          if not aContainerContext.CacheControls then begin
            xCompContext.HTMLTag.Free;
            xCompContext.HTMLTag := TIWHTMLTag(BaseComponentInterface(xCompContext.Component).RenderMarkupLanguageTag(xCompContext));
          end;
          LHTML := xCompContext.HTMLTag;

          if LHTML <> nil then
            LComponent.MakeHTMLTag(LHTML, LTmp);
        end;
      end;
    finally
      LControls.Free;
    end;

    // close input form
    if FFormType <> bsftNoForm then
      LTmp.Write('</form>');

    // close tabs
    if Container.InterfaceInstance.ClassNameIs('TIWBSTabControl') then
      LTmp.WriteLine('</div>');

    // write to buffer
    if Container.InterfaceInstance is TIWBaseForm then
      ProcessForm(aBuffer, LTmp, aPage)
    else
      aBuffer.Stream.CopyFrom(LTmp.Stream, 0);

  finally
    LTmp.Free;
  end;
end;

procedure TIWBSLayoutMgr.ProcessControl(AContainerContext: TIWContainerContext; APageContext: TIWBaseHTMLPageContext; AControl: IIWBaseHTMLComponent);
var
  LHTML: TIWHTMLTag;
  LStyle: string;
begin
  LHTML := TIWCompContext(AContainerContext.ComponentContext[AControl.HTMLName]).HTMLTag;

  // non IWBS components hacks
  if Assigned(LHTML) then begin
    if AControl.InterfaceInstance.ClassName = 'TIWTabPage' then
      LHTML.Params.Values['class'] := IWBSRegionCommon.TIWTabPage(AControl.InterfaceInstance).CSSClass
    else if AControl.InterfaceInstance.ClassName = 'TIWEdit' then
      LHTML.Params.Values['class'] := 'form-control'
    else if AControl.InterfaceInstance.ClassName = 'TIWMemo' then
      LHTML.Params.Values['class'] := 'form-control'
    else if AControl.InterfaceInstance.ClassName = 'TIWCheckBox' then
      LHTML.Params.Values['class'] := 'checkbox-inline'
    else if AControl.InterfaceInstance.ClassName = 'TIWComboBox' then
      LHTML.Params.Values['class'] := 'form-control'
    else if AControl.InterfaceInstance.ClassName = 'TIWListbox' then
      LHTML.Params.Values['class'] := 'form-control'
    else if AControl.InterfaceInstance.ClassName = 'TIWButton' then
      LHTML.Params.Values['class'] := 'btn';

    // bugfix, intraweb ignore StyleRenderOption.UseDisplay
    if not TControl(AControl.InterfaceInstance).Visible and HTML40ControlInterface(AControl.InterfaceInstance).StyleRenderOptions.UseDisplay then begin
      LStyle := LHTML.Params.Values['style'];
      if not AnsiContainsText(LStyle,'display:') then
        LStyle := 'display: none;'+LStyle;
      LHTML.AddStringParam('STYLE', LStyle);
    end;
  end;

  inherited;
end;

initialization
  IWBSRefreshCacheParam := FormatDateTime('yyyymmddhhnnsszzz', now);

end.
