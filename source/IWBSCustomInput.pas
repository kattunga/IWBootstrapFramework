unit IWBSCustomInput;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Data.db,
  IWControl,
  IWBaseControl, IWTypes, IWHTMLTag, IWDBCommon, IWDBStdCtrls,
  IWXMLTag, IWRenderContext, IWBaseInterfaces, IWHTML40Interfaces,
  IWBSCommon;

type
  TIWBSInputType = (bsitText, bsitPassword, bsitDateTimeLocal, bsitDate, bsitMonth, bsitTime, bsitWeek, bsitNumber, bsitEmail, bsitUrl, bsitSearch, bsitTel, bsitColor);

const
  aIWBSInputType: array[bsitText..bsitColor] of string = ('text', 'password', 'datetime-local', 'date', 'month', 'time', 'week', 'number', 'email', 'url', 'search', 'tel', 'color');

type
  TIWBSCustomInput = class(TIWCustomControl, IIWInputControl, IIWSubmitControl, IIWInputControl40, IIWAutoEditableControl)
  private
    FAutoEditable: Boolean;
    FAutoFocus: boolean;
    FDbEditable: boolean;
    FCaption: string;
    FDataLink: TIWDataLink;
    FDataField: string;
    FDataSource: TDataSource;
    FInputType: TIWBSInputType;
    FMaxLength: Integer;
    FOnSubmit: TNotifyEvent;
    FReadOnly: Boolean;
    FRequired: Boolean;
    FSubmitParam : String;
    FStyle: TStrings;

    procedure EditingChanged;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(const Value: TDataSource);
  protected
    FIsStatic: boolean;
    FSupportReadOnly: boolean;
    FMainID: string;
    FOldVisible: boolean;
    FOldDisabled: boolean;
    FOldCss: string;
    FOldStyle: string;
    FOldReadOnly: boolean;
    FOldText: string;

    procedure InitControl; override;
    procedure CheckData; virtual;
    procedure DoSubmit;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetMaxLength(const AValue:integer);
    procedure SetReadOnly(const AValue:boolean);
    procedure SetRequired(const AValue:boolean);
    procedure SetStyle(const AValue: TStrings);
    procedure SetValue(const AValue: string); virtual;
    procedure Submit(const AValue: string); override;
    function FormHasOnDefaultActionSet:boolean;
    function get_ShouldRenderTabOrder: boolean;override;

    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); virtual;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; virtual;
    procedure InternalRenderStyle(AStyle: TStrings); virtual;
    procedure InternalSetValue(const AValue: string; var AFieldValue: string); virtual;

    function IsReadOnly: boolean;
    function IsDisabled: boolean;

    property MaxLength: Integer read FMaxLength write SetMaxLength;
    property ReadOnly: boolean read FReadOnly write SetReadOnly;
    property BSInputType: TIWBSInputType read FInputType write FInputType;
  public
    destructor Destroy; override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
    function GetSubmitParam : String;
  published
    property AutoEditable: Boolean read FAutoEditable write FAutoEditable default True;
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default False;
    property Caption: string read FCaption write FCaption;
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property DataField: string read FDataField write SetDataField;
    property DoSubmitValidation;
    property Editable default True;
    property Enabled default True;
    property ExtraTagParams;
    property FriendlyName;
    property NonEditableAsLabel default False;
    property Required: Boolean read FRequired write SetRequired default False;
    property ScriptEvents;
    property SubmitOnAsyncEvent;
    property Style: TStrings read FStyle write SetStyle;
    property TabOrder;

    property OnAsyncClick;
    property OnAsyncDoubleClick;
    property OnAsyncChange;
    property OnAsyncEnter;
    property OnAsyncExit;
    property OnAsyncKeyDown;
    property OnAsyncKeyUp;
    property OnAsyncKeyPress;
    property OnAsyncMouseDown;
    property OnAsyncMouseMove;
    property OnAsyncMouseOver;
    property OnAsyncMouseOut;
    property OnAsyncMouseUp;
    property OnSubmit: TNotifyEvent read FOnSubmit write FOnSubmit;
  end;

  TIWBSCustomTextInput = class(TIWBSCustomInput)
  private
    FPlaceHolder: string;
    FTextAlignment: TIWBSTextAlignment;
    FTextCase: TIWBSTextCase;
  protected
    procedure InitControl; override;
  public
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
  published
    property BSTextAlignment: TIWBSTextAlignment read FTextAlignment write FTextAlignment default bstaDefault;
    property BSTextCase: TIWBSTextCase read FTextCase write FTextCase default bstcDefault;
    property MaxLength default 0;
    property PlaceHolder: string read FPlaceHolder write FPlaceHolder;
    property ReadOnly default False;
    property Text;
  end;

  TIWBSCustomSelectInput = class(TIWBSCustomInput)
  private
    FItemIndex: integer;
    FItems: TStrings;
    FItemsHaveValues: boolean;
  protected
    procedure InitControl; override;
    procedure CheckData; override;
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    procedure InternalSetValue(const AValue: string; var AFieldValue: string); override;
    procedure SetItemIndex(AValue: integer);
    procedure SetItems(AValue: TStrings);
    procedure SetItemsHaveValues(AValue: boolean);
  public
    destructor Destroy; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
  published
    property ItemIndex: integer read FItemIndex write SetItemIndex;
    property Items: TStrings read FItems write SetItems;
    property ItemsHaveValues: boolean read FItemsHaveValues write SetItemsHaveValues default False;
  end;

