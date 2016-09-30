unit IWBSRegion;

interface

uses
  SysUtils, Classes, Controls, StrUtils,
  IWBSCommon,
  IWBSCustomregion;

type
  TIWBSRegionBack = (bsrbDefault, bsrbPrimary, bsrbSuccess, bsrbInfo, bsrbWarning, bsrbDanger);

const
  aIWBSRegionBack: array[bsrbDefault..bsrbDanger] of string = ('default', 'primary', 'success', 'info', 'warning', 'danger');

type
  TIWBSRegionType = (bsrtNone, bsrtContainer, bsrtContainerFluid, bsrtRow, bsrtColumn,
                     bsrtDropDown, bsrtDropDownMenu,
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
                     'dropdown', 'dropdown-menu',
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
    FBackground: TIWBSRegionBack;
    FRegionType: TIWBSRegionType;
    FTagType: TIWBSRegionTagType;
    procedure SetRegionType(AValue: TIWBSRegionType);
    procedure SetBackground(AValue: TIWBSRegionBack);
    procedure SetTagType(const Value: TIWBSRegionTagType);
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    function GetRoleString: string; override;
  published
    property BSBackground: TIWBSRegionBack read FBackground write SetBackground default bsrbDefault;
    property BSRegionType: TIWBSRegionType read FRegionType write SetRegionType default bsrtNone;
    property TagType: TIWBSRegionTagType read FTagType write SetTagType default bsttDiv;
  end;

implementation

uses IWBSNavBar;

procedure TIWBSRegion.InternalRenderCss(var ACss: string);
begin
  TIWBSCommon.AddCssClass(ACss, aIWBSRegionType[FRegionType]);

  if (FRegionType = bsrtPanel) then
    TIWBSCommon.AddCssClass(ACss, 'panel-'+aIWBSRegionBack[FBackground])
  else if (FRegionType in [bsrtWell, bsrtWellLarge, bsrtWellSmall]) and (FBackground <> bsrbDefault) then
    TIWBSCommon.AddCssClass(ACss, 'well-'+aIWBSRegionBack[FBackground])
  else if (FBackground <> bsrbDefault)  then
    TIWBSCommon.AddCssClass(ACss, 'bg-'+aIWBSRegionBack[FBackground])
  else if (Parent is TIWBSNavBar) then
    TIWBSCommon.AddCssClass(ACss, 'navbar-btn');

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

procedure TIWBSRegion.SetBackground(AValue: TIWBSRegionBack);
begin
  FBackground := AValue;
  Invalidate;
end;

end.
