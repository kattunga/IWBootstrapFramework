unit IWBSInput;

interface

uses
  System.SysUtils, System.Classes, IWScriptEvents, data.db, System.StrUtils,
  IWRenderContext, IWHTMLTag, IWXMLTag, IWBaseHTMLControl, IWBaseInterfaces, IWControl,
  IWCompEdit, IWCompMemo, IWCompCheckBox, IWCompRadioButton, IWCompListbox, IWCompButton, IWDBStdCtrls, IWDBExtCtrls,
  IWBSRegion, IWBSCommon, IWBSCustomInput;

type

  TIWBSInputType = (bsitText, bsitPassword, bsitDateTimeLocal, bsitDate, bsitMonth, bsitTime, bsitWeek, bsitNumber, bsitEmail, bsitUrl, bsitSearch, bsitTel, bsitColor);

  TIWBSInput = class(TIWCustomInput, IIWAutoEditableControl)
  private
    FIsStatic: boolean;
    FAutoFocus: boolean;
    FCaption: string;
    FInputType: TIWBSInputType;
    FPlaceHolder: string;
    FTextAlignment: TIWBSTextAlignment;
    FTextCase: TIWBSTextCase;
    FDataLink: TIWDataLink;
    FDataField: string;
    FDataSource: TDataSource;

    FMainID: string;
    FOldVisible: boolean;
    FOldDisabled: boolean;
    FOldCss: string;
    FOldStyle: string;
    FOldReadOnly: boolean;
    FOldText: string;

    procedure EditingChanged;
    procedure CheckData;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(const Value: TDataSource);
  protected
    procedure InitControl; override;
    procedure Paint; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetValue(const AValue: string); override;
  public
    destructor Destroy; override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  published
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default False;
    property BSTextAlignment: TIWBSTextAlignment read FTextAlignment write FTextAlignment default bstaDefault;
    property BSTextCase: TIWBSTextCase read FTextCase write FTextCase default bstcDefault;
    property BSInputType: TIWBSInputType read FInputType write FInputType default bsitText;
    property Caption: string read FCaption write FCaption;
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property DataField: string read FDataField write SetDataField;
    property Editable default True;
    property Enabled default True;
    property MaxLength default 0;
    property PlaceHolder: string read FPlaceHolder write FPlaceHolder;
    property ReadOnly default False;
    property Text;
  end;

  TIWBSMemo = class(TIWCustomMemo, IIWAutoEditableControl)
  private
    FAutoFocus: boolean;
    FCaption: string;
    FMaxLength: integer;
    FPlaceHolder: string;
    FReadOnly: boolean;
    FRows: integer;
    FTextAlignment: TIWBSTextAlignment;
    FTextCase: TIWBSTextCase;
    FDataLink: TIWDataLink;
    FDataField: string;
    FDataSource: TDataSource;

    FMainID: string;
    FOldVisible: boolean;
    FOldDisabled: boolean;
    FOldCss: string;
    FOldStyle: string;
    FOldReadOnly: boolean;
    FOldText: string;

    procedure EditingChanged;
    procedure CheckData;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(const Value: TDataSource);
  protected
    procedure InitControl; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetValue(const AValue: string); override;
  public
    destructor Destroy; override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  published
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property BSTextAlignment: TIWBSTextAlignment read FTextAlignment write FTextAlignment default bstaDefault;
    property BSTextCase: TIWBSTextCase read FTextCase write FTextCase default bstcDefault;
    property Caption: string read FCaption write FCaption;
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property DataField: string read FDataField write SetDataField;
    property Editable default True;
    property Enabled;
    property MaxLength: integer read FMaxLength write FMaxLength default 0;
    property PlaceHolder: string read FPlaceHolder write FPlaceHolder;
    property ReadOnly: boolean read FReadOnly write FReadOnly default false;
    property Rows: integer read FRows write FRows default 5;
  end;

  TIWBSCheckBox = class(TIWDBCheckBox, IIWAutoEditableControl)
  private
    FAutoFocus: boolean;

    FMainID: string;
    FOldVisible: boolean;
    FOldDisabled: boolean;
    FOldCss: string;
    FOldStyle: string;
    FOldChecked: boolean;
  protected
    procedure InitControl; override;
    procedure CheckData; override;
    procedure EditingChanged;
    procedure SetValue(const AValue: string; out AValueChanged: Boolean); override;
  public
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  published
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property AutoEditable default True;
    property Checked;
    property Confirmation;
    property Enabled;
    property Editable default True;
  end;

  TIWBSRadioButton = class(TIWRadioButton)
  private
    FAutoFocus: boolean;

    FMainID: string;
    FOldVisible: boolean;
    FOldDisabled: boolean;
    FOldCss: string;
    FOldStyle: string;
    FOldChecked: boolean;
  protected
    procedure InitControl; override;
  public
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  published
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property Editable default True;
  end;

  TIWBSListbox = class(TIWDBListBox, IIWAutoEditableControl)
  private
    FAutoFocus: boolean;
    FCaption: string;

    FMainID: string;
    FOldVisible: boolean;
    FOldDisabled: boolean;
    FOldCss: string;
    FOldStyle: string;
    FOldItemIndex: integer;
  protected
    procedure InitControl; override;
    procedure CheckData; override;
    procedure EditingChanged;
  public
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  published
    property AutoEditable default True;
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property Caption: string read FCaption write FCaption;
    property Editable default True;
    property MultiSelect;
  end;

  TIWBSComboBox = class(TIWDBComboBox, IIWAutoEditableControl)
  private
    FAutoFocus: boolean;
    FCaption: string;

    FMainID: string;
    FOldVisible: boolean;
    FOldDisabled: boolean;
    FOldCss: string;
    FOldStyle: string;
    FOldItemIndex: integer;
  protected
    procedure InitControl; override;
    procedure CheckData; override;
    procedure EditingChanged;
  public
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  published
    property AutoEditable default True;
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property Caption: string read FCaption write FCaption;
    property Editable default True;
  end;

  TIWBSRadioGroup = class(TIWDBRadioGroup, IIWAutoEditableControl)
  private
    FAutoFocus: boolean;
    FCaption: string;

    FMainID: string;
    FOldVisible: boolean;
    FOldDisabled: boolean;
    FOldCss: string;
    FOldStyle: string;
    FOldItemIndex: integer;
  protected
    procedure InitControl; override;
    procedure CheckData; override;
    procedure EditingChanged;
    procedure SetValue(const AValue: string; out AValueChanged: Boolean); override;
  public
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  published
    property AutoEditable default True;
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property Caption: string read FCaption write FCaption;
    property Editable default True;
    property Enabled default True;
  end;

  TIWBSButtonStyle = (bsbsDefault, bsbsPrimary, bsbsSuccess, bsbsInfo, bsbsWarning, bsbsDanger, bsbsLink, bsbsClose);
  TIWBSButtonDataDismiss = (bsbdNone, bsbdModal, bsbdAlert);

  TIWBSAsyncClickProc = reference to procedure(EventParams: TStringList);

  TIWBSButton = class(TIWButton)
  private
    FDataDismiss: TIWBSButtonDataDismiss;
    FButtonSize: TIWBSSize;
    FButtonStyle: TIWBSButtonStyle;
    FGlyphicon: string;
    FAsyncClickProc: TIWBSAsyncClickProc;

    FMainID: string;
    FOldVisible: boolean;
    FOldDisabled: boolean;
    FOldCss: string;
    FOldStyle: string;

    procedure DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
    procedure SetAsyncClickProc(Value: TIWBSAsyncClickProc);
    procedure SetGlyphicon(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
    property AsyncClickProc: TIWBSAsyncClickProc read FAsyncClickProc write SetAsyncClickProc;
  published
    property BSButtonSize: TIWBSSize read FButtonSize write FButtonSize default bsszDefault;
    property BSButtonStyle: TIWBSButtonStyle read FButtonStyle write FButtonStyle default bsbsDefault;
    property BSDataDismiss: TIWBSButtonDataDismiss read FDataDismiss write FDataDismiss default bsbdNone;
    property BSGlyphicon: string read FGlyphicon write SetGlyphicon;
  end;

implementation

uses IWColor, IWDBCommon, IWMarkupLanguageTag, IW.Common.System, Graphics,
     IWBSRegionCommon, IWBSUtils, IWBSInputCommon;

{$region 'TIWBSInput'}
const
  aIWBSInputType: array[bsitText..bsitColor] of string = ('text', 'password', 'datetime-local', 'date', 'month', 'time', 'week', 'number', 'email', 'url', 'search', 'tel', 'color');

var
  LFormatSettings: TFormatSettings;

procedure TIWBSInput.InitControl;
begin
  inherited;
  FAutoFocus := False;
  FCaption := '';
  FDataLink := nil;
  FDataField := '';
  FInputType := bsitText;
  FIsStatic := False;
  FTextAlignment := bstaDefault;
  FTextCase := bstcDefault;
end;

destructor TIWBSInput.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited;
end;

procedure TIWBSInput.EditingChanged;
begin
  invalidate;
end;

procedure TIWBSInput.CheckData;

  function GetFieldText(AField: TField): String;
  begin
    if AField.IsBlob then begin
      if Assigned(AField.OnGetText) then begin
        result := AField.Text;
      end else begin
        result := AField.AsString;
      end;
    end
    else begin
      result := AField.Text;
    end;
  end;

var
  LField: TField;
begin
  if FDataSource <> nil then begin
    if CheckDataSource(FDataSource, DataField, LField) then
      begin
        ReadOnly := not InEditMode(FDataSource.Dataset) or not FieldIsEditable(FDataSource, FDataField);
        if Assigned(LField.OnGetText) then
          Text := LField.Text
        else if (FInputType = bsitNumber) and (LField.DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBCD, ftExtended]) then
          Text := FloatToStr(LField.AsExtended, LFormatSettings)
        else if (FInputType = bsitDateTimeLocal) and (LField.DataType in [ftDate, ftTime, ftDateTime, ftTimeStamp, ftOraTimeStamp]) then
          Text := FormatDateTime('yyyy-mm-dd"T"hh:nn',LField.AsDateTime)
        else
          Text := LField.AsString;
      end
    else
      ReadOnly := True;
  end;
