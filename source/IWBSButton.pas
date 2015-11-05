unit IWBSButton;

interface

uses
  System.SysUtils, System.Classes, data.db, System.StrUtils, Vcl.Controls,
  IWRenderContext, IWHTMLTag, IWXMLTag, IWBaseInterfaces,
  IWBSCustomControl, IWScriptEvents, IWBSRegion, IWBSCommon;

type
  TIWBSButtonStyle = (bsbsDefault, bsbsPrimary, bsbsSuccess, bsbsInfo, bsbsWarning, bsbsDanger, bsbsLink, bsbsClose);
  TIWBSButtonDataDismiss = (bsbdNone, bsbdModal, bsbdAlert);

  TIWBSAsyncClickProc = reference to procedure(EventParams: TStringList);
  TIWBSButtonType = (iwbsbtButton, iwbsbtSubmit, iwbsbtReset);

  TIWBSCustomButton = class(TIWBSCustomControl)
  private
    FButtonSize: TIWBSSize;
    FButtonStyle: TIWBSButtonStyle;
    FGlyphicon: string;

    procedure SetGlyphicon(const Value: string);
    procedure SetButtonStyle(const Value: TIWBSButtonStyle);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BSButtonSize: TIWBSSize read FButtonSize write FButtonSize default bsszDefault;
    property BSButtonStyle: TIWBSButtonStyle read FButtonStyle write SetButtonStyle default bsbsDefault;
    property BSGlyphicon: string read FGlyphicon write SetGlyphicon;
    property Caption;
    property TabStop default True;
  end;

  TIWBSButton = class(TIWBSCustomButton)
  private
    FAnchor: boolean;
    FAsyncClickProc: TIWBSAsyncClickProc;
    FButtonType: TIWBSButtonType;
    FDataDismiss: TIWBSButtonDataDismiss;
    FHotKey: string;

    procedure DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
    procedure SetAsyncClickProc(Value: TIWBSAsyncClickProc);
  protected
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
    property AsyncClickProc: TIWBSAsyncClickProc read FAsyncClickProc write SetAsyncClickProc;
  published
    property Anchor: boolean read FAnchor write FAnchor default False;
    property ButtonType: TIWBSButtonType read FButtonType write FButtonType default iwbsbtButton;
    property BSDataDismiss: TIWBSButtonDataDismiss read FDataDismiss write FDataDismiss default bsbdNone;
    property Confirmation;
    property DoSubmitValidation;
    property HotKey: string read FHotkey write FHotKey;
  end;

  const
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
end;

procedure TIWBSButton.InternalRenderCss(var ACss: string);
begin
  inherited;
  if not FAnchor then begin
    TIWBSCommon.AddCssClass(ACss, 'btn');
    if FButtonSize <> bsszDefault then
      TIWBSCommon.AddCssClass(ACss, 'btn-'+aIWBSSize[FButtonSize]);
    TIWBSCommon.AddCssClass(ACss, aIWBSButtonStyle[FButtonStyle]);
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
    if FAnchor then
      AHTMLTag.AddStringParam('href', '#')
    else if FButtonType = iwbsbtButton then
      AHTMLTag.AddStringParam('type', 'button')
    else if FButtonType = iwbsbtSubmit then
      AHTMLTag.AddStringParam('type', 'submit')
    else if FButtonType = iwbsbtReset then
      AHTMLTag.AddStringParam('type', 'reset');
    if ShowHint and (Hint <> '') then begin
      AHTMLTag.AddStringParam('data-toggle', 'tooltip');
      AHTMLTag.AddStringParam('title', Hint);
    end;
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

    if FGlyphicon <> '' then begin
      xHTMLTag := AHTMLTag.Contents.AddTag('span');
      xHTMLTag.AddClassParam('glyphicon glyphicon-'+FGlyphicon);
      xHTMLTag.AddBoolParam('aria-hidden',true);
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

procedure TIWBSButton.DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
begin
  FAsyncClickProc(EventParams);
end;

procedure TIWBSButton.SetAsyncClickProc(Value: TIWBSAsyncClickProc);
begin
  FAsyncClickProc := Value;
  OnAsyncClick := DoAsyncClickProc
end;
{$endregion}

end.
