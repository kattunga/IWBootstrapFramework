unit IWBSCGJQRegion;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer, IWApplication, IWBaseRenderContext,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IW.Common.Strings,
  IWRenderContext, IWHTMLTag,
  IWCGJQRegion, IWBSCommon, IWBSRegionCommon;

type
  TIWBSCGJQRegion = class(TIWCGJQCustomRegion)
  private
    FFormType: TIWBSFormType;
    FGridOptions: TIWBSGridOptions;
    FLayoutMrg: boolean;
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
    property BSFormType: TIWBSFormType read FFormType write FFormType default bsftNoForm;
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;
    property BSLayoutMgr: boolean read FLayoutMrg write FLayoutMrg default True;
    property BSRegionType: TIWBSRegionType read FRegionType write FRegionType default bsrtIWBSRegion;
  end;

implementation

uses IWBSLayoutMgr, IWBSUtils, IWCGJQControl;

procedure RemoveIWCssAttr(var AIWStyle: string; AAttr: string);
var
  SL: TIWCGStyle;
  Index: Integer;
begin
  SL:= TIWCGStyle.Create;
  try
    SL.IWStyle:= AIWStyle;
    Index:= SL.IndexOfName(AAttr);
    if Index >= 0 then
      SL.Delete(Index);
    AIWStyle:= SL.IWStyle;
  finally
    SL.Free;
  end;
end;

constructor TIWBSCGJQRegion.Create(AOwner: TComponent);
begin
  inherited;

  // reset inherited classes
  Css := '';

  // bootstrap settings
  FRegionType := bsrtIWBSRegion;
  FGridOptions := TIWBSGridOptions.Create;
  FFormType := bsftNoForm;
  FLayoutMrg := True;
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
  if FLayoutMrg then begin
    if not (Self.LayoutMgr is TIWBSLayoutMgr) then
      Self.LayoutMgr := TIWBSLayoutMgr.Create(Self);
    TIWBSLayoutMgr(Self.LayoutMgr).BSFormType := FFormType;
  end;
  Result := inherited;
end;

procedure TIWBSCGJQRegion.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  if FLayoutMrg then
    IWBSPrepareChildComponentsForRender(Self, FFormType);
  inherited;
end;

function TIWBSCGJQRegion.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  LStyle: string;
begin
  // do not render Styles
  IWBSDisableRenderOptions(StyleRenderOptions);

  // do not render borders
  CGAppearanceSettings.BorderVisibilty := [];
  CGAppearanceSettings.Corners := False;

  // do not render anything
  CGRenderAsyncSize := False;
  CGRenderIWBorders := False;

  Result := inherited;

  // cgdevtools has a bug where it render borders still when StyleRenderOptions.RenderBorder = False
  LStyle := Result.Params.Values['style'];
  RemoveIWCssAttr(LStyle, 'border-top');
  RemoveIWCssAttr(LStyle, 'border-left');
  RemoveIWCssAttr(LStyle, 'border-right');
  RemoveIWCssAttr(LStyle, 'border-bottom');
  Result.Params.Values['style'] := LStyle;

  // css
  Result.Params.Values['class'] := aIWBSRegionType[FRegionType];

  Result.AddClassParam(FGridOptions.GetClassString);

  Result.AddClassParam(Css);
end;

end.
