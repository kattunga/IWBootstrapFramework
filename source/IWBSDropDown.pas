unit IWBSDropDown;

interface

uses
  SysUtils, Classes, StrUtils,
  IWRenderContext, IWHTMLTag, IWControl,
  IWBSCommon, IWBSCommonInterfaces, IWBSButton;

type
  // Bootstrap DropDown @br
  // http://getbootstrap.com/components/#dropdowns @br
  // http://www.w3schools.com/bootstrap/bootstrap_dropdowns.asp
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
    function RenderAnchorTag(const AHTMLName, ACaption, ACss, AGlyphicon, AHint, AHref, AStyle: string; ADisabled, AHeader: boolean; AItemIdx: integer; AOnAsyncClick: boolean; ADataParent, ADataTarget: IIWBSContainer; ADropDownItems: TOwnedCollection): TIWHTMLTag;
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
    FHeader: boolean;
    FHint: string;
    FOnAsyncClick: TIWAsyncEvent;
    FStyle: string;
    FHref: string;
    FTarget: string;
    FDataParent: IIWBSContainer;
    FDataTarget: IIWBSContainer;
    function GetDropDownItems: TOwnedCollection;
    function IsStoredDropDownItems: Boolean;
    procedure SetDropDownItems(const Value: TOwnedCollection);
    function IsHrefStored: Boolean;
    procedure SetHref(const Value: string);
    function IsTargetStored: Boolean;
    procedure SetTarget(const Value: string);
    procedure SetDataParent(const Value: IIWBSContainer);
    procedure SetDataTarget(const Value: IIWBSContainer);
  protected
    function GetDisplayName: string; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property Caption: string read FCaption write FCaption;
    property BSGlyphicon: string read FGlyphicon write FGlyphicon;
    property DataParent: IIWBSContainer read FDataParent write SetDataParent;
    property DataTarget: IIWBSContainer read FDataTarget write SetDataTarget;
    property DropDownItems: TOwnedCollection read GetDropDownItems write SetDropDownItems stored IsStoredDropDownItems;
    property Header: boolean read FHeader write FHeader default False;
    property Href: string read FHref write SetHref stored IsHrefStored;
    property Target: string read FTarget write SetTarget stored IsTargetStored;

    property OnAsyncClick: TIWAsyncEvent read FOnAsyncClick write FOnAsyncClick;
  end;

implementation

uses IW.Common.System, IWBSModal, IWBSCustomRegion, IWBSNavbar, IWBSList, IWBSButtonGroup, IWBSInputForm;

{$region 'TIWBSDropDownItem'}
constructor TIWBSDropDownItem.Create(Collection: TCollection);
begin
  inherited;
  FHref := '#';
  FTarget := '_self';
end;

destructor TIWBSDropDownItem.Destroy;
begin
  FreeAndNil(FDropDownItems);
  inherited;
end;

procedure TIWBSDropDownItem.Assign(Source: TPersistent);
begin
  if Source is TIWBSDropDownItem then
    begin
      Caption := TIWBSDropDownItem(Source).Caption;
      BSGlyphicon := TIWBSDropDownItem(Source).BSGlyphicon;
      DataParent := TIWBSDropDownItem(Source).DataParent;
      DataTarget := TIWBSDropDownItem(Source).DataTarget;
      Header := TIWBSDropDownItem(Source).Header;
      Href := TIWBSDropDownItem(Source).Href;
      Target := TIWBSDropDownItem(Source).Target;
      OnAsyncClick := TIWBSDropDownItem(Source).OnAsyncClick;
      DropDownItems.Assign(TIWBSDropDownItem(Source).DropDownItems);
    end
  else
    inherited;
end;

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

function TIWBSDropDownItem.IsHrefStored: Boolean;
begin
  Result := FHref <> '#';
end;

function TIWBSDropDownItem.IsStoredDropDownItems: Boolean;
begin
  Result := (FDropDownItems <> nil) and (FDropDownItems.Count > 0);
end;

function TIWBSDropDownItem.IsTargetStored: Boolean;
begin
  Result := FTarget <> '_self';
end;

procedure TIWBSDropDownItem.SetDataParent(const Value: IIWBSContainer);
begin
  FDataParent := Value;
end;

procedure TIWBSDropDownItem.SetDataTarget(const Value: IIWBSContainer);
begin
  FDataTarget := Value;
end;

procedure TIWBSDropDownItem.SetDropDownItems(const Value: TOwnedCollection);
begin
  FDropDownItems.Assign(Value);
end;
procedure TIWBSDropDownItem.SetHref(const Value: string);
begin
  FHref := Value;
end;

