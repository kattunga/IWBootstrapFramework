unit IWBSRegion;

interface

uses
  SysUtils, Classes, Controls, StrUtils,
  IWBSCommon,
  IWBSCustomregion;

type
  TIWBSPanelStyle = (bspsDefault, bspsPrimary, bspsSuccess, bspsInfo, bspsWarning, bspsDanger);

const
  aIWBSPanelStyle: array[bspsDefault..bspsDanger] of string = ('panel-default', 'panel-primary', 'panel-success', 'panel-info', 'panel-warning', 'panel-danger');

type
  TIWBSRegionType = (bsrtNone, bsrtContainer, bsrtContainerFluid, bsrtRow, bsrtColumn,
                     bsrtFormGroup,
                     bsrtJumbotron, bsrtPageHeader,
                     bsrtWell, bsrtWellLarge, bsrtWellSmall,
                     bsrtButtonToolbar,
                     bsrtListGroup,
                     bsrtModalContent, bsrtModalHeader, bsrtModalBody, bsrtModalFooter,
                     bsrtPanelGroup, bsrtPanel, bsrtPanelBody, bsrtPanelHeading, bsrtPanelFooter);

const
  aIWBSRegionType: array [bsrtNone..bsrtPanelFooter] of string =
                    ('', 'container', 'container-fluid', 'row', 'column',
                     'form-group',
                     'jumbotron', 'page-header',
                     'well', 'well well-lg', 'well well-sm',
                     'btn-toolbar',
                     'list-group',
                     'modal-content', 'modal-header', 'modal-body', 'modal-footer',
                     'panel-group', 'panel', 'panel-body', 'panel-heading', 'panel-footer');

type
  TIWBSRegionTagType = (bsttDiv, bsttH1, bsttH2, bsttH3, bsttH4, bsttH5, bsttH6, bsttP);

const
  aIWBSRegionTagType: array[bsttDiv..bsttP] of string = ('div', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p');

type
  TIWBSRegion = class(TIWBSCustomRegion)
  private
    FPanelStyle: TIWBSPanelStyle;
    FRegionType: TIWBSRegionType;
    FTagType: TIWBSRegionTagType;
    procedure SetRegionType(AValue: TIWBSRegionType);
    procedure SetPanelStyle(AValue: TIWBSPanelStyle);
    procedure SetTagType(const Value: TIWBSRegionTagType);
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetRoleString: string; override;
  published
    property BSPanelStyle: TIWBSPanelStyle read FPanelStyle write SetPanelStyle default bspsDefault;
    property BSRegionType: TIWBSRegionType read FRegionType write SetRegionType default bsrtNone;
    property TagType: TIWBSRegionTagType read FTagType write SetTagType default bsttDiv;
  end;

implementation

constructor TIWBSRegion.Create(AOwner: TComponent);
begin
  inherited;
  FPanelStyle := bspsDefault;
  FRegionType := bsrtNone;
end;

procedure TIWBSRegion.InternalRenderCss(var ACss: string);
begin
  TIWBSCommon.AddCssClass(ACss, aIWBSRegionType[FRegionType]);

  if FRegionType = bsrtPanel then
    TIWBSCommon.AddCssClass(ACss, aIWBSPanelStyle[FPanelStyle]);

  inherited;
end;

function TIWBSRegion.GetRoleString: string;
begin
  if FRegionType = bsrtButtonToolbar then
    Result := 'toolbar'
  else
    Result := '';
end;

procedure TIWBSRegion.SetRegionType(AValue: TIWBSRegionType);
begin
  FRegionType := AValue;
  Invalidate;
end;

procedure TIWBSRegion.SetTagType(const Value: TIWBSRegionTagType);
begin
  FTagType := Value;
  FTagName := aIWBSRegionTagType[Value];
  AsyncRefreshControl;
end;

procedure TIWBSRegion.SetPanelStyle(AValue: TIWBSPanelStyle);
begin
  FPanelStyle := AValue;
  Invalidate;
end;

end.
