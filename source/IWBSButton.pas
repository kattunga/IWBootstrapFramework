unit IWBSButton;

interface

uses
  System.SysUtils, System.Classes, data.db, System.StrUtils, Vcl.Controls,
  IWRenderContext, IWHTMLTag, IWXMLTag, IWBaseHTMLControl, IWBaseInterfaces,
  IWCompCheckBox, IWCompRadioButton, IWCompButton, IWDBStdCtrls, IWDBExtCtrls,
  IWBSRegion, IWBSCommon, IWBSCustomInput;

type
  TIWBSButtonStyle = (bsbsDefault, bsbsPrimary, bsbsSuccess, bsbsInfo, bsbsWarning, bsbsDanger, bsbsLink, bsbsClose);
  TIWBSButtonDataDismiss = (bsbdNone, bsbdModal, bsbdAlert);

  TIWBSAsyncClickProc = reference to procedure(EventParams: TStringList);

  TIWBSButton = class(TIWButton)
  private
    FDataDismiss: TIWBSButtonDataDismiss;
    FButtonSize: TIWBSSize;
    FButtonStyle: TIWBSButtonStyle;
    FGlyphicon: string;
    FAsyncClickProc: TIWBSAsyncClickProc;

    FMainID: string;
    FOldVisible: boolean;
    FOldDisabled: boolean;
    FOldCss: string;
    FOldStyle: string;

    procedure DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
    procedure SetAsyncClickProc(Value: TIWBSAsyncClickProc);
    procedure SetGlyphicon(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
    property AsyncClickProc: TIWBSAsyncClickProc read FAsyncClickProc write SetAsyncClickProc;
  published
    property BSButtonSize: TIWBSSize read FButtonSize write FButtonSize default bsszDefault;
    property BSButtonStyle: TIWBSButtonStyle read FButtonStyle write FButtonStyle default bsbsDefault;
    property BSDataDismiss: TIWBSButtonDataDismiss read FDataDismiss write FDataDismiss default bsbdNone;
    property BSGlyphicon: string read FGlyphicon write SetGlyphicon;
  end;

implementation

uses Vcl.Graphics,
     IWColor, IWBSInputCommon;

{$region 'TIWBSButton'}
constructor TIWBSButton.Create(AOwner: TComponent);
begin
  inherited;
  FButtonSize := bsszDefault;
  FButtonStyle := bsbsDefault;
  FDataDismiss := bsbdNone;
  FGlyphicon := '';
end;

function TIWBSButton.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  Result := nil;

  SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
  SetAsyncDisabled(AContext, xHTMLName, not (Enabled and Editable), FOldDisabled);
  SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
end;

function TIWBSButton.RenderCSSClass(AComponentContext: TIWCompContext): string;
const
  aIWBSButtonStyle: array[bsbsDefault..bsbsClose] of string = ('btn-default', 'btn-primary', 'btn-success', 'btn-info', 'btn-warning', 'btn-danger', 'btn-link', 'close');
begin
  Result := 'btn';
  if FButtonSize <> bsszDefault then
    Result := Result + ' btn-'+aIWBSSize[FButtonSize];
  Result := Result + ' ' + aIWBSButtonStyle[FButtonStyle];
  if Css <> '' then
    Result := Result + ' ' + Css;
end;

function TIWBSButton.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
const
  aIWBSButtonDataDismiss: array[bsbdNone..bsbdAlert] of string = ('', 'modal', 'alert');
var
  xHTMLName: string;
  s: string;
  gspan: TIWHTMLTag;
begin
  xHTMLName := HTMLName;

  FOldVisible := Visible;
  FOldDisabled := not (Enabled and Editable);
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);

  Result := TIWHTMLTag.CreateTag('button');
  try
    Result.AddStringParam('id', xHTMLName);
    Result.AddClassParam(FOldCss);
    if FDataDismiss <> bsbdNone then
      Result.AddStringParam('data-dismiss', aIWBSButtonDataDismiss[FDataDismiss]);
    Result.AddStringParam('type', 'button');
    if ShowHint and (Hint <> '') then begin
      Result.AddStringParam('data-toggle', 'tooltip');
      Result.AddStringParam('title', Hint);
    end;
    if FOldDisabled then
      Result.Add('disabled');
    s := TextToHTML(Caption);
    if HotKey <> '' then begin
      Result.AddStringParam('accesskey', HotKey);
      s := StringReplace(s, FHotKey, '<u>' + FHotKey + '</u>', [rfIgnoreCase]);
    end;
    if FButtonStyle = bsbsClose then
      Result.AddStringParam('aria-label', 'Close');
    Result.AddStringParam('style', FOldStyle);

    if FGlyphicon <> '' then begin
      gspan := Result.Contents.AddTag('span');
      gspan.AddClassParam('glyphicon glyphicon-'+FGlyphicon);
      gspan.AddBoolParam('aria-hidden',true);
      s := ' '+s;
    end;

    // caption after glyphicon
    if (FButtonStyle = bsbsClose) and (s = '') and (FGlyphicon = '') then
      Result.Contents.AddText('&times;')
    else
      Result.Contents.AddText(s);
  except
    FreeAndNil(Result);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, 'btn')
  else
    Result := IWBSCreateFormGroup(Parent, IWBSFindParentInputForm(Parent), Result, xHTMLName, True);

  // save id of final container to set visibility
  FMainID := Result.Params.Values['id'];
end;

function TIWBSButton.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
  if (WebFont.Enabled) then
    Result := Result + WebFont.FontToStringStyle+';';
  if toTColor(WebColor) <> clBtnFace then
    Result := Result + RenderBGColor(WebColor)+';';
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
