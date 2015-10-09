unit IWBSInput;

interface

uses
  System.SysUtils, System.Classes, IWScriptEvents, data.db, System.StrUtils,
  IWRenderContext, IWHTMLTag, IWXMLTag, IWBaseHTMLControl, IWBaseInterfaces, IWControl,
  IWCompEdit, IWCompMemo, IWCompCheckBox, IWCompRadioButton, IWCompListbox, IWCompButton, IWDBStdCtrls, IWDBExtCtrls,
  IWBSRegion, IWBSCommon, IWBSCustomInput;

type

  TIWBSCustomTextInput = class(TIWBSCustomInput)
  private
    FAutoFocus: boolean;
    FPlaceHolder: string;
    FTextAlignment: TIWBSTextAlignment;
    FTextCase: TIWBSTextCase;
  protected
    procedure InitControl; override;
  public
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
  published
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default False;
    property BSTextAlignment: TIWBSTextAlignment read FTextAlignment write FTextAlignment default bstaDefault;
    property BSTextCase: TIWBSTextCase read FTextCase write FTextCase default bstcDefault;
    property MaxLength default 0;
    property PlaceHolder: string read FPlaceHolder write FPlaceHolder;
    property ReadOnly default False;
    property Text;
  end;

  TIWBSInput = class(TIWBSCustomTextInput)
  protected
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property BSInputType default bsitText;
  end;

  TIWBSMemo = class(TIWBSCustomTextInput)
  private
    FLines: TStrings;
    FRows: integer;
  protected
    procedure InitControl; override;
    procedure CheckData; override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
    procedure InternalRenderStyle(AStyle: TStrings); override;
    procedure SetLines(const AValue: TStrings);
  public
    destructor Destroy; override;
  published
    property Lines: TStrings read FLines write SetLines;
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

{$region 'TIWBSCustomTextInput'}
procedure TIWBSCustomTextInput.InitControl;
begin
  inherited;
  FAutoFocus := False;
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

{$region 'TIWBSInput'}
function TIWBSInput.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
begin
  if FIsStatic then
    begin
      Result := TIWHTMLTag.CreateTag('p');
      try
        Result.AddClassParam(FOldCss);
        Result.AddStringParam('id', AHTMLName);
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
        Result.AddStringParam('id', AHTMLName);
        Result.AddStringParam('name', AHTMLName);
        Result.AddStringParam('type', aIWBSInputType[BSInputType]);
        if ShowHint and (Hint <> '') then begin
          Result.AddStringParam('data-toggle', 'tooltip');
          Result.AddStringParam('title', Hint);
        end;
        if FAutoFocus then
          Result.Add('autofocus');
        if IsReadOnly then
          Result.Add('readonly');
        if IsDisabled then
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
    Result := CreateInputFormGroup(Self, Parent, Result, Caption, AHTMLName);
end;
{$endregion}

{$region 'TIWBSMemo'}
procedure TIWBSMemo.InitControl;
begin
  inherited;
  FLines := TStringList.Create;
  FRows := 5;
  Height := 101;
  Width := 121;
end;

destructor TIWBSMemo.Destroy;
begin
  FLines.Free;
  inherited;
end;

procedure TIWBSMemo.CheckData;
begin
  inherited;
  FLines.Text := Text;
end;

procedure TIWBSMemo.SetLines(const AValue: TStrings);
begin
  FLines.Assign(AValue);
  Invalidate;
end;

function TIWBSMemo.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('textarea');
  try
    Result.AddStringParam('id', AHTMLName);
    Result.AddClassParam(FOldCss);
    Result.AddStringParam('name', AHTMLName);
    if ShowHint and (Hint <> '') then begin
      Result.AddStringParam('data-toggle', 'tooltip');
      Result.AddStringParam('title', Hint);
    end;
    if FAutoFocus then
      Result.Add('autofocus');
    if IsReadOnly then
      Result.Add('readonly');
    if IsDisabled then
      Result.Add('disabled');
    if MaxLength > 0 then
      Result.AddIntegerParam('maxlength', MaxLength);
    if Required then
      Result.Add('required');
    if FPlaceHolder <> '' then
      Result.AddStringParam('placeholder', TextToHTML(FPlaceHolder));
    Result.AddIntegerParam('rows', FRows);
    Result.AddStringParam('style', FOldStyle);
    Result.Contents.AddText(TextToHTML(Text,false,false));
  except
    FreeAndNil(Result);
    raise;
  end;

  if not (Parent is TIWBSInputGroup) then
    Result := CreateInputFormGroup(Self, Parent, Result, Caption, HTMLName);
end;

procedure TIWBSMemo.InternalRenderStyle(AStyle: TStrings);
begin
{  if not FVertScrollBar then
    Result := Result + 'overflow: hidden;';
  case ResizeDirection of
    rdNone: Result := Result + 'resize:none;';
    rdBoth: Result := Result + 'resize:both;';
    rdVertical: Result := Result + 'resize:vertical;';
    rdHorizontal: Result := Result + 'resize:horizontal;';
  end; }
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

end.
