unit IWBSCustomControl;

interface

uses System.Classes, System.SysUtils, System.StrUtils, Data.db,
     IWControl, IWRenderContext, IWHTMLTag, IWXMLTag, IWDBCommon, IWDBStdCtrls,
     IWBSCommon;

type
  TIWBSCustomControl = class(TIWCustomControl, IIWBSComponent)
  private
    FMainID: string;
    FOldCss: string;
    FOldDisabled: boolean;
    FOldReadOnly: boolean;
    FOldStyle: string;
    FOldVisible: boolean;

    FAsyncRefreshControl: boolean;
    FTabStop: boolean;
    FScript: TStringList;
    FScriptParams: TStringList;
    FStyle: TStringList;
    FOnRenderAsync: TNotifyEvent;

    procedure SetScript(const AValue: TStringList);
    procedure SetScriptParams(const AValue: TStringList);
    procedure SetStyle(const AValue: TStringList);
    procedure OnScriptChange(ASender : TObject);
    procedure OnScriptParamsChange(ASender : TObject);
  protected
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); virtual;
    procedure InternalRenderCss(var ACss: string); virtual;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); virtual;
    function InternalRenderScript: string; virtual;
    procedure InternalRenderStyle(AStyle: TStringList); virtual;
    function IsReadOnly: boolean; virtual;
    function IsDisabled: boolean; virtual;
    function InputSelector: string; virtual;
    function InputSuffix: string; virtual;
  public
    class procedure AddCssClass(var ACss: string; const AClass: string);

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderHTMLTag(AContext: TIWCompContext): string; virtual;
    procedure RenderScripts(AComponentContext: TIWCompContext); override;
    function RenderStyle(AContext: TIWCompContext): string; override;

    property MainID: string read FMainID;
    property ActiveCss: string read FOldCss;
    property ActiveStyle: string read FOldStyle;

    function get_HasTabOrder: Boolean; override;

    // Force a full refresh of the control during an Async call.
    // Usually there is no need to use this method, only if some property change during async calls is not reflected.
    procedure AsyncRefreshControl;
  published
    property Enabled;
    property ExtraTagParams;
    property FriendlyName;
    property Script: TStringList read FScript write SetScript;
    property ScriptEvents;
    property ScriptParams: TStringList read FScriptParams write SetScriptParams;
    property Style: TStringList read FStyle write SetStyle;
    property TabStop: boolean read FTabStop write FTabStop default False;
    property TabOrder;

    property OnAsyncClick;
    property OnAsyncDoubleClick;
    property OnAsyncChange;
    property OnAsyncEnter;
    property OnAsyncExit;
    property OnAsyncKeyDown;
    property OnAsyncKeyUp;
    property OnAsyncKeyPress;
    property OnAsyncMouseDown;
    property OnAsyncMouseMove;
    property OnAsyncMouseOver;
    property OnAsyncMouseOut;
    property OnAsyncMouseUp;

    property OnHTMLtag;
    property OnRenderAsync: TNotifyEvent read FOnRenderAsync write FOnRenderAsync;
  end;

  TIWBSCustomDbControl = class(TIWBSCustomControl, IIWBSComponent)
  private
    FDataLink: TIWDataLink;
    FDataField: string;
    FDataSource: TDataSource;
    FMaxLength: Integer;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetMaxLength(const AValue:integer);
  protected
    procedure CheckData(AContext: TIWCompContext); virtual;
    property MaxLength: Integer read FMaxLength write SetMaxLength;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property DataField: string read FDataField write SetDataField;
  end;

implementation

uses IW.Common.RenderStream, IWBaseHTMLInterfaces, IWForm, IWBSScriptEvents, IWBSGlobal, IWBSUtils;

{$region 'TIWBSCustomControl'}
class procedure TIWBSCustomControl.AddCssClass(var ACss: string; const AClass: string);
begin
  if ACss <> '' then
    ACss := ACss+' ';
  ACss := ACss+AClass;
end;

constructor TIWBSCustomControl.Create(AOwner: TComponent);
begin
  inherited;
  FAsyncRefreshControl := True;
  FMainID := '';
  FTabStop := False;
  FScript := TStringList.Create;
  FScript.OnChange := OnScriptChange;
  FScriptParams := TStringList.Create;
  FScriptParams.OnChange := OnScriptParamsChange;
  FStyle := TStringList.Create;
  FStyle.NameValueSeparator := ':';
end;

destructor TIWBSCustomControl.Destroy;
begin
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);
  inherited;
end;

procedure TIWBSCustomControl.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

function TIWBSCustomControl.get_HasTabOrder: Boolean;
begin
  Result := FTabStop and gIWBSEnableTabIndex;
end;

procedure TIWBSCustomControl.OnScriptChange( ASender : TObject );
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBSCustomControl.SetScript(const AValue: TStringList);
begin
  FScript.Assign(AValue);
end;

procedure TIWBSCustomControl.OnScriptParamsChange( ASender : TObject );
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBSCustomControl.SetScriptParams(const AValue: TStringList);
begin
  FScriptParams.Assign(AValue);
end;

procedure TIWBSCustomControl.SetStyle(const AValue: TStringList);
begin
  FStyle.Assign(AValue);
  Invalidate;
end;

procedure TIWBSCustomControl.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  //
end;

procedure TIWBSCustomControl.InternalRenderCss(var ACss: string);
begin
  //
end;

procedure TIWBSCustomControl.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  FOldCss := RenderCSSClass(AContext);
  FOldDisabled := IsDisabled;
  FOldReadOnly := IsReadOnly;
  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;
