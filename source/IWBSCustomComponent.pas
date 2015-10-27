unit IWBSCustomComponent;

interface

uses System.Classes, System.StrUtils, System.SysUtils,
     IWRenderContext, IWHTMLTag, IWBSCustomControl;

type
  TIWBSTagType = (bsttDiv, bsttSpan);

  TIWBSCustomComponent = class(TIWBSCustomControl)
  private
    FCustomAjaxEvents: TOwnedCollection;
    FCustomRestEvents: TOwnedCollection;
    FLines: TStringList;
    FTagType: TIWBSTagType;
    procedure OnItemsChange(ASender : TObject);
    procedure SetLines(const AValue: TStringList);
  protected
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    function InternalRenderScript: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CustomAjaxEvents: TOwnedCollection read FCustomAjaxEvents write FCustomAjaxEvents;
    property CustomRestEvents: TOwnedCollection read FCustomRestEvents write FCustomRestEvents;
    property Lines: TStringList read FLines write SetLines;
    property TagType: TIWBSTagType read FTagType write FTagType default bsttDiv;
  end;

implementation

uses IWBSCustomEvents, IWBSCommon;

{$region 'TIWBSCustomComponent'}
constructor TIWBSCustomComponent.Create(AOwner: TComponent);
begin
  inherited;
  FCustomAjaxEvents := TOwnedCollection.Create(Self, TIWBSCustomAjaxEvent);
  FCustomRestEvents := TOwnedCollection.Create(Self, TIWBSCustomRestEvent);
  FLines := TStringList.Create;
  FLines.OnChange := OnItemsChange;
  FTagType := bsttDiv;
end;

destructor TIWBSCustomComponent.Destroy;
begin
  FreeAndNil(FCustomAjaxEvents);
  FreeAndNil(FCustomRestEvents);
  inherited;
end;

procedure TIWBSCustomComponent.OnItemsChange( ASender : TObject );
begin
  DoRefreshControl := True;
  Invalidate;
end;

procedure TIWBSCustomComponent.SetLines(const AValue: TStringList);
begin
  FLines.Assign(AValue);
  Invalidate;
end;

procedure TIWBSCustomComponent.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
const
  aTagType: array[bsttDiv..bsttSpan] of string = ('div', 'span');
var
  i: integer;
  LHtml: string;
begin
  inherited;

  // get html
  LHtml := TIWBSCommon.ReplaceParams(HTMLName, LHtml, ScriptParams);

  // register ajax callbacks
  for i := 0 to FCustomAjaxEvents.Count-1 do begin

  end;

  // register rest callbacks
  for i := 0 to FCustomRestEvents.Count-1 do begin
    TIWBSCustomRestEvent(FCustomRestEvents.Items[i]).RegisterEvent(AContext.WebApplication, AHTMLName);
    LHtml := TIWBSCustomRestEvent(FCustomRestEvents.Items[i]).ParseParamEvent(LHtml);
  end;

  AHTMLTag := TIWHTMLTag.CreateTag(aTagType[FTagType]);
  AHTMLTag.AddStringParam('id', HTMLName);
  AHTMLTag.AddClassParam(ActiveCss);
  AHTMLTag.AddStringParam('style',ActiveStyle);
  AHTMLTag.Contents.AddText(LHtml);
end;

function TIWBSCustomComponent.InternalRenderScript: string;
var
  i: integer;
begin
  Result := inherited;
  for i := 0 to FCustomRestEvents.Count-1 do
    Result := TIWBSCustomRestEvent(FCustomRestEvents.Items[i]).ParseParamEvent(Result);
end;
{$endregion}

end.
