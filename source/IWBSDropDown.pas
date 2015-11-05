unit IWBSDropDown;

interface

uses
  System.SysUtils, System.Classes, System.StrUtils,
  IWRenderContext, IWHTMLTag, IWControl,
  IWBSCommon, IWBSButton;

type
  TIWBSDropDown = class(TIWBSCustomButton)
  private
    FDropDownItems: TOwnedCollection;
    FItemsTree: TList;
    FDropup: boolean;
    FDropDownRight: boolean;
    function GetDropDownItems: TOwnedCollection;
    function IsStoredDropDownItems: Boolean;
    procedure SetDropDownItems(const Value: TOwnedCollection);
    procedure DoOnItemAsyncClick(AParams: TStringList);
    function RenderAnchorTag(const AHTMLName, ACaption, ACss, AGlyphicon, AHint, AStyle: string; ADisabled: boolean; AItemIdx: integer; AOnAsyncClick: boolean; ADropDownItems: TOwnedCollection; ALevel: integer; AContext: TIWCompContext): TIWHTMLTag;
    procedure SetDropUp(const Value: boolean);
    procedure SetDropDownRight(const Value: boolean);
  protected
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); override;
  public
    destructor Destroy; override;
  published
    property DropDownItems: TOwnedCollection read GetDropDownItems write SetDropDownItems stored IsStoredDropDownItems;
    property DropUp: boolean read FDropup write SetDropUp default False;
    property DropDownRight: boolean read FDropDownRight write SetDropDownRight default False;
  end;

  TIWBSDropDownItem = class (TCollectionItem)
  private
    FCaption: string;
    FCss: string;
    FDisabled: boolean;
    FDropDownItems: TOwnedCollection;
    FGlyphicon: string;
    FHint: string;
    FOnAsyncClick: TIWAsyncEvent;
    FStyle: string;
    function GetDropDownItems: TOwnedCollection;
    function IsStoredDropDownItems: Boolean;
    procedure SetDropDownItems(const Value: TOwnedCollection);
  protected
    function GetDisplayName: string; override;
  published
    property Caption: string read FCaption write FCaption;
    property BSGlyphicon: string read FGlyphicon write FGlyphicon;
    property DropDownItems: TOwnedCollection read GetDropDownItems write SetDropDownItems stored IsStoredDropDownItems;
    property OnAsyncClick: TIWAsyncEvent read FOnAsyncClick write FOnAsyncClick;
  end;

implementation

uses IW.Common.System;

{$region 'TIWBSDropDownItem'}
function TIWBSDropDownItem.GetDisplayName: string;
begin
  Result := FCaption;
  if Result = '' then Result := inherited GetDisplayName;
end;

function TIWBSDropDownItem.GetDropDownItems: TOwnedCollection;
begin
  if FDropDownItems = nil then
    FDropDownItems := TOwnedCollection.Create(Self, TIWBSDropDownItem);
  Result := FDropDownItems;
end;

function TIWBSDropDownItem.IsStoredDropDownItems: Boolean;
begin
  Result := (FDropDownItems <> nil) and (FDropDownItems.Count > 0);
end;

procedure TIWBSDropDownItem.SetDropDownItems(const Value: TOwnedCollection);
begin
  FDropDownItems.Assign(Value);
end;
{$endregion}

{$region 'TIWBSDropDown'}
destructor TIWBSDropDown.Destroy;
begin
  FreeAndNil(FDropDownItems);
  FreeAndNil(FItemsTree);
  inherited;
end;

function TIWBSDropDown.GetDropDownItems: TOwnedCollection;
begin
  if FDropDownItems = nil then
    FDropDownItems := TOwnedCollection.Create(Self, TIWBSDropDownItem);
  Result := FDropDownItems;
end;

function TIWBSDropDown.IsStoredDropDownItems: Boolean;
begin
  Result := (FDropDownItems <> nil) and (FDropDownItems.Count > 0);
end;

procedure TIWBSDropDown.SetDropDownItems(const Value: TOwnedCollection);
begin
  if Value = nil then
    FreeAndNil(FDropDownItems)
  else
    FDropDownItems.Assign(Value);
end;

procedure TIWBSDropDown.SetDropDownRight(const Value: boolean);
begin
  FDropDownRight := Value;
  AsyncRefreshControl;
end;

procedure TIWBSDropDown.SetDropUp(const Value: boolean);
begin
  FDropup := Value;
  AsyncRefreshControl;
end;

procedure TIWBSDropDown.DoOnItemAsyncClick(AParams: TStringList);
var
  idx: integer;
begin
  if FItemsTree = nil then Exit;
  idx := StrToIntDef(AParams.Values['itemidx'], -1);
  if (idx >= 0) and (idx < FItemsTree.Count) and Assigned(TIWBSDropDownItem(FItemsTree.Items[idx]).OnAsyncClick) then
    TIWBSDropDownItem(FItemsTree.Items[idx]).OnAsyncClick(FItemsTree.Items[idx], AParams);
