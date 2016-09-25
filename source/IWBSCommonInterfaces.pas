unit IWBSCommonInterfaces;

interface

uses
  Classes, SysUtils, StrUtils,
  IWApplication, IWRenderContext, IWControl, IWHTML40Interfaces, IWTypes,
  IWBaseInterfaces, IWHTMLTag, IWBaseRenderContext,
  IWBSJsonDataObjects, IWBSCustomEvents;

type
  TIWBSScriptParams = class(TStringList)
  private
    function GetJson(const Name: string): TJsonObject;
    procedure SetJson(const Name: string; const Value: TJsonObject);
  public
    constructor Create;
    property Json[const Name: string]: TJsonObject read GetJson write SetJson;
  end;

  IIWBSComponent = interface(IIWHTML40Control)
    ['{12925CB3-58EC-4B56-B032-478892548906}']
    procedure AsyncRemoveControl;
    procedure AsyncRefreshControl;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
    procedure InternalRenderStyle(AStyle: TStringList);
    function HTMLControlImplementation: TIWHTMLControlImplementation;
    function JQSelector: string;
    function ParentContainer: IIWBaseContainer;
    procedure ResetAsyncRefreshControl;
    procedure SetFocus;

    function GetCustomAsyncEvents: TIWBSCustomAsyncEvents;
    procedure SetCustomAsyncEvents(const Value: TIWBSCustomAsyncEvents);
    function IsStoredCustomAsyncEvents: Boolean;
    function GetCustomRestEvents: TIWBSCustomRestEvents;
    procedure SetCustomRestEvents(const Value: TIWBSCustomRestEvents);
    function IsStoredCustomRestEvents: Boolean;

    function GetAfterRender: TNotifyEvent;
    procedure SetAfterRender(const Value: TNotifyEvent);

    function GetScript: TStringList;
    procedure SetScript(const AValue: TStringList);
    function GetScriptInsideTag: boolean;
    procedure SetScriptInsideTag(const AValue: boolean);
    function GetScriptParams: TIWBSScriptParams;
    procedure SetScriptParams(const AValue: TIWBSScriptParams);
    function GetStyle: TStringList;
    procedure SetStyle(const AValue: TStringList);
    function get_Visible: Boolean;
    procedure set_Visible(Value: Boolean);

    property Cursor: TIWCursor read get_WebCursor write set_WebCursor;
    property CustomAsyncEvents: TIWBSCustomAsyncEvents read GetCustomAsyncEvents write SetCustomAsyncEvents;
    property CustomRestEvents: TIWBSCustomRestEvents read GetCustomRestEvents write SetCustomRestEvents;
    property Script: TStringList read GetScript write SetScript;
    property ScriptInsideTag: boolean read GetScriptInsideTag write SetScriptInsideTag;
    property ScriptParams: TIWBSScriptParams read GetScriptParams write SetScriptParams;
    property Style: TStringList read GetStyle write SetStyle;
    property Visible: boolean read get_Visible write set_Visible;

    property OnAfterRender: TNotifyEvent read GetAfterRender write SetAfterRender;
  end;

  IIWBSContainer = interface(IIWBaseContainer)
    ['{819FB21E-8204-450F-8778-3DEB56FDB062}']
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
    function ParentContainer: IIWBaseContainer;
    function RegionDiv: TIWHTMLTag;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag;

    function get_ContainerContext: TIWContainerContext;
    procedure set_ContainerContext(const AContainerContext: TIWContainerContext);
    function get_HTMLName: String;

    property ContainerContext: TIWContainerContext read get_ContainerContext write set_ContainerContext;
    property HTMLName: string read get_HTMLName;
  end;

implementation

{$region 'TIWBSScriptParams'}
constructor TIWBSScriptParams.Create;
begin
  inherited;
  Duplicates := dupError;
  OwnsObjects := True;
end;

function TIWBSScriptParams.GetJson(const Name: string): TJsonObject;
var
  i: integer;
begin
  i := IndexOf(Name);
  if i < 0 then
    begin
      Result := TJsonObject.Create;
      AddObject(Name, Result);
    end
  else if Objects[i] = nil then
    begin
      Result := TJsonObject.Create;
      Objects[i] := Result;
    end
  else
    Result := TJsonObject(Objects[i]);
end;

procedure TIWBSScriptParams.SetJson(const Name: string; const Value: TJsonObject);
begin
  Json[Name].Assign(Value);
end;
{$endregion}

end.
