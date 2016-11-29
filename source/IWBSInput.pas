unit IWBSInput;

interface

uses
  SysUtils, Classes, db, StrUtils, Controls,
  IWRenderContext, IWHTMLTag, IWBaseHTMLControl, IWApplication,

  IWBSCommon, IWBSCustomInput;

type

  TIWBSInput = class(TIWBSCustomTextInput)
  protected
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  published
    property InputType default bsitText;
  end;

  TIWBSMemo = class(TIWBSCustomTextInput)
  private
    FLines: TStringList;
    FResizeDirection: TIWBSResizeDirection;
    FRows: integer;
    FVertScrollBar: boolean;
    procedure OnLinesChange(ASender : TObject);
    procedure SetLines(const AValue: TStringList);
  protected
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure InternalRenderStyle(AStyle: TStringList); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetText(const AValue: TCaption); override;
  published
    property Lines: TStringList read FLines write SetLines;
    property ResizeDirection: TIWBSResizeDirection read FResizeDirection write FResizeDirection default bsrdDefault;
    property Rows: integer read FRows write FRows default 5;
    property VertScrollBar: boolean read FVertScrollBar write FVertScrollBar default True;
  end;

  TIWBSCheckBox = class(TIWBSCustomInput)
  private
    FChecked: boolean;
    FValueChecked: string;
    FValueUnchecked: string;
  protected
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean); override;
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure SetChecked(AValue: boolean);
    procedure SetName(const AValue: TComponentName); override;
  public
    procedure SetText(const AValue: TCaption); override;
  published
    constructor Create(AOwner: TComponent); override;
    property Checked: boolean read FChecked write SetChecked default False;
    property ValueChecked: string read FValueChecked write FValueChecked;
    property ValueUnchecked: string read FValueUnchecked write FValueUnchecked;
  end;

  TIWBSRadioButton = class(TIWBSCustomInput)
  private
    FChecked: boolean;
    FGroup: string;
    FSaveUnchecked: boolean;
    FValueChecked: string;
    FValueUnchecked: string;
  protected
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean); override;
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure SetChecked(AValue: boolean);
    procedure SetName(const AValue: TComponentName); override;
    function InputSuffix: string; override;
  public
    procedure SetText(const AValue: TCaption); override;
  published
    constructor Create(AOwner: TComponent); override;
    property Checked: boolean read FChecked write SetChecked default False;
    property SaveUnchecked: boolean read FSaveUnchecked write FSaveUnchecked default True;
    property Group: string read FGroup write FGroup;
    property ValueChecked: string read FValueChecked write FValueChecked;
    property ValueUnchecked: string read FValueUnchecked write FValueUnchecked;
  end;

  TIWBSSelect = class(TIWBSCustomSelectInput)
  private
    FItemsSelected: array of boolean;
    FMultiSelect: boolean;
    FSize: integer;
    procedure ResetItemsSelected;
    procedure SetSize(AValue: integer);
  protected
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean); override;
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure OnItemsChange(ASender : TObject); override;
    procedure SetItemIndex(AValue: integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetText(const AValue: TCaption); override;
  published
    property MultiSelect: boolean read FMultiSelect write FMultiSelect default False;
    property Size: integer read FSize write SetSize default 1;
  end;

  TIWBSRadioGroup = class(TIWBSCustomSelectInput)
  protected
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    function InputSelector: string; override;
    function InputSuffix: string; override;
  end;

implementation

uses IW.Common.System, IWBSInputCommon, IWBSInputForm, IWBSUtils;

{$region 'TIWBSInput'}
procedure TIWBSInput.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  lHTMLTag: TIWHTMLTag;
begin
  inherited;
  if FIsStatic then
    begin
      lHTMLTag := TIWHTMLTag.CreateTag('p');
      try
        lHTMLTag.AddClassParam(ActiveCss);
        lHTMLTag.AddStringParam('id', AHTMLName);
        lHTMLTag.AddStringParam('style', ActiveStyle);
        lHTMLTag.Contents.AddText(TextToHTML(FText));
      except
        FreeAndNil(lHTMLTag);
        raise;
      end;
    end
  else
    begin
      lHTMLTag := TIWHTMLTag.CreateTag('input');
      try
        lHTMLTag.AddClassParam(ActiveCss);
        lHTMLTag.AddStringParam('id', AHTMLName);
        lHTMLTag.AddStringParam('name', AHTMLName);
        lHTMLTag.AddStringParam('type', aIWBSInputType[InputType]);
        if ShowHint and (Hint <> '') then
          lHTMLTag.AddStringParam('title', Hint);
        if AutoFocus then
          lHTMLTag.Add('autofocus');
        if IsReadOnly then
          lHTMLTag.Add('readonly');
        if IsDisabled then
          lHTMLTag.Add('disabled');
        if MaxLength > 0 then
          lHTMLTag.AddIntegerParam('maxlength', MaxLength);
        lHTMLTag.AddStringParam('value', TextToHTML(FText));
        if Required then
          lHTMLTag.Add('required');
        if PlaceHolder <> '' then
          lHTMLTag.AddStringParam('placeholder', TextToHTML(PlaceHolder));
        if TabIndex <> 0 then
          lHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
        lHTMLTag.AddStringParam('style', ActiveStyle);
      except
        FreeAndNil(lHTMLTag);
        raise;
      end;
    end;

  if not (Parent is TIWBSInputGroup) and (InputType <> bsitHidden) then
    AHTMLTag := IWBSCreateInputFormGroup(Self, Parent, lHTMLTag, Caption, AHTMLName)
  else
    AHTMLTag := lHTMLTag;

  if AHTMLTag = lHTMLTag then
    ScriptInsideTag := False;
end;
{$endregion}

{$region 'TIWBSMemo'}
constructor TIWBSMemo.Create(AOwner: TComponent);
begin
  inherited;
  FLines := TStringList.Create;
  FLines.OnChange := OnLinesChange;
  FResizeDirection := bsrdDefault;
  FRows := 5;
  FVertScrollBar := True;
  Height := 101;
  Width := 121;
end;

destructor TIWBSMemo.Destroy;
begin
  FreeAndNil(FLines);
  inherited;
end;

procedure TIWBSMemo.OnLinesChange(ASender : TObject);
begin
  FText := FLines.Text;
  Invalidate;
  if Script.Count > 0 then
    AsyncRefreshControl;
end;

procedure TIWBSMemo.SetLines(const AValue: TStringList);
begin
  FLines.Assign(AValue);
end;

procedure TIWBSMemo.SetText(const AValue: TCaption);
begin
  inherited;
  FLines.Text := FText;
  FText := FLines.Text; // this autoadjust linebreaks
end;

procedure TIWBSMemo.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean);
begin
  FLines.Text := ASubmitValue;
  ATextValue := FLines.Text;
