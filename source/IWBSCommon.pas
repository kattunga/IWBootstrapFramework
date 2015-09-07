unit IWBSCommon;

interface

uses System.Classes, System.SysUtils;

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
  TIWBSGridOptions = class(TPersistent)
  private
    FGridXSOffset: integer;
    FGridXSSpan: integer;
    FGridSMOffset: integer;
    FGridSMSpan: integer;
    FGridMDOffset: integer;
    FGridMDSpan: integer;
    FGridLGOffset: integer;
    FGridLGSpan: integer;
  public
    constructor Create;
    function GetClassString: string;

    class function GetGridClassString(AGridXSOffset, AGridSMOffset, AGridMDOffset, AGridLGOffset, AGridXSSpan, AGridSMSpan, AGridMDSpan, AGridLGSpan: integer): string;
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

//******************************************************************************

implementation

{$region 'TIWBSGridOptions'}
constructor TIWBSGridOptions.Create;
begin
  FGridXSOffset := 0;
  FGridXSSpan   := 0;
  FGridSMOffset := 0;
  FGridSMSpan   := 0;
  FGridMDOffset := 0;
  FGridMDSpan   := 0;
  FGridLGOffset := 0;
  FGridLGSpan   := 0;
end;

class function TIWBSGridOptions.GetGridClassString(AGridXSOffset, AGridSMOffset, AGridMDOffset, AGridLGOffset, AGridXSSpan, AGridSMSpan, AGridMDSpan, AGridLGSpan: integer): string;
  procedure AddCssValue(var s: string; const Value: string);
  begin
    if s <> '' then
      s := s + ' ';
    s := s + Value;
  end;
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

function TIWBSGridOptions.GetClassString: string;
begin
  Result := GetGridClassString(FGridXSOffset, FGridSMOffset, FGridMDOffset, FGridLGOffset, FGridXSSpan, FGridSMSpan, FGridMDSpan, FGridLGSpan);
end;
{$endregion}

end.
