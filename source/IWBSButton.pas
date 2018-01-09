unit IWBSButton;

interface

uses
  SysUtils, Classes, db, StrUtils, Controls,
  IWRenderContext, IWHTMLTag, IWBaseInterfaces,
  IWBSCustomControl, IWBSCommon, IWBSCommonInterfaces;

type
  // TIWBSCustomButton.BSButtonStyle
  TIWBSButtonStyle = (bsbsDefault, bsbsPrimary, bsbsSuccess, bsbsInfo, bsbsWarning, bsbsDanger, bsbsLink, bsbsClose);

  // Base class for TIWBSButton and TIWBSDropDown
  TIWBSCustomButton = class(TIWBSCustomControl)
  private
    FBlockLevel: boolean;
    FButtonSize: TIWBSSize;
    FButtonStyle: TIWBSButtonStyle;
    FCaption: string;
    FGlyphicon: string;
    FRawText: boolean;

    procedure SetGlyphicon(const Value: string);
    procedure SetButtonStyle(const Value: TIWBSButtonStyle);
    procedure SetBlockLevel(const Value: boolean);
    procedure SetCaption(const Value: string);
    procedure SetRawText(const Value: boolean);
  public
    constructor Create(AOwner: TComponent); override;
  published
    // Boostrap Block Level Button @br
    // http://getbootstrap.com/css/#buttons-sizes
    property BSBlockLevel: boolean read FBlockLevel write SetBlockLevel default False;
    // Boostrap Button Size @br
    // http://getbootstrap.com/css/#buttons-sizes
    property BSButtonSize: TIWBSSize read FButtonSize write FButtonSize default bsszDefault;
    // Bootstrap Button Style @br
    // http://getbootstrap.com/css/#buttons-options
    property BSButtonStyle: TIWBSButtonStyle read FButtonStyle write SetButtonStyle default bsbsDefault;
    // Bootstrap Glyphicon @br
    // http://getbootstrap.com/components/#glyphicons
    property BSGlyphicon: string read FGlyphicon write SetGlyphicon;
    // Button Text
    property Caption: string read FCaption write SetCaption;
    // If true, the Caption will be rendered as Raw HTML
    property RawText: boolean read FRawText write SetRawText default False;
  end;

  // TIWBSButton.DataDismiss
  TIWBSButtonDataDismiss = (bsbdNone, bsbdModal, bsbdAlert);

  // TIWBSButton.ButtonType
  TIWBSButtonType = (bsbtButton, bsbtSubmit, bsbtReset);

  // TIWBSButton.ElementTypeType
  TIWBSButtonElementType = (bsetAuto, bsetAnchor, bsetButton);

  // TIWBSButton.AsyncClickProc
  TIWBSAsyncEventProc = reference to procedure(Sender: TObject; EventParams: TStringList);

  // Bootstrap Button @br
  // http://getbootstrap.com/css/#buttons @br
  // http://www.w3schools.com/bootstrap/bootstrap_buttons.asp
  TIWBSButton = class(TIWBSCustomButton)
  private
    FAsyncClickProc: TIWBSAsyncEventProc;
    FButtonType: TIWBSButtonType;
    FDataDismiss: TIWBSButtonDataDismiss;
    FDataParent: IIWBSContainer;
    FDataTarget: IIWBSContainer;
    FElementType: TIWBSButtonElementType;
    FHotKey: string;
    FHref: string;
    FTarget: string;

    procedure DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
    procedure SetAsyncClickProc(Value: TIWBSAsyncEventProc);
    function IsHrefStored: Boolean;
    function IsTargetStored: Boolean;
    function IsAnchor: Boolean;
    procedure SetDataTarget(const Value: IIWBSContainer);
    procedure SetDataParent(const Value: IIWBSContainer);
    procedure SetHref(const Value: string);
    procedure SetTarget(const Value: string);
    procedure SetDataDismiss(const Value: TIWBSButtonDataDismiss);
    function GetDataToggle: string;
    procedure SetElementType(const Value: TIWBSButtonElementType);
  protected
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
    // Anonymous procedure that let you execute code when button is pressed without the need of declare an event. @br
    // Usefull when you create buttons at runtime
    property AsyncClickProc: TIWBSAsyncEventProc read FAsyncClickProc write SetAsyncClickProc;
  published
    // Button type
    property ButtonType: TIWBSButtonType read FButtonType write FButtonType default bsbtButton;
    // Used when button in placed on a TIWBSModal or TIWBSAlert. @br
    // Let the button automatically close the dialog.
    property DataDismiss: TIWBSButtonDataDismiss read FDataDismiss write SetDataDismiss default bsbdNone;
    // Specifies the parent region off collapsable regions to autoclose other regions when one is toggled. See accordion example. @br
    // http://getbootstrap.com/javascript/#collapse-example-accordion @br
    // http://www.w3schools.com/bootstrap/bootstrap_collapse.asp
    property DataParent: IIWBSContainer read FDataParent write SetDataParent;
    // Specifies the target region for for toggle visiblity of TIWBSModal or TIWBSRegion.Collapse @br
    // http://www.w3schools.com/bootstrap/bootstrap_modal.asp @br
    // http://www.w3schools.com/bootstrap/bootstrap_collapse.asp
    property DataTarget: IIWBSContainer read FDataTarget write SetDataTarget;
    // Toogle operation
    property DataToggle: string read GetDataToggle;
    // acceskey tag atribute @br
    // http://www.w3schools.com/tags/att_global_accesskey.asp
    property HotKey: string read FHotkey write FHotKey;
    // this property determines if the element will be type anchor or button, default is Auto
    property ElementType: TIWBSButtonElementType read FElementType write SetElementType default bsetAuto;
    // Destination address to jump when button is pressed. @br
    // Requires following property values: Anchor = true, DataTarget = nil, OnAsyncClic = nil. @br
    // http://www.w3schools.com/html/html_links.asp
    property Href: string read FHref write SetHref stored IsHrefStored;
    // The target attribute specifies where to open the linked document. Apply when Href is used. @br
    // http://www.w3schools.com/html/html_links.asp
    property Target: string read FTarget write SetTarget stored IsTargetStored;
  end;

