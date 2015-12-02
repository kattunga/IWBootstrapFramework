unit IWBSTabControl;

interface

uses
  System.SysUtils, System.Classes, System.StrUtils,
  IWApplication, IWBaseRenderContext, IWControl, IWBaseInterfaces,
  IWCompTabControl,
  IWRenderContext, IWHTMLTag, IWBSCommon, IWBSRegionCommon, IWXMLTag, IW.Common.RenderStream, IWBSCustomEvents;

type
  TIWBSTabOptions = class(TPersistent)
  private
    FFade: boolean;
    FPills: boolean;
    FJustified: boolean;
    FStacked: boolean;
  public
    constructor Create(AOwner: TComponent);
    procedure Assign(Source: TPersistent); override;
  published
    property Fade: boolean read FFade write FFade default false;
    property Pills: boolean read FPills write FPills default false;
    property Justified: boolean read FJustified write FJustified default false;
    property Stacked: boolean read FStacked write FStacked default false;
  end;

  TIWBSTabControl = class(TIWTabControl, IIWInputControl, IIWBSComponent, IIWBSContainer)
  private
    FOldCss: string;
    FOldStyle: string;
    FOldVisible: boolean;
    FOldActivePage: integer;

    FAsyncRefreshControl: boolean;
    FCustomAsyncEvents: TIWBSCustomAsyncEvents;
    FCustomRestEvents: TIWBSCustomRestEvents;
    FGridOptions: TIWBSGridOptions;
    FRegionDiv: TIWHTMLTag;
    FScript: TStringList;
    FScriptParams: TIWBSScriptParams;
    FStyle: TStringList;
    FTabOptions: TIWBSTabOptions;
    FOnRenderAsync: TNotifyEvent;

    procedure CheckActiveVisible;
    function HTMLControlImplementation: TIWHTMLControlImplementation;
    function RegionDiv: TIWHTMLTag;

    procedure SetGridOptions(const Value: TIWBSGridOptions);
    procedure SetTabOptions(const Value: TIWBSTabOptions);
    procedure SetScript(const AValue: TStringList);
    procedure SetScriptParams(const AValue: TIWBSScriptParams);
    function GetStyle: TStringList;
    procedure SetStyle(const AValue: TStringList);
    procedure OnScriptChange(ASender : TObject);
    procedure OnStyleChange(ASender : TObject);
    function GetCustomAsyncEvents: TIWBSCustomAsyncEvents;
    function GetCustomRestEvents: TIWBSCustomRestEvents;
    procedure SetCustomAsyncEvents(const Value: TIWBSCustomAsyncEvents);
    procedure SetCustomRestEvents(const Value: TIWBSCustomRestEvents);
    function GetScript: TStringList;
    function GetScriptParams: TIWBSScriptParams;
  protected
    procedure SetValue(const AValue: string);
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); virtual;
    procedure InternalRenderStyle(AStyle: TStringList); virtual;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure RenderScripts(AComponentContext: TIWCompContext); override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AsyncRefreshControl;
    procedure AsyncRemoveControl;
    function GetTabPageCSSClass(ATabPage: TComponent): string;
    function IsStoredCustomAsyncEvents: Boolean;
    function IsStoredCustomRestEvents: Boolean;
    procedure SetTabPageVisibility(ATabIndex: integer; Visible: boolean); overload;
    procedure SetTabPageVisibility(ATabPage: TIWTabPage; Visible: boolean); overload;
  published
    property ActivePage: Integer read FActivePage write SetActivePage;
    property Align;
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;
    property BSTabOptions: TIWBSTabOptions read FTabOptions write SetTabOptions;
    property ClipRegion default False;
    property CustomAsyncEvents: TIWBSCustomAsyncEvents read GetCustomAsyncEvents write SetCustomAsyncEvents stored IsStoredCustomAsyncEvents;
    property CustomRestEvents: TIWBSCustomRestEvents read GetCustomRestEvents write SetCustomRestEvents stored IsStoredCustomRestEvents;
    property ExtraTagParams;
    property LayoutMgr;
    property RenderInvisibleControls default False;
    property Script: TStringList read GetScript write SetScript;
    property ScriptParams: TIWBSScriptParams read GetScriptParams write SetScriptParams;
    property Style: TStringList read GetStyle write SetStyle;
    property ZIndex default 0;

    property OnRenderAsync: TNotifyEvent read FOnRenderAsync write FOnRenderAsync;
    property OnHTMLTag;
  end;

