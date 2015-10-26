unit IWBSControls;

interface

uses System.Classes, System.SysUtils, Data.Db,
     IWControl, IWRenderContext, IWMarkupLanguageTag, IWXMLTag, IWHTMLTag,
     IWDBCommon, IWBSCommon,
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
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure SetForControl(const Value: TIWCustomControl);
  public
    constructor Create(AOwner: TComponent); override;
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
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
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
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function get_HasTabOrder: boolean; override;
  published
    property BSGlyphicon: string read FGlyphicon write FGlyphicon;
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

procedure TIWBSLabel.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;
  FOldText := RenderLabelText;

  if Assigned(FForControl) then
    begin
      AHTMLTag := TIWHTMLTag.CreateTag('label');
      AHTMLTag.AddStringParam('for', ForControl.HTMLName);
    end
  else
    AHTMLTag := TIWHTMLTag.CreateTag('span');
  AHTMLTag.AddStringParam('id', HTMLName);
  AHTMLTag.AddClassParam(ActiveCss);
  AHTMLTag.AddStringParam('style',ActiveStyle);
  AHTMLTag.Contents.AddText(FOldText);

  if Parent is TIWBSInputGroup then
    AHTMLTag := IWBSCreateInputGroupAddOn(AHTMLTag, HTMLName, 'addon');
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

procedure TIWBSText.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;
  FOldText := RenderText;

  AHTMLTag := TIWHTMLTag.CreateTag('div');
  AHTMLTag.AddStringParam('id', HTMLName);
  AHTMLTag.AddClassParam(ActiveCss);
  AHTMLTag.AddStringParam('style',ActiveStyle);
  AHTMLTag.Contents.AddText(FOldText);
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

procedure TIWBSGlyphicon.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;
  AHTMLTag := TIWHTMLTag.CreateTag('span');
  try
    AHTMLTag.AddStringParam('id', AHTMLName);
    AHTMLTag.AddClassParam(ActiveCss);
    AHTMLTag.AddStringParam('style',ActiveStyle);
    if FGlyphicon <> '' then
      AHTMLTag.AddBoolParam('aria-hidden',true)
    else
      AHTMLTag.Contents.AddText('&times;');
  except
    FreeAndNil(AHTMLTag);
    raise;
  end;
  if Parent is TIWBSInputGroup then
    AHTMLTag := IWBSCreateInputGroupAddOn(AHTMLTag, AHTMLName, 'addon');
end;
{$endregion}

end.
