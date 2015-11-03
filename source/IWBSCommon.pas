unit IWBSCommon;

interface

// if you have JsonDataObjects from https://github.com/ahausladen/JsonDataObjects
// include in your application: define JsonDataObjects
// don't enable here, we don't want to include in package

uses System.Classes, System.SysUtils, System.StrUtils, {$IFDEF IWBS_JSONDATAOBJECTS}JsonDataObjects, {$ENDIF}
     IWRenderContext, IWControl, IWHTML40Interfaces;

const
  EOL = #13#10;

type
  TIWBSTextAlignment = (bstaDefault, bstaLeft, bstaCenter, bstaRight, bstaJustify, bstaNowrap);
  TIWBSTextCase = (bstcDefault, bstcLowercase, bstcUppercase, bstcCapitalize);
  TIWBSSize = (bsszDefault, bsszLg, bsszMd, bsszSm, bsszXs);
  TIWBSRelativeSize = (bsrzDefault, bsrzLg, bsrzSm);
  TIWBSResizeDirection = (bsrdDefault, bsrdNone, bsrdBoth, bsrdVertical, bsrdHorizontal);

const
  aIWBSRelativeSize: array[bsrzDefault..bsrzSm] of string = ('', 'lg', 'sm');
  aIWBSSize: array[bsszDefault..bsszXs] of string = ('', 'lg', 'md', 'sm', 'xs');
  aIWBSTextAlignment: array[bstaDefault..bstaNowrap] of string = ('', 'text-left', 'text-center', 'text-right', 'text-justify', 'text-nowrap');
  aIWBSTextCase: array[bstcDefault..bstcCapitalize] of string = ('', 'text-lowercase', 'text-uppercase', 'text-capitalize');
  aIWBSResizeDirection: array[bsrdDefault..bsrdHorizontal] of string = ('', 'none', 'both', 'vertical', 'horizontal');

type

  TIWBSScriptParams = class(TStringList)
  {$IFDEF IWBS_JSONDATAOBJECTS}
  private
    function GetJson(const Name: string): TJsonObject;
    procedure SetJson(const Name: string; const Value: TJsonObject);
  public
    constructor Create;
    property Json[const Name: string]: TJsonObject read GetJson write SetJson;
  {$ENDIF}
  end;


  TIWBSGridOptions = class(TPersistent)
  private
    FGridXSOffset: integer;
    FGridXSSpan: integer;
    FGridSMOffset: integer;
    FGridSMSpan: integer;
    FGridMDOffset: integer;
    FGridMDSpan: integer;
    FGridLGOffset: integer;
    FGridLGSpan: integer;
  public
    constructor Create;
    function GetClassString: string;

    class function GetGridClassString(AGridXSOffset, AGridSMOffset, AGridMDOffset, AGridLGOffset, AGridXSSpan, AGridSMSpan, AGridMDSpan, AGridLGSpan: integer): string;
  published
    property GridXSOffset: integer read FGridXSOffset write FGridXSOffset default 0;
    property GridXSSpan: integer read FGridXSSpan write FGridXSSpan default 0;
    property GridSMOffset: integer read FGridSMOffset write FGridSMOffset default 0;
    property GridSMSpan: integer read FGridSMSpan write FGridSMSpan default 0;
    property GridMDOffset: integer read FGridMDOffset write FGridMDOffset default 0;
    property GridMDSpan: integer read FGridMDSpan write FGridMDSpan default 0;
    property GridLGOffset: integer read FGridLGOffset write FGridLGOffset default 0;
    property GridLGSpan: integer read FGridLGSpan write FGridLGSpan default 0;
  end;

  IIWBSComponent = interface(IIWHTML40Control)
    ['{12925CB3-58EC-4B56-B032-478892548906}']
    procedure AsyncRemoveControl;
    procedure AsyncRefreshControl;
    function InternalRenderScript: string;
    function HTMLControlImplementation: TIWHTMLControlImplementation;

    function ReadCustomAsyncEvents: TOwnedCollection;
    function ReadCustomRestEvents: TOwnedCollection;
    procedure SetCustomAsyncEvents(const Value: TOwnedCollection);
    procedure SetCustomRestEvents(const Value: TOwnedCollection);
    function IsStoredCustomAsyncEvents: Boolean;
    function IsStoredCustomRestEvents: Boolean;

    function GetStyle: TStringList;
    procedure SetStyle(const AValue: TStringList);
    function get_Visible: Boolean;
    procedure set_Visible(Value: Boolean);

    property CustomAsyncEvents: TOwnedCollection read ReadCustomAsyncEvents write SetCustomAsyncEvents;
    property CustomRestEvents: TOwnedCollection read ReadCustomRestEvents write SetCustomRestEvents;
    property Style: TStringList read GetStyle write SetStyle;
    property Visible: boolean read get_Visible write set_Visible;
  end;

  TIWBSCommon = class
  public
    class procedure AddCssClass(var ACss: string; const AClass: string);
    class procedure AsyncRemoveControl(const AHTMLName: string);
    class function RenderStyle(AComponent: IIWBSComponent): string;
    class function ReplaceParams(const AHTMLName, AScript: string; AParams: TStrings): string;
    class procedure SetNotVisible(AParams: TStrings);
    class procedure ValidateParamName(const AName: string);
    class procedure ValidateTagName(const AName: string);
  end;

