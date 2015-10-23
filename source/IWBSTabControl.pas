unit IWBSTabControl;

interface

{$I IWBSConfig.inc}

uses
  System.SysUtils, System.Classes, System.StrUtils, Vcl.Controls, Vcl.Forms, Vcl.Graphics,
  IWVCLBaseContainer, IWApplication, IWBaseRenderContext, IWControl,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWHTML40Interfaces, IWRegion, IWCompTabControl, IWBaseContainerLayout,
  IWRenderContext, IWHTMLTag, IWBSCommon, IWBSRegionCommon, IWXMLTag, IW.Common.RenderStream;

type
  TIWBSTabOptions = class(TPersistent)
  private
    FFade: boolean;
    FPills: boolean;
    FJustified: boolean;
    FStacked: boolean;
  public
    constructor Create(AOwner: TComponent);
  published
    property Fade: boolean read FFade write FFade default false;
    property Pills: boolean read FPills write FPills default false;
    property Justified: boolean read FJustified write FJustified default false;
    property Stacked: boolean read FStacked write FStacked default false;
  end;

  TIWBSTabControl = class(TIWTabControl, IIWBSComponent)
  private
    FOldStyle: string;
    FOldVisible: boolean;
    FOldActivePage: integer;

    FGridOptions: TIWBSGridOptions;
    FRegionDiv: TIWHTMLTag;
    FScript: TStrings;
    FStyle: TStrings;
    FTabOptions: TIWBSTabOptions;
    procedure SetGridOptions(const Value: TIWBSGridOptions);
    procedure SetTabOptions(const Value: TIWBSTabOptions);
    procedure SetStyle(const AValue: TStrings);
    procedure CheckActiveVisible;
    procedure InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream);
  protected
    function HTMLControlImplementation: TIWHTMLControlImplementation;
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    function InternalRenderScript: string;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure RenderScripts(AComponentContext: TIWCompContext); override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabPageCSSClass(ATabPage: TComponent): string;
    procedure SetTabPageVisibility(ATabIndex: integer; Visible: boolean); overload;
    procedure SetTabPageVisibility(ATabPage: TIWTabPage; Visible: boolean); overload;
  published
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;
    property BSTabOptions: TIWBSTabOptions read FTabOptions write SetTabOptions;
    property Script: TStrings read FScript write FScript;
    property Style: TStrings read FStyle write SetStyle;
  end;

implementation

uses IWLists, IW.Common.System, IWBSutils, IWBSLayoutMgr, IWBSScriptEvents, IWBaseInterfaces;

{$region 'THackCustomRegion'}
type
  THackTIWHTML40Container = class(TIWHTML40Container)
  private
    procedure CallInheritedRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
  end;

procedure THackTIWHTML40Container.CallInheritedRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  inherited RenderComponents(AContainerContext, APageContext);
end;
{$endregion}

{$region 'TIWBSTabOptions'}
constructor TIWBSTabOptions.Create(AOwner: TComponent);
begin
  FFade := False;
  FPills := False;
  FJustified := False;
  FStacked := False;
end;
{$endregion}

{$region 'TIWBSTabControl'}
constructor TIWBSTabControl.Create(AOwner: TComponent);
begin
  inherited;
  FGridOptions := TIWBSGridOptions.Create;
  FScript := TStringList.Create;
  FStyle := TStringList.Create;
  FTabOptions := TIWBSTabOptions.Create(Self);
end;

destructor TIWBSTabControl.Destroy;
begin
  FGridOptions.Free;
  FScript.Free;
  FStyle.Free;
  FTabOptions.Free;
  inherited;
end;

procedure TIWBSTabControl.SetGridOptions(const Value: TIWBSGridOptions);
begin
  FGridOptions.Assign(Value);
  invalidate;
end;

procedure TIWBSTabControl.SetTabOptions(const Value: TIWBSTabOptions);
begin
  FTabOptions.Assign(Value);
  invalidate;
end;

procedure TIWBSTabControl.SetStyle(const AValue: TStrings);
begin
  FStyle.Assign(AValue);
  Invalidate;
end;

function TIWBSTabControl.HTMLControlImplementation: TIWHTMLControlImplementation;
begin
  Result := ControlImplementation;
end;