end;

procedure TIWBSInput.SetDataField(const AValue: string);
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

procedure TIWBSInput.SetDataSource(const Value: TDataSource);
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

procedure TIWBSInput.Paint;
begin
  if FDataSource <> nil then
    Text := FDataField;
  inherited Paint;
end;

procedure TIWBSInput.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then
    if FDatasource = AComponent then
      SetDataSource(nil);
end;

procedure TIWBSInput.SetValue(const AValue: string);
var
  LField: TField;
begin
  FOldText := AValue;
  inherited SetValue(AValue);
  if CheckDataSource(FDataSource, DataField, LField) then begin
    if AValue <> Text then begin
      if InEditMode(FDataSource.DataSet) and LField.CanModify then
        begin
          if Assigned(LField.OnSetText) then
            LField.Text := AValue
          else if (FInputType = bsitNumber) and (LField.DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBCD, ftExtended]) then
            LField.Value := StrToFloat(AValue, LFormatSettings)
          else if (FInputType = bsitDateTimeLocal) and (LField.DataType in [ftDate, ftTime, ftDateTime, ftTimeStamp, ftOraTimeStamp]) then
            LField.Value := StrToDateTime(ReplaceStr(AValue,'T',' '), LFormatSettings)
          else
            LField.AsString := AValue;
        end
      else
        raise EIWDataSetNotEditingError.Create(FDataSource);
    end;
  end;