end;

procedure TIWBSMemo.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  lHTMLTag: TIWHTMLTag;
begin
  inherited;
  lHTMLTag := TIWHTMLTag.CreateTag('textarea');
  try
    lHTMLTag.AddStringParam('id', AHTMLName);
    lHTMLTag.AddClassParam(ActiveCss);
    lHTMLTag.AddStringParam('name', AHTMLName);
    if ShowHint and (Hint <> '') then
      lHTMLTag.AddStringParam('title', Hint);
    if AutoFocus then
      lHTMLTag.Add('autofocus');
    if IsReadOnly then
      lHTMLTag.Add('readonly');
    if IsDisabled then
      lHTMLTag.Add('disabled');
    if MaxLength > 0 then
      lHTMLTag.AddIntegerParam('maxlength', MaxLength);
    if Required then
      lHTMLTag.Add('required');
    if PlaceHolder <> '' then
      lHTMLTag.AddStringParam('placeholder', TextToHTML(PlaceHolder));
    lHTMLTag.AddIntegerParam('rows', FRows);
    if TabIndex <> 0 then
      lHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
    lHTMLTag.AddStringParam('style', ActiveStyle);
    lHTMLTag.Contents.AddText(TextToHTML(FText,false,false));
  except
    FreeAndNil(lHTMLTag);
    raise;
  end;

  if not (Parent is TIWBSInputGroup) then
    AHTMLTag := IWBSCreateInputFormGroup(Self, Parent, lHTMLTag, Caption, HTMLName)
  else
    AHTMLTag := lHTMLTag;

  if AHTMLTag = lHTMLTag then
    ScriptInsideTag := False;
end;

procedure TIWBSMemo.InternalRenderStyle(AStyle: TStringList);
begin
  if not FVertScrollBar then
    AStyle.Values['overflow'] := 'hidden';
  if FResizeDirection <> bsrdDefault then
    AStyle.Values['resize'] := aIWBSResizeDirection[FResizeDirection];
end;
{$endregion}

