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

  TIWBSButton = class(TIWBSCustomControl, IIWSubmitControl)
  private
    FAnchor: boolean;
    FDataDismiss: TIWBSButtonDataDismiss;
    FButtonSize: TIWBSSize;
    FButtonStyle: TIWBSButtonStyle;
    FGlyphicon: string;
    FHotKey: string;
    FAsyncClickProc: TIWBSAsyncClickProc;

    FOldDisabled: boolean;

    procedure DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
    procedure SetAsyncClickProc(Value: TIWBSAsyncClickProc);
    procedure SetGlyphicon(const Value: string);
  protected
    procedure Submit(const AValue: string); override;
    procedure HookEvents(APageContext: TIWPageContext40; AScriptEvents: TIWScriptEvents); override;
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetSubmitParam : String;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
    property AsyncClickProc: TIWBSAsyncClickProc read FAsyncClickProc write SetAsyncClickProc;
  published
    property Anchor: boolean read FAnchor write FAnchor default False;
    property BSButtonSize: TIWBSSize read FButtonSize write FButtonSize default bsszDefault;
    property BSButtonStyle: TIWBSButtonStyle read FButtonStyle write FButtonStyle default bsbsDefault;
    property BSDataDismiss: TIWBSButtonDataDismiss read FDataDismiss write FDataDismiss default bsbdNone;
    property BSGlyphicon: string read FGlyphicon write SetGlyphicon;
    property Caption;
    property Confirmation;
    property DoSubmitValidation;
    property Enabled;
    property ExtraTagParams;
    property HotKey: string read FHotkey write FHotKey;
    property FriendlyName;
    property ScriptEvents;
    property TabOrder;

    property OnClick;
    property OnAsyncClick;
    property OnAsyncDoubleClick;
    property OnAsyncEnter;
    property OnAsyncExit;
    property OnAsyncMouseMove;
    property OnAsyncMouseOver;
    property OnAsyncMouseOut;
  end;

implementation

uses Vcl.Graphics, IW.Common.System,
     IWColor, IWBSInputCommon;

{$region 'TIWBSButton'}
constructor TIWBSButton.Create(AOwner: TComponent);
begin
  inherited;
  FAnchor := False;
  FButtonSize := bsszDefault;
  FButtonStyle := bsbsDefault;
  FDataDismiss := bsbdNone;
  FGlyphicon := '';

  FCanReceiveFocus := True;
  FNeedsFormTag := True;
  Height := 25;
  Width := 200;
end;

function TIWBSButton.GetSubmitParam: String;
begin
  Result := FSubmitParam;
end;

procedure TIWBSButton.Submit(const AValue: string);
begin
  FSubmitParam := AValue;
  DoClick;
end;

procedure TIWBSButton.HookEvents(APageContext: TIWPageContext40; AScriptEvents: TIWScriptEvents);
begin
  inherited HookEvents(APageContext, AScriptEvents);
  if HasOnClick then begin
    AScriptEvents.HookEvent('OnClick', SubmitHandler(''));
  end;
end;

procedure TIWBSButton.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  inherited;
  SetAsyncDisabled(AContext, AHTMLName, not (Enabled and Editable), FOldDisabled);
end;

function TIWBSButton.RenderCSSClass(AComponentContext: TIWCompContext): string;
const
  aIWBSButtonStyle: array[bsbsDefault..bsbsClose] of string = ('btn-default', 'btn-primary', 'btn-success', 'btn-info', 'btn-warning', 'btn-danger', 'btn-link', 'close');
begin
  if not FAnchor then
    begin
      Result := 'btn';
      if FButtonSize <> bsszDefault then
        Result := Result + ' btn-'+aIWBSSize[FButtonSize];
      Result := Result + ' ' + aIWBSButtonStyle[FButtonStyle];
      if Parent.ClassName = 'TIWBSNavBar' then
        Result := Result + ' navbar-btn';
      if Css <> '' then
        Result := Result + ' ' + Css;
    end
  else
    Result := Css;
end;

procedure TIWBSButton.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
const
  aIWBSButtonDataDismiss: array[bsbdNone..bsbdAlert] of string = ('', 'modal', 'alert');
var
  s: string;
  xHTMLTag: TIWHTMLTag;
begin
  inherited;
  FOldDisabled := not (Enabled and Editable);

  AHTMLTag := TIWHTMLTag.CreateTag(iif(FAnchor,'a','button'));
  try
    AHTMLTag.AddStringParam('id', AHTMLName);
    AHTMLTag.AddClassParam(ActiveCss);
    if FDataDismiss <> bsbdNone then
      AHTMLTag.AddStringParam('data-dismiss', aIWBSButtonDataDismiss[FDataDismiss]);
    if FAnchor then
      AHTMLTag.AddStringParam('href', '#')
    else
      AHTMLTag.AddStringParam('type', 'button');
    if ShowHint and (Hint <> '') then begin
      AHTMLTag.AddStringParam('data-toggle', 'tooltip');
      AHTMLTag.AddStringParam('title', Hint);
    end;
    if FOldDisabled then
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

function TIWBSButton.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
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

procedure TIWBSButton.SetGlyphicon(const Value: string);
begin
  FGlyphicon := Value;
  Invalidate;
end;
{$endregion}

end.