end;

function TIWBSInput.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  Result := nil;

  CheckData;
  if FIsStatic then
    begin
      SetAsyncHtml(AContext, xHTMLName, Text, FOldText);
    end
  else
    begin
      SetAsyncDisabled(AContext, xHTMLName, not (Enabled and Editable), FOldDisabled);
      SetAsyncReadOnly(AContext, xHTMLName, ReadOnly, FOldReadOnly);
      SetAsyncText(AContext, xHTMLName, Text, FOldText);
    end;
  SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
  SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
end;

function TIWBSInput.RenderCSSClass(AComponentContext: TIWCompContext): string;
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

function TIWBSInput.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  CheckData;
  FOldVisible := Visible;
  FOldDisabled := not (Enabled and Editable);
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldReadOnly := ReadOnly;
  FOldText := Text;

  if FIsStatic then
    begin
      Result := TIWHTMLTag.CreateTag('p');
      try
        Result.AddClassParam(FOldCss);
        Result.AddStringParam('id', xHTMLName);
        Result.AddStringParam('style', FOldStyle);
        Result.Contents.AddText(TextToHTML(Text));
      except
        FreeAndNil(Result);
        raise;
      end;
    end
  else
    begin
      Result := TIWHTMLTag.CreateTag('input');
      try
        Result.AddClassParam(FOldCss);
        Result.AddStringParam('id', xHTMLName);
        Result.AddStringParam('name', xHTMLName);
        Result.AddStringParam('type', aIWBSInputType[FInputType]);
        if ShowHint and (Hint <> '') then begin
          Result.AddStringParam('data-toggle', 'tooltip');
          Result.AddStringParam('title', Hint);
        end;
        if FAutoFocus then
          Result.Add('autofocus');
        if ReadOnly then
          Result.Add('readonly');
        if FOldDisabled then
          Result.Add('disabled');
        if MaxLength > 0 then
          Result.AddIntegerParam('maxlength', MaxLength);
        Result.AddStringParam('value', TextToHTML(Text));
        if Required then
          Result.Add('required');
        if FPlaceHolder <> '' then
          Result.AddStringParam('placeholder', TextToHTML(FPlaceHolder));
        Result.AddStringParam('style', FOldStyle);
      except
        FreeAndNil(Result);
        raise;
      end;
    end;

  if not (Parent is TIWBSInputGroup) then
    Result := CreateInputFormGroup(Self, Parent, Result, FCaption, xHTMLName);

  // save id of final container to set visibility
  FMainID := Result.Params.Values['id'];
