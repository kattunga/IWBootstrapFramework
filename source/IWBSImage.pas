unit IWBSImage;

interface

uses System.Classes, System.SysUtils, Vcl.Graphics, Data.Db,
     IWScriptEvents, IWBaseInterfaces,
     IWRenderContext, IWHTMLTag, IWBSCustomControl, IWCompExtCtrls;


type
  TIWBSImageOption = (iwbsimResponsive, iwbsimCircle, iwbsimRounded, iwbsimThumbnail);
  TIWBSImageOptions = set of TIWBSImageOption;

  TIWBSImage = class(TIWBSCustomDbControl, IIWSubmitControl)
  private
    FActiveSrc: string;
    FOldSrc: string;

    FAltText: string;
    FEmbedBase64: boolean;
    FImageFile: string;
    FImageOptions: TIWBSImageOptions;
    FimageSrc: string;
    FMimeType: string;
    FPicture: TPicture;
    FUseSize: Boolean;

    procedure SetImageFile(const AValue: string);
    procedure SetImageSrc(const AValue: string);
    function GetPicture: TPicture;
    procedure SetPicture(AValue: TPicture);
    procedure SetUseSize(const AValue: Boolean);
  protected
    procedure CheckData(AContext: TIWCompContext); override;
    procedure PictureChanged(ASender: TObject);
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure InternalRenderStyle(AStyle: TStringList); override;
    procedure HookEvents(APageContext: TIWPageContext40; AScriptEvents: TIWScriptEvents); override;
    procedure Submit(const AValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetSubmitParam : String;
    property ActiveSrc: string read FActiveSrc;
  published
    property AltText: string read FAltText write FAltText;
    property Confirmation;
    property DoSubmitValidation;
    property EmbedBase64: boolean read FEmbedBase64 write FEmbedBase64 default False;
    property Enabled default True;
    property ImageFile: string read FImageFile write SetImageFile;
    property BSImageOptions: TIWBSImageOptions read FImageOptions write FImageOptions default [iwbsimResponsive];
    property ImageSrc: string read FImageSrc write SetImageSrc;
    property MimeType: string read FMimeType write FMimeType;
    property Picture: TPicture read GetPicture write SetPicture;
    property UseSize: Boolean read FUseSize write SetUseSize default False;

    property OnClick;
  end;

implementation

uses IW.Common.System, IW.Common.Strings, IWTypes, IWForm, IWAppCache, IW.CacheStream, IWDbCommon, InCoderMIME;

{$region 'FieldBlobStream'}
// this comes from TBlobField.SaveToStreamPersist, is the only way to directly obtain a valid image without usen a TPicture
type
  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;

function GetFieldBlobStream(ADataSet: TDataSet; AField: TBlobField): TStream;
var
  Size: Longint;
  Header: TBytes;
  GraphicHeader: TGraphicHeader;
begin
  Result := ADataSet.CreateBlobStream(AField, bmRead);
  Size := Result.Size;
  if Size >= SizeOf(TGraphicHeader) then begin
    SetLength(Header, SizeOf(TGraphicHeader));
    Result.Read(Header, 0, Length(Header));
    Move(Header[0], GraphicHeader, SizeOf(TGraphicHeader));
    if (GraphicHeader.Count <> 1) or (GraphicHeader.HType <> $0100) or
      (GraphicHeader.Size <> Size - SizeOf(GraphicHeader)) then
      Result.Position := 0;
  end;
end;
{$endregion}

{$region 'TIWBSImage'}
constructor TIWBSImage.Create(AOwner: TComponent);
begin
  inherited;
  FAltText := '';
  ImageFile := '';
  FImageOptions := [iwbsimResponsive];
  ImageSrc := '';
  FMimeType := '';
  FPicture := nil;
  FUseSize := False;
  Width := 89;
  Height := 112;
end;

destructor TIWBSImage.Destroy;
begin
  FreeAndNil(FPicture);
  inherited;
end;

function TIWBSImage.GetSubmitParam: String;
begin
  Result := FSubmitParam;
end;

procedure TIWBSImage.Submit(const AValue: string);
begin
  FSubmitParam := AValue;
  DoClick;
end;

procedure TIWBSImage.HookEvents(APageContext: TIWPageContext40; AScriptEvents: TIWScriptEvents);
begin
  inherited HookEvents(APageContext, AScriptEvents);
  if HasOnClick then begin
    AScriptEvents.HookEvent('OnClick', SubmitHandler(''));
  end;
end;

function TIWBSImage.GetPicture: TPicture;
begin
  if not Assigned(FPicture) then begin
    FPicture := TPicture.Create;
    FPicture.OnChange := PictureChanged;
  end;
  Result := FPicture;
end;

procedure TIWBSImage.SetImageFile(const AValue: string);
begin
  FImageFile := AValue;
  FActiveSrc := '';
  Invalidate;
end;

procedure TIWBSImage.SetImageSrc(const AValue: string);
begin
  FImageSrc := AValue;
  FActiveSrc := '';
  Invalidate;
end;

procedure TIWBSImage.SetPicture(AValue: TPicture);
begin
  Picture.Assign(AValue);
  FActiveSrc := '';
end;

procedure TIWBSImage.PictureChanged(ASender: TObject);
begin
  if not IsLoading then begin
    FActiveSrc := '';
    Invalidate;
  end;
end;

procedure TIWBSImage.SetUseSize(const AValue: Boolean);
begin
  if FUseSize <> AValue then begin
    FUseSize := AValue;
    Invalidate;
  end;
end;

procedure TIWBSImage.CheckData(AContext: TIWCompContext);
var
  LField: TField;
  LMimeType: string;
  LFile: string;
  LStream: TStream;
  LParentForm: TIWForm;
begin
  LFile := '';

  if FMimeType <> '' then
    LMimeType := FMimeType
  else
    LMimeType := 'image';

  // if there is field data we show it, if not we fallback to other sources
  if CheckDataSource(DataSource, DataField, LField) then begin
    FActiveSrc := '';
    if Assigned(FPicture) then
      FPicture.Graphic := nil;
    if (LField is TBlobField) and not LField.IsNull then begin
      LStream := GetFieldBlobStream(DataSource.DataSet, TBlobField(LField));
      try
        if FEmbedBase64 then
          FActiveSrc := 'data:image;base64, '+TIdEncoderMIME.EncodeStream(LStream)
        else
          FActiveSrc := TIWAppCache.StreamToCacheFile(AContext.WebApplication,LStream, LMimeType);
      finally
        LStream.Free;
      end;
    end;
  end;

  if FActiveSrc = '' then
    if FImageSrc <> '' then
      FActiveSrc := FImageSrc
    else
      begin
        if Assigned(FPicture) and Assigned(FPicture.Graphic) and (not FPicture.Graphic.Empty) then
          if FEmbedBase64 then
            begin
              LStream := TMemoryStream.Create;
              try
                FPicture.Graphic.SaveToStream(LStream);
                LStream.Position := 0;
                FActiveSrc := 'data:image;base64, '+TIdEncoderMIME.EncodeStream(LStream)
              finally
                LStream.Free;
              end;
            end
          else
            begin
              LFile := TIWAppCache.NewTempFileName;
              FPicture.SaveToFile(LFile);
            end
        else if FImageFile <> '' then
          LFile := FImageFile;

        if LFile <> '' then begin
          LParentForm := TIWForm.FindParentForm(Self);
          if LParentForm <> nil then
            FActiveSrc := TIWAppCache.AddFileToCache(LParentForm, LFile, LMimeType, ctForm)
          else
            FActiveSrc := TIWAppCache.AddFileToCache(AContext.WebApplication, LFile, LMimeType);
      end;
  end;
end;

procedure TIWBSImage.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  inherited;
  if FActiveSrc <> FOldSrc then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+AHTMLName+'").attr("src","'+FActiveSrc+'");');
    FOldSrc := FActiveSrc;
  end;