const
  // @exclude
  aIWBSButtonStyle: array[bsbsDefault..bsbsClose] of string = ('btn-default', 'btn-primary', 'btn-success', 'btn-info', 'btn-warning', 'btn-danger', 'btn-link', 'close');

implementation

uses
  IW.Common.System,
  IWBSInputCommon, IWBSInputForm, IWBSModal, IWBSCustomRegion, IWBSNavbar, IWBSList, IWBSRegion, IWBSButtonGroup;

{$region 'TIWBSCustomButton'}
constructor TIWBSCustomButton.Create(AOwner: TComponent);
begin
  inherited;
  FButtonSize := bsszDefault;
  FButtonStyle := bsbsDefault;
  FCaption := '';
  FGlyphicon := '';
  FNeedsFormTag := True;
  Height := 25;
  Width := 200;
end;

procedure TIWBSCustomButton.SetBlockLevel(const Value: boolean);
begin
  FBlockLevel := Value;
  Invalidate;
end;

procedure TIWBSCustomButton.SetButtonStyle(const Value: TIWBSButtonStyle);
begin
  FButtonStyle := Value;
  Invalidate;
end;

procedure TIWBSCustomButton.SetCaption(const Value: string);
begin
  FCaption := Value;
  AsyncRefreshControl;
end;

procedure TIWBSCustomButton.SetGlyphicon(const Value: string);
begin
  FGlyphicon := Value;
  Invalidate;
end;
procedure TIWBSCustomButton.SetRawText(const Value: boolean);
begin
  FRawText := Value;
  AsyncRefreshControl;
end;
{$endregion}

{$region 'TIWBSButton'}
constructor TIWBSButton.Create(AOwner: TComponent);
begin
  inherited;
  FButtonType := bsbtButton;
  FDataDismiss := bsbdNone;
  FElementType := bsetAuto;
  FHotKey := '';
  FHref := '#';
  FTarget := '';
end;

