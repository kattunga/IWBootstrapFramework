unit IWBSButtonGroup;

interface

uses
  SysUtils, Classes, Controls, StrUtils,
  IWBSCommon,
  IWBSCustomregion;

type
  TIWBSButtonGroup = class(TIWBSCustomRegion)
  private
    FVertical: boolean;
    FJustified: boolean;
    FSize: TIWBSSize;
    procedure SetJustified(const Value: boolean);
    procedure SetSize(const Value: TIWBSSize);
    procedure SetVertical(const Value: boolean);
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetRoleString: string; override;
  published
    property BSVertical: boolean read FVertical write SetVertical default false;
    property BSJustified: boolean read FJustified write SetJustified default false;
    property BSButtonSize: TIWBSSize read FSize write SetSize default bsszDefault;
  end;

implementation

uses IWBSNavBar;

constructor TIWBSButtonGroup.Create(AOwner: TComponent);
begin
  inherited;
  FVertical := false;
  FJustified := false;
  FSize := bsszDefault;
end;

function TIWBSButtonGroup.GetRoleString: string;
begin
  Result := 'group';
end;

procedure TIWBSButtonGroup.InternalRenderCss(var ACss: string);
begin
  if FVertical then
    TIWBSCommon.AddCssClass(ACss, 'btn-group-vertical')
  else
    TIWBSCommon.AddCssClass(ACss, 'btn-group');
  if FSize <> bsszDefault then
    TIWBSCommon.AddCssClass(ACss, 'btn-group-'+aIWBSSize[FSize]);
  if FJustified then
    TIWBSCommon.AddCssClass(ACss, 'btn-group-justified');
  if Parent is TIWBSNavBarBase then
    TIWBSCommon.AddCssClass(ACss, 'navbar-btn');
  inherited;
end;

procedure TIWBSButtonGroup.SetJustified(const Value: boolean);
begin
  FJustified := Value;
  AsyncRefreshControl;
end;

procedure TIWBSButtonGroup.SetSize(const Value: TIWBSSize);
begin
  FSize := Value;
  AsyncRefreshControl;
end;

procedure TIWBSButtonGroup.SetVertical(const Value: boolean);
begin
  FVertical := Value;
  AsyncRefreshControl;
end;

end.
