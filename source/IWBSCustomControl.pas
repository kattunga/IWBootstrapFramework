unit IWBSCustomControl;

interface

uses Classes, SysUtils, StrUtils, db,
     IWControl, IWRenderContext, IWHTMLTag, IWXMLTag, IWDBCommon, IWDBStdCtrls, IWTypes, IWApplication,
     IWBSCommon, IWBSCommonInterfaces, IWBSCustomEvents;

type
  // Base class for IWBS controls
  TIWBSCustomControl = class(TIWCustomControl, IIWBSComponent)
  private
    FMainID: string;

    FAsyncRefreshControl: boolean;
    FRendered: boolean;
    FCustomAsyncEvents: TIWBSCustomAsyncEvents;
    FCustomRestEvents: TIWBSCustomRestEvents;
    FExtraTagParams: TStringList;
    FTabIndex: Integer;
    FScript: TStringList;
    FScriptInsideTag: boolean;
    FScriptParams: TIWBSScriptParams;
    FStyle: TStringList;

    FOnAfterRender: TNotifyEvent;
    FOnAfterAsyncChange: TNotifyEvent;

    procedure SetScript(const AValue: TStringList);
    procedure SetScriptParams(const AValue: TIWBSScriptParams);
    procedure OnScriptChange(ASender : TObject);
    function GetStyle: TStringList;
    procedure SetStyle(const AValue: TStringList);
    procedure OnStyleChange(ASender : TObject);
    function GetCustomAsyncEvents: TIWBSCustomAsyncEvents;
    procedure SetCustomAsyncEvents(const Value: TIWBSCustomAsyncEvents);
    function GetCustomRestEvents: TIWBSCustomRestEvents;
    procedure SetCustomRestEvents(const Value: TIWBSCustomRestEvents);
    function GetScript: TStringList;
    function GetScriptParams: TIWBSScriptParams;
    function GetScriptInsideTag: boolean;
    procedure SetScriptInsideTag(const Value: boolean);
    function GetAfterRender: TNotifyEvent;
    procedure SetAfterRender(const Value: TNotifyEvent);
    function GetExtraTagParams: TStringList;
    procedure SetExtraTagParams(const Value: TStringList);
    procedure OnExtraTagParamsChange(ASender : TObject);
  protected
    FOldCss: string;
    FOldDisabled: boolean;
    FOldReadOnly: boolean;
    FOldStyle: string;
    FOldVisible: boolean;

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
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); virtual;
    procedure InternalRenderCss(var ACss: string); virtual;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); virtual;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); virtual;
    procedure InternalRenderStyle(AStyle: TStringList); virtual;
    function InputSelector: string; virtual;
    function InputSuffix: string; virtual;
    function IsReadOnly: boolean; virtual;
    function IsDisabled: boolean; virtual;

    property ActiveCss: string read FOldCss;
    property ActiveStyle: string read FOldStyle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // Force a full refresh of the control during an Async call. @br
    // Usually there is no need to use this method, only if some property changed during async calls is not reflected.
    procedure AsyncRefreshControl;

    // Cancel AsyncRefreshControl
    // Usually there is no need to use this method. It is for internal use.
    procedure ResetAsyncRefreshControl;

    // Remove a control from html flow. You should execute this when destroying a control durinc async calls before Freeing @br
    // If you are destroying a region is enought to execute this in that region, you don't need to execute it in each child control.
    procedure AsyncRemoveControl;

    // Resturns True if CustomAsyncEvents are defined
    function IsStoredCustomAsyncEvents: Boolean;

    // Resturns True if CustomRestEvents are defined
    function IsStoredCustomRestEvents: Boolean;

    // returns a string representing the the JQSelector for this object.
    // @preformatted(IWBSCustomControl.JQSelector > '$(#"htmlname")')
    function JQSelector: string;

    // Set focus on component in an Ajax Callback
    procedure SetFocus;
  published
    // Mainteins a list of TIWBSCustomAsyncEvent. @br
    // CustomAsyncEvent let you bind delphi code execution to practically any jQuery event of the control. @br
    // This is usefull when you apply third party plugins to the control.
    property CustomAsyncEvents: TIWBSCustomAsyncEvents read GetCustomAsyncEvents write SetCustomAsyncEvents stored IsStoredCustomAsyncEvents;
    // Mainteins a list of TIWBSCustomRestEvent. @br
    // CustomRestEvent are for providing data to third party controls that request data via REST calls.
    property CustomRestEvents: TIWBSCustomRestEvents read GetCustomRestEvents write SetCustomRestEvents stored IsStoredCustomRestEvents;
    // Specifies whether the control responds to mouse, keyboard, and timer events.
    property Enabled;

    property ExtraTagParams: TStringList read GetExtraTagParams write SetExtraTagParams;

    property FriendlyName;
    // Specifies user javascript code that will be rendered and executed with this object. @br
    // You can define ScriptParams inside the script. ScriptParams are specified in scripts as: {%param%}. @br
    // With property ScriptInsideTag you can define if the script will be rendered inside or outside the script.
    property Script: TStringList read GetScript write SetScript;
    // Maintains a list of JS events you can directly write events in JS @br
    // at design time you can access to a limited set of events, but at runtime you can attach to any event of the control doing:
    // @preformatted(IWBSCustomControl.ScriptEvents.Values['object.custom.event'] := 'your javascript code...';
    // or if you want to define the function params:
    // @preformatted(IWBSCustomControl.ScriptEvents.Values['object.custom.event'] := 'function (param1, param2, param3) { your javascript code... }';
    property ScriptEvents;
    // Specifies if the script will be rendered inside the control tag or not. @br
    // If true the script will be rendered inside the tag. @br
    // If false a new div will be created to surround the control and the script will be rendered in this div, outside the control tag. @br
    // this is necessary script can't be placed inside the tag, for example in input controls.
    property ScriptInsideTag: boolean read GetScriptInsideTag write SetScriptInsideTag default True;
    // Params that will be replaced in scripts and in some controls content, for example in TIWBSText. @br
    // Params are specified in scripts as: {%param%}.
    property ScriptParams: TIWBSScriptParams read GetScriptParams write SetScriptParams;
    // List of inline styles in pairs name: value
    property Style: TStringList read GetStyle write SetStyle;
    // Corresponds to html tabindex attribute. It will be rendered if tabindex <> 0. Set to -1 to disable tabstop
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

    // Occurs after HTMLTag is created
    property OnHTMLtag;

    // Occurs after component is rendered.
    property OnAfterRender: TNotifyEvent read GetAfterRender write SetAfterRender;

    // Occurs after component is changed on an Asyn call, it doesn't occurs if the control is fully rendered
    property OnAfterAsyncChange: TNotifyEvent read FOnAfterAsyncChange write FOnAfterAsyncChange;
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