implementation

uses
  IWBaseForm, IWForm, IWMarkupLanguageTag;

var
  LFormatSettings: TFormatSettings;

{$region 'TIWBSCustomInput'}
procedure TIWBSCustomInput.InitControl;
begin
  inherited;
  FAutoEditable := True;
  FAutoFocus := False;
  FCaption := '';
  FDataLink := nil;
  FDataField := '';
  FInputType := bsitText;
  FNonEditableAsLabel := False;
  FReadOnly := False;
  FRequired := False;
  FStyle := TStringList.Create;
  FStyle.NameValueSeparator := ':';

  FCanReceiveFocus := True;
  FNeedsFormTag := True;
  FIsStatic := False;
  FSupportReadOnly := False;

  Height := 25;
  Width := 121;
end;

destructor TIWBSCustomInput.Destroy;
begin
  FreeAndNil(FDataLink);
  FreeAndNil(FStyle);
  inherited;
end;

procedure TIWBSCustomInput.CheckData;
var
  LField: TField;
begin
  if DataSource <> nil then
    begin
      if CheckDataSource(DataSource, DataField, LField) then
        begin
          if AutoEditable then
            FDbEditable := InEditMode(DataSource.Dataset) and FieldIsEditable(DataSource, DataField);
          if Assigned(LField.OnGetText) then
            Text := LField.Text
          else if (FInputType = bsitNumber) and (LField.DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBCD, ftExtended]) then
            Text := FloatToStr(LField.AsExtended, LFormatSettings)

          // aca agregar todos los tipos fecha que hay

          else if (FInputType = bsitDateTimeLocal) and (LField.DataType in [ftDate, ftTime, ftDateTime, ftTimeStamp, ftOraTimeStamp]) then
            Text := FormatDateTime('yyyy-mm-dd"T"hh:nn',LField.AsDateTime)
          else
            Text := LField.AsString;
        end
      else
        begin
          Text := '';
          if AutoEditable then
            FDbEditable := True;
        end;
    end
  else
    FDbEditable := true;
end;

procedure TIWBSCustomInput.EditingChanged;
begin
  invalidate;
end;

procedure TIWBSCustomInput.SetDataField(const AValue: string);
var
  xFld: TField;
begin
  if not SameText(AValue, FDataField) then begin
    FDataField := AValue;
    MaxLength := 0;
    if FDataField <> '' then begin
      xFld := GetDataSourceField(FDataSource, FDataField);
      if Assigned(xFld) and (xFld is TStringField) then
        MaxLength := TStringField(xFld).Size;
    end;
    Invalidate;
  end;
end;