{$region 'TIWBSCheckBox'}
constructor TIWBSCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  FChecked := False;
  FValueChecked := 'true';
  FValueUnchecked := 'false';
  FText := FValueUnchecked;
end;

procedure TIWBSCheckBox.SetName(const AValue: TComponentName);
begin
  if Caption = Name then
    Caption := AValue;
  inherited;
end;

procedure TIWBSCheckBox.SetChecked(AValue: boolean);
begin
  FChecked := AValue;
  if AValue then
    FText := FValueChecked
  else
    FText := FValueUnchecked;
  Invalidate;
end;

procedure TIWBSCheckBox.SetText(const AValue: TCaption);
begin
  inherited;
  FChecked := FText = FValueChecked;
end;

procedure TIWBSCheckBox.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean);
begin
  FChecked := ASubmitValue = 'on';
  if FChecked then
    ATextValue := FValueChecked
  else
    ATextValue := FValueUnchecked;
end;

procedure TIWBSCheckBox.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;
  if FText <> FOldText then begin
    IWBSExecuteAsyncJScript(AApplication, '$("#'+AHTMLName+'").prop("checked", '+iif(Checked,'true','false')+');', False, True);
    FOldText := FText;
  end;
end;

procedure TIWBSCheckBox.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  lHTMLTag: TIWHTMLTag;
begin
  inherited;

  lHTMLTag := TIWHTMLTag.CreateTag('input');
  try
    lHTMLTag.AddStringParam('id', AHTMLName);
    lHTMLTag.AddStringParam('name', AHTMLName);
    lHTMLTag.AddClassParam(ActiveCss);
    lHTMLTag.AddStringParam('type', 'checkbox');
    if IsDisabled then
      lHTMLTag.Add('disabled');
    if Checked then
      lHTMLTag.Add('checked');
    if TabIndex <> 0 then
      lHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
    lHTMLTag.AddStringParam('style', ActiveStyle);
  except
    FreeAndNil(lHTMLTag);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    AHTMLTag := IWBSCreateInputGroupAddOn(lHTMLTag, AHTMLName, 'addon')
  else
    AHTMLTag := IWBSCreateCheckBoxFormGroup(Parent, lHTMLTag, 'checkbox', Caption, Hint, AHTMLName, ShowHint);

  if AHTMLTag = lHTMLTag then
    ScriptInsideTag := False;
end;
{$endregion}

{$region 'TIWBSRadioButton'}
constructor TIWBSRadioButton.Create(AOwner: TComponent);
begin
  inherited;
  FChecked := False;
  FGroup := 'group';
  FSaveUnchecked := True;
  FValueChecked := 'true';
  FValueUnchecked := 'false';
  FText := FValueUnchecked;
end;

function TIWBSRadioButton.InputSuffix: string;
begin
  Result := '_INPUT';
end;

procedure TIWBSRadioButton.SetName(const AValue: TComponentName);
begin
  if Caption = Name then
    Caption := AValue;
  inherited;
end;

procedure TIWBSRadioButton.SetChecked(AValue: boolean);
begin
  FChecked := AValue;
  if AValue then
    FText := FValueChecked
  else
    FText := FValueUnchecked;
  Invalidate;
end;

procedure TIWBSRadioButton.SetText(const AValue: TCaption);
begin
  inherited;
  FChecked := FText = FValueChecked;
end;

procedure TIWBSRadioButton.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean);
begin
  if ASubmitValue = 'on' then
    ATextValue := FValueChecked
  else
    begin
      ATextValue := FValueUnchecked;
      ASetFieldValue := FSaveUnchecked;
    end;
end;

procedure TIWBSRadioButton.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;
  if FText <> FOldText then begin
    IWBSExecuteAsyncJScript(AApplication, '$("#'+AHTMLName+InputSuffix+'").prop("checked", '+iif(Checked,'true','false')+');', False, True);
    FOldText := FText;
  end;
end;

