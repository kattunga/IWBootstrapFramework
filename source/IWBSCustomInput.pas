unit IWBSCustomInput;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Data.db, Vcl.Controls,
  IWControl,
  IWBaseControl, IWTypes, IWHTMLTag, IWDBCommon, IWDBStdCtrls,
  IWXMLTag, IWRenderContext, IWBaseInterfaces, IWHTML40Interfaces,
  IWBSCommon;

type
  TIWBSInputType = (bsitText, bsitPassword, bsitDateTimeLocal, bsitDate, bsitMonth, bsitTime, bsitWeek, bsitNumber, bsitEmail, bsitUrl, bsitSearch, bsitTel, bsitColor, bsitHidden);

const
  aIWBSInputType: array[bsitText..bsitHidden] of string = ('text', 'password', 'datetime-local', 'date', 'month', 'time', 'week', 'number', 'email', 'url', 'search', 'tel', 'color', 'hidden');

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
    FSubmitParam : string;
    FScript: TStrings;
    FStyle: TStrings;

    procedure EditingChanged;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(const Value: TDataSource);
  protected
    FMainID: string;
    FInputSuffix: string;
    FInputSelector: string;
    FIsStatic: boolean;
    FSupportReadOnly: boolean;
    FText: TCaption;

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
    procedure SetCaption(const AValue: string);
    procedure SetMaxLength(const AValue:integer);
    procedure SetReadOnly(const AValue:boolean);
    procedure SetRequired(const AValue:boolean);
    procedure SetStyle(const AValue: TStrings);
    procedure SetValue(const AValue: string);
    procedure Submit(const AValue: string); override;
    function FormHasOnDefaultActionSet:boolean;
    function get_ShouldRenderTabOrder: boolean;override;

    procedure GetInputControlNames(ANames: TStringList); override;
    function IsForThisControl(AName: string): boolean; override;

    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); virtual;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; virtual;
    procedure InternalRenderStyle(AStyle: TStrings); virtual;

    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean); virtual;

    function IsReadOnly: boolean;
    function IsDisabled: boolean;

    function getText: TCaption; override;

    property MaxLength: Integer read FMaxLength write SetMaxLength;
    property ReadOnly: boolean read FReadOnly write SetReadOnly;
    property BSInputType: TIWBSInputType read FInputType write FInputType;
  public
    destructor Destroy; override;
    procedure Invalidate; override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure RenderScripts(AComponentContext: TIWCompContext); override;
    function RenderStyle(AContext: TIWCompContext): string; override;
    function GetSubmitParam : String;
    procedure SetText(const AValue: TCaption); override;
  published
    property AutoEditable: Boolean read FAutoEditable write FAutoEditable default True;
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default False;
    property Caption: string read FCaption write SetCaption;
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
    property Script: TStrings read FStyle write FScript;
    property Style: TStrings read FStyle write SetStyle;
    property TabOrder;
    property Text: TCaption read GetText write SetText;

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
  end;

  TIWBSCustomSelectInput = class(TIWBSCustomInput)
  private
    FItems: TStringList;
    FItemsHaveValues: boolean;
    procedure SetItems(AValue: TStringList);
    procedure SetItemsHaveValues(AValue: boolean);
  protected
    FItemIndex: integer;

    procedure InitControl; override;
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean); override;
    function FindValue(const AValue: string): integer;
    procedure Loaded; override;
    procedure OnItemsChange(ASender : TObject); virtual;
    procedure SetItemIndex(AValue: integer); virtual;
  public
    destructor Destroy; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    procedure SetText(const AValue: TCaption); override;
  published
    property ItemIndex: integer read FItemIndex write SetItemIndex default -1;
    property Items: TStringList read FItems write SetItems;
    property ItemsHaveValues: boolean read FItemsHaveValues write SetItemsHaveValues default False;
  end;

implementation

uses
  IWBaseForm, IWForm, IWMarkupLanguageTag, Dialogs;

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

  FScript := TStringList.Create;
  FStyle := TStringList.Create;
  FStyle.NameValueSeparator := ':';

  FInputSelector := '';
  FInputSuffix := '';

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
  FreeAndNil(FScript);
  FreeAndNil(FStyle);
  inherited;
end;

procedure TIWBSCustomInput.Invalidate;
begin
  DoRefreshControl := true;
  inherited;
end;

procedure TIWBSCustomInput.GetInputControlNames(ANames: TStringList);
begin
  ANames.Text := HTMLName+FInputSuffix;
end;

function TIWBSCustomInput.IsForThisControl(AName: string): boolean;
begin
  Result := SameText(HTMLName+FInputSuffix, AName);
end;

function TIWBSCustomInput.GetText: TCaption;
begin
  Result := FText;
end;

procedure TIWBSCustomInput.SetText(const AValue: TCaption);
begin
  FText := AValue;
  invalidate;
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

procedure TIWBSCustomInput.SetValue(const AValue: string);
var
  LField: TField;
  LText: string;
  LSave: boolean;
