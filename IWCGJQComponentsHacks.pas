unit IWCGJQComponentsHacks;

interface

uses System.Classes, System.SysUtils,
     IWCGJQControl, IWCGJQCommon, IWRenderContext, IWHTMLTag,
     IWCGJQButton, IWCGJQLabel, IWCGJQTabs, IWCGJQEdit;

type
  TIWCGJQButton = class(IWCGJQButton.TIWCGJQButton)
  protected
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  end;

  TIWCGJQEdit = class(IWCGJQEdit.TIWCGJQEdit)
  private
    FCssCustom: string;
  protected
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  public
    property CssCustom: string read FCssCustom write FCssCustom;
  end;

  TIWCGJQLabel = class(IWCGJQLabel.TIWCGJQLabel)
  protected
    function RenderStyle(AComponentContext: TIWCompContext): string; override;
  end;

  TIWCGJQTabs = class(IWCGJQTabs.TIWCGJQTabs)
  protected
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AComponentContext: TIWCompContext): string; override;
  end;

implementation

uses IWMarkupLanguageTag;

function RemoveStyle(const style, name: string): string;
var
  st: TStringList;
begin
  st := TStringList.Create;
  try
    st.Delimiter := ';';
    st.NameValueSeparator := ':';
    st.StrictDelimiter := True;
    st.DelimitedText := style;
    st.Values[name] := '';
    if st.Count > 1 then
      Result := st.DelimitedText
    else
      Result := Trim(st.Text);
  finally
    st.Free;
  end;
end;

function RemoveInlineStyles(const style: string; Border, Padding: boolean): string;
begin
  Result := style;
  if not Border then
    Result := RemoveStyle(Result,'padding');
  if not Padding then begin
    Result := RemoveStyle(Result,'border-style');
    Result := RemoveStyle(Result,'border-width');
  end;
  Result := Result;
end;

function TIWCGJQButton.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  st: string;
  tg: TIWHTMLTag;
begin
  // if there is no caption, doesn't create text tag
  JQButtonOptions.Text := Caption <> '';

  result := inherited;

  // remove inline styles
  Result.Params.Values['style'] := RemoveInlineStyles(Result.Params.Values['style'], StyleRenderOptions.RenderBorder, StyleRenderOptions.RenderPadding);

  // remove inner inline styles
  if not StyleRenderOptions.RenderPadding then begin
    tg := TIWHTMLTag(TIWHTMLTag(result.Contents[0]).Contents[0]);
    if AnsiSameText(tg.Tag, 'input') then begin
      st := tg.Params.Values['style'];
      tg.Params.Values['style'] := RemoveStyle(st,'padding');
    end;
  end;

  // add a class for easy css
  result.AddClassParam('iwbs-button');

  // user css
  if Css <> '' then
    result.AddClassParam(Css);
end;

function TIWCGJQEdit.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  st: string;
  tg: TIWHTMLTag;
begin
  result := inherited;

  // remove inline styles
  Result.Params.Values['style'] := RemoveInlineStyles(Result.Params.Values['style'], StyleRenderOptions.RenderBorder, StyleRenderOptions.RenderPadding);

  // add a class for easy css
  result.AddClassParam('iwbs-edit');

  // user css
  if FCssCustom <> '' then
    result.AddClassParam(FCssCustom);
end;

// hack to avoid render height style when StyleRenderOptions.RenderSize = False (TIWCGJQTabs bug)
function TIWCGJQTabs.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  i: integer;
begin
  for i := 0 to TabCount-1 do begin
    Tabs[i].StyleRenderOptions.RenderAbsolute := StyleRenderOptions.RenderAbsolute;
    Tabs[i].StyleRenderOptions.RenderPadding := StyleRenderOptions.RenderPadding;
    Tabs[i].StyleRenderOptions.RenderPosition := StyleRenderOptions.RenderPosition;
    Tabs[i].StyleRenderOptions.RenderSize := StyleRenderOptions.RenderSize;
    Tabs[i].ClipRegion := True; // anyway it's true by default
  end;

  Result := inherited;
end;

function TIWCGJQTabs.RenderStyle(AComponentContext: TIWCompContext): string;
var
  b: boolean;
begin
  b := ClipRegion;
  ClipRegion := not StyleRenderOptions.RenderSize or b;
  Result:= inherited RenderStyle(AComponentContext);
  ClipRegion := b;
end;

function TIWCGJQLabel.RenderStyle(AComponentContext: TIWCompContext): string;
var
  b: boolean;
begin
  b := Autosize;
  Autosize := not StyleRenderOptions.RenderSize or b;
  Result:= inherited RenderStyle(AComponentContext);
  Autosize := b;
end;

end.
