unit IWBSInput;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, IWVCLBaseControl, IWScriptEvents, data.db, System.StrUtils,
  IWRenderContext, IWHTMLTag, IWXMLTag, IWBaseHTMLControl, IWBaseInterfaces, IWControl,
  IWCompEdit, IWCompMemo, IWCompCheckBox, IWCompRadioButton, IWCompListbox, IWCompButton, IWDBStdCtrls, IWDBExtCtrls,
  IWBSRegion, IWBSCommon;

type
  TIWBSInputType = (bsitText, bsitPassword, bsitDateTimeLocal, bsitDate, bsitMonth, bsitTime, bsitWeek, bsitNumber, bsitEmail, bsitUrl, bsitSearch, bsitTel, bsitColor);

  TIWBSInput = class(TIWCustomEdit, IIWAutoEditableControl)
  private
    FAutoFocus: boolean;
    FCaption: string;
    FInputType: TIWBSInputType;
    FPlaceHolder: string;
    FTextAlignment: TIWBSTextAlignment;
    FTextCase: TIWBSTextCase;
    FDataLink: TIWDataLink;
    FDataField: string;
    FDataSource: TDataSource;

    FOldDisabled: boolean;
    FOldReadOnly: boolean;
    FOldStyle: string;
    FOldText: string;

    procedure EditingChanged;
    procedure CheckData;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(const Value: TDataSource);
  protected
    procedure InitControl; override;
    procedure Paint; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function StyleValue(AContext: TIWCompContext): string; virtual;
    procedure SetValue(const AValue: string); override;
  public
    destructor Destroy; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
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
    property PlaceHolder: string read FPlaceHolder write FPlaceHolder;
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

    FOldDisabled: boolean;
    FOldReadOnly: boolean;
    FOldStyle: string;
    FOldText: string;

    procedure EditingChanged;
    procedure CheckData;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(const Value: TDataSource);
  protected
    procedure InitControl; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    procedure SetValue(const AValue: string); override;
    function StyleValue(AContext: TIWCompContext): string; virtual;
  public
    destructor Destroy; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
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

  TIWBSCheckBox = class(TIWDBCheckBox)
  private
    FAutoFocus: boolean;
  protected
    procedure InitControl; override;
    procedure CheckData; override;
  public
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
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
  protected
    procedure InitControl; override;
  public
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property Editable default True;
  end;

  TIWBSListbox = class(TIWDBListBox)
  private
    FAutoFocus: boolean;
    FCaption: string;
  protected
    procedure InitControl; override;
    procedure CheckData; override;
  public
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property AutoEditable default True;
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property Caption: string read FCaption write FCaption;
    property Editable default True;
    property MultiSelect;
  end;

  TIWBSComboBox = class(TIWDBComboBox)
  private
    FAutoFocus: boolean;
    FCaption: string;
  protected
    procedure InitControl; override;
    procedure CheckData; override;
  public
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property AutoEditable default True;
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property Caption: string read FCaption write FCaption;
    property Editable default True;
  end;

  TIWBSRadioGroup = class(TIWDBRadioGroup)
  private
    FAutoFocus: boolean;
    FCaption: string;

    FOldDisabled: boolean;
    FOldItemIndex: integer;
  protected
    procedure InitControl; override;
    procedure CheckData; override;
  public
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property AutoEditable default True;
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property Caption: string read FCaption write FCaption;
    property Editable default True;
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
    procedure DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
    procedure SetAsyncClickProc(Value: TIWBSAsyncClickProc);
    procedure SetGlyphicon(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    property AsyncClickProc: TIWBSAsyncClickProc read FAsyncClickProc write SetAsyncClickProc;
  published
    property BSButtonSize: TIWBSSize read FButtonSize write FButtonSize default bsszDefault;
    property BSButtonStyle: TIWBSButtonStyle read FButtonStyle write FButtonStyle default bsbsDefault;
    property BSDataDismiss: TIWBSButtonDataDismiss read FDataDismiss write FDataDismiss default bsbdNone;
    property BSGlyphicon: string read FGlyphicon write SetGlyphicon;
  end;

  TIWBSInputGroup = class(TIWBSCustomRegion)
  private
    FCaption: string;
    FRelativeSize: TIWBSRelativeSize;
  public
    constructor Create(AOwner: TComponent); override;
    function GetClassString: string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Caption: string read FCaption write FCaption;
    property BSRelativeSize: TIWBSRelativeSize read FRelativeSize write FRelativeSize default bsrzDefault;
  end;

implementation

uses IWColor, IWDBCommon, IWMarkupLanguageTag, IW.Common.System, Graphics,
     IWBSRegionCommon, IWBSUtils;

{$region 'help functions'}
procedure SetAsyncDisabled(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").prop("disabled", '+IIF(Value,'true','false')+');');
    OldValue := Value;
  end;
end;

procedure SetAsyncReadOnly(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").prop("readonly", '+IIF(Value,'true','false')+');');
    OldValue := Value;
  end;
end;

procedure SetAsyncText(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").val("'+TIWBaseHTMLControl.TextToJSStringLiteral(Value)+'");');
    OldValue := Value;
  end;
end;

procedure SetAsyncStyle(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").prop("style", "'+Value+'");');
    OldValue := Value;
  end;
end;

function CreateFormGroup(AParent: TControl; AParentForm: TIWBSInputForm; ATag: TIWHTMLTag; const AHTMLName: string; ASpanDiv: boolean): TIWHTMLTag;
var
  LSpanDiv: TIWHTMLTag;
begin
  if (AParentForm <> nil) and not ((AParent is TIWBSRegion) and (TIWBSRegion(AParent).BSRegionType in [bsrtFormGroup,bsrtButtonGroup])) then
    begin
      Result := TIWHTMLTag.CreateTag('div');
      Result.AddClassParam('form-group');
      Result.AddStringParam('id',AHTMLName+'_FG');
      Result.AddStringParam('name',AHTMLName+'_FG');
      if ASpanDiv and (AParentForm.BSFormType = bsftHorizontal) then
        begin
          LSpanDiv := Result.Contents.AddTag('div');
          LSpanDiv.AddClassParam(AParentForm.BSFormOptions.GetOffsetClassString);
          LSpanDiv.Contents.AddTagAsObject(aTag);
        end
      else
        Result.Contents.AddTagAsObject(aTag);
    end
  else
    Result := ATag;
end;

function CreateInputFormGroup(AParent: TControl; ATag: TIWHTMLTag; const ACaption, AHTMLName: string): TIWHTMLTag;
var
  lablTag, editTag: TIWHTMLTag;
  ParentForm: TIWBSInputForm;
begin
  ParentForm := IWBSFindParentInputForm(AParent);
  if ACaption <> '' then
    begin
      Result := TIWHTMLTag.CreateTag('div');
      try
        Result.AddClassParam('form-group');
        Result.AddStringParam('id',AHTMLName+'_FG');
        Result.AddStringParam('name',AHTMLName+'_FG');
        lablTag := Result.Contents.AddTag('label');
        lablTag.AddClassParam('control-label');
        lablTag.AddStringParam('for', AHTMLName);
        lablTag.Contents.AddText(TIWBaseHTMLControl.TextToHTML(ACaption));
        if (ParentForm <> nil) and (ParentForm.BSFormType = bsftHorizontal) then
          begin
            lablTag.AddClassParam(ParentForm.BSFormOptions.CaptionsSize.GetClassString);
            editTag := Result.Contents.AddTag('div');
            editTag.AddClassParam(ParentForm.BSFormOptions.InputsSize.GetClassString);
            editTag.Contents.AddTagAsObject(aTag);
          end
        else
          Result.Contents.AddTagAsObject(ATag);
      except
        FreeAndNil(Result);
        FreeAndNil(ATag);
        raise;
      end;
    end
  else
    Result := CreateFormGroup(AParent, ParentForm, ATag, AHTMLName, True);
end;

function CreateCheckBoxFormGroup(AParent: TControl; ATag: TIWHTMLTag; const ACss, ACaption, AHint, AHTMLName: string; AShowHint: boolean): TIWHTMLTag;
var
  lablTag: TIWHTMLTag;
  ParentForm: TIWBSInputForm;
begin
  ParentForm := IWBSFindParentInputForm(AParent);
  Result := TIWHTMLTag.CreateTag('div');
  try
    if (ParentForm <> nil) and (ParentForm.BSFormType = bsftInline) then
      Result.AddClassParam(ACss+'-inline')
    else
      Result.AddClassParam(ACss);
    if (ParentForm <> nil) and (ParentForm.BSFormType = bsftHorizontal) then
      Result.AddClassParam(ParentForm.BSFormOptions.GetOffsetClassString);
    lablTag := Result.Contents.AddTag('label');
    lablTag.AddStringParam('id', AHTMLName+'_CHKBCAPTION');
    if AShowHint and (AHint <> '') then begin
      lablTag.AddStringParam('data-toggle', 'tooltip');
      lablTag.AddStringParam('title', AHint);
    end;
    lablTag.Contents.AddTagAsObject(ATag);
    lablTag.Contents.AddText(TIWBaseHTMLControl.TextToHTML(ACaption));

    Result := CreateFormGroup(AParent, ParentForm, Result, AHTMLName, False);
  except
    FreeAndNil(Result);
    FreeAndNil(ATag);
    raise;
  end;
end;
{$endregion}

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
  if CheckDataSource(FDataSource, DataField, LField) then begin
    if AValue <> Text then begin
      if FEditable then
        FDataSource.Edit;
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
  inherited SetValue(AValue);
  FOldText := AValue;
end;

function TIWBSInput.StyleValue(AContext: TIWCompContext): string;
begin
  Result := '';
  if toTColor(WebFont.Color) <> clNone then
    Result := Result + 'color:' + ColorToRGBString(WebFont.Color) + ';';
  if toTColor(BGColor) <> clNone then
    result := result + 'background-color: ' + ColorToRGBString(BGColor) + ';';
end;

function TIWBSInput.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  Result := nil;

  CheckData;
  SetAsyncDisabled(AContext, xHTMLName, not (Enabled and Editable), FOldDisabled);
  SetAsyncReadOnly(AContext, xHTMLName, ReadOnly, FOldReadOnly);
  SetAsyncStyle(AContext, xHTMLName, StyleValue(AContext), FOldStyle);
  SetAsyncText(AContext, xHTMLName, Text, FOldText);
end;

function TIWBSInput.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'form-control';
  if FTextAlignment <> bstaDefault then
    Result := Result + ' ' + aIWBSTextAlignment[FTextAlignment];
  if FTextCase <> bstcDefault then
    Result := Result + ' ' + aIWBSTextCase[FTextCase];
end;

function TIWBSInput.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
  xStyleVal: string;
begin
  xHTMLName := HTMLName;
  xStyleVal := StyleValue(AContext);

  CheckData;
  Result := TIWHTMLTag.CreateTag('input');
  try
    Result.AddClassParam(RenderCSSClass(AContext));
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
    if not (Enabled and Editable) then
      Result.Add('disabled');
    if MaxLength > 0 then
      Result.AddIntegerParam('maxlength', MaxLength);
    Result.AddStringParam('value', TextToHTML(Text));
    if Required then
      Result.Add('required');
    if FPlaceHolder <> '' then
      Result.AddStringParam('placeholder', TextToHTML(FPlaceHolder));
    Result.AddStringParam('style', xStyleVal);
  except
    FreeAndNil(Result);
    raise;
  end;

  if not (Parent is TIWBSInputGroup) then
    Result := CreateInputFormGroup(Parent, Result, FCaption, xHTMLName);

  FOldDisabled := not (Enabled and Editable);
  FOldReadOnly := ReadOnly;
  FOldStyle := xStyleVal;
  FOldText := Text;
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

function TIWBSMemo.StyleValue(AContext: TIWCompContext): string;
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

function TIWBSMemo.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  Result := nil;

  CheckData;
  SetAsyncDisabled(AContext, xHTMLName, not (Enabled and Editable), FOldDisabled);
  SetAsyncReadOnly(AContext, xHTMLName, ReadOnly, FOldReadOnly);
  SetAsyncStyle(AContext, xHTMLName, StyleValue(AContext), FOldStyle);
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
  xStyleVal: string;
  s: string;
begin
  xHTMLName := HTMLName;
  xStyleVal := StyleValue(AContext);

  CheckData;
  Result := TIWHTMLTag.CreateTag('textarea');
  try
    Result.AddStringParam('id', xHTMLName);
    Result.AddClassParam(RenderCSSClass(AContext));
    Result.AddStringParam('name', xHTMLName);
    if ShowHint and (Hint <> '') then begin
      Result.AddStringParam('data-toggle', 'tooltip');
      Result.AddStringParam('title', Hint);
    end;
    if FAutoFocus then
      Result.Add('autofocus');
    if ReadOnly then
      Result.Add('readonly');
    if not Enabled or not Editable then
      Result.Add('disabled');
    if FMaxLength > 0 then
      Result.AddIntegerParam('maxlength', FMaxLength);
    if Required then
      Result.Add('required');
    if FPlaceHolder <> '' then
      Result.AddStringParam('placeholder', TextToHTML(FPlaceHolder));
    Result.AddIntegerParam('rows', FRows);
    Result.AddStringParam('style', StyleValue(AContext));

    s := TextToHTML(Text,false,false);
    if not FEndsWithCRLF and (Length(s) >= Length(sLineBreak)) then
      SetLength(s, Length(s) - Length(sLineBreak));
    Result.Contents.AddText(s);
  except
    FreeAndNil(Result);
    raise;
  end;

  if not (Parent is TIWBSInputGroup) then
    Result := CreateInputFormGroup(Parent, Result, FCaption, HTMLName);

  FOldDisabled := not (Enabled and Editable);
  FOldReadOnly := ReadOnly;
  FOldStyle := xStyleVal;
  FOldText := Text;
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
  if DataSource <> nil then begin
    inherited;
    if CheckDataSource(FDataSource) then
      Editable := InEditMode(FDataSource.Dataset) and FieldIsEditable(FDataSource, FDataField)
    else
      Editable := False;
  end;
end;

function TIWBSCheckBox.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xEnabled: boolean;
begin
  CheckData;
  Result := TIWXMLTag.CreateTag('control');
  try
    Result.AddStringParam('id', HTMLName);
    Result.AddStringParam('type', 'IWCHECKBOX');
    RenderAsyncCommonProperties(AContext,  Result, [acpVisible]);
    RenderAsyncProperty('checked', Result, Checked);
    xEnabled := Enabled and Editable;
    RenderAsyncProperty('enabled', Result, xEnabled);
  except
    FreeAndNil(Result);
  end;
end;

function TIWBSCheckBox.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := '';
end;

function TIWBSCheckBox.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  CheckData;
  Result := TIWHTMLTag.CreateTag('span');
  try
    xHTMLName := HTMLName;
    Result.AddStringParam('id', xHTMLName);
    with Result.Contents.AddTag('input') do begin
      if TabOrderInterface(Self).HasTabOrder then
        AddStringParam('tabindex', IntToStr(TabOrderInterface(Self).RealTabOrder + 1));
      AddStringParam('type', 'checkbox');
      AddStringParam('id', xHTMLName + '_CHECKBOX');
      AddStringParam('name', xHTMLName + '_CHECKBOX');
//      AddStringParam('OnClick', 'checkBoxClick(event, ''' + xHTMLName + ''');');
      if not Enabled or not Editable then
        Add('disabled');
      if Checked then
        Add('checked');
    end;
  except
    FreeAndNil(Result);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, 'addon')
  else
    Result := CreateCheckBoxFormGroup(Parent, Result, 'checkbox', Caption, Hint, xHTMLName, ShowHint);
end;
{$endregion}

{$region 'TIWBSRadioButton'}
procedure TIWBSRadioButton.InitControl;
begin
  inherited;
  FAutoFocus := False;
end;

function TIWBSRadioButton.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  Result := TIWHTMLTag.CreateTag('input');
  try
    Result.AddStringParam('id', xHTMLName+'_CHECKBOX');
    Result.AddStringParam('name', Group);
    Result.AddStringParam('type', 'radio');
    Result.AddStringParam('value', Value);
    if FAutoFocus then
      Result.Add('autofocus');
    if not Enabled or not Editable then
      Result.Add('disabled');
    if Checked then
      Result.Add('checked');
  except
    FreeAndNil(Result);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, 'addon')
  else
    Result := CreateCheckBoxFormGroup(Parent, Result, 'radio', Caption, Hint, xHTMLName, ShowHint);
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
  if DataSource <> nil then begin
    inherited;
    if CheckDataSource(FDataSource) then
      Editable := InEditMode(FDataSource.Dataset) and FieldIsEditable(FDataSource, FDataField)
    else
      Editable := False;
  end;
end;

function TIWBSListbox.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'form-control';
end;

function TIWBSListbox.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  Result := inherited;
  Result.AddStringParam('id', xHTMLName);
  Result.AddClassParam(RenderCSSClass(AContext));
  if FAutoFocus then
    Result.Add('autofocus');
  if not (Parent is TIWBSInputGroup) then
    Result := CreateInputFormGroup(Parent, Result, FCaption, xHTMLName);
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
      Editable := InEditMode(FDataSource.Dataset) and FieldIsEditable(FDataSource, FDataField)
    else
      Editable := False;
  end;
end;

function TIWBSComboBox.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'form-control';
end;

function TIWBSComboBox.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  Result := inherited;
  Result.AddStringParam('id', xHTMLName);
  Result.AddClassParam(RenderCSSClass(AContext));
  if FAutoFocus then
    Result.Add('autofocus');
  if not (Parent is TIWBSInputGroup) then
    Result := CreateInputFormGroup(Parent, Result, FCaption, xHTMLName);
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

procedure TIWBSRadioGroup.CheckData;
begin
  if DataSource <> nil then begin
    inherited;
    if CheckDataSource(FDataSource) then
      Editable := InEditMode(FDataSource.Dataset) and FieldIsEditable(FDataSource, FDataField)
    else
      Editable := False;
  end;
end;

function TIWBSRadioGroup.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;
  Result := nil;

  CheckData;
  SetAsyncDisabled(AContext, xHTMLName+' > input', not (Enabled and Editable), FOldDisabled);
  if ItemIndex <> FOldItemIndex then begin
    if ItemIndex >= 0 then
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+xHTMLName+'_INPUT_'+IntToStr(ItemIndex+1)+'").prop("checked", true);')
    else
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+xHTMLName+' > input").prop("checked", false);');
    FOldItemIndex := ItemIndex;
  end;
end;

function TIWBSRadioGroup.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'form-control';
end;

function TIWBSRadioGroup.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  Result := inherited;
  Result.AddStringParam('id', xHTMLName);
  Result.AddClassParam('radio-inline');

  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, 'addon')
  else
    Result := CreateInputFormGroup(Parent, Result, FCaption, xHTMLName);

  FOldDisabled  := not (Enabled and Editable);
  FOldItemIndex := ItemIndex;
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

