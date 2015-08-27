unit IWBSCGJQRegion;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer, IWApplication, IWBaseRenderContext,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IW.Common.Strings,
  IWRenderContext, IWHTMLTag,
  IWCGJQRegion, IWBSCommon;

type
  TIWBSCGJQRegion = class(TIWCGJQCustomRegion)
  private
    FChildRenderOptions: TIWBSChildRenderOptions;
    FGridOptions: TIWBSGridOptions;
    FFormType: TIWBSFormType;
    FRegionType: TIWBSRegionType;
  protected
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure SetGridOptions(const Value: TIWBSGridOptions);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BSChildRenderOptions: TIWBSChildRenderOptions read FChildRenderOptions write FChildRenderOptions default [bschDisablePosition, bschDisableSize];
    property BSRegionType: TIWBSRegionType read FRegionType write FRegionType default bsrtIWBSRegion;
    property BSFormType: TIWBSFormType read FFormType write FFormType default bsftNoForm;
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;
  end;

implementation

uses IWBSLayoutMgr;


constructor TIWBSCGJQRegion.Create(AOwner: TComponent);
begin
  inherited;

  // reset inherited classes
  Css := '';

  // bootstrap settings
  FRegionType := bsrtIWBSRegion;
  FChildRenderOptions := [bschDisablePosition, bschDisableSize];
  FGridOptions := TIWBSGridOptions.Create(Self);
  FFormType := bsftNoForm;

  // esto sirve para hacel el calculo automatico de ancho de columnas
  // lo leemos en la creacion del componente sino en runtime no funciona
  if AOwner is TWinControl then
    Width := TWinControl(AOwner).Width;
end;

destructor TIWBSCGJQRegion.Destroy;
begin
  FGridOptions.Free;
  inherited;
end;

procedure TIWBSCGJQRegion.SetGridOptions(const Value: TIWBSGridOptions);
begin
  FGridOptions.Assign(Value);
end;

function TIWBSCGJQRegion.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  Result := TIWContainerContext.Create(AWebApplication, CacheControls);
  if (Self.LayoutMgr = nil) or not (Self.LayoutMgr.Able) then begin
    Self.LayoutMgr := TIWBSLayoutMgr.Create(Self);
    TIWBSLayoutMgr(Self.LayoutMgr).BSFormType := FFormType;
  end;
  Self.LayoutMgr.SetContainer(Self);
  Result.LayoutManager := Self.LayoutMgr;
end;

procedure TIWBSCGJQRegion.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  IWBSDisableChildRenderOptions(Self, FChildRenderOptions);
  inherited;
end;

function TIWBSCGJQRegion.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  // do not render Styles
  IWBSDisableAllRenderOptions(StyleRenderOptions);

  // do not render borders
  CGAppearanceSettings.BorderVisibilty := [];
  CGAppearanceSettings.Corners := False;

  // do not render anything
  CGRenderAsyncSize := False;
  CGRenderIWBorders := False;

  Result := inherited;

  // damn cgdevtools still rendering borders
  Result.Params.Values['style'] := '';

  // css
  Result.Params.Values['class'] := aIWBSRegionType[FRegionType];
  if Css <> '' then
    Result.AddClassParam(Css);

  // grid settings
  FGridOptions.RenderHTMLTag(Result);
end;

end.
