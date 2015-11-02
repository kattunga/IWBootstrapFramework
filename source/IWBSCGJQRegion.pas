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
    FButtonGroupOptions: TIWBSButonGroupOptions;
    FGridOptions: TIWBSGridOptions;
    FPanelStyle: TIWBSPanelStyle;
    FRegionType: TIWBSRegionType;
    FRelativeSize: TIWBSRelativeSize;
  protected
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure SetButtonGroupOptions(AValue: TIWBSButonGroupOptions);
    procedure SetGridOptions(const Value: TIWBSGridOptions);
    procedure SetRegionType(AValue: TIWBSRegionType);
    procedure SetPanelStyle(AValue: TIWBSPanelStyle);
    procedure SetRelativeSize(AValue: TIWBSRelativeSize);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetClassString: string;
    function GetRoleString: string;
  published
    property BSButtonGroupOptions: TIWBSButonGroupOptions read FButtonGroupOptions write SetButtonGroupOptions;
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;
    property BSPanelStyle: TIWBSPanelStyle read FPanelStyle write SetPanelStyle default bspsDefault;
    property BSRegionType: TIWBSRegionType read FRegionType write SetRegionType default bsrtIWBSRegion;
    property BSRelativeSize: TIWBSRelativeSize read FRelativeSize write SetRelativeSize default bsrzDefault;
  end;

implementation

uses IWBSLayoutMgr, IWCGJQControl;

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
  FGridOptions := TIWBSGridOptions.Create;
  FButtonGroupOptions := TIWBSButonGroupOptions.Create(Self);
  FPanelStyle := bspsDefault;
  FRegionType := bsrtIWBSRegion;
  FRelativeSize := bsrzDefault;
end;

destructor TIWBSCGJQRegion.Destroy;
begin
  FButtonGroupOptions.Free;
  FGridOptions.Free;
  inherited;
end;

procedure TIWBSCGJQRegion.SetButtonGroupOptions(AValue: TIWBSButonGroupOptions);
begin
  FButtonGroupOptions.Assign(AValue);
  Invalidate;
end;

procedure TIWBSCGJQRegion.SetGridOptions(const Value: TIWBSGridOptions);
begin
  FGridOptions.Assign(Value);
end;

procedure TIWBSCGJQRegion.SetRegionType(AValue: TIWBSRegionType);
begin
  FRegionType := AValue;
  Invalidate;
end;

procedure TIWBSCGJQRegion.SetPanelStyle(AValue: TIWBSPanelStyle);
begin
  FPanelStyle := AValue;
  Invalidate;
end;

procedure TIWBSCGJQRegion.SetRelativeSize(AValue: TIWBSRelativeSize);
begin
  FRelativeSize := AValue;
  Invalidate;
end;

function TIWBSCGJQRegion.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  if not (Self.LayoutMgr is TIWBSLayoutMgr) then
    Self.LayoutMgr := TIWBSLayoutMgr.Create(Self);
  Result := inherited;
end;

procedure TIWBSCGJQRegion.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  TIWBSRegionCommon.PrepareChildComponentsForRender(Self);
  inherited;
end;

function TIWBSCGJQRegion.GetClassString: string;
const
  aIWBSPanelStyle: array[bspsDefault..bspsDanger] of string = ('panel-default', 'panel-primary', 'panel-success', 'panel-info', 'panel-warning', 'panel-danger');
var
  s: string;
begin
  Result := aIWBSRegionType[FRegionType];

  if FRegionType = bsrtPanel then
    Result := Result + ' ' + aIWBSPanelStyle[FPanelStyle]

  else if (FRegionType = bsrtWell) and (FRelativeSize <> bsrzDefault) then
    Result := Result + ' well-' + aIWBSRelativeSize[FRelativeSize]

  else if FRegionType = bsrtButtonGroup then
    begin
      if FButtonGroupOptions.Vertical then
        Result := Result + '-vertical';
      if FButtonGroupOptions.Size <> bsszDefault then
        Result := Result + ' btn-group-'+aIWBSSize[FButtonGroupOptions.Size];
      if FButtonGroupOptions.Justified then
        Result := Result + ' btn-group-justified';
    end;

  s := FGridOptions.GetClassString;
  if s <> '' then
    Result := Result + ' ' + s;

  if Css <> '' then
    Result := Result + ' ' + Css;
end;

function TIWBSCGJQRegion.GetRoleString: string;
begin
  if FRegionType = bsrtButtonToolbar then
    Result := 'toolbar'
  else if FRegionType = bsrtButtonGroup then
    Result := 'group'
  else
    Result := '';
end;

function TIWBSCGJQRegion.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  LStyle: string;
begin
  // do not render Styles
  TIWBSRegionCommon.DisableRenderOptions(StyleRenderOptions);

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
  Result.Params.Values['class'] := GetClassString;

  // role
  Result.Params.Values['role'] := GetRoleString;
end;

end.
