unit IWBSControls;

interface

uses System.Classes, System.SysUtils, Data.Db,
     IWControl, IWRenderContext, IWMarkupLanguageTag, IWXMLTag, IWHTMLTag,
     IWCompLabel, IWDBCommon, IWDBStdCtrls, IWDBExtCtrls, IWCompText;

type
  TIWBSLabel = class(TIWCustomLabel)
  private
    FDataLink: TIWDataLink;
    FDataField: string;
    FDataSource: TDataSource;
    procedure CheckData; virtual;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(const Value: TDataSource);
  protected
    procedure Paint; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure InitControl; override;
  public
    destructor Destroy; override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property AutoSize;
    property Caption;
    property DataField: string read FDataField write SetDataField;
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property FriendlyName;
    property RawText default False;
    property OnAsyncClick;
    property OnAsyncMouseDown;
    property OnAsyncMouseMove;
    property OnAsyncMouseOver;
    property OnAsyncMouseOut;
    property OnAsyncMouseUp;
  end;

  TIWBSGlyphicon = class(TIWCustomControl)
  private
    FGlyphicon: string;
  protected
    procedure InitControl; override;
    function get_ShouldRenderTabOrder: boolean;override;
    function get_HasName: Boolean; override;
  public
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AComponentContext: TIWCompContext): string; override;
    function get_HasTabOrder: boolean; override;
  published
    property BSGlyphicon: string read FGlyphicon write FGlyphicon;
  end;

  TIWBSImage = class(TIWDBImage)
  protected
    procedure CheckData; override;
  public
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
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

  TIWBSText = class(TIWText)
  public
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  end;

implementation

uses IWBSInput, IWBSUtils;

{$region 'TIWBSLabel'}
procedure TIWBSLabel.InitControl;
begin
  inherited;
  FDataField := '';
end;

destructor TIWBSLabel.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited;
end;

procedure TIWBSLabel.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then
    if FDatasource = AComponent then
      SetDataSource(nil);
end;

procedure TIWBSLabel.Paint;
begin
  if FDataSource <> nil then
    if DataField = '' then
      Caption := Name
    else
      Caption := DataField;
  inherited Paint;
end;

function TIWBSLabel.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
begin
  CheckData;
  Result := inherited RenderAsync(AContext);
end;

function TIWBSLabel.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  CheckData;
  Result := inherited RenderHTML(AContext);
  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, 'addon');
end;

procedure TIWBSLabel.SetDataField(const AValue: string);
begin
  if not SameText(AValue, FDataField) then begin
    FDataField := AValue;
    Invalidate;
  end;
end;

procedure TIWBSLabel.SetDataSource(const Value: TDataSource);
begin
  if Value <> FDataSource then begin
    FDataSource := Value;
    if Value = nil then
      begin
        FDataField := '';
        FreeAndNil(FDataLink);
      end
    else
      begin
        if FDataLink = nil then
          FDataLink := TIWDataLink.Create(Self);
        FDataLink.DataSource := FDataSource;
      end;
    Invalidate;
  end;
end;

procedure TIWBSLabel.CheckData;
var
  LField: TField;
begin
  if CheckDataSource(FDataSource, DataField, LField) then
    Caption := LField.DisplayText;
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

function TIWBSGlyphicon.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('SPAN');
  try
    if FGlyphicon <> '' then
      begin
        Result.AddClassParam('glyphicon glyphicon-'+FGlyphicon);
        Result.AddBoolParam('aria-hidden',true);
      end
    else
      Result.Contents.AddText('&times;');
  except
    FreeAndNil(Result);
    raise;
  end;
  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(REsult, 'addon');
end;

function TIWBSGlyphicon.RenderStyle(AComponentContext: TIWCompContext): string;
begin
  Result := '';
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

function TIWBSImage.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result.AddClassParam(RenderCSSClass(AContext));
end;
{$endregion}

{$region 'TIWBSImage'}
function TIWBSText.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := Css;
end;

function TIWBSText.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result.AddClassParam(RenderCSSClass(AContext));
end;
{$endregion}

end.
