unit IWBSCustomControl;

interface

uses System.Classes, System.SysUtils, System.StrUtils, Data.db,
     IWControl, IWRenderContext, IWHTMLTag, IWXMLTag, IWDBCommon, IWDBStdCtrls, IWTypes,
     IWBSCommon;

type
  // Base class for IWBS controls
  TIWBSCustomControl = class(TIWCustomControl, IIWBSComponent)
  private
    FMainID: string;
    FOldCss: string;
    FOldDisabled: boolean;
    FOldReadOnly: boolean;
    FOldStyle: string;
    FOldVisible: boolean;

    FAsyncRefreshControl: boolean;
    FCustomAsyncEvents: TOwnedCollection;
    FCustomRestEvents: TOwnedCollection;
    FTabIndex: Integer;
    FScript: TStringList;
    FScriptParams: TIWBSScriptParams;
    FStyle: TStringList;
    FOnRenderAsync: TNotifyEvent;

    function RenderHTMLTag(AContext: TIWCompContext): string;

    procedure SetScript(const AValue: TStringList);
    procedure SetScriptParams(const AValue: TIWBSScriptParams);
    function GetStyle: TStringList;
    procedure SetStyle(const AValue: TStringList);
    procedure OnScriptChange(ASender : TObject);
    procedure OnStyleChange(ASender : TObject);
    function GetCustomAsyncEvents: TOwnedCollection;
    procedure SetCustomAsyncEvents(const Value: TOwnedCollection);
    function GetCustomRestEvents: TOwnedCollection;
    procedure SetCustomRestEvents(const Value: TOwnedCollection);
    function GetScript: TStringList;
    function GetScriptParams: TIWBSScriptParams;
  protected
    {$hints off}
    function get_HasTabOrder: Boolean; override;
    function getTabOrder: TIWTabOrder; override;
    procedure setTabOrder(AValue: TIWTabOrder); override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure RenderScripts(AComponentContext: TIWCompContext); override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  protected
    {$hints on}
    property ActiveCss: string read FOldCss;
    property ActiveStyle: string read FOldStyle;
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); virtual;
    procedure InternalRenderCss(var ACss: string); virtual;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); virtual;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); virtual;
    procedure InternalRenderStyle(AStyle: TStringList); virtual;
    function InputSelector: string; virtual;
    function InputSuffix: string; virtual;
    function IsReadOnly: boolean; virtual;
    function IsDisabled: boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // Force a full refresh of the control during an Async call.
    // Usually there is no need to use this method, only if some property change during async calls is not reflected.
    procedure AsyncRefreshControl;

    // Remove a control from html flow. You should execute this when destroying a control durinc async calls before Freeing
    // if you are destroying a region is enought to execute this in that region, you don't need to execute it in each child control.
    procedure AsyncRemoveControl;

    function IsStoredCustomAsyncEvents: Boolean;
    function IsStoredCustomRestEvents: Boolean;
    function JQSelector: string;
  published
    property CustomAsyncEvents: TOwnedCollection read GetCustomAsyncEvents write SetCustomAsyncEvents stored IsStoredCustomAsyncEvents;
    property CustomRestEvents: TOwnedCollection read GetCustomRestEvents write SetCustomRestEvents stored IsStoredCustomRestEvents;
    property Enabled;
    property ExtraTagParams;
    property FriendlyName;
    property Script: TStringList read GetScript write SetScript;
    property ScriptEvents;
    property ScriptParams: TIWBSScriptParams read GetScriptParams write SetScriptParams;
    property Style: TStringList read GetStyle write SetStyle;

    // It will be rendered if tabindex <> 0.
    // Set to -1 to disable tabstop
    property TabIndex: integer read FTabIndex write FTabIndex default 0;

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

    // this event is fired after HTMLTag is created
    property OnHTMLtag;

    // this event is fired after component is updated during async calls
    property OnRenderAsync: TNotifyEvent read FOnRenderAsync write FOnRenderAsync;
  end;

  // Base class for IWBS data aware controls
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

uses IW.Common.RenderStream, IWBaseHTMLInterfaces, IWForm, IWBSScriptEvents, IWBSGlobal, IWBSUtils, IWBSCustomEvents;