procedure TIWBSCustomInput.SetDataSource(const Value: TDataSource);
begin
  if Value <> FDataSource then begin
    FDataSource := Value;
    if Value = nil then
      begin
        FDataField := '';
        FreeAndNil(FDataLink);
      end
    else
      begin
        if FDataLink = nil then
          FDataLink := TIWDataLink.Create(Self);
        FDataLink.DataSource := FDataSource;
      end;
    Invalidate;
  end;
end;

procedure TIWBSCustomInput.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then
    if FDatasource = AComponent then
      SetDataSource(nil);
end;

function TIWBSCustomInput.GetSubmitParam: String;
begin
  Result := FSubmitParam;
end;

function TIWBSCustomInput.get_ShouldRenderTabOrder: boolean;
begin
  result := Editable or (NonEditableAsLabel = false);
end;

function TIWBSCustomInput.FormHasOnDefaultActionSet:boolean;
var
  LForm: TIWBaseForm;
begin
  Result := false;
  LForm := OwnerForm;
  if Assigned(LForm) then
    if LForm is TIWForm then
      result := Assigned( TIWForm(LForm).OnDefaultAction );
end;

procedure TIWBSCustomInput.DoSubmit;
begin
  if Assigned(OnSubmit) then
    OnSubmit(Self)
  else if FormHasOnDefaultActionSet then
    TIWForm(OwnerForm).OnDefaultAction(Self);
end;

procedure TIWBSCustomInput.Submit(const AValue: string);
begin
  FSubmitParam := AValue;
  DoSubmit;
end;

procedure TIWBSCustomInput.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  //
end;

function TIWBSCustomInput.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := nil;
end;

procedure TIWBSCustomInput.InternalRenderStyle(AStyle: TStrings);
begin
  //
end;

procedure TIWBSCustomInput.InternalSetValue(const AValue: string; var AFieldValue: string);
begin
  if FInputType = bsitNumber then
    AFieldValue := FloatToStr(StrToFloat(AValue, LFormatSettings))
  else if FInputType = bsitDateTimeLocal then                               // agregar todos los tipos fecha que hay
    AFieldValue := DateTimeToStr(StrToDateTime(ReplaceStr(AValue,'T',' '), LFormatSettings))
  else
    AFieldValue := AValue;
end;

function TIWBSCustomInput.IsReadOnly: boolean;
begin
  Result := FSupportReadOnly and (FReadOnly or not FDbEditable);
end;

function TIWBSCustomInput.IsDisabled: boolean;
begin
  Result := not (Enabled and Editable and (FDbEditable or FSupportReadOnly));
end;

function TIWBSCustomInput.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  Result := nil;
  CheckData;
  InternalRenderAsync(xHTMLName, AContext);
  SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
  SetAsyncReadOnly(AContext, xHTMLName, IsReadOnly, FOldReadOnly);
  SetAsyncDisabled(AContext, xHTMLName, IsDisabled, FOldDisabled);
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
  SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
end;

function TIWBSCustomInput.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  CheckData;
  FOldVisible := Visible;
  FOldDisabled := IsDisabled;
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldReadOnly := IsReadOnly;
  FOldText := Text;

  Result := InternalRenderHTML(HTMLName, AContext);

  FMainID := Result.Params.Values['id'];
end;

function TIWBSCustomInput.RenderStyle(AContext: TIWCompContext): string;
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

procedure TIWBSCustomInput.SetMaxLength(const AValue:integer);
begin
  if FMaxLength <> AValue then
  begin
    FMaxLength := AValue;
    Invalidate;
  end;
end;

procedure TIWBSCustomInput.SetReadOnly(const AValue:boolean);
begin
  if FReadOnly <> AValue then
  begin
    FReadOnly := AValue;
    Invalidate;
  end;
end;

procedure TIWBSCustomInput.SetRequired(const AValue:boolean);
begin
  if FRequired <> AValue then begin
    FRequired := AValue;
    Invalidate;
  end;
end;

procedure TIWBSCustomInput.SetValue(const AValue: string);
var
  LField: TField;
  LValue: string;