end;

function TIWBSInput.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
{  if toTColor(WebFont.Color) <> clNone then
    Result := Result + 'color:' + ColorToRGBString(WebFont.Color) + ';';
  if toTColor(BGColor) <> clNone then
    result := result + 'background-color: ' + ColorToRGBString(BGColor) + ';';      }
end;
{$endregion}

{$region 'TIWBSMemo'}
procedure TIWBSMemo.InitControl;
begin
  inherited;
  FAutoFocus := False;
  FCaption := '';
  FDataLink := nil;
  FDataField := '';
  FMaxLength := 0;
  FRows := 5;
  FReadOnly := False;
  FTextAlignment := bstaDefault;
  FTextCase := bstcDefault;
end;

destructor TIWBSMemo.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited;
end;

procedure TIWBSMemo.EditingChanged;
begin
  invalidate;
end;

procedure TIWBSMemo.CheckData;
var
  LField: TField;
begin
  if FDataSource <> nil then begin
    if CheckDataSource(FDataSource, DataField, LField) then
      begin
        ReadOnly := not InEditMode(FDataSource.Dataset) or not FieldIsEditable(FDataSource, FDataField);
        Lines.Text := GetFieldText(LField);
      end
    else
      ReadOnly := True;
  end;
end;

procedure TIWBSMemo.SetDataField(const AValue: string);
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

procedure TIWBSMemo.SetDataSource(const Value: TDataSource);
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

procedure TIWBSMemo.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then
    if FDatasource = AComponent then
      SetDataSource(nil);
end;

procedure TIWBSMemo.SetValue(const AValue: string);
var
  LField: TField;
begin
  FOldText := AValue;
  inherited SetValue(AValue);
  if CheckDataSource(FDataSource, DataField, LField) then begin
    if (GetFieldText(LField) <> Text) then begin
      if FEditable then
        FDataSource.Edit;
      if InEditMode(FDataSource.DataSet) and LField.CanModify then
        LField.Text := Text
      else
        raise EIWDataSetNotEditingError.Create(FDataSource);
    end;
  end;
end;

function TIWBSMemo.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  Result := nil;

  CheckData;
  SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
  SetAsyncDisabled(AContext, xHTMLName, not (Enabled and Editable), FOldDisabled);
  SetAsyncReadOnly(AContext, xHTMLName, ReadOnly, FOldReadOnly);
  SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
  SetAsyncText(AContext, xHTMLName, Text, FOldText);
end;

function TIWBSMemo.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'form-control';
  if FTextAlignment <> bstaDefault then
    Result := Result + ' ' + aIWBSTextAlignment[FTextAlignment];
  if FTextCase <> bstcDefault then
    Result := Result + ' ' + aIWBSTextCase[FTextCase];
end;

function TIWBSMemo.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
  s: string;
