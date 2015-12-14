unit IWBSUtils;

interface

uses System.Classes, System.SysUtils, System.StrUtils,
     IWApplication;

function IWBSGetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;

function IWBSTextToJsParamText(AText: string): string;

//procedure IWBSExecuteJScript(AWebApplication: TIWApplication; const AScript: string); overload;
//procedure IWBSExecuteJScript(const AScript: string); overload;

procedure IWBSExecuteAsyncJScript(AWebApplication: TIWApplication; const AScript: string; AsCDATA: boolean = False; AFirst: boolean = False); overload;
procedure IWBSExecuteAsyncJScript(const AScript: string; AsCDATA: boolean = False; AFirst: boolean = False); overload;

function IWBSexecuteAjaxEventJs(const HtmlName, EventName: string): string;

implementation

uses IWHTML40Interfaces, IWXMLTag, IWCallBack;

type
  TIWCallBackResponseHack = class(TIWCallBackResponse);

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
  Result := ReplaceStr(Result, #39, '\'#39);
  Result := ReplaceStr(Result, #10, '\n');
  Result := ReplaceStr(Result, #13, '');
end;
{
procedure IWBSExecuteJScript(AWebApplication: TIWApplication; const AScript: string); overload;
begin
  if Length(AScript) <= 0 then Exit;

  if AWebApplication.IsCallBack then
    AWebApplication.CallBackResponse.AddJavaScriptToExecute(AScript)
  else
    HTML40FormInterface(AWebApplication.ActiveForm).PageContext.AddToInitProc(AScript);
end;

procedure IWBSExecuteJScript(const AScript: string);
var
  LWebApplication: TIWApplication;
begin
  LWebApplication := GGetWebApplicationThreadVar;
  if LWebApplication = nil then
    raise Exception.Create('User session not found');
  IWBSExecuteJScript(LWebApplication, AScript);
end;
}
procedure IWBSExecuteAsyncJScript(AWebApplication: TIWApplication; const AScript: string; AsCDATA: boolean = False; AFirst: boolean = False); overload;
var
  LCallTag: TIWXMLTag;
begin
  if Length(AScript) <= 0 then Exit;

  if AWebApplication.IsCallBack then begin
    if AFirst then
      begin
        LCallTag := TIWXMLTag.CreateTag('literal');
        if AsCDATA then
          LCallTag.Contents.AddText('<![CDATA[' + AScript + ']]>')
        else
          LCallTag.Contents.AddText(AScript);
        TIWCallBackResponseHack(AWebApplication.CallBackResponse).FExecuteTag.Contents.Insert(0,LCallTag);
      end
    else if AsCDATA then
      AWebApplication.CallBackResponse.AddJavaScriptToExecuteAsCDATA(AScript)
    else
      AWebApplication.CallBackResponse.AddJavaScriptToExecute(AScript);
  end;
end;

procedure IWBSExecuteAsyncJScript(const AScript: string; AsCDATA: boolean = False; AFirst: boolean = False);
var
  LWebApplication: TIWApplication;
begin
  LWebApplication := GGetWebApplicationThreadVar;
  if LWebApplication = nil then
    raise Exception.Create('User session not found');
  IWBSExecuteAsyncJScript(LWebApplication, AScript, AsCDATA, AFirst);
end;

function IWBSexecuteAjaxEventJs(const HtmlName, EventName: string): string;
begin
  Result := format('executeAjaxEvent("",null,"%s",true,null,true)',[HTMLName+EventName]);
end;

end.