procedure TIWBSRadioButton.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  lHTMLTag: TIWHTMLTag;
begin
  inherited;
  lHTMLTag := TIWHTMLTag.CreateTag('input');
  try
    lHTMLTag.AddStringParam('id', AHTMLName+InputSuffix);
    lHTMLTag.AddStringParam('name', FGroup);
    lHTMLTag.AddClassParam(ActiveCss);
    lHTMLTag.AddStringParam('type', 'radio');
    if IsDisabled then
      lHTMLTag.Add('disabled');
    if FChecked then
      lHTMLTag.Add('checked');
    lHTMLTag.AddStringParam('onclick', 'radioButtonClick(event, '''+FGroup+''','''+AHTMLName+InputSuffix+''');');
    lHTMLTag.AddStringParam('value', 'on');
    if TabIndex <> 0 then
      lHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
    lHTMLTag.AddStringParam('style', ActiveStyle);
  except
    FreeAndNil(lHTMLTag);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    AHTMLTag := IWBSCreateInputGroupAddOn(lHTMLTag, AHTMLName, 'addon')
  else
    AHTMLTag := IWBSCreateCheckBoxFormGroup(Parent, lHTMLTag, 'radio', Caption, Hint, AHTMLName, ShowHint);

  if AHTMLTag = lHTMLTag then
    ScriptInsideTag := False;
end;
{$endregion}

{$region 'TIWBSSelect'}
constructor TIWBSSelect.Create(AOwner: TComponent);
begin
  inherited;
  FMultiSelect := False;
  FSize := 1;
end;

procedure TIWBSSelect.OnItemsChange(ASender : TObject);
begin
  inherited;
  SetLength(FItemsSelected, Items.Count);
  ResetItemsSelected;
  AsyncRefreshControl;
end;

procedure TIWBSSelect.SetItemIndex(AValue: integer);
begin
  if not FMultiSelect and (AValue < 0) and (Items.Count > 0) then
    AValue := 0;
  inherited;
  ResetItemsSelected;
end;

procedure TIWBSSelect.ResetItemsSelected;
var
  i: integer;
begin
  for i := 0 to Length(FItemsSelected)-1 do
    FItemsSelected[i] := false;
  if (FItemIndex >= 0) and (FItemIndex < Length(FItemsSelected)) then
    FItemsSelected[FItemIndex] := True;
end;

procedure TIWBSSelect.SetSize(AValue: integer);
begin
  FSize := AValue;
  Invalidate;
end;

procedure TIWBSSelect.SetText(const AValue: TCaption);
var
  LSelectedVal: TStringList;
  i, j: integer;
begin
  FText := AValue;
  if FMultiSelect and AnsiContainsStr(FText,',') then
    begin
      ResetItemsSelected;
      LSelectedVal := TStringList.Create;
      try
        LSelectedVal.StrictDelimiter := True;
        LSelectedVal.CommaText := FText;
        for i := 0 to LSelectedVal.Count-1 do
          for j := 0 to Items.Count-1 do
            if AnsiSameStr(IfThen(ItemsHaveValues, Items.ValueFromIndex[j], Items[j]), LSelectedVal[i]) then
              FItemsSelected[j] := True;
      finally
        LSelectedVal.Free;
      end;
    end
  else
    begin
      FItemIndex := FindValue(FText);
      if not FMultiSelect and (FItemIndex < 0) and (Items.Count > 0) then begin
        FItemIndex := 0;
        FText := IfThen(ItemsHaveValues, Items.ValueFromIndex[FItemIndex], Items[FItemIndex]);
      end;
      ResetItemsSelected;
    end;
  Invalidate;
end;

procedure TIWBSSelect.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean);
var
  LSelectedIdx, LSelectedVal: TStringList;
  i, v: integer;
begin
  if FMultiSelect and AnsiContainsStr(ASubmitValue,',') then
    begin
      FItemIndex := -1;
      ResetItemsSelected;
      LSelectedIdx := TStringList.Create;
      LSelectedVal := TStringList.Create;
      try
        LSelectedIdx.CommaText := ASubmitValue;
        for i := 0 to LSelectedIdx.Count-1 do
          if TryStrToInt(LSelectedIdx[i], v) and (v >= 0) and (v < Items.Count) then begin
            if i = 0 then
              FItemIndex := v
            else if ItemsHaveValues then
              LSelectedVal.Add(Items.ValueFromIndex[v])
            else
              LSelectedVal.Add(Items[v]);
            FItemsSelected[v] := True;
          end;
        LSelectedVal.StrictDelimiter := True;
        ATextValue := LSelectedVal.CommaText;
      finally
        LSelectedIdx.Free;
        LSelectedVal.Free;
      end;
    end
  else
    begin
      inherited InternalSetValue(ASubmitValue, ATextValue, ASetFieldValue);
      ResetItemsSelected;
    end;
end;

procedure TIWBSSelect.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
var
  LSelectedIdx: string;
  i: integer;
begin
  inherited;
  if (FText <> FOldText) then begin
    LSelectedIdx := '';
    if FMultiSelect then
      begin
        for i := 0 to Length(FItemsSelected)-1 do
          if FItemsSelected[i] then begin
            if LSelectedIdx <> '' then
              LSelectedIdx := LSelectedIdx + ',';
            LSelectedIdx := LSelectedIdx + IntToStr(i);
          end;
      end
    else if FItemIndex >= 0 then
      LSelectedIdx := IntToStr(FItemIndex);
    IWBSExecuteAsyncJScript(AApplication, '$("#'+AHTMLName+'").val(['+LSelectedIdx+']);', False, True);
    FOldText := FText;
  end;
end;

procedure TIWBSSelect.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  i: Integer;
  lHTMLTag: TIWHTMLTag;
begin
  inherited;
  lHTMLTag := TIWHTMLTag.CreateTag('select');
  try
    lHTMLTag.AddStringParam('id', AHTMLName);
    lHTMLTag.AddClassParam(ActiveCss);
    lHTMLTag.AddStringParam('name', AHTMLName);
    if FSize > 0 then
      lHTMLTag.AddIntegerParam('size', FSize)
    else
      lHTMLTag.AddIntegerParam('size', Items.Count);
    if FMultiSelect then
      lHTMLTag.Add('multiple');
    if IsDisabled then
      lHTMLTag.Add('disabled');
    if AutoFocus then
      lHTMLTag.Add('autofocus');
    if TabIndex <> 0 then
      lHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
    for i := 0 to Items.Count - 1 do begin
      with lHTMLTag.Contents.AddTag('option') do begin
        AddStringParam('value', IntToStr(i));
        if FItemsSelected[i] then
          Add('selected');
        Contents.AddText(TextToHTML(iif(ItemsHaveValues, Items.Names[i], Items[i])));
      end;
    end;
  except
    FreeAndNil(lHTMLTag);
    raise;
  end;

  if not (Parent is TIWBSInputGroup) then
    AHTMLTag := IWBSCreateInputFormGroup(Self, Parent, lHTMLTag, Caption, AHTMLName)
  else
    AHTMLTag := lHTMLTag;

  if AHTMLTag = lHTMLTag then
    ScriptInsideTag := False;
end;
{$endregion}

{$region 'TIWBSRadioGroup'}
function TIWBSRadioGroup.InputSelector: string;
begin
  Result := ' input';
end;

function TIWBSRadioGroup.InputSuffix: string;
begin
  Result := '_INPUT';
end;

procedure TIWBSRadioGroup.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;
  if (FText <> FOldText) then begin
    if FItemIndex >= 0 then
      IWBSExecuteAsyncJScript(AApplication, '$("#'+AHTMLName+'_INPUT_'+IntToStr(FItemIndex)+'").prop("checked", true);', False, True)
    else
      IWBSExecuteAsyncJScript(AApplication, '$("#'+AHTMLName+' input").prop("checked", false);', False, True);
    FOldText := FText;
  end;
end;

procedure TIWBSRadioGroup.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  i: Integer;
  lHTMLTag: TIWHTMLTag;
begin
  inherited;
  lHTMLTag := TIWHTMLTag.CreateTag('div');
  try
    lHTMLTag.AddStringParam('id', AHTMLName);
    lHTMLTag.AddClassParam('radio');
    if TabIndex <> 0 then
      lHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
    lHTMLTag.AddStringParam('style', ActiveStyle);
    for i := 0 to Items.Count - 1 do begin
      with lHTMLTag.Contents.AddTag('label') do begin
        with Contents.AddTag('input') do begin
          AddStringParam('type', 'radio');
          Add(iif(FItemIndex = i, 'checked'));
          AddStringParam('name', AHTMLName + InputSuffix);
          AddStringParam('id', AHTMLName + InputSuffix+'_'+IntToStr(i));
          AddStringParam('value', IntToStr(i));
          if IsDisabled then
            Add('disabled');
        end;
        Contents.AddText(TextToHTML(iif(ItemsHaveValues, Items.Names[i], Items[i])));
      end;
      lHTMLTag.Contents.AddText('<br>');
    end;
  except
    FreeAndNil(lHTMLTag);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    AHTMLTag := IWBSCreateInputGroupAddOn(lHTMLTag, AHTMLName, 'addon')
  else
    AHTMLTag := IWBSCreateInputFormGroup(Self, Parent, lHTMLTag, Caption, AHTMLName);

  if AHTMLTag = lHTMLTag then
    ScriptInsideTag := False;
end;
{$endregion}

end.