implementation

uses IWLists, IW.Common.System, IWBSutils, IWBSLayoutMgr, IWBSScriptEvents, IWBSGlobal;

{$region 'TIWBSTabOptions'}
constructor TIWBSTabOptions.Create(AOwner: TComponent);
begin
  FFade := False;
  FPills := False;
  FJustified := False;
  FStacked := False;
end;

procedure TIWBSTabOptions.Assign(Source: TPersistent);
begin
  if Source is TIWBSTabOptions then
    begin
      Fade := TIWBSTabOptions(Source).Fade;
      Pills := TIWBSTabOptions(Source).Pills;
      Justified := TIWBSTabOptions(Source).Justified;
      Stacked := TIWBSTabOptions(Source).Stacked;
    end
  else
    inherited;
end;
{$endregion}

{$region 'TIWBSTabControl'}
constructor TIWBSTabControl.Create(AOwner: TComponent);
begin
  inherited;
  FGridOptions := TIWBSGridOptions.Create;
  FScript := TStringList.Create;
  FScript.OnChange := OnScriptChange;
  FScriptParams := TIWBSScriptParams.Create;
  FScriptParams.OnChange := OnScriptChange;
  FStyle := TStringList.Create;
  FStyle.OnChange := OnStyleChange;
  FStyle.NameValueSeparator := ':';
  FTabOptions := TIWBSTabOptions.Create(Self);
  Height := 112;
  Width := 112;
end;

destructor TIWBSTabControl.Destroy;
begin
  FreeAndNil(FGridOptions);
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);
  FreeAndNil(FTabOptions);
  inherited;
end;

procedure TIWBSTabControl.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBSTabControl.AsyncRemoveControl;
begin
  TIWBSCommon.AsyncRemoveControl(HTMLName);
end;

procedure TIWBSTabControl.SetGridOptions(const Value: TIWBSGridOptions);
begin
  FGridOptions.Assign(Value);
  invalidate;
end;

procedure TIWBSTabControl.SetValue(const AValue: string);
begin
  if RequiresUpdateNotification(Parent) then
    UpdateNotifiedInterface(Parent).NotifyUpdate(Self,AValue);
  FActivePage := StrToIntDef(AValue, 0);
  if (FActivePage < 0) or (FActivePage >= Pages.Count) then
    begin
      FActivePage := 0;
      FOldActivePage := -1;
    end
  else
    FOldActivePage := FActivePage;
end;

procedure TIWBSTabControl.SetTabOptions(const Value: TIWBSTabOptions);
begin
  FTabOptions.Assign(Value);
  invalidate;
end;

procedure TIWBSTabControl.OnScriptChange( ASender : TObject );
begin
  AsyncRefreshControl;
end;

procedure TIWBSTabControl.OnStyleChange( ASender : TObject );
begin
  Invalidate;
end;

function TIWBSTabControl.GetCustomAsyncEvents: TIWBSCustomAsyncEvents;
begin
  if FCustomAsyncEvents = nil then
    FCustomAsyncEvents := TIWBSCustomAsyncEvents.Create(Self);
  Result := FCustomAsyncEvents;
end;

function TIWBSTabControl.GetCustomRestEvents: TIWBSCustomRestEvents;
begin
  if FCustomRestEvents = nil then
    FCustomRestEvents := TIWBSCustomRestEvents.Create(Self);
  Result := FCustomRestEvents;
end;

procedure TIWBSTabControl.SetCustomAsyncEvents(const Value: TIWBSCustomAsyncEvents);
begin
  FCustomAsyncEvents.Assign(Value);
end;

procedure TIWBSTabControl.SetCustomRestEvents(const Value: TIWBSCustomRestEvents);
begin
  FCustomRestEvents.Assign(Value);
end;

