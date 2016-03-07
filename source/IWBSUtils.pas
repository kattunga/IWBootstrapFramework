unit IWBSUtils;

interface

uses Classes, SysUtils, StrUtils,
     IWApplication;

function IWBSGetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;

function IWBSTextToJsParamText(AText: string): string;

//procedure IWBSExecuteJScript(AWebApplication: TIWApplication; const AScript: string); overload;
//procedure IWBSExecuteJScript(const AScript: string); overload;

procedure IWBSExecuteAsyncJScript(AWebApplication: TIWApplication; const AScript: string; AsCDATA: boolean = False; AFirst: boolean = False); overload;
procedure IWBSExecuteAsyncJScript(const AScript: string; AsCDATA: boolean = False; AFirst: boolean = False); overload;

function IWBSExecuteAjaxEventJs(const HtmlName, EventName: string; const Params: string = ''; ALock: boolean = False): string;

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

type
  TPrevIWXMLTag = class(TIWXMLTag);

procedure IWBSExecuteAsyncJScript(AWebApplication: TIWApplication; const AScript: string; AsCDATA: boolean = False; AFirst: boolean = False); overload;
var
  LCallTag: TPrevIWXMLTag;
  i, j: integer;
begin
  if Length(AScript) <= 0 then Exit;

  if AWebApplication.IsCallBack then begin
    if AFirst then
      begin
        LCallTag := TPrevIWXMLTag.CreateTag('literal');
        if AsCDATA then
          LCallTag.Contents.AddText('<![CDATA[' + AScript + ']]>')
        else
          LCallTag.Contents.AddText(AScript);
        with TIWCallBackResponseHack(AWebApplication.CallBackResponse).FExecuteTag do begin
          j := 0;
          for i := 0 to Contents.Count-1 do
            if Contents.Items[i] is TPrevIWXMLTag then
              Inc(j)
            else
              break;
          Contents.Insert(j,LCallTag);
        end;
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

function IWBSexecuteAjaxEventJs(const HtmlName, EventName: string; const Params: string = ''; ALock: boolean = False): string;
begin
  if ALock then
    Result := format('ajaxCall("%s","%s", true)',[HTMLName+EventName, Params])
  else
    Result := format('ajaxCall("%s","%s")',[HTMLName+EventName, Params]);
end;

end.
