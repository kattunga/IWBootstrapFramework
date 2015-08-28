unit IWBSCommon;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.Forms,
     IWTypes, IWContainer, IWControl, IWHTMLTag;

type
  TIWBSFormType = (bsftNoForm, bsftInline, bsftHorizontal, bsftVertical);
  TIWBSChildRenderOption = (bschDisablePosition, bschDisableSize, bschDisableFont, bschDisableBorder);
  TIWBSChildRenderOptions = set of TIWBSChildRenderOption;

type
  TIWBSSize = (bsszDefault, bsszLg, bsszMd, bsszSm, bsszXs);

const
  aIWBSSize: array[bsszDefault..bsszXs] of string = ('', 'lg', 'md', 'sm', 'xs');

type
  TIWBSTextAlignment = (bstaDefault, bstaLeft, bstaCenter, bstaRight, bstaJustify, bstaNowrap);
  TIWBSTextCase = (bstcDefault, bstcLowercase, bstcUppercase, bstcCapitalize);

const
  aIWBSTextAlignment: array[bstaDefault..bstaNowrap] of string = ('', 'text-left', 'text-center', 'text-right', 'text-justify', 'text-nowrap');
  aIWBSTextCase: array[bstcDefault..bstcCapitalize] of string = ('', 'text-lowercase', 'text-uppercase', 'text-capitalize');

type
  TIWBSRegionType = (bsrtNone, bsrtContainer, bsrtContainerFluid, bsrtRow, bsrtColumn, bsrtJumbotron, bsrtPageHeader, bsrtIWBSRegion, bsrtIWBSToolbar);

const
  aIWBSRegionType: array [bsrtNone..bsrtIWBSToolbar] of string = ('', 'container', 'container-fluid', 'row', 'column', 'jumbotron', 'page-header', 'iwbs-region', 'iwbs-toolbar');

type
  TIWBSCssHeight = (css_hg_none, css_hg_fill, css_hg_fill_container, css_hg_toolbar, css_hg_fill_toolbar);
  TIWBSCssClass  = (css_none, css_region, css_toolbar, css_toolbar_separator);

const
  aIWBSCssHeight: array [css_hg_none..css_hg_fill_toolbar] of string =
    ('', 'iwbs-hg-fill', 'iwbs-hg-fill-container', 'iwbs-hg-toolbar', 'iwbs-hg-fill-toolbar');
  aIWBSCssClass:  array [css_none..css_toolbar_separator] of string =
    ('', 'iwbs-region', 'iwbs-toolbar', 'iwbs-toolbar-separator');

type
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
    procedure RenderHTMLTag(Tag: TIWHTMLTag);
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

  procedure IWBSDisableAllRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);
  procedure IWBSDisableChildRenderOptions(AContainer: TIWContainer; AChildRenderOptions: TIWBSChildRenderOptions);

  function  IWBSGetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;

implementation

uses IWBaseInterfaces, IWHTML40Interfaces, IWLists, IWBaseHTMLControl, IWHTMLContainer;

procedure IWBSDisableAllRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);
begin
  StyleRenderOptions.RenderAbsolute := False;
  StyleRenderOptions.RenderBorder := False;
  StyleRenderOptions.RenderFont := False;
  StyleRenderOptions.RenderPadding := False;
  StyleRenderOptions.RenderPosition := False;
  StyleRenderOptions.RenderSize := False;
  StyleRenderOptions.RenderStatus := False;
end;

procedure IWBSDisableChildRenderOptions(AContainer: TIWContainer; AChildRenderOptions: TIWBSChildRenderOptions);
var
  i: integer;
  LBaseControl: IIWBaseControl;
  LHTML40Control: IIWHTML40Control;
begin
  for i := 0 to AContainer.IWComponentsCount - 1 do begin
    LBaseControl := BaseControlInterface(AContainer.Component[i]);
    if Assigned(LBaseControl) then begin
      LHTML40Control := HTML40ControlInterface(AContainer.Component[i]);
      if bschDisablePosition in AChildRenderOptions then begin
        LHTML40Control.StyleRenderOptions.RenderPosition := False;
        LHTML40Control.StyleRenderOptions.RenderAbsolute := False;
      end;
      if bschDisableSize in AChildRenderOptions then begin
        LHTML40Control.StyleRenderOptions.RenderSize := False;
        LHTML40Control.StyleRenderOptions.RenderPadding := False;
      end;
      if bschDisableFont in AChildRenderOptions then
        LHTML40Control.StyleRenderOptions.RenderFont := False;
      if bschDisableBorder in AChildRenderOptions then
        LHTML40Control.StyleRenderOptions.RenderBorder := False;
    end;
  end;
end;

function IWBSGetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;
var
  i: Integer;
begin
  Result:= APrefix;
  i:= 0;
  while Assigned(AOwner.FindComponent(Result)) do begin
    inc(i);
    Result:= APrefix + IntToStr(i);
  end;
end;

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

procedure TIWBSGridOptions.RenderHTMLTag(Tag: TIWHTMLTag);
begin
  if FGridXSOffset > 0 then
    Tag.AddClassParam('col-xs-offset-'+IntToStr(FGridXSOffset));
  if FGridSMOffset > 0 then
    Tag.AddClassParam('col-sm-offset-'+IntToStr(FGridSMOffset));
  if FGridMDOffset > 0 then
    Tag.AddClassParam('col-md-offset-'+IntToStr(FGridMDOffset));
  if FGridLGOffset > 0 then
    Tag.AddClassParam('col-lg-offset-'+IntToStr(FGridLGOffset));

  if (FGridXSSpan > 0) then
    Tag.AddClassParam('col-xs-'+IntToStr(FGridXSSpan));
  if (FGridSMSpan > 0) then
    Tag.AddClassParam('col-sm-'+IntToStr(FGridSMSpan));
  if (FGridMDSpan > 0) then
    Tag.AddClassParam('col-md-'+IntToStr(FGridMDSpan));
  if (FGridLGSpan > 0) then
    Tag.AddClassParam('col-lg-'+IntToStr(FGridLGSpan));
end;
{$endregion}

end.