function TIWBSTabControl.IsStoredCustomAsyncEvents: boolean;
begin
  Result := (FCustomAsyncEvents <> nil) and (FCustomAsyncEvents.Count > 0);
end;

function TIWBSTabControl.IsStoredCustomRestEvents: boolean;
begin
  Result := (FCustomRestEvents <> nil) and (FCustomRestEvents.Count > 0);
end;

procedure TIWBSTabControl.SetScript(const AValue: TStringList);
begin
  FScript.Assign(AValue);
end;

procedure TIWBSTabControl.SetScriptParams(const AValue: TIWBSScriptParams);
begin
  FScriptParams.Assign(AValue);
end;

function TIWBSTabControl.GetScript: TStringList;
begin
  Result := FScript;
end;

function TIWBSTabControl.GetScriptParams: TIWBSScriptParams;
begin
  Result := FScriptParams;
end;

function TIWBSTabControl.GetStyle: TStringList;
begin
  Result := FStyle;
end;

procedure TIWBSTabControl.SetStyle(const AValue: TStringList);
begin
  FStyle.Assign(AValue);
end;

function TIWBSTabControl.HTMLControlImplementation: TIWHTMLControlImplementation;
begin
  Result := ControlImplementation;
end;

function TIWBSTabControl.RegionDiv: TIWHTMLTag;
begin
  Result := FRegionDiv;
end;

function TIWBSTabControl.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  if not (Self.LayoutMgr is TIWBSLayoutMgr) then
    Self.LayoutMgr := TIWBSLayoutMgr.Create(Self);
  Result := inherited;
end;

procedure TIWBSTabControl.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  if not FTabOptions.Justified and not FTabOptions.Stacked and gIWBSLibDynamicTabs then
    AScript.Add('$("#'+AHTMLName+'_tabs'+'").bootstrapDynamicTabs();');

  // save seleted tab on change, manually trigger change event because val don't do it
  AScript.Add('$("#'+AHTMLName+'_tabs").off("show.bs.tab").on("show.bs.tab", function(e){ $("#'+AHTMLName+'_input").val($(e.target).attr("tabindex")).change(); });');

  // event async change
  if Assigned(OnAsyncChange) then begin
    AScript.Add('$("#'+AHTMLName+'_tabs").off("shown.bs.tab").on("shown.bs.tab", function(e){ executeAjaxEvent("&page="+$(e.target).attr("tabindex"), null, "'+AHTMLName+'.DoOnAsyncChange", true, null, true); });');
    AContext.WebApplication.RegisterCallBack(AHTMLName+'.DoOnAsyncChange', DoOnAsyncChange);
  end;
end;

procedure TIWBSTabControl.InternalRenderStyle(AStyle: TStringList);
begin
  //
end;

function TIWBSTabControl.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  Result := nil;
  xHTMLName := HTMLName;

  if FAsyncRefreshControl then
    TIWBSRegionCommon.RenderAsync(Self, AContext)
  else
    begin
      SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
      SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
      SetAsyncVisible(AContext, xHTMLName, Visible, FOldVisible);
      if FOldActivePage <> ActivePage then begin
        AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'_tabs a[tabindex='+IntToStr(ActivePage)+']").tab("show");');
        FOldActivePage := ActivePage;
      end;
    end;

  if Assigned(FOnRenderAsync) then
    FOnRenderAsync(Self);

  if Assigned(gIWBSOnRenderAsync) then
    gIWBSOnRenderAsync(Self, xHTMLName);
end;

procedure TIWBSTabControl.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  TIWBSRegionCommon.RenderComponents(Self, AContainerContext, APageContext);
end;

procedure TIWBSTabControl.CheckActiveVisible;
var
  i, tabIndex: integer;
begin
  if (ActivePage >= 0) and (ActivePage < Pages.Count) and not TIWTabPage(FPages.Items[ActivePage]).Visible then begin
    tabIndex := -1;
    for i := 0 to Pages.Count-1 do
      if TIWTabPage(FPages[i]).Visible then begin
        tabIndex := i;
        break;
      end;
    ActivePage := tabIndex;
  end;
end;

