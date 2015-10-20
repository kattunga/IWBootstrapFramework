unit IWBSCustomControl;

interface

uses System.Classes, System.SysUtils,
     IWControl, IWRenderContext, IWHTMLTag;

type
  TIWBSCustomControl = class(TIWCustomControl)
  private
    FScript: TStrings;
    FStyle: TStrings;

    procedure SetStyle(const AValue: TStrings);
  protected
    FMainID: string;

    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); virtual;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; virtual;
    procedure InternalRenderStyle(AStyle: TStrings); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure RenderScripts(AComponentContext: TIWCompContext); override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  published
    property Script: TStrings read FScript write FScript;
    property Style: TStrings read FStyle write SetStyle;
  end;

implementation

constructor TIWBSCustomControl.Create(AOwner: TComponent);
begin
  inherited;
  FScript := TStringList.Create;
  FStyle := TStringList.Create;
  FStyle.NameValueSeparator := ':';
end;

destructor TIWBSCustomControl.Destroy;
begin
  FreeAndNil(FScript);
  FreeAndNil(FStyle);
  inherited;
end;

procedure TIWBSCustomControl.SetStyle(const AValue: TStrings);
begin
  FStyle.Assign(AValue);
  Invalidate;
end;

procedure TIWBSCustomControl.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  //
end;

function TIWBSCustomControl.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := nil;
end;

procedure TIWBSCustomControl.InternalRenderStyle(AStyle: TStrings);
begin
  //
end;

function TIWBSCustomControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := InternalRenderHTML(HTMLName, AContext);

  FMainID := Result.Params.Values['id'];

  // add user scripts (it's more easy to create and destroy dinamically when they are embedded in the tag)
  if FScript.Count > 0 then
    Result.Contents.AddTag('script').Contents.AddText(FScript.Text);
end;

procedure TIWBSCustomControl.RenderScripts(AComponentContext: TIWCompContext);
begin
  inherited;
end;

function TIWBSCustomControl.RenderStyle(AContext: TIWCompContext): string;
var
  xStyle: TStringList;
  i: integer;
begin
  Result := '';

  xStyle := TStringList.Create;
  try
    xStyle.Assign(FStyle);
    InternalRenderStyle(xStyle);
    for i := 0 to xStyle.Count-1 do begin
      if Result <> '' then
        Result := Result + ';';
      Result := Result + xStyle[i];
    end;
  finally
    xStyle.Free;
  end;
end;

end.
