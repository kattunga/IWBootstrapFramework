unit IWBSCommon;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.Forms,
     IWTypes, IWContainer, IWControl, IWHTMLTag, IWCompTabControl;

type
  TIWBSFormType = (bsftNoForm, bsftInline, bsftHorizontal, bsftVertical);
  TIWBSChildRenderOption = (bschDisablePosition, bschDisableSize, bschDisableFont, bschDisableBorder);
  TIWBSChildRenderOptions = set of TIWBSChildRenderOption;

type
  TIWBSSize = (bsszDefault, bsszLg, bsszMd, bsszSm, bsszXs);

const
  aIWBSSize: array[bsszDefault..bsszXs] of string = ('', 'lg', 'md', 'sm', 'xs');

type
  TIWBSRelativeSize = (bsrzDefault, bsrzLg, bsrzSm);

const
  aIWBSRelativeSize: array[bsrzDefault..bsrzSm] of string = ('', 'lg', 'sm');

type
  TIWBSTextAlignment = (bstaDefault, bstaLeft, bstaCenter, bstaRight, bstaJustify, bstaNowrap);
  TIWBSTextCase = (bstcDefault, bstcLowercase, bstcUppercase, bstcCapitalize);

const
  aIWBSTextAlignment: array[bstaDefault..bstaNowrap] of string = ('', 'text-left', 'text-center', 'text-right', 'text-justify', 'text-nowrap');
  aIWBSTextCase: array[bstcDefault..bstcCapitalize] of string = ('', 'text-lowercase', 'text-uppercase', 'text-capitalize');

type
  TIWBSRegionType = (bsrtNone, bsrtContainer, bsrtContainerFluid, bsrtRow, bsrtColumn,
                     bsrtJumbotron, bsrtPageHeader, bsrtWell,
                     bsrtIWBSRegion, bsrtIWBSToolbar,
                     bsrtButtonToolbar, bsrtButtonGroup,
                     bsrtModalContent, bsrtModalHeader, bsrtModalTitle, bsrtModalBody, bsrtModalFooter,
                     bsrtPanel, bsrtPanelBody, bsrtPanelHeading, bsrtPanelTitle, bsrtPanelFooter);

const
  aIWBSRegionType: array [bsrtNone..bsrtPanelFooter] of string =
                    ('', 'container', 'container-fluid', 'row', 'column',
                     'jumbotron', 'page-header', 'well',
                     'iwbs-region', 'iwbs-toolbar',
                     'btn-toolbar', 'btn-group',
                     'modal-content', 'modal-heading', 'modal-title', 'modal-body', 'modal-footer',
                     'panel', 'panel-body', 'panel-heading', 'panel-title', 'panel-footer');

type
  TIWBSCssHeight = (css_hg_none, css_hg_fill, css_hg_fill_container, css_hg_toolbar, css_hg_fill_toolbar);
  TIWBSCssClass  = (css_none, css_region, css_toolbar, css_toolbar_separator);

const
  aIWBSCssHeight: array [css_hg_none..css_hg_fill_toolbar] of string =
    ('', 'iwbs-hg-fill', 'iwbs-hg-fill-container', 'iwbs-hg-toolbar', 'iwbs-hg-fill-toolbar');
  aIWBSCssClass:  array [css_none..css_toolbar_separator] of string =
    ('', 'iwbs-region', 'iwbs-toolbar', 'iwbs-toolbar-separator');

type
  TIWBSContextualStyle = (bsbsDefault, bsbsPrimary, bsbsSuccess, bsbsInfo, bsbsWarning, bsbsDanger, bsbsLink);

const
  aIWBSContextualStyle: array[bsbsDefault..bsbsLink] of string = ('default', 'primary', 'success', 'info', 'warning', 'danger', 'link');

type
  TIWTabPage = class(IWCompTabControl.TIWTabPage)
  public
    function CSSClass: string;
    property LayoutMgr;
  end;

  TIWBSGridOptions = class(TPersistent)
  private
    FOwner: TControl;
    FGridXSOffset: integer;
    FGridXSSpan: integer;
    FGridSMOffset: integer;
    FGridSMSpan: integer;
    FGridMDOffset: integer;
    FGridMDSpan: integer;
    FGridLGOffset: integer;
    FGridLGSpan: integer;
  public
    constructor Create(AOwner: TControl);
    function GetClassString: string;
  published
    property GridXSOffset: integer read FGridXSOffset write FGridXSOffset default 0;
    property GridXSSpan: integer read FGridXSSpan write FGridXSSpan default 0;
    property GridSMOffset: integer read FGridSMOffset write FGridSMOffset default 0;
    property GridSMSpan: integer read FGridSMSpan write FGridSMSpan default 0;
    property GridMDOffset: integer read FGridMDOffset write FGridMDOffset default 0;
    property GridMDSpan: integer read FGridMDSpan write FGridMDSpan default 0;
    property GridLGOffset: integer read FGridLGOffset write FGridLGOffset default 0;
    property GridLGSpan: integer read FGridLGSpan write FGridLGSpan default 0;
  end;

type
  TIWBSRenderingSortMethod = (bsrmSortYX, bsrmSortXY);

var
  aIWBSRenderingSortMethod: TIWBSRenderingSortMethod = bsrmSortYX;
  aIWBSRenderingGridPrecision: integer = 12;

//******************************************************************************

implementation

uses IWBaseInterfaces, IWHTML40Interfaces, IWLists, IWBaseHTMLControl, IWHTMLContainer,
     IWRegion, IWBSTabControl, IWBSLayoutMgr;

{$region 'TIWTabPage'}
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
{$endregion}

{$region 'TIWBSGridOptions'}
constructor TIWBSGridOptions.Create(AOwner: TControl);
begin
  FOwner := AOwner;
  FGridXSOffset := 0;
  FGridXSSpan   := 0;
  FGridSMOffset := 0;
  FGridSMSpan   := 0;
  FGridMDOffset := 0;
  FGridMDSpan   := 0;
  FGridLGOffset := 0;
  FGridLGSpan   := 0;
end;

function TIWBSGridOptions.GetClassString: string;
  procedure AddValue(var s: string; const Value: string);
  begin
    if s <> '' then
      s := s + ' ';
    s := s + Value;
  end;
begin
  Result := '';
  if FGridXSOffset > 0 then
    AddValue(Result, 'col-xs-offset-'+IntToStr(FGridXSOffset));
  if FGridSMOffset > 0 then
    AddValue(Result, 'col-sm-offset-'+IntToStr(FGridSMOffset));
  if FGridMDOffset > 0 then
    AddValue(Result, 'col-md-offset-'+IntToStr(FGridMDOffset));
  if FGridLGOffset > 0 then
    AddValue(Result, 'col-lg-offset-'+IntToStr(FGridLGOffset));

  if (FGridXSSpan > 0) then
    AddValue(Result, 'col-xs-'+IntToStr(FGridXSSpan));
  if (FGridSMSpan > 0) then
    AddValue(Result, 'col-sm-'+IntToStr(FGridSMSpan));
  if (FGridMDSpan > 0) then
    AddValue(Result, 'col-md-'+IntToStr(FGridMDSpan));
  if (FGridLGSpan > 0) then
    AddValue(Result, 'col-lg-'+IntToStr(FGridLGSpan));
end;
{$endregion}

end.