procedure TIWBSDropDownItem.SetTarget(const Value: string);
begin
  FTarget := Value;
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

function TIWBSDropDown.RenderAnchorTag(const AHTMLName, ACaption, ACss, AGlyphicon, AHint, AHref, AStyle: string; ADisabled, AHeader: boolean; AItemIdx: integer; AOnAsyncClick: boolean; ADataParent, ADataTarget: IIWBSContainer; ADropDownItems: TOwnedCollection): TIWHTMLTag;
var
  i: integer;
  button: boolean;
  LItemIdx: integer;
begin
  button := (AItemIdx < 0) and (not (Parent is TIWBSList));

  if (AItemIdx < 0) and (Parent is TIWBSInputGroup) then
    begin
      result := TIWHTMLTag.CreateTag('span');
      Result.AddClassParam('input-group-btn');
    end
  else if button then
    result := TIWHTMLTag.CreateTag('div')
  else
    result := TIWHTMLTag.CreateTag('li');
  try

    // divider
    if (AItemIdx >= 0) and (ACaption = '-') then begin
      Result.AddClassParam('divider');
      Result.AddStringParam('role', 'separator');
      Exit;
    end;

    // header
    if AHeader then begin
      Result.AddClassParam('dropdown-header');
      Result.Contents.AddText(ACaption);
      Exit;
    end;

    // items
    result.AddStringParam('id', AHTMLName+iif(AItemIdx >= 0, IntToStr(AItemIdx)));
    if ADropDownItems <> nil then begin
      if Parent is TIWBSButtonGroup then
        Result.AddClassParam('btn-group')
      else if FDropUp then
        Result.AddClassParam('dropup')
      else
        Result.AddClassParam('dropdown');
      if AItemIdx >= 0 then
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
          if Parent is TIWBSNavBarBase then
            AddClassParam('navbar-btn');
        end
      else if ADataTarget = nil then
        AddStringParam('href', AHref)
      else
        AddStringParam('href', '#'+ADataTarget.HTMLName);

      if Showhint and (AHint <> '') then
        AddStringParam('title', AHint);
      if ADisabled then
        Add('disabled');
      AddStringParam('style', AStyle);

      AddParmsList(ExtraTagParams);

      if ADropDownItems <> nil then
        begin
          AddClassParam('dropdown-toggle');
          AddStringParam('data-toggle','dropdown');
        end
      else
        begin
          if (AItemIdx >= 0) and AOnAsyncClick then
            AddStringParam('data-item-idx',IntToStr(AItemIdx));
          if ADataTarget <> nil then begin
            if ADataParent <> nil then
              AddStringParam('data-parent', '#'+ADataParent.HTMLName);
            if (ADataTarget.InterfaceInstance is TIWBSModal) then
              AddStringParam('data-toggle', 'modal')
            else if (ADataTarget.InterfaceInstance is TIWBSCustomRegion) and TIWBSCustomRegion(ADataTarget.InterfaceInstance).Collapse then
              AddStringParam('data-toggle', 'collapse');
          end;
        end;

      Contents.AddText(TextToHTML(ACaption));

      if AGlyphicon <> '' then
        with Contents.AddTag('span') do begin
          AddClassParam('glyphicon glyphicon-'+AGlyphicon);
          AddBoolParam('aria-hidden',true);
        end
      else if ADropDownItems <> nil then
        with Contents.AddTag('span') do
          if AItemIdx < 0 then
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
            Contents.AddTagAsObject(RenderAnchorTag(AHTMLName, FCaption, FCss, FGlyphicon, FHint, FHref, FStyle, FDisabled, FHeader, LItemIdx, Assigned(FOnAsyncClick), FDataParent, FDataTarget, FDropDownItems));
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
  AHTMLTag := RenderAnchorTag(AHTMLName, Caption, ActiveCss, BSGlyphicon, Hint, '#', ActiveStyle, IsDisabled, False, -1, False, nil, nil, FDropDownItems);
end;

procedure TIWBSDropDown.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
	AScript.Add('$("#'+AHTMLName+' a[data-toggle=dropdown]").off().on("click", function(e) { $(this).parent().toggleClass("open").find("li").removeClass("open"); $(this).parent().siblings().removeClass("open").find("li").removeClass("open"); return false; });');
	AScript.Add('$("#'+AHTMLName+' a[data-item-idx]").off().on("click", function(e) { executeAjaxEvent("&itemidx="+$(this).attr("data-item-idx"), null, "'+AHTMLName+'.DoOnAsyncClick", true, null, true); });');
  AContext.WebApplication.RegisterCallBack(AHTMLName+'.DoOnAsyncClick', DoOnItemAsyncClick);
end;
{$endregion}

end.
