unit IWBSRegion;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer, IWApplication, IWBaseRenderContext,
  IWBaseContainerLayout, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IW.Common.Strings,
  IWRenderContext, IWHTMLTag, IWBaseInterfaces,
  IWBSCommon, IWBSLayoutMgr;

type

  TIWBSCustomRegion = class(TIWCustomRegion)
  private
    FChildRenderOptions: TIWBSChildRenderOptions;
    FCss: string;
    FGridOptions: TIWBSGridOptions;
    FFormType: TIWBSFormType;
  protected
    procedure SetGridOptions(const Value: TIWBSGridOptions);
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    property BSFormType: TIWBSFormType read FFormType write FFormType default bsftNoForm;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BSChildRenderOptions: TIWBSChildRenderOptions read FChildRenderOptions write FChildRenderOptions default [bschDisablePosition, bschDisableSize];
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;
    property Css: string read FCss write FCss;
  end;

  TIWBSRegion = class(TIWBSCustomRegion)
  private
    FRegionType: TIWBSRegionType;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Align;
    property BSRegionType: TIWBSRegionType read FRegionType write FRegionType default bsrtIWBSRegion;
    property BSFormType;
  end;

  TIWBSBtnGroupOptions = class(TPersistent)
  private
    FVertical: boolean;
    FJustified: boolean;
    FSize: TIWBSSize;
  public
    constructor Create(AOwner: TComponent);
  published
    property Vertical: boolean read FVertical write FVertical default false;
    property Justified: boolean read FJustified write FJustified default false;
    property Size: TIWBSSize read FSize write FSize default bsszDefault;
  end;

  TIWBSBtnGroup = class(TIWBSCustomRegion)
  private
    FBGOptions: TIWBSBtnGroupOptions;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property BGOptions: TIWBSBtnGroupOptions read FBGOptions write FBGOptions;
  end;

  TIWBSBtnToolBar = class(TIWBSCustomRegion)
  public
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  end;

implementation

{$region 'TIWBSCustomRegion'}
constructor TIWBSCustomRegion.Create(AOwner: TComponent);
begin
  inherited;

  FChildRenderOptions := [bschDisablePosition, bschDisableSize];
  FCss := '';
  FGridOptions := TIWBSGridOptions.Create(Self);
  FFormType := bsftNoForm;

  ClipRegion := False;

  // esto sirve para hacel el calculo automatico de ancho de columnas
  // lo leemos en la creacion del componente sino en runtime no funciona
  if AOwner is TWinControl then
    Width := TWinControl(AOwner).Width;
end;

destructor TIWBSCustomRegion.Destroy;
begin
  FGridOptions.Free;
  inherited;
end;

procedure TIWBSCustomRegion.SetGridOptions(const Value: TIWBSGridOptions);
begin
  FGridOptions.Assign(Value);
end;

function TIWBSCustomRegion.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  Result := TIWContainerContext.Create(AWebApplication, CacheControls);
  if (Self.LayoutMgr = nil) or not (Self.LayoutMgr.Able) then begin
    Self.LayoutMgr := TIWBSLayoutMgr.Create(Self);
    TIWBSLayoutMgr(Self.LayoutMgr).BSFormType := FFormType;
  end;
  Self.LayoutMgr.SetContainer(Self);
  Result.LayoutManager := Self.LayoutMgr;
end;

procedure TIWBSCustomRegion.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  IWBSDisableChildRenderOptions(Self, FChildRenderOptions);
  inherited;
end;

function TIWBSCustomRegion.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := '';
end;

function TIWBSCustomRegion.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  IWBSDisableAllRenderOptions(StyleRenderOptions);
  Result := inherited;
  Result.AddClassParam(FCss);
  FGridOptions.RenderHTMLTag(Result);
end;
{$endregion}

{$region 'TIWBSRegion'}
constructor TIWBSRegion.Create(AOwner: TComponent);
begin
  inherited;
  FRegionType := bsrtIWBSRegion;
end;

function TIWBSRegion.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result.AddClassParam(aIWBSRegionType[FRegionType]);
end;
{$endregion}

{$region 'TIWBSBtnGroup'}
constructor TIWBSBtnGroupOptions.Create(AOwner: TComponent);
begin
  FVertical := false;
  FJustified := false;
  FSize := bsszDefault;
end;

constructor TIWBSBtnGroup.Create(AOwner: TComponent);
begin
  inherited;
  FBGOptions := TIWBSBtnGroupOptions.Create(Self);
end;

destructor TIWBSBtnGroup.Destroy;
begin
  FBGOptions.Free;
  inherited;
end;

function TIWBSBtnGroup.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  if FBGOptions.FVertical then
    Result.AddClassParam('btn-group-vertical')
  else
    Result.AddClassParam('btn-group');
  if FBGOptions.FSize <> bsszDefault then
    Result.AddClassParam('btn-group-'+aIWBSSize[FBGOptions.FSize]);
  if FBGOptions.FJustified then
    Result.AddClassParam('btn-group-justified');
  Result.AddStringParam('role','group');
end;
{$endregion}

{$region 'TIWBSBtnToolBar'}
function TIWBSBtnToolBar.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result.AddClassParam('btn-toolbar');
  Result.AddStringParam('role','toolbar');
end;
{$endregion}

end.
