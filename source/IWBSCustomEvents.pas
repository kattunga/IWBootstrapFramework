unit IWBSCustomEvents;

interface

uses Classes, SysUtils, StrUtils,
     IWApplication, IWControl, IWBSRestServer;

type
  TIWBSCustomAsyncEvent = class (TCollectionItem)
  private
    FApplication: TIWApplication;
    FCallbackName: string;
    FEventName: string;
    FAsyncEvent: TIWAsyncEvent;
    FCallBackParams: TStringList;
    FAutoBind: boolean;
    FEventParams: string;
    FLock: boolean;
    procedure SetCallBackParams(const Value: TStringList);
    procedure ExecuteCallBack(aParams: TStringList);
    function IsEventParamsStored: Boolean;
  protected
    function GetDisplayName: string; override;
    procedure SetEventName(const AValue: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    // Return the javascript code necessary to execute the callback
    function GetScript(const AHTMLName: string; ASemiColon: boolean = True): string;
    // Register the callback in the server. Is for internal use, don't use it.
    procedure RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
    // Search in a script and replace params with same name as EventName with the js code necessary to execute the callback.
    procedure ParseParam(const AHTMLName: string; AScript: TStringList);
  published
    // Specifies if the delphi event will be automatically binded to the jQuery control with the EventName specified.
    // If true, the event will be automatically attached to the rendered object. @br
    // If false, you need to manually bind the event. @br
    // To manually bind an event in delphi code you could do:
    // @preformatted(IWBSExecuteJScript(MyObject.JQSelector+'.on("api.event.name", function(event, param1, param2) {'+MyObject.CustomAsyncEvents[0].GetScript+'})');)
    // or you can add in the script property:
    // @preformatted($("#{%htmlname%}").on("api.event.name", function(event, param1, param2) { {%eventname%} });)
    property AutoBind: boolean read FAutoBind write FAutoBind default False;
    // Mainteins a list of pairs names=values to translate the EventParams to the params pased to the OnAsyncEvent
    property CallBackParams: TStringList read FCallBackParams write SetCallBackParams;
    // Specifies the event name, if AutoBind = True, the EventName should be exactly the name of the jQuery event,
    // if AutoBind = False you can set any name here and use the correct one when you manually register it. @br
    property EventName: string read FEventName write SetEventName;
    // Specifies a list of comma separated names of params that the event will pass to the callback function. @br
    // This params names are defined in the api of the object you are using.
    property EventParams: string read FEventParams write FEventParams stored IsEventParamsStored;
    // lock screen during async event
    property Lock: boolean read FLock write FLock default false;
    // Occurs when the defined JQ event is triggered
    property OnAsyncEvent: TIWAsyncEvent read FAsyncEvent write FAsyncEvent;
  end;

  TIWBSCustomAsyncEvents = class (TOwnedCollection)
  private
    function GetItems(I: Integer): TIWBSCustomAsyncEvent;
    procedure SetItems(I: Integer; const Value: TIWBSCustomAsyncEvent);
  public
    constructor Create(AOwner: TPersistent);
    function ByName(const AEventName: string): TIWBSCustomAsyncEvent;
    property Items[I: Integer]: TIWBSCustomAsyncEvent read GetItems write SetItems; default;
  end;

  TIWBSCustomRestEvent = class (TCollectionItem)
  private
    FParseFileUpload: boolean;
    FEventName: string;
    FRestEvent: TIWBSRestCallBackFunction;
    FRestEventPath: string;
  protected
    function GetDisplayName: string; override;
    procedure SetEventName(const AValue: string);
  public
    procedure Assign(Source: TPersistent); override;
    procedure RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
    procedure ParseParam(AScript: TStringList);
  published
    property EventName: string read FEventName write SetEventName;
    property OnRestEvent: TIWBSRestCallBackFunction read FRestEvent write FRestEvent;
    property ParseFileUpload: boolean read FParseFileUpload write FParseFileUpload default False;
  end;

  TIWBSCustomRestEvents = class (TOwnedCollection)
  private
    function GetItems(I: Integer): TIWBSCustomRestEvent;
    procedure SetItems(I: Integer; const Value: TIWBSCustomRestEvent);
  public
    constructor Create(AOwner: TPersistent);
    property Items[I: Integer]: TIWBSCustomRestEvent read GetItems write SetItems; default;
  end;

implementation

uses IWBSCommon, IWBSCustomControl;

{$region 'TIWBSCustomAsyncEvent'}
constructor TIWBSCustomAsyncEvent.Create(Collection: TCollection);
begin
  inherited;
  FAutoBind := False;
  FCallBackParams := TStringList.Create;
  FEventName := '';
  FEventParams := 'event';
  FAsyncEvent := nil;
end;

destructor TIWBSCustomAsyncEvent.Destroy;
begin
  if FApplication <> nil then
    FApplication.UnregisterCallBack(FCallbackName);
  FCallBackParams.Free;
  inherited;
end;

function TIWBSCustomAsyncEvent.GetDisplayName: string;
begin
  Result := FEventName;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TIWBSCustomAsyncEvent.SetEventName(const AValue: string);
begin
  TIWBSCommon.ValidateParamName(AValue);
  FEventName := AValue;
end;

procedure TIWBSCustomAsyncEvent.SetCallBackParams(const Value: TStringList);
begin
  FCallBackParams.Assign(Value);
end;

procedure TIWBSCustomAsyncEvent.Assign(Source: TPersistent);
begin
  if Source is TIWBSCustomAsyncEvent then
    begin
      AutoBind := TIWBSCustomAsyncEvent(Source).AutoBind;
      CallBackParams.Assign(TIWBSCustomAsyncEvent(Source).CallBackParams);
      EventName := TIWBSCustomAsyncEvent(Source).EventName;
      EventParams := TIWBSCustomAsyncEvent(Source).EventParams;
      Lock := TIWBSCustomAsyncEvent(Source).Lock;
      OnAsyncEvent := TIWBSCustomAsyncEvent(Source).OnAsyncEvent;
    end
  else
    inherited;
end;

function TIWBSCustomAsyncEvent.GetScript(const AHTMLName: string; ASemiColon: boolean = True): string;
var
  LParams, LName: string;
  i: integer;
begin
  LParams := '';
  for i := 0 to FCallBackParams.Count-1 do begin
    LName := FCallBackParams.Names[i];
    TIWBSCommon.ValidateParamName(LName);
    if i > 0 then
      LParams := LParams+'+';
    LParams := LParams+'"&'+LName+'="+'+FCallBackParams.ValueFromIndex[i];
  end;
  if LParams = '' then
    LParams := '""';
  Result := 'ajaxCall("'+AHTMLName+'.'+EventName+'",'+LParams+', '+IfThen(FLock,'true','false')+')';
  if ASemiColon then
    Result := Result + ';';
end;

function TIWBSCustomAsyncEvent.IsEventParamsStored: Boolean;
begin
  Result := FEventParams <> 'event';
end;

procedure TIWBSCustomAsyncEvent.ExecuteCallBack(aParams: TStringList);
begin
  if Assigned(FAsyncEvent) and Assigned(Collection) then
    FAsyncEvent(Collection.Owner, aParams);
end;

procedure TIWBSCustomAsyncEvent.RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
begin
  FApplication := AApplication;
  FCallbackName := AComponentName+'.'+FEventName;
  AApplication.RegisterCallBack(FCallbackName, ExecuteCallBack);
end;

procedure TIWBSCustomAsyncEvent.ParseParam(const AHTMLName: string; AScript: TStringList);
begin
  if AScript.Count > 0 then
    AScript.Text := ReplaceStr(AScript.Text,'{%'+FEventName+'%}',GetScript(AHTMLName));
end;
{$endregion}

{$region 'TIWBSCustomAsyncEvents'}
constructor TIWBSCustomAsyncEvents.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIWBSCustomAsyncEvent);
end;