begin
  xHTMLName := HTMLName;

  CheckData;
  FOldVisible := Visible;
  FOldDisabled := not (Enabled and Editable);
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldReadOnly := ReadOnly;
  FOldText := Text;

  Result := TIWHTMLTag.CreateTag('textarea');
  try
    Result.AddStringParam('id', xHTMLName);
    Result.AddClassParam(FOldCss);
    Result.AddStringParam('name', xHTMLName);
    if ShowHint and (Hint <> '') then begin
      Result.AddStringParam('data-toggle', 'tooltip');
      Result.AddStringParam('title', Hint);
    end;
    if FAutoFocus then
      Result.Add('autofocus');
    if ReadOnly then
      Result.Add('readonly');
    if FOldDisabled then
      Result.Add('disabled');
    if FMaxLength > 0 then
      Result.AddIntegerParam('maxlength', FMaxLength);
    if Required then
      Result.Add('required');
    if FPlaceHolder <> '' then
      Result.AddStringParam('placeholder', TextToHTML(FPlaceHolder));
    Result.AddIntegerParam('rows', FRows);
    Result.AddStringParam('style', FOldStyle);

    s := TextToHTML(Text,false,false);
    if not FEndsWithCRLF and (Length(s) >= Length(sLineBreak)) then
      SetLength(s, Length(s) - Length(sLineBreak));
    Result.Contents.AddText(s);
  except
    FreeAndNil(Result);
    raise;
  end;

  if not (Parent is TIWBSInputGroup) then
    Result := CreateInputFormGroup(Self, Parent, Result, FCaption, HTMLName);

  // save id of final container to set visibility
  FMainID := Result.Params.Values['id'];
end;

function TIWBSMemo.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
  if toTColor(WebFont.Color) <> clNone then
    Result := Result + 'color:' + ColorToRGBString(WebFont.Color) + ';';
  if toTColor(BGColor) <> clNone then
    result := result + 'background-color: ' + ColorToRGBString(BGColor) + ';';
  if not FVertScrollBar then
    Result := Result + 'overflow: hidden;';
  case ResizeDirection of
    rdNone: Result := Result + 'resize:none;';
    rdBoth: Result := Result + 'resize:both;';
    rdVertical: Result := Result + 'resize:vertical;';
    rdHorizontal: Result := Result + 'resize:horizontal;';
  end;
end;
{$endregion}

{$region 'TIWBSCheckBox'}
procedure TIWBSCheckBox.InitControl;
begin
  inherited;
  AutoEditable := True;
  FAutoFocus := False;
end;

procedure TIWBSCheckBox.CheckData;
begin
  if DataSource <> nil then
    inherited;
end;

procedure TIWBSCheckBox.EditingChanged;
begin
  if AutoEditable then
    if CheckDataSource(FDataSource) then
      Enabled := InEditMode(FDataSource.Dataset) and FieldIsEditable(FDataSource, FDataField)
    else
      Enabled := False;
end;

procedure TIWBSCheckBox.SetValue(const AValue: string; out AValueChanged: Boolean);
begin
  FOldChecked := SameText(AValue, 'On');
  inherited;
end;

function TIWBSCheckBox.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName+ '_CHECKBOX';
  Result := nil;

  CheckData;
  SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
  SetAsyncDisabled(AContext, xHTMLName, not (Enabled and Editable), FOldDisabled);
  SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
  SetAsyncChecked(AContext, xHTMLName, Checked, FOldChecked);
end;

function TIWBSCheckBox.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := Css;
end;

function TIWBSCheckBox.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  CheckData;
  FOldVisible := Visible;
  FOldDisabled := not (Enabled and Editable);
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldChecked := Checked;

  Result := TIWHTMLTag.CreateTag('span');
  try
    Result.AddStringParam('id', xHTMLName);
    with Result.Contents.AddTag('input') do begin
      AddClassParam(FOldCss);
      if TabOrderInterface(Self).HasTabOrder then
        AddStringParam('tabindex', IntToStr(TabOrderInterface(Self).RealTabOrder + 1));
      AddStringParam('type', 'checkbox');
      AddStringParam('id', xHTMLName + '_CHECKBOX');
      AddStringParam('name', xHTMLName + '_CHECKBOX');
      if FOldDisabled then
        Add('disabled');
      if Checked then
        Add('checked');
      AddStringParam('style', FOldStyle);
    end;
  except
    FreeAndNil(Result);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, 'addon')
  else
    Result := CreateCheckBoxFormGroup(Parent, Result, 'checkbox', Caption, Hint, xHTMLName, ShowHint);

  // save id of final container to set visibility
  FMainID := Result.Params.Values['id'];
end;

