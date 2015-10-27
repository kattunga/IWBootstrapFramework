unit IWBSCustomEvents;

interface

uses System.Classes, System.StrUtils,
     IWApplication, IWBSRestServer;

type
  TIWBSCustomAsyncEvent = class (TCollectionItem)
  private
    FEventName: string;
    FAsyncEvent: TIWCallbackFunction;
    FAsyncEventFunc: string;
    FParams: string;
  protected
    function GetDisplayName: string; override;
    procedure SetEventName(const AValue: string);
  public
    procedure RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
    function ParseParamEvent(const AText: string): string;
  published
    property EventName: string read FEventName write SetEventName;
    property Params: string read FParams write FParams;
    property OnAsyncEvent: TIWCallbackFunction read FAsyncEvent write FAsyncEvent;
  end;

  TIWBSCustomRestEvent = class (TCollectionItem)
  private
    FEventName: string;
    FRestEvent: TIWBSRestCallBackFunction;
    FRestEventPath: string;
  protected
    function GetDisplayName: string; override;
    procedure SetEventName(const AValue: string);
  public
    procedure RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
    function ParseParamEvent(const AText: string): string;
  published
    property EventName: string read FEventName write SetEventName;
    property OnRestEvent: TIWBSRestCallBackFunction read FRestEvent write FRestEvent;
  end;

implementation

function TIWBSCustomAsyncEvent.GetDisplayName: string;
begin
  Result := FEventName;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TIWBSCustomAsyncEvent.SetEventName(const AValue: string);
begin
  // here we need to check that is a valid event name
  FEventName := AValue;
end;

procedure TIWBSCustomAsyncEvent.RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
begin
  AApplication.RegisterCallBack(AComponentName+'.'+FEventName, FAsyncEvent);
  FAsyncEventFunc := 'executeAjaxEvent("'+FParams+'", null, "'+AComponentName+'.'+FEventName+'", true, null, true);';
end;

function TIWBSCustomAsyncEvent.ParseParamEvent(const AText: string): string;
begin
  Result := ReplaceStr(AText,'%'+FEventName+'%',FAsyncEventFunc);
end;

function TIWBSCustomRestEvent.GetDisplayName: string;
begin
  Result := FEventName;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TIWBSCustomRestEvent.SetEventName(const AValue: string);
begin
  // here we need to check that is a valid event name
  FEventName := AValue;
end;

procedure TIWBSCustomRestEvent.RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
begin
  FRestEventPath := IWBSRegisterRestCallBack(AApplication, AComponentName+'.'+FEventName, FRestEvent);
end;

function TIWBSCustomRestEvent.ParseParamEvent(const AText: string): string;
begin
  Result := ReplaceStr(AText,'%'+FEventName+'%',FRestEventPath);
end;

end.