{$region 'TIWBSCustomControl'}
constructor TIWBSCustomControl.Create(AOwner: TComponent);
begin
  inherited;
  FAsyncRefreshControl := True;
  FCustomAsyncEvents := nil;
  FCustomRestEvents := nil;
  FMainID := '';
  FTabIndex := 0;
  FScript := TStringList.Create;
  FScript.OnChange := OnScriptChange;
  FScriptParams := TIWBSScriptParams.Create;
  FScriptParams.OnChange := OnScriptChange;
  FStyle := TStringList.Create;
  FStyle.OnChange := OnStyleChange;
  FStyle.NameValueSeparator := ':';
end;

destructor TIWBSCustomControl.Destroy;
begin
  FreeAndNil(FCustomAsyncEvents);
  FreeAndNil(FCustomRestEvents);
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);
  inherited;
end;

function TIWBSCustomControl.JQSelector: string;
begin
  Result := '$("#'+HTMLName+'")';
end;

procedure TIWBSCustomControl.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBSCustomControl.AsyncRemoveControl;
begin
  TIWBSCommon.AsyncRemoveControl(HTMLName);
end;

function TIWBSCustomControl.get_HasTabOrder: Boolean;
begin
  Result := False;
end;

function TIWBSCustomControl.getTabOrder: TIWTabOrder;
begin
  Result := -1;
end;

procedure TIWBSCustomControl.setTabOrder(AValue: TIWTabOrder);
begin
  //
end;

function TIWBSCustomControl.GetCustomAsyncEvents: TOwnedCollection;
begin
  if FCustomAsyncEvents = nil then
    FCustomAsyncEvents := TOwnedCollection.Create(Self, TIWBSCustomAsyncEvent);
  Result := FCustomAsyncEvents;
end;

function TIWBSCustomControl.GetCustomRestEvents: TOwnedCollection;
begin
  if FCustomRestEvents = nil then
    FCustomRestEvents := TOwnedCollection.Create(Self, TIWBSCustomRestEvent);
  Result := FCustomRestEvents;
end;

procedure TIWBSCustomControl.SetCustomAsyncEvents(const Value: TOwnedCollection);
begin
  FCustomAsyncEvents.Assign(Value);
end;

procedure TIWBSCustomControl.SetCustomRestEvents(const Value: TOwnedCollection);
begin
  FCustomRestEvents.Assign(Value);
end;

function TIWBSCustomControl.IsStoredCustomAsyncEvents: boolean;
begin
  Result := (FCustomAsyncEvents <> nil) and (FCustomAsyncEvents.Count > 0);
end;

function TIWBSCustomControl.IsStoredCustomRestEvents: boolean;
begin
  Result := (FCustomRestEvents <> nil) and (FCustomRestEvents.Count > 0);
end;

procedure TIWBSCustomControl.OnScriptChange( ASender : TObject );
begin
  AsyncRefreshControl;
end;

procedure TIWBSCustomControl.SetScript(const AValue: TStringList);
begin
  FScript.Assign(AValue);
end;

procedure TIWBSCustomControl.OnStyleChange( ASender : TObject );
begin
  Invalidate;
end;

procedure TIWBSCustomControl.SetScriptParams(const AValue: TIWBSScriptParams);
begin
  FScriptParams.Assign(AValue);
end;

function TIWBSCustomControl.GetScript: TStringList;
begin
  Result := FScript;
end;

function TIWBSCustomControl.GetScriptParams: TIWBSScriptParams;
begin
  Result := FScriptParams;
end;

function TIWBSCustomControl.GetStyle: TStringList;
begin
  Result := FStyle;
end;

procedure TIWBSCustomControl.SetStyle(const AValue: TStringList);
begin
  FStyle.Assign(AValue);
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
  //
end;

procedure TIWBSCustomControl.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  //
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
        xInputSelector := FMainID+InputSelector
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

  if Assigned(gIWBSOnRenderAsync) then
    gIWBSOnRenderAsync(Self, xHTMLName);
end;

function TIWBSCustomControl.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := Css;
  InternalRenderCss(Result);
end;

function TIWBSCustomControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := nil;
  FOldCss := RenderCSSClass(AContext);
  FOldDisabled := IsDisabled;
  FOldReadOnly := IsReadOnly;
  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;

  InternalRenderHTML(HTMLName, AContext, Result);
  if Result = nil then
    raise Exception.Create('HTML tag not created');

  IWBSRenderScript(Self, AContext, Result);
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
    if not Visible then
      TIWBSCommon.SetNotVisible(LTag.Params);

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
begin
  Result := TIWBSCommon.RenderStyle(Self);
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
  if FMaxLength <> AValue then begin
    FMaxLength := AValue;
    AsyncRefreshControl;
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