procedure TIWBSButton.InternalRenderCss(var ACss: string);
begin
  inherited;

  if (Parent is TIWBSRegion) and (TIWBSRegion(Parent).BSRegionType = bsrtListGroup) then
    begin
      TIWBSCommon.AddCssClass(ACss, 'list-group-item');
    end
  else if (FDataTarget <> nil) and (FDataTarget.InterfaceInstance is TIWBSNavBarCollapse) then
    begin
      TIWBSCommon.AddCssClass(ACss, 'navbar-toggle');
    end
  else if (Parent is TIWBSButtonGroup) or not IsAnchor then
    begin
      TIWBSCommon.AddCssClass(ACss, 'btn');
      if FButtonSize <> bsszDefault then
        TIWBSCommon.AddCssClass(ACss, 'btn-'+aIWBSSize[FButtonSize]);
      TIWBSCommon.AddCssClass(ACss, aIWBSButtonStyle[FButtonStyle]);
      if FBlockLevel then
        TIWBSCommon.AddCssClass(ACss, 'btn-block');

      if (Parent is TIWBSNavBarBase) then
        TIWBSCommon.AddCssClass(ACss, 'navbar-btn')
      else if (Parent is TIWBSRegion) and (TIWBSRegion(Parent).BSRegionType = bsrtDropDown) then
        TIWBSCommon.AddCssClass(ACss, 'dropdown-toggle');
    end;
end;

procedure TIWBSButton.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
const
  aIWBSButtonDataDismiss: array[bsbdNone..bsbdAlert] of string = ('', 'modal', 'alert');
var
  s: string;
  lAnchor: boolean;
  lTarget: string;
begin
  inherited;

  lAnchor := IsAnchor;

  AHTMLTag := TIWHTMLTag.CreateTag(iif(lAnchor,'a','button'));
  try
    AHTMLTag.AddStringParam('id', AHTMLName);
    AHTMLTag.AddClassParam(ActiveCss);

    // button type
    if not lAnchor then
      if FButtonType = bsbtButton then
        AHTMLTag.AddStringParam('type', 'button')
      else if FButtonType = bsbtSubmit then
        AHTMLTag.AddStringParam('type', 'submit')
      else if FButtonType = bsbtReset then
        AHTMLTag.AddStringParam('type', 'reset');

    if ShowHint and (Hint <> '') then
      AHTMLTag.AddStringParam('title', Hint);

    if IsDisabled then
      AHTMLTag.Add('disabled');

    AHTMLTag.AddStringParam('style', ActiveStyle);
    AHTMLTag.AddParmsList(ExtraTagParams);

    if TabIndex <> 0 then
      AHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));

    // caption
    if FRawText then
      s := Caption
    else
      s := TextToHTML(Caption);

    // hotkey
    if FHotKey <> '' then begin
      AHTMLTag.AddStringParam('accesskey', FHotKey);
      s := StringReplace(s, FHotKey, '<u>' + FHotKey + '</u>', [rfIgnoreCase]);
    end;

    // glyphicon
    if FGlyphicon <> '' then
      with AHTMLTag.Contents.AddTag('span') do begin
        AddClassParam('glyphicon glyphicon-'+FGlyphicon);
        AddBoolParam('aria-hidden',true);
        s := ' ' + s;
      end;

    // close button
    if (FButtonStyle = bsbsClose) then begin
      AHTMLTag.AddStringParam('aria-label', 'Close');
      if (s = '') and (FGlyphicon = '') then
        s := '&times;';
    end;

    // data-dismiss
    if FDataDismiss <> bsbdNone then
      AHTMLTag.AddStringParam('data-dismiss', aIWBSButtonDataDismiss[FDataDismiss]);

    // datatarget / href
    if FDataTarget = nil then
      begin
        if lAnchor then begin
          AHTMLTag.AddStringParam('href', FHref);
          if FTarget = '' then
            if AnsiStartsStr('#', FHref) then
              lTarget := '_self'
            else
              lTarget := '_blank'
          else
            lTarget := FTarget;
          AHTMLTag.AddStringParam('target', lTarget);
        end;
      end
    else
      begin
        if lAnchor then
          AHTMLTag.AddStringParam('href', '#'+FDataTarget.HTMLName)
        else
          AHTMLTag.AddStringParam('data-target', '#'+FDataTarget.HTMLName);

        if FDataParent <> nil then
          AHTMLTag.AddStringParam('data-parent', '#'+FDataParent.HTMLName);

        // draw a menu button if no caption and no glyphicon
        if (s = '') and (FGlyphicon = '') then begin
          AHTMLTag.Contents.AddTag('span').AddClassParam('icon-bar');
          AHTMLTag.Contents.AddTag('span').AddClassParam('icon-bar');
          AHTMLTag.Contents.AddTag('span').AddClassParam('icon-bar');
        end;
      end;

    // datatoggle
    AHTMLTag.AddStringParam('data-toggle', DataToggle);

    // caption after glyphicon
    if s <> '' then
      AHTMLTag.Contents.AddText(s);

  except
    FreeAndNil(AHTMLTag);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    AHTMLTag := IWBSCreateInputGroupAddOn(AHTMLTag, AHTMLName, 'btn')
  else
    AHTMLTag := IWBSCreateFormGroup(Parent, IWBSFindParentInputForm(Parent), AHTMLTag, AHTMLName, True);

  // wrap item if parent is list
  TIWBSList.WrapItem(Self, AHTMLTag);
