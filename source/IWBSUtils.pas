unit IWBSUtils;

interface

uses System.Classes, System.SysUtils, System.StrUtils, Windows,
     IWAppForm, IWtypes, IWBSCommon, IWHTMLTag, IWApplication;

procedure IWBSDisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);

function  IWBSGetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;

function  IWBSCreateInputGroupAddOn(ATag: TIWHTMLTag; const css: string): TIWHTMLTag;

procedure IWBSUnregisterCallbacks(const AControlName: string; WebApplication: IWApplication.TIWApplication);

procedure ExecuteJScript(const Script: string);

implementation

uses IWHTML40Interfaces;

procedure IWBSDisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);
begin
  StyleRenderOptions.RenderAbsolute := False;
  StyleRenderOptions.RenderBorder := False;
  StyleRenderOptions.RenderFont := False;
  StyleRenderOptions.RenderPadding := False;
  StyleRenderOptions.RenderPosition := False;
  StyleRenderOptions.RenderSize := False;
  StyleRenderOptions.RenderZIndex := False;
end;

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

function IWBSCreateInputGroupAddOn(ATag: TIWHTMLTag; const css: string): TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('span');
  try
    Result.AddClassParam('input-group-'+css);
    Result.Contents.AddTagAsObject(ATag);
  except
    FreeAndNil(Result);
    FreeAndNil(ATag);
    raise;
  end;
end;

type
  TIWApplication = class(IWApplication.TIWApplication);
  TIWCallBacks = class(IWApplication.TIWCallBacks);

procedure IWBSUnregisterCallbacks(const AControlName: string; WebApplication: IWApplication.TIWApplication);
var
  CallBacks: TIWCallBacks;
  idx: Integer;
  xQualifiedName: string;
begin
  if (WebApplication = nil) or not WebApplication.IsCallBack then
    Exit;

  CallBacks := TIWCallBacks(TIWApplication(WebApplication).FCallBacks);
  xQualifiedName := CallBacks.QualifiedName(WebApplication.ActiveForm, AControlName)+'.';

  for idx := CallBacks.Count-1 downto 0 do
    if AnsiStartsStr(xQualifiedName, CallBacks[idx]) then
      CallBacks.Delete(idx);
end;

procedure ExecuteJScript(const Script: string);
var
  IWApp: IWApplication.TIWApplication;
begin
  if Length(Script) <= 0 then Exit;

  IWApp := GGetWebApplicationThreadVar;
  if IWApp = nil then
    raise Exception.Create('User session not found');

  if IWApp.IsCallBack and IWApp.CallBackProcessing then
    IWApp.CallBackResponse.AddJavaScriptToExecute(Script)
  else
    HTML40FormInterface(IWApp.ActiveForm).PageContext.AddToInitProc(Script);
end;

end.
