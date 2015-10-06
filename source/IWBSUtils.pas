unit IWBSUtils;

interface

uses System.Classes, System.SysUtils, System.StrUtils, Windows,
     IWAppForm, IWtypes, IWBSCommon, IWHTMLTag, IWApplication;

procedure IWBSDisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);

function  IWBSGetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;

function  IWBSCreateInputGroupAddOn(ATag: TIWHTMLTag; const css: string): TIWHTMLTag;

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

procedure ExecuteJScript(const Script: string);
var
  LWebApplication: TIWApplication;
begin
  if Length(Script) <= 0 then Exit;

  LWebApplication := GGetWebApplicationThreadVar;
  if LWebApplication = nil then
    raise Exception.Create('User session not found');

  if LWebApplication.IsCallBack and LWebApplication.CallBackProcessing then
    LWebApplication.CallBackResponse.AddJavaScriptToExecute(Script)
  else
    HTML40FormInterface(LWebApplication.ActiveForm).PageContext.AddToInitProc(Script);
end;

end.