function TIWBSCheckBox.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
end;
{$endregion}

{$region 'TIWBSRadioButton'}
procedure TIWBSRadioButton.InitControl;
begin
  inherited;
  FAutoFocus := False;
end;

function TIWBSRadioButton.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  Result := nil;

  SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
  SetAsyncDisabled(AContext, xHTMLName, not (Enabled and Editable), FOldDisabled);
  SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
  SetAsyncChecked(AContext, xHTMLName, Checked, FOldChecked);
end;

function TIWBSRadioButton.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := Css;
end;

function TIWBSRadioButton.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  FOldVisible := Visible;
  FOldDisabled := not (Enabled and Editable);
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);

  Result := TIWHTMLTag.CreateTag('input');
  try
    Result.AddStringParam('id', xHTMLName+'_CHECKBOX');
    Result.AddClassParam(FOldCss);
    Result.AddStringParam('name', Group);
    Result.AddStringParam('type', 'radio');
    Result.AddStringParam('value', Value);
    if FAutoFocus then
      Result.Add('autofocus');
    if FOldDisabled then
      Result.Add('disabled');
    if Checked then
      Result.Add('checked');
    Result.AddStringParam('style', FOldStyle);
  except
    FreeAndNil(Result);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, 'addon')
  else
    Result := CreateCheckBoxFormGroup(Parent, Result, 'radio', Caption, Hint, xHTMLName, ShowHint);

  // save id of final container to set visibility
  FMainID := Result.Params.Values['id'];
end;

function TIWBSRadioButton.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
end;
{$endregion}

{$region 'TIWBSListbox'}
procedure TIWBSListbox.InitControl;
begin
  inherited;
  AutoEditable := True;
  FAutoFocus := False;
  FCaption := '';
end;

procedure TIWBSListbox.CheckData;
begin
  if DataSource <> nil then
    inherited;
end;

procedure TIWBSListbox.EditingChanged;
begin
  if AutoEditable then
    if CheckDataSource(FDataSource) then
      Enabled := InEditMode(FDataSource.Dataset) and FieldIsEditable(FDataSource, FDataField)
    else
      Enabled := False;
end;

function TIWBSListbox.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  Result := nil;

  CheckData;
  SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
  SetAsyncDisabled(AContext, xHTMLName, not (Enabled and Editable), FOldDisabled);
  SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
  if (ItemIndex <> FOldItemIndex) then begin
    if ItemIndex >= 0 then
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+xHTMLName+' option:eq('+IntToStr(ItemIndex)+')").prop("selected", true);')
    else
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+xHTMLName+' option").prop("selected", false);');
    FOldItemIndex := ItemIndex;
  end;
end;

function TIWBSListbox.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'form-control';
  if Css <> '' then
    Result := Result + Css;
end;

function TIWBSListbox.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  CheckData;
  FOldVisible := Visible;
  FOldDisabled := not (Enabled and Editable);
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldItemIndex := ItemIndex;

  Result := inherited;
  Result.AddStringParam('id', xHTMLName);
  Result.AddClassParam(FOldCss);
  if FAutoFocus then
    Result.Add('autofocus');
  if not (Parent is TIWBSInputGroup) then
    Result := CreateInputFormGroup(Self, Parent, Result, FCaption, xHTMLName);

  // save id of final container to set visibility
  FMainID := Result.Params.Values['id'];
end;

function TIWBSListbox.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
end;
{$endregion}

{$region 'TIWBSComboBox'}
procedure TIWBSComboBox.InitControl;
begin
  inherited;
  AutoEditable := True;
  FAutoFocus := False;
  FCaption := '';
end;

procedure TIWBSComboBox.CheckData;
begin
  if DataSource <> nil then begin
    inherited;
    if CheckDataSource(FDataSource) then
      Enabled := InEditMode(FDataSource.Dataset) and FieldIsEditable(FDataSource, FDataField)
    else
      Enabled := False;
  end;
end;

procedure TIWBSComboBox.EditingChanged;
begin
  if AutoEditable then
    if CheckDataSource(FDataSource) then
      Enabled := InEditMode(FDataSource.Dataset) and FieldIsEditable(FDataSource, FDataField)
    else
      Enabled := False;
end;