uses IWBaseHTMLInterfaces, IWBSScriptEvents, IWBSGlobal, IWBSUtils;

{$region 'TIWBSCustomControl'}
constructor TIWBSCustomControl.Create(AOwner: TComponent);
begin
  inherited;
  FAsyncRefreshControl := False;
  FRendered := False;
  FCustomAsyncEvents := nil;
  FCustomRestEvents := nil;
  FExtraTagParams := TStringList.Create;
  FExtraTagParams.OnChange := OnExtraTagParamsChange;
  FMainID := '';
  FTabIndex := 0;
  FScript := TStringList.Create;
  FScript.OnChange := OnScriptChange;
  FScriptInsideTag := True;
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
  FreeAndNil(FExtraTagParams);
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);
  inherited;
end;

function TIWBSCustomControl.JQSelector: string;
begin
  Result := '$("#'+HTMLName+'")';
end;

procedure TIWBSCustomControl.SetFocus;
begin
  IWBSExecuteAsyncJScript(JQSelector+'.focus()');
end;

procedure TIWBSCustomControl.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBSCustomControl.ResetAsyncRefreshControl;
begin
  FAsyncRefreshControl := False;
end;

procedure TIWBSCustomControl.AsyncRemoveControl;
begin
  TIWBSCommon.AsyncRemoveControl(HTMLName);
  FRendered := False;
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