end;

function TIWBSCustomControl.InternalRenderScript: string;
begin
  Result := TIWBSCommon.ReplaceParams(HTMLName, FScript.Text, FScriptParams);
end;

procedure TIWBSCustomControl.InternalRenderStyle(AStyle: TStringList);
begin
  //
end;

function TIWBSCustomControl.IsReadOnly: boolean;
begin
  Result := False;
end;

function TIWBSCustomControl.IsDisabled: boolean;
begin
  Result := not Enabled;
end;

function TIWBSCustomControl.InputSelector: string;
begin
  Result := '';
end;

function TIWBSCustomControl.InputSuffix: string;
begin
  Result := '';
end;

function TIWBSCustomControl.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
  xInputSelector: string;
  LParentContainer: IIWBaseHTMLComponent;
  LParentSl: string;
  LHtmlTag: string;
begin
  Result := nil;
  xHTMLName := HTMLName;

  if FAsyncRefreshControl then
    begin
      // get base container
      if ParentContainer.InterfaceInstance is TIWForm then
        LParentSl := 'body'
      else
        begin
          LParentContainer := BaseHTMLComponentInterface(ParentContainer.InterfaceInstance);
          if LParentContainer <> nil then
            LParentSl := '#'+LParentContainer.HTMLName
          else
            Exit;
        end;
      LHtmlTag := RenderHtmlTag(AContext);
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecuteAsCDATA('AsyncRenderControl("'+xHTMLName+'", "'+LParentSl+'", "'+IWBSTextToJsParamText(LHtmlTag)+'");')
    end
  else
    begin
      if InputSelector <> '' then
        xInputSelector := MainID+InputSelector
      else
        xInputSelector := xHTMLName+InputSuffix;
      SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
      SetAsyncDisabled(AContext, xInputSelector, IsDisabled, FOldDisabled);
      SetAsyncReadOnly(AContext, xInputSelector, IsReadOnly, FOldReadOnly);
      SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
      SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
      InternalRenderAsync(xHTMLName, AContext);
    end;

  if Assigned(FOnRenderAsync) then
    FOnRenderAsync(Self);

  // global hook
  if Assigned(gIWBSOnRenderAsync) then
    gIWBSOnRenderAsync(Self, xHTMLName, xInputSelector);
end;

function TIWBSCustomControl.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := Css;
  InternalRenderCss(Result);
end;

function TIWBSCustomControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := nil;
  InternalRenderHTML(HTMLName, AContext, Result);
  if Result = nil then
    raise Exception.Create('HTML tag not created');
  IWBSRenderScript(Self, AContext, Result);
  if not Visible then
    TIWBSCommon.SetNotVisible(Result.Params);
  FMainID := Result.Params.Values['id'];
  FAsyncRefreshControl := False;
end;

function TIWBSCustomControl.RenderHTMLTag(AContext: TIWCompContext): string;
var
  LBuffer: TIWRenderStream;
  LTag: TIWHTMLTag;
begin
  LTag := RenderHTML(AContext);
  try
    LBuffer := TIWRenderStream.Create(True, True);
    try
      RenderHTML(AContext).Render(LBuffer);
      Result := LBuffer.AsString;
    finally
      LBuffer.Free;
    end;
  finally
    LTag.Free;
  end;
end;

procedure TIWBSCustomControl.RenderScripts(AComponentContext: TIWCompContext);
begin
  //
end;

function TIWBSCustomControl.RenderStyle(AContext: TIWCompContext): string;
var
  xStyle: TStringList;
  i: integer;
begin
  Result := '';

  xStyle := TStringList.Create;
  try
    xStyle.Assign(FStyle);

    // here we render z-index
    if ZIndex <> 0 then
      xStyle.Values['z-index'] := IntToStr(Zindex);

    for i := 0 to xStyle.Count-1 do begin
      if Result <> '' then
        Result := Result + ';';
      Result := Result + xStyle[i];
    end;
  finally
    xStyle.Free;
  end;
end;
{$endregion}

{$region 'TIWBSCustomDbControl'}
constructor TIWBSCustomDbControl.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink := nil;
  FDataField := '';
end;

destructor TIWBSCustomDbControl.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited;
end;

procedure TIWBSCustomDbControl.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then
    if FDatasource = AComponent then
      SetDataSource(nil);
end;

procedure TIWBSCustomDbControl.SetDataField(const AValue: string);
var
  xFld: TField;
begin
  if not SameText(AValue, FDataField) then begin
    FDataField := AValue;
    MaxLength := 0;
    if FDataField <> '' then begin
      xFld := GetDataSourceField(FDataSource, FDataField);
      if Assigned(xFld) and (xFld is TStringField) then
        MaxLength := TStringField(xFld).Size;
    end;
    Invalidate;
  end;
end;

procedure TIWBSCustomDbControl.SetDataSource(const Value: TDataSource);
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

procedure TIWBSCustomDbControl.SetMaxLength(const AValue:integer);
begin
  if FMaxLength <> AValue then
  begin
    FMaxLength := AValue;
    Invalidate;
  end;
end;

procedure TIWBSCustomDbControl.CheckData(AContext: TIWCompContext);
begin
  //
end;

function TIWBSCustomDbControl.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
begin
  CheckData(AContext);
  Result := inherited;
end;

function TIWBSCustomDbControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  CheckData(AContext);
  Result := inherited;
end;
{$endregion}

end.