function TIWBSButton.RenderCSSClass(AComponentContext: TIWCompContext): string;
const
  aIWBSButtonStyle: array[bsbsDefault..bsbsClose] of string = ('btn-default', 'btn-primary', 'btn-success', 'btn-info', 'btn-warning', 'btn-danger', 'btn-link', 'close');
begin
  Result := 'btn';
  if FButtonSize <> bsszDefault then
    Result := Result + ' btn-'+aIWBSSize[FButtonSize];
  Result := Result + ' ' + aIWBSButtonStyle[FButtonStyle];
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

  Result := TIWHTMLTag.CreateTag('button');
  try
    Result.AddStringParam('id', xHTMLName);
    Result.AddClassParam(RenderCSSClass(AContext));
    if FDataDismiss <> bsbdNone then
      Result.AddStringParam('data-dismiss', aIWBSButtonDataDismiss[FDataDismiss]);
    Result.AddStringParam('type', 'button');
    if ShowHint and (Hint <> '') then begin
      Result.AddStringParam('data-toggle', 'tooltip');
      Result.AddStringParam('title', Hint);
    end;
    if not Enabled then
      Result.Add('disabled');
    s := TextToHTML(Caption);
    if HotKey <> '' then begin
      Result.AddStringParam('accesskey', HotKey);
      s := StringReplace(s, FHotKey, '<u>' + FHotKey + '</u>', [rfIgnoreCase]);
    end;
    if FButtonStyle = bsbsClose then
      Result.AddStringParam('aria-label', 'Close');

    if (WebFont.Enabled) and (toTColor(WebColor) <> clBtnFace) then
      Result.AddStringParam('style', RenderBGColor(WebColor) + WebFont.FontToStringStyle);

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

{$region 'TIWBSInputGroup'}
constructor TIWBSInputGroup.Create(AOwner: TComponent);
begin
  inherited;
  FRelativeSize := bsrzDefault;
end;

function TIWBSInputGroup.GetClassString: string;
var
  s: string;
begin
  Result := 'input-group';
  if FRelativeSize <> bsrzDefault then
    Result := Result + ' input-group-'+aIWBSRelativeSize[FRelativeSize];
  s := inherited;
  if s <> '' then
    Result := Result + ' ' + s;
end;

function TIWBSInputGroup.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result.AddClassParam(GetClassString);
  Result := CreateInputFormGroup(Parent, Result, FCaption, HTMLName);
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
