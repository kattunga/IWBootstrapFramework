unit IWBSLayoutMgr;

interface

{$I IWBSConfig.inc}

uses
  System.Classes, System.SysUtils, System.StrUtils, Vcl.Controls,
  IWContainerLayout, IWRenderContext, IWBaseHTMLInterfaces, IWBaseRenderContext, IW.Common.RenderStream, IWHTMLTag;

type

  TIWBSRenderingSortMethod = (bsrmSortYX, bsrmSortXY);

  TIWBSPageOption = (bslyNoConflictButton);

  TIWBSPageOptions = set of TIWBSPageOption;

  TIWBSLayoutMgr = class(TIWContainerLayout)
  private
    FPageOptions: TIWBSPageOptions;
    function SetNotVisible(const AStyle: string): string;
  protected
    procedure InitControl; override;
  public
    constructor Create(AOnwer: TComponent); override;
    procedure ProcessControl(AContainerContext: TIWContainerContext; APageContext: TIWBaseHTMLPageContext; AControl: IIWBaseHTMLComponent); override;
    procedure ProcessForm(ABuffer, ATmpBuf: TIWRenderStream; APage: TIWBasePageContext);
    procedure Process(ABuffer: TIWRenderStream; AContainerContext: TIWContainerContext; aPage: TIWBasePageContext); override;

    class procedure AddLinkFile(const AFile: string);
    class function ParseLinkFile(const AFile: string; ADisableCache: boolean = True): string;
  published
    property BSPageOptions: TIWBSPageOptions read FPageOptions write FPageOptions default [];
  end;

var
  gIWBSLibraryPath: string = '/iwbs/';
  gIWBSRefreshCacheParam: string;
  gIWBSjqlibversion: string = '1.11.3';
  gIWBSbslibversion: string = '3.3.5';

  gIWBSRenderingSortMethod: TIWBSRenderingSortMethod = bsrmSortYX;
  gIWBSRenderingGridPrecision: integer = 12;

implementation

uses
  IWBaseForm, IWGlobal, IWHTML40Interfaces, IWTypes, IWHTMLContainer, IWBaseInterfaces, IWBaseControl, IWLists, IWURL,
  IWRegion, IW.Common.Strings,
  IWBSRegionCommon, IWBSCommon, IWBSTabControl;

var
  gIWBSLinkFiles: TStringList = nil;

// to add files should be done only in initialization section, it's not thread safe
class procedure TIWBSLayoutMgr.AddLinkFile(const AFile: string);
begin
  if gIWBSLinkFiles = nil then
    gIWBSLinkFiles := TStringList.Create;
  gIWBSLinkFiles.Add(AFile);
end;

class function TIWBSLayoutMgr.ParseLinkFile(const AFile: string; ADisableCache: boolean = True): string;
begin
  if AnsiEndsStr('.js', AFile) then
    Result := '<script type="text/javascript" src="'+AFile+IfThen(ADisableCache,'?v='+gIWBSRefreshCacheParam)+'"></script>'

  else if AnsiEndsStr('.css', AFile) then
    Result := '<link rel="stylesheet" type="text/css" href="'+AFile+IfThen(ADisableCache,'?v='+gIWBSRefreshCacheParam)+'">'

  else
    raise Exception.Create('Unknown file type');
end;

constructor TIWBSLayoutMgr.Create(AOnwer: TComponent);
begin
  inherited;
  FPageOptions := [];
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
  i: integer;
begin

  // library path must end with /
  if not AnsiEndsStr('/', gIWBSLibraryPath) then
    gIWBSLibraryPath := gIWBSLibraryPath+'/';

  // get library path
  FLibPath := TURL.Concat(gSC.URLBase,gIWBSLibraryPath);

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
  ABuffer.WriteLine(ParseLinkFile(FLibPath+'jquery-'+gIWBSjqlibversion+'.min.js', False));

  // bootstrap
  ABuffer.WriteLine(ParseLinkFile(FLibPath+'bootstrap-'+gIWBSbslibversion+'/css/bootstrap.min.css', False));
  ABuffer.WriteLine(ParseLinkFile(FLibPath+'bootstrap-'+gIWBSbslibversion+'/js/bootstrap.min.js', False));

  // disable bootstap button plugin for no conflict with jqButton of jQueryUI framework, required if use CGDevtools buttons
  if bslyNoConflictButton in FPageOptions then
    ABuffer.WriteLine('<script type="text/javascript">$.fn.button.noConflict();</script>');

  // iwbs
  ABuffer.WriteLine(ParseLinkFile(FLibPath+'iwbs.css'));
  ABuffer.WriteLine(ParseLinkFile(FLibPath+'iwbs.js'));

  // add global linkfiles
  if gIWBSLinkFiles <> nil then
    for i := 0 to gIWBSLinkFiles.Count-1 do
      if AnsiStartsStr('//', gIWBSLinkFiles[i]) then
        ABuffer.WriteLine(ParseLinkFile(gIWBSLinkFiles[i], False))
      else
        ABuffer.WriteLine(ParseLinkFile(TURL.Concat(gSC.URLBase,ReplaceStr(gIWBSLinkFiles[i],'/<iwbspath>/',gIWBSLibraryPath))));

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

function TIWBSLayoutMgr.SetNotVisible(const AStyle: string): string;
begin
  Result := Trim(AStyle);
  if not AnsiEndsStr(';', Result) then
    Result := Result+';';
  if not AnsiContainsStr(AStyle, 'visibility:') then
    Result := Result +  'visibility: hidden';
  if not AnsiContainsStr(AStyle, 'display:') then
    Result := Result +  'display: none';
end;

procedure TIWBSLayoutMgr.ProcessControl(AContainerContext: TIWContainerContext; APageContext: TIWBaseHTMLPageContext; AControl: IIWBaseHTMLComponent);
var
  xHTMLName: string;
  LRenderInvisibleControls: Boolean;
  LComponentContext: TIWCompContext;
  LVisible: boolean;
  LHTML: TIWHTMLTag;
  L40Component: IIWHTML40Component;
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
          LHTML.Params.Values['style'] := SetNotVisible(LHTML.Params.Values['style']);
      end;
  end;

  // render hidden inputs for submit
  if AControl.SupportsInput then
    begin
      LInputLists := TStringList.Create;
      try
        InputInterface(AControl.InterfaceInstance).GetInputControlNames(LInputLists);
        if LVisible or LRenderInvisibleControls then
          for i := 0 to LInputLists.Count-1 do
            APageContext.AppendHiddenInput(LInputLists.Strings[i]);
      finally
        LInputLists.Free;
      end;
    end
  else
    APageContext.AppendHiddenInput(AControl.HTMLName);

  APageContext.AppendContext(LComponentContext);
end;

initialization
  gIWBSRefreshCacheParam := FormatDateTime('yyyymmddhhnnsszzz', now);

{$IFDEF IWBSWEBSHIM}
  TIWBSLayoutMgr.AddLinkFile('/<iwbspath>/webshim-1.15.8/js-webshim/minified/polyfiller.js');
{$ENDIF}

finalization
  FreeAndNil(gIWBSLinkFiles);

end.
