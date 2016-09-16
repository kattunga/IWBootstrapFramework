unit IWBSRegion;

interface

uses
  SysUtils, Classes, Controls, StrUtils,

  IWBSCommon, IWBSRegionCommon,
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
                     bsrtModalContent, bsrtModalHeader, bsrtModalBody, bsrtModalFooter,
                     bsrtPanelGroup, bsrtPanel, bsrtPanelBody, bsrtPanelHeading, bsrtPanelFooter);

const
  aIWBSRegionType: array [bsrtNone..bsrtPanelFooter] of string =
                    ('', 'container', 'container-fluid', 'row', 'column',
                     'form-group',
                     'jumbotron', 'page-header',
                     'well', 'well well-lg', 'well well-sm',
                     'btn-toolbar',
                     'modal-content', 'modal-header', 'modal-body', 'modal-footer',
                     'panel-group', 'panel', 'panel-body', 'panel-heading', 'panel-footer');

type
  TIWBSRegion = class(TIWBSCustomRegion)
  private
    FPanelStyle: TIWBSPanelStyle;
    FRegionType: TIWBSRegionType;
    procedure SetRegionType(AValue: TIWBSRegionType);
    procedure SetPanelStyle(AValue: TIWBSPanelStyle);
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetRoleString: string; override;
  published
    property BSPanelStyle: TIWBSPanelStyle read FPanelStyle write SetPanelStyle default bspsDefault;
    property BSRegionType: TIWBSRegionType read FRegionType write SetRegionType default bsrtNone;
  end;

  TIWBSUnorderedList = class(TIWBSCustomRegion)
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TIWBSButtonGroup = class(TIWBSCustomRegion)
  private
    FButtonGroupOptions: TIWBSButonGroupOptions;
    procedure SetButtonGroupOptions(AValue: TIWBSButonGroupOptions);
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetRoleString: string; override;
  published
    property BSButtonGroupOptions: TIWBSButonGroupOptions read FButtonGroupOptions write SetButtonGroupOptions;
  end;

implementation

uses
  IWBSNavBar;

{$region 'TIWBSRegion'}
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

procedure TIWBSRegion.SetPanelStyle(AValue: TIWBSPanelStyle);
begin
  FPanelStyle := AValue;
  Invalidate;
end;
{$endregion}

{$region 'TIWBSUnorderedList'}
constructor TIWBSUnorderedList.Create(AOwner: TComponent);
begin
  inherited;
  FTagType := 'ul';
end;

procedure TIWBSUnorderedList.InternalRenderCss(var ACss: string);
begin
  if Parent is TIWBSNavBarBase then
    TIWBSCommon.AddCssClass(ACss, 'nav navbar-nav')
  else
    TIWBSCommon.AddCssClass(ACss, 'list-group');

  inherited;
end;
{$endregion}

{$region 'TIWBSButtonGroup'}
constructor TIWBSButtonGroup.Create(AOwner: TComponent);
begin
  inherited;
  FButtonGroupOptions := TIWBSButonGroupOptions.Create(Self);
end;

destructor TIWBSButtonGroup.Destroy;
begin
  FreeAndNil(FButtonGroupOptions);
  inherited;
end;

function TIWBSButtonGroup.GetRoleString: string;
begin
  Result := 'group';
end;

procedure TIWBSButtonGroup.InternalRenderCss(var ACss: string);
begin
  ACss := 'btn-group';
  if FButtonGroupOptions.Vertical then
    ACss := ACss + '-vertical';
  if FButtonGroupOptions.Size <> bsszDefault then
    ACss := ACss + ' btn-group-'+aIWBSSize[FButtonGroupOptions.Size];
  if FButtonGroupOptions.Justified then
    ACss := ACss + ' btn-group-justified';
  inherited;
end;

procedure TIWBSButtonGroup.SetButtonGroupOptions(AValue: TIWBSButonGroupOptions);
begin
  FButtonGroupOptions.Assign(AValue);
  Invalidate;
end;
{$endregion}

end.
