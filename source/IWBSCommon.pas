unit IWBSCommon;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.Forms,
     IWTypes, IWContainer, IWControl, IWHTMLTag, IWCompTabControl;

type
  TIWBSFormType = (bsftNoForm, bsftInline, bsftHorizontal, bsftVertical);

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

  TIWBSFormOptions = class(TPersistent)
  private
    FCaptionsSize: TIWBSGridOptions;
    FInputsSize: TIWBSGridOptions;
  protected
    procedure SetCaptionsSize(const Value: TIWBSGridOptions);
    procedure SetInputsSize(const Value: TIWBSGridOptions);
  public
    constructor Create(AOwner: TControl);
    destructor Destroy; override;
    function GetOffsetClassString: string;
  published
    property CaptionsSize: TIWBSGridOptions read FCaptionsSize write SetCaptionsSize;
    property InputsSize: TIWBSGridOptions read FInputsSize write SetInputsSize;
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

procedure AddCssValue(var s: string; const Value: string);
begin
  if s <> '' then
    s := s + ' ';
  s := s + Value;
end;

function GetGridClassString(AGridXSOffset, AGridSMOffset, AGridMDOffset, AGridLGOffset, AGridXSSpan, AGridSMSpan, AGridMDSpan, AGridLGSpan: integer): string;
begin
  Result := '';
  if AGridXSOffset > 0 then
    AddCssValue(Result, 'col-xs-offset-'+IntToStr(AGridXSOffset));
  if AGridSMOffset > 0 then
    AddCssValue(Result, 'col-sm-offset-'+IntToStr(AGridSMOffset));
  if AGridMDOffset > 0 then
    AddCssValue(Result, 'col-md-offset-'+IntToStr(AGridMDOffset));
  if AGridLGOffset > 0 then
    AddCssValue(Result, 'col-lg-offset-'+IntToStr(AGridLGOffset));

  if (AGridXSSpan > 0) then
    AddCssValue(Result, 'col-xs-'+IntToStr(AGridXSSpan));
  if (AGridSMSpan > 0) then
    AddCssValue(Result, 'col-sm-'+IntToStr(AGridSMSpan));
  if (AGridMDSpan > 0) then
    AddCssValue(Result, 'col-md-'+IntToStr(AGridMDSpan));
  if (AGridLGSpan > 0) then
    AddCssValue(Result, 'col-lg-'+IntToStr(AGridLGSpan));
end;

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
begin
  Result := GetGridClassString(FGridXSOffset, FGridSMOffset, FGridMDOffset, FGridLGOffset, FGridXSSpan, FGridSMSpan, FGridMDSpan, FGridLGSpan);
end;
{$endregion}

{$region 'TIWBSFormOptions'}
constructor TIWBSFormOptions.Create(AOwner: TControl);
begin
  FCaptionsSize := TIWBSGridOptions.Create(AOwner);
  FInputsSize := TIWBSGridOptions.Create(AOwner);
end;

destructor TIWBSFormOptions.Destroy;
begin
  FCaptionsSize.Free;
  FInputsSize.Free;
  inherited;
end;

procedure TIWBSFormOptions.SetCaptionsSize(const Value: TIWBSGridOptions);
begin
  FCaptionsSize.Assign(Value);
end;

procedure TIWBSFormOptions.SetInputsSize(const Value: TIWBSGridOptions);
begin
  FInputsSize.Assign(Value);
end;

function TIWBSFormOptions.GetOffsetClassString: string;
begin
  Result := GetGridClassString(
    FCaptionsSize.FGridXSOffset+FCaptionsSize.FGridXSSpan+FInputsSize.FGridXSOffset,
    FCaptionsSize.FGridSMOffset+FCaptionsSize.FGridSMSpan+FInputsSize.FGridSMOffset,
    FCaptionsSize.FGridMDOffset+FCaptionsSize.FGridMDSpan+FInputsSize.FGridMDOffset,
    FCaptionsSize.FGridLGOffset+FCaptionsSize.FGridLGSpan+FInputsSize.FGridLGOffset,
    FInputsSize.FGridXSSpan,
    FInputsSize.FGridSMSpan,
    FInputsSize.FGridMDSpan,
    FInputsSize.FGridLGSpan);
end;
{$endregion}

end.
