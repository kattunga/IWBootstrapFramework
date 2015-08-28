unit IWBSTabControl;

interface

uses
  System.SysUtils, System.Classes, System.StrUtils, Vcl.Controls, Vcl.Forms, Vcl.Graphics,
  IWVCLBaseContainer, IWApplication, IWBaseRenderContext,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompTabControl, IWBaseContainerLayout,
  IWRenderContext, IWHTMLTag, IWBSCommon, IWBSLayoutMgr;

type
  TIWTabPage = class(IWCompTabControl.TIWTabPage)
  public
    function CSSClass: string;
  end;

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

  TIWBSTabControl = class(TIWTabControl)
  private
    FChildRenderOptions: TIWBSChildRenderOptions;
    FGridOptions: TIWBSGridOptions;
    FTabOptions: TIWBSTabOptions;
    FFormType: TIWBSFormType;
  protected
    procedure SetGridOptions(const Value: TIWBSGridOptions);
    procedure SetTabOptions(const Value: TIWBSTabOptions);
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BSChildRenderOptions: TIWBSChildRenderOptions read FChildRenderOptions write FChildRenderOptions default [bschDisablePosition, bschDisableSize];
    property BSTabOptions: TIWBSTabOptions read FTabOptions write SetTabOptions;
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;

    property ClipRegion default false;
    property Color default clNone;
  end;

implementation

uses IWLists;

{$region 'THackCustomRegion'}
type
  THackCustomRegion = class(TIWCustomRegion)
  private
    function CallInheritedRenderHTML(AContext: TIWCompContext): TIWHTMLTag;
  end;

function THackCustomRegion.CallInheritedRenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited RenderHtml(AContext);
end;
{$endregion}

constructor TIWBSTabOptions.Create(AOwner: TComponent);
begin
  FFade := False;
  FPills := False;
  FJustified := False;
  FStacked := False;
end;

function TIWTabPage.CSSClass: string;
begin
  Result := 'tab-pane';
  if Parent is TIWBSTabControl then begin
    if TIWBSTabControl(Parent).BSTabOptions.Fade then
      Result := Result + ' fade';
    if TabOrder = TIWBSTabControl(Parent).ActivePage then
      Result := Result + ' active in';
  end;
end;

constructor TIWBSTabControl.Create(AOwner: TComponent);
begin
  inherited;
  FChildRenderOptions := [bschDisablePosition, bschDisableSize];
  FGridOptions := TIWBSGridOptions.Create(Self);
  FTabOptions := TIWBSTabOptions.Create(Self);
  Color := clNone;
end;

destructor TIWBSTabControl.Destroy;
begin
  FTabOptions.Free;
  FGridOptions.Free;
  inherited;
end;

procedure TIWBSTabControl.SetGridOptions(const Value: TIWBSGridOptions);
begin
  FGridOptions.Assign(Value);
end;

procedure TIWBSTabControl.SetTabOptions(const Value: TIWBSTabOptions);
begin
   FTabOptions.Assign(Value);
end;

function TIWBSTabControl.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  Result := TIWContainerContext.Create(AWebApplication, CacheControls);
  if (Self.LayoutMgr = nil) or not (Self.LayoutMgr.Able) then begin
    Self.LayoutMgr := TIWBSLayoutMgr.Create(Self);
    TIWBSLayoutMgr(Self.LayoutMgr).BSFormType := FFormType;
  end;
  Self.LayoutMgr.SetContainer(Self);
  Result.LayoutManager := Self.LayoutMgr;
end;

procedure TIWBSTabControl.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
var
  i, n: integer;
  TabPage: TIWTabPage;
begin
  n := IWComponentsCount;
  for i := 0 to n - 1 do begin
    if Component[i] is IWCompTabControl.TIWTabPage then begin
      TabPage := TIWTabPage(Component[i]);
      if TabPage.LayoutMgr = nil then begin
        TabPage.LayoutMgr := TIWBSLayoutMgr.Create(Self);
        TIWBSLayoutMgr(TabPage.LayoutMgr).BSFormType := FFormType;
      end;
      TabPage.LayoutMgr.SetContainer(TabPage);
      IWBSDisableChildRenderOptions(TabPage, FChildRenderOptions);
    end;
  end;
  inherited;
end;

function TIWBSTabControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  i, tabIndex: integer;
  tagTabs, tag: TIWHTMLTag;
  TabPage: TIWTabPage;
  formTag: TIWHTMLTag;
begin
  IWBSDisableAllRenderOptions(StyleRenderOptions);
  result := THackCustomRegion(Self).CallInheritedRenderHTML(AContext);

  // default class
  Result.AddClassParam('iwbs-tabs');

  // render bsgrid settings
  FGridOptions.RenderHTMLTag(Result);

  // tabs region
  tagTabs := result.Contents.AddTag('ul');
  tagTabs.AddClassParam('nav');
  if FTabOptions.Pills then
    tagTabs.AddClassParam('nav-pills')
  else
    tagTabs.AddClassParam('nav-tabs');
  if FTabOptions.Justified then
    tagTabs.AddClassParam('nav-justified');
  if FTabOptions.Stacked then
    tagTabs.AddClassParam('nav-stacked');

  tabIndex := 0;

  // build the tabs
  MergeSortList(Pages, TabOrderCompare);
  for i := 0 to Pages.Count-1 do begin
    TabPage := TIWTabPage(FPages.Items[i]);
    tag := tagTabs.Contents.AddTag('li');
    if ActivePage = TabPage.TabOrder then begin
      tag.AddClassParam('active');
      tabIndex := i;
    end;
    tag := tag.Contents.AddTag('a');
    tag.AddStringParam('data-toggle', IfThen(FTabOptions.Pills,'pill','tab'));
    tag.AddStringParam('href', '#'+TabPage.HTMLName);
    tag.Contents.AddText(TabPage.Title);
  end;

  // add hidden input element holding index of selected page
  formTag := Result.Contents.AddTag('FORM');
  formTag.AddStringParam('onSubmit', 'return FormDefaultSubmit();');
  formTag.Contents.AddHiddenField(HTMLName + '_input', HTMLName + '_input', IntToStr(tabIndex));
end;

end.