function TIWBSTabControl.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'iwbs-tabs '+FGridOptions.GetClassString;
end;

function TIWBSTabControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
  xHTMLInput: string;
  i, tabIndex: integer;
  tagTabs, tag: TIWHTMLTag;
  TabPage: TIWTabPage;
begin
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;
  FOldActivePage := ActivePage;

  MergeSortList(Pages, TabOrderCompare);
  CheckActiveVisible;

  // read only one time
  xHTMLName := HTMLName;
  xHTMLInput := xHTMLName + '_input';

  // main div
  FRegionDiv := TIWHTMLTag.CreateTag('div');
  FRegionDiv.AddStringParam('id', xHTMLName);
  FRegionDiv.AddClassParam(FOldCss);
  FRegionDiv.AddStringParam('style',RenderStyle(AContext));
  Result := FRegionDiv;

  // tabs region
  tagTabs := result.Contents.AddTag('ul');
  tagTabs.AddStringParam('id',xHTMLName+'_tabs');
  tagTabs.AddClassParam('nav');
  if FTabOptions.Pills then
    tagTabs.AddClassParam('nav-pills')
  else
    tagTabs.AddClassParam('nav-tabs');

  if FTabOptions.Justified then
    tagTabs.AddClassParam('nav-justified');
  if FTabOptions.Stacked then
    tagTabs.AddClassParam('nav-stacked');

  tagTabs.AddStringParam('role', 'tablist');

  // build the tabs
  tabIndex := -1;
  for i := 0 to Pages.Count-1 do begin
    TabPage := TIWTabPage(FPages.Items[i]);
    TabPage.TabOrder := i;
    if not TabPage.Visible and not RenderInvisibleControls then
      Continue;
    tag := tagTabs.Contents.AddTag('li');
    if (ActivePage = i) and TabPage.Visible then begin
      tag.AddClassParam('active');
      tabIndex := i;
    end;
    tag := tag.Contents.AddTag('a');
    tag.AddStringParam('data-toggle', IfThen(FTabOptions.Pills,'pill','tab'));
    tag.AddStringParam('href', '#'+TabPage.HTMLName);
    tag.AddIntegerParam('tabindex', i);
    if not TabPage.Visible then
      tag.AddStringParam('style','display: none');
    tag.Contents.AddText(TabPage.Title);
  end;

  // this hidden input is for input seleted tab page
  Result.Contents.AddHiddenField(xHTMLInput, xHTMLInput, IntToStr(tabIndex));

  IWBSRenderScript(Self, AContext, Result);

  // initialize hidden input (after render scripts)
  TIWPageContext40(AContext.PageContext).AddToIWCLInitProc('  IW.initIWCL('+HTMLControlImplementation.IWCLName+',"'+xHTMLName+'_input",true);');

  FAsyncRefreshControl := False;
end;

procedure TIWBSTabControl.RenderScripts(AComponentContext: TIWCompContext);
begin
  //
end;

function TIWBSTabControl.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := TIWBSCommon.RenderStyle(Self);
end;

function TIWBSTabControl.GetTabPageCSSClass(ATabPage: TComponent): string;
begin
  Result := 'tab-pane';
  if BSTabOptions.Fade then
    Result := Result + ' fade';
  if (ActivePage >= 0) and (ActivePage < Pages.Count) and (Pages[ActivePage] = ATabPage) then
    Result := Result + ' active in';
end;

procedure TIWBSTabControl.SetTabPageVisibility(ATabIndex: integer; Visible: boolean);
begin
  if (ATabIndex >= 0) and (ATabIndex < Pages.Count) then begin
    TIWTabPage(FPages.Items[ATabIndex]).Visible := Visible;
    CheckActiveVisible;
    IWBSExecuteAsyncJScript('$("#'+HTMLName+'_tabs a[tabindex='+IntToStr(ATabIndex)+']").css("display", "'+iif(Visible,'','none')+'");');
  end;
end;

procedure TIWBSTabControl.SetTabPageVisibility(ATabPage: TIWTabPage; Visible: boolean);
begin
  SetTabPageVisibility(Pages.IndexOf(ATabPage), Visible);
end;
{$endregion}

end.
