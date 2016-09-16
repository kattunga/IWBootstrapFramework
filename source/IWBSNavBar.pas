unit IWBSNavBar;

interface

uses
  SysUtils, Classes, StrUtils,
  IWRenderContext, IWHTMLTag, IWBSCustomRegion, IWBSCommon;

type

  TIWBSNavBarFixed = (bsnvfxNone, bsnvfxTop, bsnvfxBottom);

  TIWBSNavBarBase = class(TIWBSCustomRegion);

  TIWBSNavBar = class(TIWBSNavBarBase)
  private
    FFluid: boolean;
    FFixed: TIWBSNavBarFixed;
    FInverse: boolean;
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property BSFluid: boolean read FFluid write FFluid default False;
    property BSInverse: boolean read FInverse write FInverse default False;
    property BSFixed: TIWBSNavBarFixed read FFixed write FFixed default bsnvfxNone;
  end;

  TIWBSNavBarHeader = class(TIWBSNavBarBase)
  protected
    procedure InternalRenderCss(var ACss: string); override;
  end;

  TIWBSNavBarCollapse = class(TIWBSNavBarBase)
  protected
    procedure InternalRenderCss(var ACss: string); override;
  end;

implementation

uses IW.Common.System;

{ TIWBSNavBar }

constructor TIWBSNavBar.Create(AOwner: TComponent);
begin
  inherited;
  FFluid := False;
  FFixed := bsnvfxNone;
  FInverse := False;
  FTagType := 'nav';
end;

procedure TIWBSNavBar.InternalRenderCss(var ACss: string);
begin
  TIWBSCommon.AddCssClass(ACss, 'navbar navbar-'+iif(FInverse,'inverse', 'default'));
  if FFixed = bsnvfxTop then
    TIWBSCommon.AddCssClass(ACss, 'navbar-fixed-top')
  else if FFixed = bsnvfxBottom then
    TIWBSCommon.AddCssClass(ACss, ' navbar-fixed-bottom');
  inherited;
end;

function TIWBSNavBar.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := Inherited;

  FRegionDiv := Result.Contents.AddTag('div');
  FRegionDiv.AddClassParam('container'+iif(FFluid, '-fluid'));
end;

{ TIWBSNavBarHeader }

procedure TIWBSNavBarHeader.InternalRenderCss(var ACss: string);
begin
  TIWBSCommon.AddCssClass(ACss, 'navbar-header');
  inherited;
end;

{ TIWBSNavBarCollapse }

procedure TIWBSNavBarCollapse.InternalRenderCss(var ACss: string);
begin
  TIWBSCommon.AddCssClass(ACss, 'navbar-collapse');
  TIWBSCommon.AddCssClass(ACss, 'collapse');
  inherited;
end;

end.
