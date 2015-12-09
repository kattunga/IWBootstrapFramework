unit IWBSUtils;

interface

uses System.Classes, System.SysUtils, System.StrUtils,
     IWApplication;

function IWBSGetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;

function IWBSTextToJsParamText(AText: string): string;

procedure IWBSExecuteJScript(const AScript: string);
procedure IWBSExecuteAsyncJScript(const AScript: string);

function IWBSexecuteAjaxEventJs(const HtmlName, EventName: string): string;

implementation

uses IWHTML40Interfaces;

function IWBSGetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;
var
  i: Integer;
begin
  if AOwner = nil then
    Exit;

  Result:= APrefix;
  i:= 0;
  while Assigned(AOwner.FindComponent(Result)) do begin
    inc(i);
    Result:= APrefix + IntToStr(i);
  end;
end;

function IWBSTextToJsParamText(AText: string): string;
begin
  Result := ReplaceStr(AText, '"', '\"');
  Result := ReplaceStr(Result, #10, '\n');
  Result := ReplaceStr(Result, #13, '');
end;

procedure IWBSExecuteJScript(const AScript: string);
var
  LWebApplication: TIWApplication;
begin
  if Length(AScript) <= 0 then Exit;

  LWebApplication := GGetWebApplicationThreadVar;
  if LWebApplication = nil then
    raise Exception.Create('User session not found');

  if LWebApplication.IsCallBack then
    LWebApplication.CallBackResponse.AddJavaScriptToExecute(AScript)
  else
    HTML40FormInterface(LWebApplication.ActiveForm).PageContext.AddToInitProc(AScript);
end;

procedure IWBSExecuteAsyncJScript(const AScript: string);
var
  LWebApplication: TIWApplication;
begin
  if Length(AScript) <= 0 then Exit;

  LWebApplication := GGetWebApplicationThreadVar;
  if LWebApplication = nil then
    raise Exception.Create('User session not found');

  if LWebApplication.IsCallBack then
    LWebApplication.CallBackResponse.AddJavaScriptToExecute(AScript);
end;

function IWBSexecuteAjaxEventJs(const HtmlName, EventName: string): string;
begin
  Result := format('executeAjaxEvent("",null,"%s",true,null,true)',[HTMLName+EventName]);
end;

end.