function TIWBSComboBox.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  Result := nil;

  CheckData;
  SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
  SetAsyncDisabled(AContext, xHTMLName, not (Enabled and Editable), FOldDisabled);
  SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
  if (ItemIndex <> FOldItemIndex) then begin
    if ItemIndex >= 0 then
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+xHTMLName+' option:eq('+IntToStr(ItemIndex)+')").prop("selected", true);')
    else
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+xHTMLName+' option").prop("selected", false);');
    FOldItemIndex := ItemIndex;
  end;
end;

function TIWBSComboBox.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'form-control';
  if Css <> '' then
    Result := Result + Css;
end;

function TIWBSComboBox.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  CheckData;
  FOldVisible := Visible;
  FOldDisabled := not (Enabled and Editable);
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldItemIndex := ItemIndex;

  Result := inherited;
  Result.AddStringParam('id', xHTMLName);
  Result.AddClassParam(FOldCss);
  if FAutoFocus then
    Result.Add('autofocus');
  if not (Parent is TIWBSInputGroup) then
    Result := CreateInputFormGroup(Self, Parent, Result, FCaption, xHTMLName);

  // save id of final container to set visibility
  FMainID := Result.Params.Values['id'];
end;

function TIWBSComboBox.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
end;
{$endregion}

{$region 'TIWBSRadioGroup'}
procedure TIWBSRadioGroup.InitControl;
begin
  inherited;
  AutoEditable := True;
  FAutoFocus := False;
  FCaption := '';
end;

// I need to use enabled instead of editable because
procedure TIWBSRadioGroup.EditingChanged;
begin
  if AutoEditable then
    if CheckDataSource(FDataSource) then
      Enabled := InEditMode(FDataSource.Dataset) and FieldIsEditable(FDataSource, FDataField)
    else
      Enabled := False;
end;

procedure TIWBSRadioGroup.CheckData;
var
  LField: TField;
  LText: string;
begin
  if FDataSource <> nil then
    if CheckDataSource(FDataSource, DataField, LField) then
      begin
        LText := GetFieldText(LField);
        if TrimValues then
          LText := Trim(LText);
        ItemIndex := Values.IndexOf(LText);
        if AutoEditable then
          Enabled := InEditMode(FDataSource.Dataset) and FieldIsEditable(FDataSource, FDataField);
        if ItemIndex < 0 then
          ItemIndex := Items.IndexOf(LText);
      end
    else
      begin
        ItemIndex := -1;
        if AutoEditable then begin
          Enabled := False;
      end;
    end;
end;

procedure TIWBSRadioGroup.SetValue(const AValue: string; out AValueChanged: Boolean);
begin
  inherited SetValue(AValue, AValueChanged);
  FOldItemIndex := ItemIndex;
end;

function TIWBSRadioGroup.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  Result := nil;

  CheckData;
  SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
  SetAsyncDisabled(AContext, xHTMLName+' input', not (Enabled and Editable), FOldDisabled);
  SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
  if (ItemIndex <> FOldItemIndex) then begin
    if ItemIndex >= 0 then
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+xHTMLName+'_INPUT_'+IntToStr(ItemIndex+1)+'").prop("checked", true);')
    else
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+xHTMLName+' input").prop("checked", false);');
    FOldItemIndex := ItemIndex;
  end;
end;

function TIWBSRadioGroup.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'radio';
  if Css <> '' then
    Result := Result + ' ' + Css;
end;

function TIWBSRadioGroup.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
  i: Integer;
begin
  xHTMLName := HTMLName;

  CheckData;
  FOldVisible := Visible;
  FOldDisabled := not (Enabled and Editable);
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldItemIndex := ItemIndex;

  Result := TIWHTMLTag.CreateTag('div');
  try
    Result.AddStringParam('id', xHTMLName);
    Result.AddClassParam(FOldCss);
    Result.AddStringParam('style', FOldStyle);
    for i := 0 to Items.Count - 1 do begin
      with Result.Contents.AddTag('label') do begin
        with Contents.AddTag('input') do begin
          AddStringParam('type', 'radio');
          Add(iif(ItemIndex = i, 'checked'));
          AddStringParam('name', xHTMLName + '_INPUT');
          AddStringParam('id', xHTMLName + '_INPUT_'+IntToStr(i+1));
          AddStringParam('value', IntToStr(i));
          if FOldDisabled then
            Add('disabled');
        end;
        Contents.AddText(Items.Strings[i]);
      end;
      if Layout = glVertical then
        Result.Contents.AddText('<br>');
    end;
  except
    FreeAndNil(Result);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, 'addon')
  else
    Result := CreateInputFormGroup(Self, Parent, Result, FCaption, xHTMLName);

  // save id of final container to set visibility
  FMainID := Result.Params.Values['id'];
