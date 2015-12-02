unit IWBSCustomEvents;

interface

uses System.Classes, System.StrUtils,
     IWApplication, IWControl, IWBSRestServer;

type
  TIWBSCustomAsyncEvent = class (TCollectionItem)
  private
    FEventName: string;
    FAsyncEvent: TIWAsyncEvent;
    FParams: TStringList;
    FAutoBind: boolean;
    procedure SetParams(const Value: TStringList);
    procedure ExecuteCallBack(aParams: TStringList);
  protected
    function GetDisplayName: string; override;
    procedure SetEventName(const AValue: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetScript: string;
    procedure RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
    procedure ParseParam(AScript: TStringList);
  published
    property AutoBind: boolean read FAutoBind write FAutoBind default False;
    property EventName: string read FEventName write SetEventName;
    property Params: TStringList read FParams write SetParams;
    property OnAsyncEvent: TIWAsyncEvent read FAsyncEvent write FAsyncEvent;
  end;

  TIWBSCustomAsyncEvents = class (TOwnedCollection)
  private
    function GetItems(I: Integer): TIWBSCustomAsyncEvent;
    procedure SetItems(I: Integer; const Value: TIWBSCustomAsyncEvent);
  public
    constructor Create(AOwner: TPersistent);
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
  FEventName := '';
  FParams := TStringList.Create;
end;

destructor TIWBSCustomAsyncEvent.Destroy;
begin
  FParams.Free;
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

procedure TIWBSCustomAsyncEvent.SetParams(const Value: TStringList);
begin
  FParams.Assign(Value);
end;

procedure TIWBSCustomAsyncEvent.Assign(Source: TPersistent);
begin
  if Source is TIWBSCustomAsyncEvent then
    begin
      EventName := TIWBSCustomAsyncEvent(Source).EventName;
      Params := TIWBSCustomAsyncEvent(Source).Params;
      OnAsyncEvent := TIWBSCustomAsyncEvent(Source).OnAsyncEvent;
    end
  else
    inherited;
end;

function TIWBSCustomAsyncEvent.GetScript: string;
var
  LParams, LName: string;
  i: integer;
begin
  LParams := '';
  for i := 0 to FParams.Count-1 do begin
    LName := FParams.Names[i];
    TIWBSCommon.ValidateParamName(LName);
    if i > 0 then
      LParams := LParams+'+';
    LParams := LParams+'"&'+LName+'="+'+FParams.ValueFromIndex[i];
  end;
  if LParams = '' then
    LParams := '""';
  Result := 'executeAjaxEvent('+LParams+', null, "'+TIWBSCustomControl(Collection.Owner).HTMLName+'.'+FEventName+'", true, null, true);';
end;

procedure TIWBSCustomAsyncEvent.ExecuteCallBack(aParams: TStringList);
begin
  if Assigned(FAsyncEvent) then
    FAsyncEvent(Collection.Owner, aParams);
end;

procedure TIWBSCustomAsyncEvent.RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
begin
  AApplication.RegisterCallBack(AComponentName+'.'+FEventName, ExecuteCallBack);
end;

procedure TIWBSCustomAsyncEvent.ParseParam(AScript: TStringList);
begin
  if AScript.Count > 0 then
    AScript.Text := ReplaceStr(AScript.Text,'%'+FEventName+'%',GetScript);
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
    AScript.Text := ReplaceStr(AScript.Text,'%'+FEventName+'%',FRestEventPath);
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
