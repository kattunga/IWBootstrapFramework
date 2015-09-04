unit IWBSControls;

interface

uses System.Classes, System.SysUtils,
     IWControl, IWRenderContext, IWMarkupLanguageTag, IWXMLTag, IWHTMLTag, IWCompLabel;

type
  TIWBSLabel = class(TIWLabel)
  public
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  end;

  TIWBSGlyphicon = class(TIWCustomControl)
  private
    FGlyphicon: string;
  protected
    procedure InitControl; override;
    function get_ShouldRenderTabOrder: boolean;override;
    function get_HasName: Boolean; override;
  public
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AComponentContext: TIWCompContext): string; override;
    function get_HasTabOrder: boolean; override;
  published
    property BSGlyphicon: string read FGlyphicon write FGlyphicon;
  end;

implementation

uses IWBSInput, IWBSUtils;

{$region 'TIWBSLabel'}
function TIWBSLabel.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(REsult, 'addon');
end;
{$endregion}

{$region 'TIWBSGlyphicon'}
procedure TIWBSGlyphicon.InitControl;
begin
  inherited;
  Height := 21;
  Width := 21;
end;

function TIWBSGlyphicon.get_HasTabOrder: boolean;
begin
  Result := False;
end;

function TIWBSGlyphicon.get_ShouldRenderTabOrder: boolean;
begin
  Result := False;
end;

function TIWBSGlyphicon.get_HasName: Boolean;
begin
  Result := False;
end;

function TIWBSGlyphicon.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('SPAN');
  try
    if FGlyphicon <> '' then
      begin
        Result.AddClassParam('glyphicon glyphicon-'+FGlyphicon);
        Result.AddBoolParam('aria-hidden',true);
      end
    else
      Result.Contents.AddText('&times;');
  except
    FreeAndNil(Result);
    raise;
  end;
  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(REsult, 'addon');
end;

function TIWBSGlyphicon.RenderStyle(AComponentContext: TIWCompContext): string;
begin
  Result := '';
end;
{$endregion}

end.