end;

procedure TIWBSImage.InternalRenderCss(var ACss: string);
begin
  if iwbsimResponsive in FImageOptions then
    AddCssClass(ACss, 'img-responsive');
  if iwbsimCircle in FImageOptions then
    AddCssClass(ACss, 'img-circle');
  if iwbsimRounded in FImageOptions then
    AddCssClass(ACss, 'img-rounded');
  if iwbsimThumbnail in FImageOptions then
    AddCssClass(ACss, 'img-thumbnail');
end;

procedure TIWBSImage.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  LTag: TIWHTMLTag;
begin
  inherited;
  FOldSrc := FActiveSrc;

  AHTMLTag := TIWHTMLTag.CreateTag('img');
  AHTMLTag.AddClassParam(ActiveCss);
  AHTMLTag.AddStringParam('id', AHTMLName);
  AHTMLTag.AddStringParam('style', ActiveStyle);
  AHTMLTag.AddStringParam('src', FActiveSrc);
  if AltText <> '' then
    AHTMLTag.AddStringParam('alt', AltText, True)
  else
    AHTMLTag.AddStringParam('alt', FActiveSrc, True);
  if not AutoSize then begin
    AHTMLTag.AddIntegerParam('width', Width);
    AHTMLTag.AddIntegerParam('height', Height);
  end;
  if HasOnClick then begin
    LTag := SubmitLink('', '', False,  AContext.Browser);
    LTag.Contents.AddTagAsObject(AHTMLTag, true);
  end;
  if not Enabled then
    AContext.AddToInitProc('setEnabled("' + HTMLName + '", false);');
end;

procedure TIWBSImage.InternalRenderStyle(AStyle: TStringList);
begin
  inherited;
  if Assigned(FOnAsyncClick) and (Cursor in [crHandPoint,crPointer]) then
    AStyle.Values['cursor'] := 'pointer';
end;
{$endregion}

end.
