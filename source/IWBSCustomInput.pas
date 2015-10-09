unit IWBSCustomInput;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Data.db,
  IWControl,
  IWBaseControl, IWTypes, IWHTMLTag, IWDBCommon, IWDBStdCtrls,
  IWXMLTag, IWRenderContext, IWBaseInterfaces, IWHTML40Interfaces;

type
  TIWBSInputType = (bsitText, bsitPassword, bsitDateTimeLocal, bsitDate, bsitMonth, bsitTime, bsitWeek, bsitNumber, bsitEmail, bsitUrl, bsitSearch, bsitTel, bsitColor);

const
  aIWBSInputType: array[bsitText..bsitColor] of string = ('text', 'password', 'datetime-local', 'date', 'month', 'time', 'week', 'number', 'email', 'url', 'search', 'tel', 'color');

type
  TIWBSCustomInput = class(TIWCustomControl, IIWInputControl, IIWSubmitControl, IIWInputControl40, IIWAutoEditableControl)
  private
    FAutoEditable: Boolean;
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
    property Caption: string read FCaption write FCaption;
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property DataField: string read FDataField write SetDataField;
    property DoSubmitValidation;
    property Enabled default True;
    property ExtraTagParams;
    property FriendlyName;
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

implementation

uses
  IWBaseForm, IWForm, IWMarkupLanguageTag, IWBSCommon;

var
  LFormatSettings: TFormatSettings;

procedure TIWBSCustomInput.InitControl;
begin
  inherited;
  FAutoEditable := True;
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

  Height := 21;
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
  SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
  SetAsyncReadOnly(AContext, xHTMLName, IsReadOnly, FOldReadOnly);
  SetAsyncDisabled(AContext, xHTMLName, IsDisabled, FOldDisabled);
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
  SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
  InternalRenderAsync(xHTMLName, AContext);
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

initialization
  LFormatSettings := TFormatSettings.Create('en-US'); // locale de us
  LFormatSettings.DateSeparator := '-';
  LFormatSettings.LongDateFormat := 'yyyy-mm-dd';
  LFormatSettings.ShortDateFormat := LFormatSettings.LongDateFormat;
  LFormatSettings.LongTimeFormat := 'hh:nn:ss';
  LFormatSettings.ShortTimeFormat := LFormatSettings.LongTimeFormat;

end.