function TIWBSCustomControl.GetAfterRender: TNotifyEvent;
begin
  Result := FOnAfterRender;
end;

function TIWBSCustomControl.GetCustomAsyncEvents: TIWBSCustomAsyncEvents;
begin
  if FCustomAsyncEvents = nil then
    FCustomAsyncEvents := TIWBSCustomAsyncEvents.Create(Self);
  Result := FCustomAsyncEvents;
end;

function TIWBSCustomControl.GetCustomRestEvents: TIWBSCustomRestEvents;
begin
  if FCustomRestEvents = nil then
    FCustomRestEvents := TIWBSCustomRestEvents.Create(Self);
  Result := FCustomRestEvents;
end;

function TIWBSCustomControl.GetExtraTagParams: TStringList;
begin
  Result := FExtraTagParams;
end;

procedure TIWBSCustomControl.SetAfterRender(const Value: TNotifyEvent);
begin
  FOnAfterRender := Value;
end;

procedure TIWBSCustomControl.SetCustomAsyncEvents(const Value: TIWBSCustomAsyncEvents);
begin
  FCustomAsyncEvents.Assign(Value);
end;

procedure TIWBSCustomControl.SetCustomRestEvents(const Value: TIWBSCustomRestEvents);
begin
  FCustomRestEvents.Assign(Value);
end;

procedure TIWBSCustomControl.SetExtraTagParams(const Value: TStringList);
begin
  FExtraTagParams.Assign(Value);
end;

function TIWBSCustomControl.IsStoredCustomAsyncEvents: boolean;
begin
  Result := (FCustomAsyncEvents <> nil) and (FCustomAsyncEvents.Count > 0);
end;

function TIWBSCustomControl.IsStoredCustomRestEvents: boolean;
begin
  Result := (FCustomRestEvents <> nil) and (FCustomRestEvents.Count > 0);
end;

procedure TIWBSCustomControl.OnExtraTagParamsChange(ASender: TObject);
begin
  AsyncRefreshControl;
end;

procedure TIWBSCustomControl.OnScriptChange( ASender : TObject );
begin
  AsyncRefreshControl;
end;

procedure TIWBSCustomControl.SetScript(const AValue: TStringList);
begin
  FScript.Assign(AValue);
end;

procedure TIWBSCustomControl.SetScriptInsideTag(const Value: boolean);
begin
  FScriptInsideTag := Value;
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

function TIWBSCustomControl.GetScriptInsideTag: boolean;
begin
  Result := FScriptInsideTag;
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

procedure TIWBSCustomControl.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
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
  xApplication: TIWApplication;
begin
  Result := nil;

  if FAsyncRefreshControl or not FRendered then
    begin
      xHTMLName := FMainID;
      TIWBSCommon.RenderAsync(xHTMLName, Self, AContext);
    end
  else
    begin
      xHTMLName := HTMLName;
      if InputSelector <> '' then
        xInputSelector := FMainID+InputSelector
      else
        xInputSelector := xHTMLName+InputSuffix;
      if AContext = nil then
        xApplication := GGetWebApplicationThreadVar
      else
        xApplication := AContext.WebApplication;
      TIWBSCommon.SetAsyncClass(xApplication, xHTMLName, RenderCSSClass(nil), FOldCss);
      TIWBSCommon.SetAsyncDisabled(xApplication, xInputSelector, IsDisabled, FOldDisabled);
      TIWBSCommon.SetAsyncReadOnly(xApplication, xInputSelector, IsReadOnly, FOldReadOnly);
      TIWBSCommon.SetAsyncStyle(xApplication, xHTMLName, RenderStyle(nil), FOldStyle);
      TIWBSCommon.SetAsyncVisible(xApplication, FMainID, Visible, FOldVisible);
      InternalRenderAsync(xHTMLName, xApplication);

      if Assigned(FOnAfterAsyncChange) then
        FOnAfterAsyncChange(Self);

      if Assigned(gIWBSOnAfterAsyncChange) then
        gIWBSOnAfterAsyncChange(Self, xHTMLName);
    end;
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
  FRendered := True;
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