procedure SetAsyncDisabled(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
procedure SetAsyncReadOnly(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
procedure SetAsyncVisible(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
procedure SetAsyncClass(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
procedure SetAsyncStyle(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
procedure SetAsyncChecked(AContext: TIWCompContext; const HTMLName: string; const Value: boolean; var OldValue: boolean);
procedure SetAsyncText(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
procedure SetAsyncHtml(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);

implementation

uses IW.Common.System, IWBaseHTMLControl, IWBSUtils;

{$region 'TIWBSGridOptions'}
constructor TIWBSGridOptions.Create;
begin
  FGridXSOffset := 0;
  FGridXSSpan   := 0;
  FGridSMOffset := 0;
  FGridSMSpan   := 0;
  FGridMDOffset := 0;
  FGridMDSpan   := 0;
  FGridLGOffset := 0;
  FGridLGSpan   := 0;
end;

class function TIWBSGridOptions.GetGridClassString(AGridXSOffset, AGridSMOffset, AGridMDOffset, AGridLGOffset, AGridXSSpan, AGridSMSpan, AGridMDSpan, AGridLGSpan: integer): string;
  procedure AddCssValue(var s: string; const Value: string);
  begin
    if s <> '' then
      s := s + ' ';
    s := s + Value;
  end;
begin
  Result := '';
  if AGridXSOffset > 0 then
    AddCssValue(Result, 'col-xs-offset-'+IntToStr(AGridXSOffset));
  if AGridSMOffset > 0 then
    AddCssValue(Result, 'col-sm-offset-'+IntToStr(AGridSMOffset));
  if AGridMDOffset > 0 then
    AddCssValue(Result, 'col-md-offset-'+IntToStr(AGridMDOffset));
  if AGridLGOffset > 0 then
    AddCssValue(Result, 'col-lg-offset-'+IntToStr(AGridLGOffset));

  if (AGridXSSpan > 0) then
    AddCssValue(Result, 'col-xs-'+IntToStr(AGridXSSpan));
  if (AGridSMSpan > 0) then
    AddCssValue(Result, 'col-sm-'+IntToStr(AGridSMSpan));
  if (AGridMDSpan > 0) then
    AddCssValue(Result, 'col-md-'+IntToStr(AGridMDSpan));
  if (AGridLGSpan > 0) then
    AddCssValue(Result, 'col-lg-'+IntToStr(AGridLGSpan));
end;

function TIWBSGridOptions.GetClassString: string;
begin
  Result := GetGridClassString(FGridXSOffset, FGridSMOffset, FGridMDOffset, FGridLGOffset, FGridXSSpan, FGridSMSpan, FGridMDSpan, FGridLGSpan);
end;
{$endregion}

{$region 'AsyncRender functions'}
procedure SetAsyncDisabled(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").prop("disabled",'+iif(Value,'true','false')+');');
    OldValue := Value;
  end;
end;

procedure SetAsyncReadOnly(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").prop("readonly",'+iif(Value,'true','false')+');');
    OldValue := Value;
  end;
end;

procedure SetAsyncVisible(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").css("visibility","'+iif(Value,'','hidden')+'");');
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").css("display","'+iif(Value,'','none')+'");');
    OldValue := Value;
  end;
end;

procedure SetAsyncText(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").val("'+TIWBaseHTMLControl.TextToJSStringLiteral(Value)+'");');
    OldValue := Value;
  end;
end;

procedure SetAsyncHtml(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecuteAsCDATA('$("#'+HTMLName+'").html("'+IWBSTextToJsParamText(Value)+'");');
    OldValue := Value;
  end;
end;

procedure SetAsyncClass(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").toggleClass("'+Value+'");');
    OldValue := Value;
  end;
end;

procedure SetAsyncStyle(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").prop("style","'+Value+'");');
    OldValue := Value;
  end;
end;

procedure SetAsyncChecked(AContext: TIWCompContext; const HTMLName: string; const Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").prop("checked",'+iif(Value,'true','false')+');');
    OldValue := Value;
  end;
end;
{$endregion}

{$region 'TIWBSCommon'}
class procedure TIWBSCommon.AddCssClass(var ACss: string; const AClass: string);
begin
  if ACss <> '' then
    ACss := ACss+' ';
  ACss := ACss+AClass;
end;

class procedure TIWBSCommon.AsyncRemoveControl(const AHTMLName: string);
begin
  IWBSExecuteAsyncJScript('AsyncDestroyControl("'+AHTMLName+'");');
end;

class function TIWBSCommon.RenderStyle(AComponent: IIWBSComponent): string;
var
  xStyle: TStringList;
  i: integer;
begin
  Result := '';

  xStyle := TStringList.Create;
  try
    xStyle.Assign(AComponent.Style);

    // here render z-index
    if AComponent.ZIndex <> 0 then
      xStyle.Values['z-index'] := IntToStr(AComponent.Zindex);

    for i := 0 to xStyle.Count-1 do begin
      if Result <> '' then
        Result := Result + ';';
      Result := Result + xStyle[i];
    end;
  finally
    xStyle.Free;
  end;
end;

class function TIWBSCommon.ReplaceParams(const AHTMLName, AScript: string; AParams: TStrings): string;
var
  i: integer;
begin
  Result := ReplaceText(AScript,'%HTMLNAME%',AHTMLName);
  for i := 0 to AParams.Count-1 do
  {$IFDEF IWBS_JSONDATAOBJECTS}
    if AParams.Objects[i] is TJsonObject then
      Result := ReplaceText(Result,'%'+AParams[i]+'%',TJsonObject(AParams.Objects[i]).ToJSON)
    else
  {$ENDIF}
      Result := ReplaceText(Result,'%'+AParams.Names[i]+'%',AParams.ValueFromIndex[i]);
end;

class procedure TIWBSCommon.ValidateParamName(const AName: string);
var
  i: integer;
begin
  for i := 1 to Length(AName) do
    if not CharInSet(AName[i], ['.','0'..'9','A'..'Z','a'..'z']) then
      raise Exception.Create('Invalid character in param name '+AName);
end;

class procedure TIWBSCommon.ValidateTagName(const AName: string);
var
  i: integer;
begin
  if AName = '' then
    Exception.Create('Tag name could not be empty');
  for i := 1 to Length(AName) do
    if ((i = 1) and not CharInSet(AName[i], ['A'..'Z','a'..'z'])) or
       ((i > 1) and not CharInSet(AName[i], ['0'..'9','A'..'Z','a'..'z'])) then
      raise Exception.Create('Invalid character in tag name '+AName);
end;

class procedure TIWBSCommon.SetNotVisible(AParams: TStrings);
var
  LStyle: string;
begin
  LStyle := AParams.Values['style'];
  LStyle := Trim(LStyle);
  if (LStyle <> '') and not AnsiEndsStr(';', LStyle) then
    LStyle := LStyle+';';
  if not AnsiContainsStr(LStyle, 'visibility:') then
    LStyle := LStyle +  'visibility: hidden;';
  if not AnsiContainsStr(LStyle, 'display:') then
    LStyle := LStyle +  'display: none;';
  AParams.Values['style'] := LStyle;
end;
{$endregion}

{$region 'TIWBSScriptParams'}
{$IFDEF IWBS_JSONDATAOBJECTS}
constructor TIWBSScriptParams.Create;
begin
  inherited;
  Duplicates := dupError;
  OwnsObjects := True;
  Sorted := True;
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
{$ENDIF}
{$endregion}

end.