begin
  if RequiresUpdateNotification(Parent) then
    UpdateNotifiedInterface(Parent).NotifyUpdate(Self,AValue);
  LSave := True;
  InternalSetValue(AValue, LText, LSave);
  if (FOldText <> LText) or (FText <> LText) then begin
    FOldText := LText;
    FText := LText;
    if CheckDataSource(DataSource, DataField, LField) and LSave then
      if InEditMode(DataSource.DataSet) and LField.CanModify then
        begin
          if Assigned(LField.OnSetText) then
            LField.Text := LText
          else
            if FInputType = bsitNumber then
              LField.AsFloat := StrToFloat(AValue, LFormatSettings)
            else if FInputType = bsitDateTimeLocal then  // agregar todos los tipos fecha que hay
              LField.AsDateTime := StrToDateTime(ReplaceStr(AValue,'T',' '), LFormatSettings)
            else
              LField.AsString := LText;
        end
      else
        raise EIWDataSetNotEditingError.Create(DataSource);
    CheckData;
    Invalidate;
  end;
end;

procedure TIWBSCustomInput.EditingChanged;
begin
  Invalidate;
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

procedure TIWBSCustomInput.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean);
begin
  ATextValue := ASubmitValue;
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
  xHTMLName, xInputSelector: string;
begin
  xHTMLName := HTMLName;
  if FInputSelector <> '' then
    xInputSelector := FMainID+FInputSelector
  else
    xInputSelector := xHTMLName+FInputSuffix;

  Result := nil;
  CheckData;
  SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
  SetAsyncReadOnly(AContext, xInputSelector, IsReadOnly, FOldReadOnly);
  SetAsyncDisabled(AContext, xInputSelector, IsDisabled, FOldDisabled);
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
  SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
  InternalRenderAsync(xHTMLName, AContext);
end;

function TIWBSCustomInput.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := Css;
end;

function TIWBSCustomInput.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  CheckData;
  FOldVisible := Visible;
  FOldDisabled := IsDisabled;
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldReadOnly := IsReadOnly;
  FOldText := FText;

  Result := InternalRenderHTML(HTMLName, AContext);

  FMainID := Result.Params.Values['id'];

  // add user scripts (it's more easy to create and destroy dinamically when they are embedded in the tag)
  if FScript.Count > 0 then
    Result.Contents.AddTag('script').Contents.AddText(FScript.Text);
end;

procedure TIWBSCustomInput.RenderScripts(AComponentContext: TIWCompContext);
begin
  inherited;
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

procedure TIWBSCustomInput.SetCaption(const AValue: string);
begin
  FCaption := AValue;
  Invalidate;
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
    SetAsyncHtml(AContext, AHTMLName, FText, FOldText)
  else
    SetAsyncText(AContext, AHTMLName, FText, FOldText);
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
  FItems.OnChange := OnItemsChange;
  FItemsHaveValues := False;
  FSupportReadOnly := False;
end;

destructor TIWBSCustomSelectInput.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

procedure TIWBSCustomSelectInput.OnItemsChange(ASender : TObject);
begin
  Invalidate;
end;

procedure TIWBSCustomSelectInput.Loaded;
begin
  SetItemIndex(FItemIndex);
end;

procedure TIWBSCustomSelectInput.SetItemIndex(AValue: integer);
begin
  if csReading in ComponentState then
    FItemIndex := AValue
  else
    begin
      if (AValue >= -1) and (AValue < FItems.Count) then
        begin
          FItemIndex := AValue;
          if FItemIndex >= 0 then
            if FItemsHaveValues then
              FText := FItems.ValueFromIndex[AValue]
            else
              FText := FItems[AValue]
          else
            FText := '';
        end
      else
        begin
          FItemIndex := -1;
          FText := ''
        end;
      Invalidate;
    end;
end;

procedure TIWBSCustomSelectInput.SetItems(AValue: TStringList);
begin
  FItems.Assign(AValue);
end;

procedure TIWBSCustomSelectInput.SetItemsHaveValues(AValue: boolean);
begin
  FItemsHaveValues := AValue;
  Invalidate;
end;

function TIWBSCustomSelectInput.FindValue(const AValue: string): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to FItems.Count-1 do
    if AnsiSameStr(IfThen(FItemsHaveValues, FItems.ValueFromIndex[i], FItems[i]), AValue) then begin
      Result := i;
      Break;
    end;
end;

procedure TIWBSCustomSelectInput.SetText(const AValue: TCaption);
begin
  inherited;
  FItemIndex := FindValue(FText);
end;

procedure TIWBSCustomSelectInput.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean);
var
  i: integer;
begin
  if TryStrToInt(ASubmitValue, i) and (i >= 0) and (i < Items.Count) then
    begin
      if ItemsHaveValues then
        ATextValue := Items.ValueFromIndex[i]
      else
        ATextValue := Items[i];
      FItemIndex := i;
    end
  else
    begin
      ATextValue := '';
      FItemIndex := -1;
    end;
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
