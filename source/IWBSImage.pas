unit IWBSImage;

interface

uses Data.Db, Vcl.Graphics,
     IWRenderContext, IWHTMLTag, IWDBExtCtrls;


type
  TIWBSImage = class(TIWDBImage)
  protected
    procedure CheckData; override;
  public
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property OnAsyncClick;
    property OnAsyncDoubleClick;
    property OnAsyncMouseDown;
    property OnAsyncMouseMove;
    property OnAsyncMouseOver;
    property OnAsyncMouseOut;
    property OnAsyncMouseUp;

    property Picture;
    property FriendlyName;
    property TransparentColor;
    property JpegOptions;
    property OutputType;
    property RenderEmptyAsSpan;
  end;

implementation

{$region 'TIWBSImage'}
procedure TIWBSImage.CheckData;
begin
  if DataSource <> nil then
    inherited;
end;

function TIWBSImage.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'img-responsive';
  if Css <> '' then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + Css;
  end;
end;

function TIWBSImage.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result.AddClassParam(RenderCSSClass(AContext));
end;
{$endregion}

end.