end;

function TIWBSDropDown.RenderAnchorTag(const AHTMLName, ACaption, ACss, AGlyphicon, AHint, AStyle: string; ADisabled: boolean; AItemIdx: integer; AOnAsyncClick: boolean; ADropDownItems: TOwnedCollection; ALevel: integer; AContext: TIWCompContext): TIWHTMLTag;
var
  i: integer;
  button: boolean;
  LItemIdx: integer;
begin
  button := (ALevel = 0) and (Parent.ClassName <> 'TIWBSUnorderedList');

  if (ALevel = 0) and Parent.ClassNameIs('TIWBSInputGroup') then
    begin
      result := TIWHTMLTag.CreateTag('span');
      Result.AddClassParam('input-group-btn');
    end
  else if button then
    result := TIWHTMLTag.CreateTag('div')
  else
    result := TIWHTMLTag.CreateTag('li');
  try
    result.AddStringParam('id', AHTMLName+iif(AItemIdx >= 0, IntToStr(AItemIdx)));
    if ADropDownItems <> nil then begin
      if FDropUp then
        Result.AddClassParam('dropup')
      else
        Result.AddClassParam('dropdown');
      if ALevel > 0 then
        Result.AddClassParam('dropdown-submenu');
    end;

    // anchor or button
    with result.Contents.AddTag(iif(button, 'button', 'a')) do begin
      AddClassParam(ACss);
      if Button then
        begin
          AddClassParam('btn');
          if BSButtonSize <> bsszDefault then
            AddClassParam('btn-'+aIWBSSize[BSButtonSize]);
          AddClassParam(aIWBSButtonStyle[BSButtonStyle]);
          if Parent.ClassName = 'TIWBSNavBar' then
            AddClassParam('navbar-btn');
        end
      else
        AddStringParam('href', '#');
      if Showhint and (AHint <> '') then begin
        AddStringParam('data-toggle', 'tooltip');
        AddStringParam('title', AHint);
      end;
      if ADisabled then
        Add('disabled');
      AddStringParam('style', AStyle);

      if ADropDownItems <> nil then begin
        AddClassParam('dropdown-toggle');
        AddStringParam('data-toggle','dropdown');
      end;

      if (AItemIdx >= 0) and AOnAsyncClick then
        AddStringParam('data-item-idx',IntToStr(AItemIdx));

      Contents.AddText(TextToHTML(ACaption));

      if AGlyphicon <> '' then
        with Contents.AddTag('span') do begin
          AddClassParam('glyphicon glyphicon-'+AGlyphicon);
          AddBoolParam('aria-hidden',true);
        end
      else if ADropDownItems <> nil then
        with Contents.AddTag('span') do
          if ALevel = 0 then
            AddClassParam('caret')
          else if FDropDownRight then
            AddClassParam('caret-left')
          else
            AddClassParam('caret-right');
    end;

    // unordered list
    if (ADropDownItems <> nil) then begin
      with Result.Contents.AddTag('ul') do begin
        AddClassParam('dropdown-menu');
        if FDropDownRight then
          AddClassParam('dropdown-menu-right');
        for i := 0 to ADropDownItems.Count-1 do begin
          LItemIdx := FItemsTree.Add(ADropDownItems.Items[i]);
          with TIWBSDropDownItem(ADropDownItems.Items[i]) do
            Contents.AddTagAsObject(RenderAnchorTag(AHTMLName, FCaption, FCss, FGlyphicon, FHint, FStyle, FDisabled, LItemIdx, Assigned(FOnAsyncClick), FDropDownItems, ALevel+1, AContext));
        end;
      end;
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TIWBSDropDown.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;
  FreeAndNil(FItemsTree);
  FItemsTree := TList.Create;
  AHTMLTag := RenderAnchorTag(AHTMLName, Caption, ActiveCss, BSGlyphicon, Hint, ActiveStyle, IsDisabled, -1, False, FDropDownItems, 0, AContext);
end;

procedure TIWBSDropDown.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
	AScript.Add('$("#'+AHTMLName+' a[data-toggle=dropdown]").off().on("click", function(e) { $(this).parent().toggleClass("open").find("li").removeClass("open"); $(this).parent().siblings().removeClass("open").find("li").removeClass("open"); return false; });');
	AScript.Add('$("#'+AHTMLName+' a[data-item-idx]").off().on("click", function(e) { executeAjaxEvent("&itemidx="+$(this).attr("data-item-idx"), null, "'+AHTMLName+'.DoOnAsyncClick", true, null, true); });');
  AContext.WebApplication.RegisterCallBack(AHTMLName+'.DoOnAsyncClick', DoOnItemAsyncClick);
end;
{$endregion}

end.