end;

function TIWBSRadioGroup.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
end;
{$endregion}

{$region 'TIWBSButton'}
constructor TIWBSButton.Create(AOwner: TComponent);
begin
  inherited;
  FButtonSize := bsszDefault;
  FButtonStyle := bsbsDefault;
  FDataDismiss := bsbdNone;
  FGlyphicon := '';
end;

function TIWBSButton.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  Result := nil;

  SetAsyncVisible(AContext, FMainID, Visible, FOldVisible);
  SetAsyncDisabled(AContext, xHTMLName, not (Enabled and Editable), FOldDisabled);
  SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
  SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
end;

function TIWBSButton.RenderCSSClass(AComponentContext: TIWCompContext): string;
const
  aIWBSButtonStyle: array[bsbsDefault..bsbsClose] of string = ('btn-default', 'btn-primary', 'btn-success', 'btn-info', 'btn-warning', 'btn-danger', 'btn-link', 'close');
begin
  Result := 'btn';
  if FButtonSize <> bsszDefault then
    Result := Result + ' btn-'+aIWBSSize[FButtonSize];
  Result := Result + ' ' + aIWBSButtonStyle[FButtonStyle];
  if Css <> '' then
    Result := Result + ' ' + Css;
end;

function TIWBSButton.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
const
  aIWBSButtonDataDismiss: array[bsbdNone..bsbdAlert] of string = ('', 'modal', 'alert');
var
  xHTMLName: string;
  s: string;
  gspan: TIWHTMLTag;
begin
  xHTMLName := HTMLName;

  FOldVisible := Visible;
  FOldDisabled := not (Enabled and Editable);
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);

  Result := TIWHTMLTag.CreateTag('button');
  try
    Result.AddStringParam('id', xHTMLName);
    Result.AddClassParam(FOldCss);
    if FDataDismiss <> bsbdNone then
      Result.AddStringParam('data-dismiss', aIWBSButtonDataDismiss[FDataDismiss]);
    Result.AddStringParam('type', 'button');
    if ShowHint and (Hint <> '') then begin
      Result.AddStringParam('data-toggle', 'tooltip');
      Result.AddStringParam('title', Hint);
    end;
    if FOldDisabled then
      Result.Add('disabled');
    s := TextToHTML(Caption);
    if HotKey <> '' then begin
      Result.AddStringParam('accesskey', HotKey);
      s := StringReplace(s, FHotKey, '<u>' + FHotKey + '</u>', [rfIgnoreCase]);
    end;
    if FButtonStyle = bsbsClose then
      Result.AddStringParam('aria-label', 'Close');
    Result.AddStringParam('style', FOldStyle);

    if FGlyphicon <> '' then begin
      gspan := Result.Contents.AddTag('span');
      gspan.AddClassParam('glyphicon glyphicon-'+FGlyphicon);
      gspan.AddBoolParam('aria-hidden',true);
      s := ' '+s;
    end;

    // caption after glyphicon
    if (FButtonStyle = bsbsClose) and (s = '') and (FGlyphicon = '') then
      Result.Contents.AddText('&times;')
    else
      Result.Contents.AddText(s);
  except
    FreeAndNil(Result);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, 'btn')
  else
    Result := CreateFormGroup(Parent, IWBSFindParentInputForm(Parent), Result, xHTMLName, True);

  // save id of final container to set visibility
  FMainID := Result.Params.Values['id'];
end;

function TIWBSButton.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
  if (WebFont.Enabled) then
    Result := Result + WebFont.FontToStringStyle+';';
  if toTColor(WebColor) <> clBtnFace then
    Result := Result + RenderBGColor(WebColor)+';';
end;

procedure TIWBSButton.DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
begin
  FAsyncClickProc(EventParams);
end;

procedure TIWBSButton.SetAsyncClickProc(Value: TIWBSAsyncClickProc);
begin
  FAsyncClickProc := Value;
  OnAsyncClick := DoAsyncClickProc
end;

procedure TIWBSButton.SetGlyphicon(const Value: string);
begin
  FGlyphicon := Value;
  Invalidate;
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
