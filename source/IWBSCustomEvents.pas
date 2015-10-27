unit IWBSCustomEvents;

interface

uses System.Classes, System.StrUtils,
     IWApplication, IWBSRestServer;

type
  TIWBSCustomAjaxEvent = class (TCollectionItem)
  private
    FEventName: string;
    FAsyncEvent: TIWCallbackFunction;
  protected
    function GetDisplayName: string; override;
    procedure SetEventName(const AValue: string);
  published
    property EventName: string read FEventName write SetEventName;
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

function TIWBSCustomAjaxEvent.GetDisplayName: string;
begin
  Result := FEventName;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TIWBSCustomAjaxEvent.SetEventName(const AValue: string);
begin
  // here we need to check that is a valid event name
  FEventName := AValue;
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
  FRestEventPath := IWBSRegisterRestCallBack(AApplication, AComponentName+FEventName, FRestEvent);
end;

function TIWBSCustomRestEvent.ParseParamEvent(const AText: string): string;
begin
  Result := ReplaceStr(AText,'%'+FEventName+'%',FRestEventPath);
end;

end.
