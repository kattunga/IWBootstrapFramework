unit IWBSUtils;

interface

uses System.Classes, System.SysUtils, Windows,
     IWAppForm, IWtypes, IWBSCommon, IWHTMLTag;

// Disable all RenderOptions at one time
procedure IWBSDisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);

// this help to create unique component names at runtime for example form Frames
function  IWBSGetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;

function CreateInputGroupAddOn(ATag: TIWHTMLTag; const css: string): TIWHTMLTag;

implementation

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

function CreateInputGroupAddOn(ATag: TIWHTMLTag; const css: string): TIWHTMLTag;
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

end.