begin
  if RequiresUpdateNotification(Parent) then
    UpdateNotifiedInterface(Parent).NotifyUpdate(Self,AValue);
  if FOldText <> AValue then begin
    FOldText := AValue;
    Text := AValue;

    // if db conected
    if CheckDataSource(DataSource, DataField, LField) then
      if InEditMode(DataSource.DataSet) and LField.CanModify then
        begin
          InternalSetValue(AValue, LValue);
          if Assigned(LField.OnSetText) then
            LField.Text := LValue
          else
            LField.AsString := LValue;
        end
      else
        raise EIWDataSetNotEditingError.Create(DataSource);

    DoRefreshControl := False;
  end;
end;

procedure TIWBSCustomInput.SetStyle(const AValue: TStrings);
begin
  FStyle.Assign(AValue);
  Invalidate;
end;
{$endregion}

{$region 'TIWBSCustomTextInput'}
procedure TIWBSCustomTextInput.InitControl;
begin
  inherited;
  FSupportReadOnly := True;
  FTextAlignment := bstaDefault;
  FTextCase := bstcDefault;
end;

procedure TIWBSCustomTextInput.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  if FIsStatic then
    SetAsyncHtml(AContext, AHTMLName, Text, FOldText)
  else
    SetAsyncText(AContext, AHTMLName, Text, FOldText);
end;

function TIWBSCustomTextInput.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  FIsStatic := not Editable and NonEditableAsLabel;
  if FIsStatic then
    Result := 'form-control-static'
  else
    Result := 'form-control';
  if FTextAlignment <> bstaDefault then
    Result := Result + ' ' + aIWBSTextAlignment[FTextAlignment];
  if FTextCase <> bstcDefault then
    Result := Result + ' ' + aIWBSTextCase[FTextCase];
  if Css <> '' then
    Result := Result + ' ' + Css;
end;
{$endregion}

{$region 'TIWBSCustomSelectInput'}
procedure TIWBSCustomSelectInput.InitControl;
begin
  inherited;
  FItemIndex := -1;
  FItems := TStringList.Create;
  FItemsHaveValues := False;
  FSupportReadOnly := False;
end;

destructor TIWBSCustomSelectInput.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TIWBSCustomSelectInput.CheckData;
var
  i: integer;
begin
  inherited;
  if FItemsHaveValues then
    begin
      FItemIndex := -1;
      for i := 0 to Items.Count-1 do
        if AnsiSameText(Items.ValueFromIndex[i], Text) then begin
          FItemIndex := i;
          break;
        end;
    end
  else
    FItemIndex := Items.IndexOf(Text);
  Text := IntToStr(FItemIndex);
end;

procedure TIWBSCustomSelectInput.SetItemIndex(AValue: integer);
begin
  FItemIndex := AValue;
  Invalidate;
end;

procedure TIWBSCustomSelectInput.SetItems(AValue: TStrings);
begin
  FItems.Assign(AValue);
  Invalidate;
end;

procedure TIWBSCustomSelectInput.SetItemsHaveValues(AValue: boolean);
begin
  FItemsHaveValues := AValue;
  Invalidate;
end;

procedure TIWBSCustomSelectInput.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  
end;

procedure TIWBSCustomSelectInput.InternalSetValue(const AValue: string; var AFieldValue: string);
var
  i: integer;
begin
  if TryStrToInt(AValue, i) and (i >= 0) and (i < Items.Count) then
    if ItemsHaveValues then
      AFieldValue := Items.ValueFromIndex[i]
    else
      AFieldValue := Items[i]
  else
    AFieldValue := '';
end;

function TIWBSCustomSelectInput.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'form-control';
  if Css <> '' then
    Result := Result + ' ' + Css;
end;
{$endregion}

initialization
  LFormatSettings := TFormatSettings.Create('en-US'); // locale de us
  LFormatSettings.DateSeparator := '-';
  LFormatSettings.LongDateFormat := 'yyyy-mm-dd';
  LFormatSettings.ShortDateFormat := LFormatSettings.LongDateFormat;
  LFormatSettings.LongTimeFormat := 'hh:nn:ss';
  LFormatSettings.ShortTimeFormat := LFormatSettings.LongTimeFormat;

end.
