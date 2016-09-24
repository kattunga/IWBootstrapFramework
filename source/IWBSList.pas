unit IWBSList;

interface

uses
  SysUtils, Classes, Controls, StrUtils,
  IWHTMLTag,
  IWBSCommon, IWBSCustomregion, IWBSCustomControl;

type
  TIWBSListType = (bsltNone, bsltGroup, bsltInline, bsltNav, bsltPager, bsltPagination, bsltPaginationLg, bsltPaginationSm, bsltBreadcrumb);

const
  aIWBSListType: array [bsltNone..bsltBreadcrumb] of string = ('', 'list-group', 'list-inline', 'nav navbar-nav', 'pager', 'pagination', 'pagination pagination-lg', 'pagination pagination-sm', 'breadcrumb');

type
  TIWBSList = class(TIWBSCustomRegion)
  private
    FListType: TIWBSListType;
    procedure SetListType(const Value: TIWBSListType);
  protected
    procedure InternalRenderCss(var ACss: string); override;
    procedure SetParent(AParent: TWinControl); override;
  public
    constructor Create(AOwner: TComponent); override;

    class procedure WrapItem(AControl: TIWBSCustomControl; var AHTMLTag: TIWHTMLTag);
  published
    property BSListType: TIWBSListType read FListType write SetListType default bsltNone;
  end;

implementation

uses
  IWBSNavBar;

constructor TIWBSList.Create(AOwner: TComponent);
begin
  inherited;
  FTagName := 'ul';
end;

procedure TIWBSList.InternalRenderCss(var ACss: string);
begin
  TIWBSCommon.AddCssClass(ACss, aIWBSListType[FListType]);
  inherited;
end;

procedure TIWBSList.SetListType(const Value: TIWBSListType);
begin
  if Parent is TIWBSNavBarBase then
    FListType := bsltNav
  else
    FListType := Value;
  Invalidate;
end;

procedure TIWBSList.SetParent(AParent: TWinControl);
begin
  inherited;
  if AParent is TIWBSNavBarBase then
    FListType := bsltNav;
end;

class procedure TIWBSList.WrapItem(AControl: TIWBSCustomControl; var AHTMLTag: TIWHTMLTag);
var
  xHTMLTag: TIWHTMLTag;
begin
  if AControl.Parent is TIWBSList then
    begin
      xHTMLTag := TIWHTMLTag.CreateTag('li');

      case TIWBSList(AControl.Parent).BSListType of
        bsltGroup: xHTMLTag.AddClassParam('list-group-item');
      end;

      xHTMLTag.Contents.AddTagAsObject(AHTMLtag);
      AHTMLtag := xHTMLTag;
    end;
end;

end.
