unit IWBSLayoutMgr;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Vcl.Controls,
  IWContainerLayout, IWRenderContext, IWBaseHTMLInterfaces, IWBaseRenderContext, IW.Common.RenderStream, IWHTMLTag;

type

  TIWBSRenderingSortMethod = (bsrmSortYX, bsrmSortXY);

  TIWBSLayoutMgr = class(TIWContainerLayout)
  private
    FLinkFiles: TStringList;
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
    procedure AddLinkFile(const AFile: string);
    function ParseLinkFile(const AUrlBase, AFile: string; ADisableCache: boolean = True): string;
    procedure ProcessControl(AContainerContext: TIWContainerContext; APageContext: TIWBaseHTMLPageContext; AControl: IIWBaseHTMLComponent); override;
    procedure ProcessForm(ABuffer, ATmpBuf: TIWRenderStream; APage: TIWBasePageContext);
    procedure Process(ABuffer: TIWRenderStream; AContainerContext: TIWContainerContext; aPage: TIWBasePageContext); override;
  end;

implementation

uses
  IWBaseForm, IWGlobal, IWHTML40Interfaces, IWTypes, IWHTMLContainer, IWBaseInterfaces, IWBaseControl, IWLists, IWURL,
  IWRegion, IW.Common.Strings, IWMimeTypes, IWApplication,
  IWBSGlobal, IWBSRegionCommon, IWBSCommon, IWBSTabControl;

constructor TIWBSLayoutMgr.Create(AOnwer: TComponent);
begin
  inherited;
  SetAllowFrames(true);
  SetLayoutType(ltFlow);
end;

destructor TIWBSLayoutMgr.Destroy;
begin
  FreeAndNil(FLinkFiles);
end;

procedure TIWBSLayoutMgr.AddLinkFile(const AFile: string);
begin
  if FLinkFiles = nil then
    FLinkFiles := TStringList.Create;
  if FLinkFiles.IndexOf(AFile) = -1 then
    FLinkFiles.Add(AFile);
end;

function TIWBSLayoutMgr.ParseLinkFile(const AUrlBase, AFile: string; ADisableCache: boolean = True): string;
var
  LFile: string;
  LDisableCache: boolean;
begin
  LDisableCache := ADisableCache;

  LFile := ReplaceStr(AFile, '/<iwbspath>/', gIWBSLibPath);
  if AnsiStartsStr('//', LFile) or AnsiContainsStr('://', LFile) then
    LDisableCache := False
  else
    LFile := TURL.MakeValidFileUrl(AUrlBase, LFile);

  if AnsiEndsStr('.js', LFile) then
    Result := '<script type="text/javascript" src="'+LFile+IfThen(LDisableCache,'?v='+gIWBSRefreshCacheParam)+'"></script>'

  else if AnsiEndsStr('.css', LFile) then
    Result := '<link rel="stylesheet" type="text/css" href="'+LFile+IfThen(LDisableCache,'?v='+gIWBSRefreshCacheParam)+'">'

  else
    raise Exception.Create('Unknown file type');
end;

procedure TIWBSLayoutMgr.ProcessForm(ABuffer, ATmpBuf: TIWRenderStream; APage: TIWBasePageContext);
var
  LUrlBase: string;
  LPageContext: TIWPageContext40;
  LTerminated: Boolean;
  i: integer;