function TIWBSTabControl.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  if not (Self.LayoutMgr is TIWBSLayoutMgr) then
    Self.LayoutMgr := TIWBSLayoutMgr.Create(Self);
  Result := inherited;
end;

function TIWBSTabControl.InternalRenderScript: string;
begin
  Result := '';
end;

function TIWBSTabControl.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  Result := nil;
  xHTMLName := HTMLName;
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
  SetAsyncVisible(AContext, xHTMLName, Visible, FOldVisible);
  if FOldActivePage <> ActivePage then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'_tabs a[tabindex='+IntToStr(ActivePage)+']").tab("show");');
    FOldActivePage := ActivePage;
  end;
end;

procedure TIWBSTabControl.InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream);
begin
  IWBSPrepareChildComponentsForRender(Self);
  try
    THackTIWHTML40Container(Self).CallInheritedRenderComponents(AContainerContext, APageContext);
    LayoutMgr.ProcessControls(AContainerContext, TIWBaseHTMLPageContext(APageContext));
    LayoutMgr.Process(ABuffer, AContainerContext, APageContext);
  finally
    LayoutMgr.SetContainer(nil);
  end;
end;

procedure TIWBSTabControl.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
var
  LBuffer: TIWRenderStream;
begin
  ContainerContext := AContainerContext;
  LBuffer := TIWRenderStream.Create(True, True);
  try
    InternalRenderComponents(AContainerContext, APageContext, LBuffer);
    FRegionDiv.Contents.AddBuffer(LBuffer);
  finally
    FreeAndNil(LBuffer);
  end;
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

function TIWBSTabControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
  xHTMLInput: string;
  i, tabIndex: integer;
  tagTabs, tag: TIWHTMLTag;
  TabPage: TIWTabPage;
begin
  MergeSortList(Pages, TabOrderCompare);
  CheckActiveVisible;

  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;
  FOldActivePage := ActivePage;

  // read only one time
  xHTMLName := HTMLName;
  xHTMLInput := xHTMLName + '_input';

  // main div
  FRegionDiv := TIWHTMLTag.CreateTag('div');
  FRegionDiv.AddStringParam('id', xHTMLName);
  FRegionDiv.AddClassParam('iwbs-tabs');
  FRegionDiv.AddClassParam(FGridOptions.GetClassString);
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

  // add script tag
  Result.Contents.AddText('<script>');
  try
{$IFDEF IWBSDYNTABS}
    if not FTabOptions.Justified and not FTabOptions.Stacked then
      Result.Contents.AddText('$("#'+xHTMLName+'_tabs'+'").bootstrapDynamicTabs();');
{$ENDIF}

    // save seleted tab on change
    Result.Contents.AddText('$("#'+xHTMLName+'_tabs").on("show.bs.tab", function(e){ document.getElementById("'+xHTMLInput+'").value=e.target.tabIndex; });');

    // event async change
    if Assigned(OnAsyncChange) then begin
      Result.Contents.AddText('$("#'+xHTMLName+'_tabs").on("shown.bs.tab", function(e){ executeAjaxEvent("&page="+e.target.tabIndex, null, "'+xHTMLName+'.DoOnAsyncChange", true, null, true); });');
      AContext.WebApplication.RegisterCallBack(xHTMLName+'.DoOnAsyncChange', DoOnAsyncChange);
    end;
  finally
    Result.Contents.AddText('</script>');
  end;

  IWBSRenderScript(Self, AContext, Result);
end;

procedure TIWBSTabControl.RenderScripts(AComponentContext: TIWCompContext);
begin
  //
end;

function TIWBSTabControl.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
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
    ExecuteAsyncJScript('$("#'+HTMLName+'_tabs a[tabindex='+IntToStr(ATabIndex)+']").css("display", "'+iif(Visible,'','none')+'");');
  end;
end;

procedure TIWBSTabControl.SetTabPageVisibility(ATabPage: TIWTabPage; Visible: boolean);
begin
  SetTabPageVisibility(Pages.IndexOf(ATabPage), Visible);
end;
{$endregion}

{$IFDEF IWBSDYNTABS}
initialization
  TIWBSLayoutMgr.AddLinkFile('/<iwbspath>/dyntabs/bootstrap-dynamic-tabs.css');
  TIWBSLayoutMgr.AddLinkFile('/<iwbspath>/dyntabs/bootstrap-dynamic-tabs.js');
{$ENDIF}

end.
