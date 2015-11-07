unit IWBSButton;

interface

uses
  System.SysUtils, System.Classes, data.db, System.StrUtils, Vcl.Controls,
  IWRenderContext, IWHTMLTag, IWXMLTag, IWBaseInterfaces,
  IWBSCustomControl, IWScriptEvents, IWBSRegion, IWBSCommon, IWBSRegionCommon;

type
  // TIWBSCustomButton.BSButtonStyle
  TIWBSButtonStyle = (bsbsDefault, bsbsPrimary, bsbsSuccess, bsbsInfo, bsbsWarning, bsbsDanger, bsbsLink, bsbsClose);

  // Base class for TIWBSButton and TIWBSDropDown
  TIWBSCustomButton = class(TIWBSCustomControl)
  private
    FButtonSize: TIWBSSize;
    FButtonStyle: TIWBSButtonStyle;
    FGlyphicon: string;
    FBlockLevel: boolean;

    procedure SetGlyphicon(const Value: string);
    procedure SetButtonStyle(const Value: TIWBSButtonStyle);
    procedure SetBlockLevel(const Value: boolean);
  public
    constructor Create(AOwner: TComponent); override;
  published
    // Boostrap Block Level Button @br
    // http://getbootstrap.com/css/#buttons-sizes
    property BSBlockLevel: boolean read FBlockLevel write SetBlockLevel;
    // Boostrap Button Size @br
    // http://getbootstrap.com/css/#buttons-sizes
    property BSButtonSize: TIWBSSize read FButtonSize write FButtonSize default bsszDefault;
    // Bootstrap Button Style @br
    //http://getbootstrap.com/css/#buttons-options
    property BSButtonStyle: TIWBSButtonStyle read FButtonStyle write SetButtonStyle default bsbsDefault;
    // Bootstrap Glyphicon @br
    // http://getbootstrap.com/components/#glyphicons
    property BSGlyphicon: string read FGlyphicon write SetGlyphicon;
    // Button Caption
    property Caption;
    // Rendered tabindex tag if true and gIWBSEnableTabIndex = true. @br
    // http://www.w3schools.com/tags/att_global_tabindex.asp
    property TabStop default True;
  end;

  // TIWBSButton.DataDismiss
  TIWBSButtonDataDismiss = (bsbdNone, bsbdModal, bsbdAlert);
  // TIWBSButton.AsyncClickProc
  TIWBSAsyncClickProc = reference to procedure(EventParams: TStringList);
  // TIWBSButton.ButtonType
  TIWBSButtonType = (iwbsbtButton, iwbsbtSubmit, iwbsbtReset);

  // Bootstrap Button @br
  // http://getbootstrap.com/css/#buttons @br
  // http://www.w3schools.com/bootstrap/bootstrap_buttons.asp
  TIWBSButton = class(TIWBSCustomButton)
  private
    FAnchor: boolean;
    FAsyncClickProc: TIWBSAsyncClickProc;
    FButtonType: TIWBSButtonType;
    FDataDismiss: TIWBSButtonDataDismiss;
    FDataParent: IIWBSContainer;
    FDataTarget: IIWBSContainer;
    FHotKey: string;
    FHref: string;
    FTarget: string;

    procedure DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
    procedure SetAsyncClickProc(Value: TIWBSAsyncClickProc);
    function IsHrefStored: Boolean;
    function IsTargetStored: Boolean;
    procedure SetDataTarget(const Value: IIWBSContainer);
    procedure SetDataParent(const Value: IIWBSContainer);
    procedure SetHref(const Value: string);
    procedure SetTarget(const Value: string);
    procedure SetDataDismiss(const Value: TIWBSButtonDataDismiss);
  protected
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
    // Anonymous procedure that let you execute code when button is pressed without the need of declare an event. @br
    // Usefull when you create buttons at runtime
    property AsyncClickProc: TIWBSAsyncClickProc read FAsyncClickProc write SetAsyncClickProc;
  published
    // If true it will render an anchor if not a button. (This property should be droped, the condition should be autodetected)
    property Anchor: boolean read FAnchor write FAnchor default False;
    // Button type
    property ButtonType: TIWBSButtonType read FButtonType write FButtonType default iwbsbtButton;
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
    // acceskey tag atribute @br
    // http://www.w3schools.com/tags/att_global_accesskey.asp
    property HotKey: string read FHotkey write FHotKey;
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

uses IW.Common.System, IWBSInputCommon;

{$region 'TIWBSCustomButton'}
constructor TIWBSCustomButton.Create(AOwner: TComponent);
begin
  inherited;
  FButtonSize := bsszDefault;
  FButtonStyle := bsbsDefault;
  FGlyphicon := '';

  FCanReceiveFocus := True;
  FNeedsFormTag := True;
  Height := 25;
  Width := 200;
  TabStop := True;
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

procedure TIWBSCustomButton.SetGlyphicon(const Value: string);
begin
  FGlyphicon := Value;
  Invalidate;
end;
{$endregion}

{$region 'TIWBSButton'}
constructor TIWBSButton.Create(AOwner: TComponent);
begin
  inherited;
  FAnchor := False;
  FButtonType := iwbsbtButton;
  FDataDismiss := bsbdNone;
  FHotKey := '';
  FHref := '#';
  FTarget := '_self';