begin

  LUrlBase := gGetWebApplicationThreadVar.AppUrlBase;

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

  // jquery
  ABuffer.WriteLine(ParseLinkFile(LUrlBase, gIWBSLibJQueryJs, False));

  // bootstrap
  ABuffer.WriteLine(ParseLinkFile(LUrlBase, gIWBSLibBootstrapCss, False));
  ABuffer.WriteLine(ParseLinkFile(LUrlBase, gIWBSLibBootstrapJs, False));

  // iwbs
  ABuffer.WriteLine(ParseLinkFile(LUrlBase, gIWBSLibIWBSCss));
  ABuffer.WriteLine(ParseLinkFile(LUrlBase, gIWBSLibIWBSJs));

  // polyfiller
  if gIWBSlibPolyfiller then
    ABuffer.WriteLine(ParseLinkFile(LUrlBase, gIWBSLibPolyfillerJs, False));

  // Dynamic Tabs
  if gIWBSLibDynamicTabs then begin
    ABuffer.WriteLine(ParseLinkFile(LUrlBase, gIWBSLibDynamicTabsCss));
    ABuffer.WriteLine(ParseLinkFile(LUrlBase, gIWBSLibDynamicTabsJs));
  end;

  // add global linkfiles
  if gIWBSLinkFiles <> nil then
    for i := 0 to gIWBSLinkFiles.Count-1 do
      ABuffer.WriteLine(ParseLinkFile(LUrlBase, gIWBSLinkFiles[i]));

  // add LayoutMgr linkfiles
  if FLinkFiles <> nil then
    for i := 0 to FLinkFiles.Count-1 do
      ABuffer.WriteLine(ParseLinkFile(LUrlBase, FLinkFiles[i]));

  ABuffer.WriteLine('<script>var IWBSAppBaseUrl = "'+LUrlBase+'";</script>');
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

  if gIWBSRenderingSortMethod = bsrmSortYX then
    begin
      Result := LTop1 - LTop2;
      if Abs(Result) < gIWBSRenderingGridPrecision then
        Result := LLeft1 - LLeft2;
    end
  else
    begin
      Result := LLeft1 - LLeft2;
      if Abs(Result) < gIWBSRenderingGridPrecision then
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

    // TIWBSTabControl (investigate how to move this to IWBSTabControl)
    if Container.InterfaceInstance.ClassNameIs('TIWBSTabControl') then
      LTmp.WriteLine('<div class="tab-content">');

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
  xHTMLName: string;
  LRenderInvisibleControls: Boolean;
  LComponentContext: TIWCompContext;
  LVisible: boolean;
  LHTML: TIWHTMLTag;
  L40Component: IIWHTML40Component;
  LIWBSComponent: IIWBSComponent;
  LInputLists: TStringList;
  i: integer;
begin
  xHTMLName := AControl.HTMLName;

  if SupportsInterface(Container.InterfaceInstance, IIWInvisibleControlRenderer) then
    LRenderInvisibleControls := (Container as IIWInvisibleControlRenderer).RenderInvisibleControls
  else
    LRenderInvisibleControls := False;

  LComponentContext := TIWCompContext(AContainerContext.ComponentContext[xHTMLName]);

  if SupportsInterface(AControl.InterfaceInstance, IIWBaseControl) then
    LVisible := BaseControlInterface(AControl.InterfaceInstance).Visible
  else
    LVisible := True;

  LHTML := LComponentContext.HTMLTag;
  if Assigned(LHTML) then begin

    // TIWBSTabControl pages
    if (AControl.InterfaceInstance.ClassName = 'TIWTabPage') and (TControl(AControl.InterfaceInstance).Parent is TIWBSTabControl) then
      begin
        LHTML.Params.Values['class'] := TIWBSTabControl(TControl(AControl.InterfaceInstance).Parent).GetTabPageCSSClass(AControl.InterfaceInstance);
        LHTML.Params.Values['id'] := xHTMLName;
      end

    else if AControl.InterfaceInstance.GetInterfaceEntry(IIWBSComponent) = nil then
      begin
        L40Component := HTML40ComponentInterface(AControl.InterfaceInstance);
        if L40Component <> nil then begin
          if LHTML.Params.Values['id'] = '' then
            LHTML.AddStringParam('id', xHTMLName);
          if L40Component.SupportsInput and (AControl.HasName) and (LHTML.Params.Values['name'] = '') then
            LHTML.AddStringParam('name', xHTMLName);
          if LHTML.Params.Values['class'] = '' then
            LHTML.AddStringParam('class', L40Component.RenderCSSClass(nil));
          LHTML.Params.Values['style'] := L40Component.RenderStyle(LComponentContext) + LHTML.Params.Values['style'];
        end;
      end

    else
      begin
        if not LVisible and LRenderInvisibleControls then
          TIWBSCommon.SetNotVisible(LHTML.Params);
      end;

    // global hook
    if Assigned(gIWBSOnHTMLTag) then
      gIWBSOnHTMLTag(AControl.InterfaceInstance, xHTMLName, LHTML);

  end;

  // render hidden inputs for submit
  if AControl.SupportsInput then begin
    LInputLists := TStringList.Create;
    try
      InputInterface(AControl.InterfaceInstance).GetInputControlNames(LInputLists);
      if LVisible or LRenderInvisibleControls then
        for i := 0 to LInputLists.Count-1 do
          APageContext.AppendHiddenInput(LInputLists.Strings[i]);
    finally
      LInputLists.Free;
    end;
  end;

  APageContext.AppendContext(LComponentContext);

  AControl.InterfaceInstance.GetInterface(IIWBSComponent, LIWBSComponent);
  if (LIWBSComponent <> nil) and Assigned(LIWBSComponent.OnAfterRender) then
    LIWBSComponent.OnAfterRender(LIWBSComponent.InterfaceInstance);
end;

initialization
  TIWMimeTypes.RegisterType('.woff','text/html; charset=UTF-8',True);
  TIWMimeTypes.RegisterType('.woff2','text/html; charset=UTF-8',True);

end.