function TIWBSCustomAsyncEvents.GetItems(I: Integer): TIWBSCustomAsyncEvent;
begin
  Result := TIWBSCustomAsyncEvent(inherited Items[I]);
end;

procedure TIWBSCustomAsyncEvents.SetItems(I: Integer; const Value: TIWBSCustomAsyncEvent);
begin
  inherited SetItem(I, Value);
end;

function TIWBSCustomAsyncEvents.ByName(const AEventName: string): TIWBSCustomAsyncEvent;
var
  i: integer;
begin
  Result := nil;

  for i := 0 to Count-1 do
    if Items[i].FEventName = AEventName then begin
      Result := Items[i];
      Break;
    end;

  if Result = nil then begin
    Result := TIWBSCustomAsyncEvent(Add);
    Result.FEventName := AEventName;
  end;
end;
{$endregion}

{$region 'TIWBSCustomRestEvent'}
function TIWBSCustomRestEvent.GetDisplayName: string;
begin
  Result := FEventName;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TIWBSCustomRestEvent.SetEventName(const AValue: string);
begin
  TIWBSCommon.ValidateParamName(AValue);
  FEventName := AValue;
end;

procedure TIWBSCustomRestEvent.Assign(Source: TPersistent);
begin
  if Source is TIWBSCustomRestEvent then
    begin
      EventName := TIWBSCustomRestEvent(Source).EventName;
      ParseFileUpload := TIWBSCustomRestEvent(Source).ParseFileUpload;
      OnRestEvent := TIWBSCustomRestEvent(Source).OnRestEvent;
    end
  else
    inherited;
end;

procedure TIWBSCustomRestEvent.RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
begin
  FRestEventPath := IWBSRegisterRestCallBack(AApplication, AComponentName+'.'+FEventName, FRestEvent, FParseFileUpload);
end;

procedure TIWBSCustomRestEvent.ParseParam(AScript: TStringList);
begin
  if AScript.Count > 0 then
    AScript.Text := ReplaceStr(AScript.Text,'{%'+FEventName+'%}',FRestEventPath);
end;
{$endregion}

{$region 'TIWBSCustomRestEvents'}
constructor TIWBSCustomRestEvents.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIWBSCustomRestEvent);
end;

function TIWBSCustomRestEvents.GetItems(I: Integer): TIWBSCustomRestEvent;
begin
  Result := TIWBSCustomRestEvent(inherited Items[I]);
end;

procedure TIWBSCustomRestEvents.SetItems(I: Integer;
  const Value: TIWBSCustomRestEvent);
begin
  inherited SetItem(I, Value);
end;
{$endregion}

end.