end;

function TIWBSButton.IsAnchor: Boolean;
begin
  if FElementType = bsetAuto then
    begin
      if FDataTarget <> nil then
        Result := False
      else if FHref <> '#' then
        Result := True
      else if (Parent is TIWBSNavBarBase) then
        Result := False
      else if (Parent is TIWBSList) then
        Result := True
      else if (Parent is TIWBSRegion) and (TIWBSRegion(Parent).BSRegionType = bsrtListGroup) then
        Result := True
      else if (Parent is TIWBSButtonGroup) and TIWBSButtonGroup(Parent).BSJustified then
        Result := True
      else
        Result := False;
    end
  else
    Result := FElementType = bsetAnchor;
end;

function TIWBSButton.IsHrefStored: Boolean;
begin
  Result := FHref <> '#';
end;

function TIWBSButton.IsTargetStored: Boolean;
begin
  Result := FTarget <> '';
end;

procedure TIWBSButton.DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
begin
  FAsyncClickProc(Sender, EventParams);
end;

function TIWBSButton.GetDataToggle: string;
begin
  if (Parent is TIWBSRegion) and (TIWBSRegion(Parent).BSRegionType = bsrtDropDown) then
    Result := 'dropdown'
  else if (FDataTarget = nil) then
    Result := ''
  else if (FDataTarget.InterfaceInstance is TIWBSModal) then
    Result := 'modal'
  else if (FDataTarget.InterfaceInstance is TIWBSCustomRegion) and TIWBSCustomRegion(FDataTarget.InterfaceInstance).Collapse then
    Result := 'collapse'
  else if (FDataTarget.InterfaceInstance is TIWBSNavBarCollapse) then
    Result := 'collapse';
end;

procedure TIWBSButton.SetAsyncClickProc(Value: TIWBSAsyncEventProc);
begin
  FAsyncClickProc := Value;
  OnAsyncClick := DoAsyncClickProc
end;
procedure TIWBSButton.SetHref(const Value: string);
begin
  FHref := Value;
  AsyncRefreshControl;
end;

procedure TIWBSButton.SetTarget(const Value: string);
begin
  FTarget := Value;
  AsyncRefreshControl;
end;

procedure TIWBSButton.SetDataDismiss(const Value: TIWBSButtonDataDismiss);
begin
  FDataDismiss := Value;
  AsyncRefreshControl;
end;

procedure TIWBSButton.SetDataParent(const Value: IIWBSContainer);
begin
  FDataParent := Value;
  AsyncRefreshControl;
end;

procedure TIWBSButton.SetDataTarget(const Value: IIWBSContainer);
begin
  FDataTarget := Value;
  AsyncRefreshControl;
end;
procedure TIWBSButton.SetElementType(const Value: TIWBSButtonElementType);
begin
  FElementType := Value;
  AsyncRefreshControl;
end;

{$endregion}

end.