end;

procedure TIWBSButton.InternalRenderCss(var ACss: string);
begin
  inherited;
  if not FAnchor then begin
    TIWBSCommon.AddCssClass(ACss, 'btn');
    if FButtonSize <> bsszDefault then
      TIWBSCommon.AddCssClass(ACss, 'btn-'+aIWBSSize[FButtonSize]);
    TIWBSCommon.AddCssClass(ACss, aIWBSButtonStyle[FButtonStyle]);
    if FBlockLevel then
      TIWBSCommon.AddCssClass(ACss, 'btn-block');
    if Parent.ClassName = 'TIWBSNavBar' then
      TIWBSCommon.AddCssClass(ACss, 'navbar-btn');
  end;
end;

procedure TIWBSButton.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
const
  aIWBSButtonDataDismiss: array[bsbdNone..bsbdAlert] of string = ('', 'modal', 'alert');
var
  s: string;
  xHTMLTag: TIWHTMLTag;
begin
  inherited;

  AHTMLTag := TIWHTMLTag.CreateTag(iif(FAnchor,'a','button'));
  try
    AHTMLTag.AddStringParam('id', AHTMLName);
    AHTMLTag.AddClassParam(ActiveCss);

    if FDataDismiss <> bsbdNone then
      AHTMLTag.AddStringParam('data-dismiss', aIWBSButtonDataDismiss[FDataDismiss]);

    if FAnchor or (FButtonType = iwbsbtButton) then
      begin
        if FAnchor and (FDataTarget = nil) then
          AHTMLTag.AddStringParam('href', FHref);
        if not FAnchor then
          AHTMLTag.AddStringParam('type', 'button');
        if FDataTarget <> nil then begin
          if FAnchor then
            AHTMLTag.AddStringParam('href', '#'+FDataTarget.HTMLName)
          else
            AHTMLTag.AddStringParam('data-target', '#'+FDataTarget.HTMLName);
          if FDataParent <> nil then
            AHTMLTag.AddStringParam('data-parent', '#'+FDataParent.HTMLName);
          if (FDataTarget.InterfaceInstance is TIWBSModal) then
            AHTMLTag.AddStringParam('data-toggle', 'modal')
          else if (FDataTarget.InterfaceInstance is TIWBSRegion) and TIWBSRegion(FDataTarget.InterfaceInstance).Collapse then
            AHTMLTag.AddStringParam('data-toggle', 'collapse');
        end;
      end
    else if FButtonType = iwbsbtSubmit then
      AHTMLTag.AddStringParam('type', 'submit')
    else if FButtonType = iwbsbtReset then
      AHTMLTag.AddStringParam('type', 'reset');

    if ShowHint and (Hint <> '') then
      AHTMLTag.AddStringParam('title', Hint);
    if IsDisabled then
      AHTMLTag.Add('disabled');
    s := TextToHTML(Caption);
    if FHotKey <> '' then begin
      AHTMLTag.AddStringParam('accesskey', FHotKey);
      s := StringReplace(s, FHotKey, '<u>' + FHotKey + '</u>', [rfIgnoreCase]);
    end;
    if FButtonStyle = bsbsClose then
      AHTMLTag.AddStringParam('aria-label', 'Close');
    AHTMLTag.AddStringParam('style', ActiveStyle);

    if FGlyphicon <> '' then
      with AHTMLTag.Contents.AddTag('span') do begin
        AddClassParam('glyphicon glyphicon-'+FGlyphicon);
        AddBoolParam('aria-hidden',true);
        s := ' '+s;
      end;

    // caption after glyphicon
    if (FButtonStyle = bsbsClose) and (s = '') and (FGlyphicon = '') then
      AHTMLTag.Contents.AddText('&times;')
    else
      AHTMLTag.Contents.AddText(s);
  except
    FreeAndNil(AHTMLTag);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    AHTMLTag := IWBSCreateInputGroupAddOn(AHTMLTag, AHTMLName, 'btn')
  else if Parent.ClassName = 'TIWBSUnorderedList' then
    begin
      xHTMLTag := TIWHTMLTag.CreateTag('li');
      xHTMLTag.Contents.AddTagAsObject(AHTMLtag);
      AHTMLtag := xHTMLTag;
    end
  else
    AHTMLTag := IWBSCreateFormGroup(Parent, IWBSFindParentInputForm(Parent), AHTMLTag, AHTMLName, True);
end;

function TIWBSButton.IsHrefStored: Boolean;
begin
  Result := FHref <> '#';
end;

function TIWBSButton.IsTargetStored: Boolean;
begin
  Result := FTarget <> '_self';
end;

procedure TIWBSButton.DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
begin
  FAsyncClickProc(EventParams);
end;

procedure TIWBSButton.SetAsyncClickProc(Value: TIWBSAsyncClickProc);
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
end;

procedure TIWBSButton.SetDataParent(const Value: IIWBSContainer);
begin
  FDataParent := Value;
end;

procedure TIWBSButton.SetDataTarget(const Value: IIWBSContainer);
begin
  FDataTarget := Value;
end;
{$endregion}

end.
