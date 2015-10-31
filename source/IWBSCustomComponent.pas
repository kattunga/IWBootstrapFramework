unit IWBSCustomComponent;

interface

uses System.Classes, System.StrUtils, System.SysUtils,
     IWRenderContext, IWHTMLTag, IWBSCustomControl;

type
  TIWBSTagType = (bsttDiv, bsttSpan);

  TIWBSCustomComponent = class(TIWBSCustomControl)
  private
    FCustomAsyncEvents: TOwnedCollection;
    FCustomRestEvents: TOwnedCollection;
    FHtml: TStringList;
    FTagType: TIWBSTagType;
    procedure OnHtmlChange(ASender : TObject);
    procedure SetHtml(const AValue: TStringList);
  protected
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    function InternalRenderScript: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CustomAsyncEvents: TOwnedCollection read FCustomAsyncEvents write FCustomAsyncEvents;
    property CustomRestEvents: TOwnedCollection read FCustomRestEvents write FCustomRestEvents;
    property Html: TStringList read FHtml write SetHtml;
    property TagType: TIWBSTagType read FTagType write FTagType default bsttDiv;
  end;

implementation

uses IWBSCustomEvents, IWBSCommon;

{$region 'TIWBSCustomComponent'}
constructor TIWBSCustomComponent.Create(AOwner: TComponent);
begin
  inherited;
  FCustomAsyncEvents := TOwnedCollection.Create(Self, TIWBSCustomAsyncEvent);
  FCustomRestEvents := TOwnedCollection.Create(Self, TIWBSCustomRestEvent);
  FHtml := TStringList.Create;
  FHtml.OnChange := OnHtmlChange;
  FTagType := bsttDiv;
end;

destructor TIWBSCustomComponent.Destroy;
begin
  FreeAndNil(FCustomAsyncEvents);
  FreeAndNil(FCustomRestEvents);
  inherited;
end;

procedure TIWBSCustomComponent.OnHtmlChange( ASender : TObject );
begin
  Invalidate;
  if Script.Count > 0 then
    AsyncRefreshControl;
end;

procedure TIWBSCustomComponent.SetHtml(const AValue: TStringList);
begin
  FHtml.Assign(AValue);
end;

procedure TIWBSCustomComponent.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
const
  aTagType: array[bsttDiv..bsttSpan] of string = ('div', 'span');
var
  i: integer;
  LHtml: string;
begin
  inherited;
  LHtml := TIWBSCommon.ReplaceParams(HTMLName, FHtml.Text, ScriptParams);

  // register ajax callbacks
  for i := 0 to FCustomAsyncEvents.Count-1 do begin
    TIWBSCustomAsyncEvent(FCustomAsyncEvents.Items[i]).RegisterEvent(AContext.WebApplication, AHTMLName);
    LHtml := TIWBSCustomAsyncEvent(FCustomAsyncEvents.Items[i]).ParseParamEvent(LHtml);
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
  for i := 0 to FCustomAsyncEvents.Count-1 do
    Result := TIWBSCustomAsyncEvent(FCustomAsyncEvents.Items[i]).ParseParamEvent(Result);
  for i := 0 to FCustomRestEvents.Count-1 do
    Result := TIWBSCustomRestEvent(FCustomRestEvents.Items[i]).ParseParamEvent(Result);
end;
{$endregion}

end.
