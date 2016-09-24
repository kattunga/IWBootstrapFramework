unit IWBSDeprecated;

interface

uses
  SysUtils, Classes, Controls, StrUtils,
  IWBSCommon,
  IWBSCustomregion;

type
  TIWBSUnorderedList = class(TIWBSCustomRegion)
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
  end deprecated;

implementation

uses IWBSNavBar;

{$region 'TIWBSUnorderedList'}
constructor TIWBSUnorderedList.Create(AOwner: TComponent);
begin
  inherited;
  FTagName := 'ul';
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

end.
