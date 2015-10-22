unit IWBSControls;

interface

uses System.Classes, System.SysUtils, Data.Db, Vcl.Graphics,
     IWControl, IWRenderContext, IWMarkupLanguageTag, IWXMLTag, IWHTMLTag,
     IWDBCommon, IWDBExtCtrls, IWBSCommon,
     IWBSCustomControl;

type
  TIWBSLabel = class(TIWBSCustomDbControl)
  private
    FForControl: TIWCustomControl;
    FRawText: boolean;
    FOldText: string;
    function  RenderLabelText: string;
  protected
    procedure CheckData; override;
    procedure SetForControl(const Value: TIWCustomControl);
  public
    constructor Create(AOwner: TComponent); override;
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Caption;
    property ForControl: TIWCustomControl read FForControl write SetForControl;
    property RawText: boolean read FRawText write FRawText default False;
  end;

  TIWBSText = class(TIWBSCustomDbControl)
  private
    FLines: TStringList;
    FRawText: boolean;
    FOldText: string;
    function  RenderText: string;
    procedure OnItemsChange(ASender : TObject);
    procedure SetLines(const AValue: TStringList);
  protected
    procedure CheckData; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Lines: TStringList read FLines write SetLines;
    property RawText: boolean read FRawText write FRawText default False;
  end;

  TIWBSGlyphicon = class(TIWBSCustomControl)
  private
    FGlyphicon: string;
  protected
    procedure InitControl; override;
    function get_ShouldRenderTabOrder: boolean; override;
    function get_HasName: Boolean; override;
  public
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
    function get_HasTabOrder: boolean; override;
  published
    property BSGlyphicon: string read FGlyphicon write FGlyphicon;
  end;

  TIWBSImage = class(TIWDBImage, IIWBSComponent)
  private
    FOldVisible: boolean;
  protected
    procedure CheckData; override;
  public
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AComponentContext: TIWCompContext): string; override;
  published
    property OnAsyncClick;
    property OnAsyncDoubleClick;
    property OnAsyncMouseDown;
    property OnAsyncMouseMove;
    property OnAsyncMouseOver;
    property OnAsyncMouseOut;
    property OnAsyncMouseUp;

    property Picture;
    property FriendlyName;
    property TransparentColor;
    property JpegOptions;
    property OutputType;
    property RenderEmptyAsSpan;
  end;

implementation

uses IWBSInput, IWBSRegion, IWBSInputCommon;

{$region 'TIWBSLabel'}
constructor TIWBSLabel.Create(AOwner: TComponent);
begin
  inherited;
  FRawText := False;
end;

procedure TIWBSLabel.SetForControl(const Value: TIWCustomControl);
begin
  FForControl := Value;
end;

function TIWBSLabel.RenderLabelText: string;
begin
  if RawText then
    Result := Caption
  else
    Result := TextToHTML(Caption);
end;

procedure TIWBSLabel.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  SetAsyncHtml(AContext, AHTMLName, RenderLabelText, FOldText);
end;

function TIWBSLabel.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
var
  RawContent: string;
begin
  inherited;
  RawContent := RenderLabelText;

  if Assigned(FForControl) then
    begin
      Result := TIWHTMLTag.CreateTag('label');
      Result.AddStringParam('for', ForControl.HTMLName);
    end
  else
    Result := TIWHTMLTag.CreateTag('span');
  Result.AddStringParam('id', HTMLName);
  Result.AddClassParam(ActiveCss);
  Result.AddStringParam('style',ActiveStyle);
  Result.Contents.AddText(RawContent);

  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, HTMLName, 'addon');

  FOldText := RawContent;
end;

procedure TIWBSLabel.CheckData;
var
  LField: TField;
begin
  if CheckDataSource(DataSource, DataField, LField) then
    Caption := LField.DisplayText;
end;
{$endregion}

{$region 'TIWBSText'}
constructor TIWBSText.Create(AOwner: TComponent);
begin
  inherited;
  FLines := TStringList.Create;
  FLines.OnChange := OnItemsChange;
  FRawText := False;
end;

procedure TIWBSText.OnItemsChange( ASender : TObject );
begin
  DoRefreshControl := True;
  Invalidate;
end;

procedure TIWBSText.SetLines(const AValue: TStringList);
begin
  FLines.Assign(AValue);
  Invalidate;
end;

function TIWBSText.RenderText: string;
begin
  if RawText then
    Result := Lines.Text
  else
    Result := TextToHTML(Lines.Text);
end;

procedure TIWBSText.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  SetAsyncHtml(AContext, AHTMLName, RenderText, FOldText);
end;

function TIWBSText.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
var
  RawContent: string;
begin
  inherited;
  RawContent := RenderText;

  Result := TIWHTMLTag.CreateTag('div');
  Result.AddStringParam('id', HTMLName);
  Result.AddClassParam(ActiveCss);
  Result.AddStringParam('style',ActiveStyle);
  Result.Contents.AddText(RawContent);

  FOldText := RawContent;
end;

procedure TIWBSText.CheckData;
var
  LField: TField;
begin
  if CheckDataSource(DataSource, DataField, LField) then
    Lines.Text := LField.DisplayText;
end;
{$endregion}

{$region 'TIWBSGlyphicon'}
procedure TIWBSGlyphicon.InitControl;
begin
  inherited;
  Height := 21;
  Width := 21;
end;

function TIWBSGlyphicon.get_HasTabOrder: boolean;
begin
  Result := False;
end;

function TIWBSGlyphicon.get_ShouldRenderTabOrder: boolean;
begin
  Result := False;
end;

function TIWBSGlyphicon.get_HasName: Boolean;
begin
  Result := False;
end;

function TIWBSGlyphicon.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  if FGlyphicon <> '' then
    Result := 'glyphicon glyphicon-'+FGlyphicon
  else
    Result := '';
  if Css <> '' then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + Css;
  end;
end;

function TIWBSGlyphicon.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
begin
  inherited;
  Result := TIWHTMLTag.CreateTag('span');
  try
    Result.AddStringParam('id', AHTMLName);
    Result.AddClassParam(ActiveCss);
    Result.AddStringParam('style',ActiveStyle);
    if FGlyphicon <> '' then
      Result.AddBoolParam('aria-hidden',true)
    else
      Result.Contents.AddText('&times;');
  except
    FreeAndNil(Result);
    raise;
  end;
  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, AHTMLName, 'addon');
end;
{$endregion}

{$region 'TIWBSImage'}
procedure TIWBSImage.CheckData;
begin
  if DataSource <> nil then
    inherited;
end;

function TIWBSImage.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'img-responsive';
end;

function TIWBSImage.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  Result := nil;
  xHTMLName := HTMLName;
  SetAsyncVisible(AContext, xHTMLName, Visible, FOldVisible);
end;

function TIWBSImage.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result.AddClassParam(RenderCSSClass(AContext));

  FOldVisible := Visible;
end;

function TIWBSImage.RenderStyle(AComponentContext: TIWCompContext): string;
begin
  Result := '';
end;
{$endregion}

end.
