unit IWBSInput;

interface

{$I IWBSConfig.inc}

uses
  System.SysUtils, System.Classes, data.db, System.StrUtils, Vcl.Controls,
  IWRenderContext, IWHTMLTag, IWXMLTag, IWBaseHTMLControl, IWBaseInterfaces,
  IWCompCheckBox, IWCompRadioButton, IWCompButton, IWDBStdCtrls, IWDBExtCtrls,
  IWBSRegion, IWBSCommon, IWBSCustomInput;

type

  TIWBSInput = class(TIWBSCustomTextInput)
  protected
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property BSInputType default bsitText;
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
    procedure InitControl; override;
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
    procedure InternalRenderStyle(AStyle: TStrings); override;
  public
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
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
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
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
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
    procedure InitControl; override;
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean); override;
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
    procedure OnItemsChange(ASender : TObject); override;
    procedure SetItemIndex(AValue: integer); override;
  public
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    procedure SetText(const AValue: TCaption); override;
  published
    property MultiSelect: boolean read FMultiSelect write FMultiSelect default False;
    property Size: integer read FSize write SetSize default 1;
  end;

  TIWBSRadioGroup = class(TIWBSCustomSelectInput)
  protected
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
    function InputSelector: string; override;
    function InputSuffix: string; override;
  end;

implementation

uses IW.Common.System, IWBSUtils, IWBSInputCommon, IWBSLayoutMgr;

{$region 'TIWBSInput'}
function TIWBSInput.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
begin
  if FIsStatic then
    begin
      Result := TIWHTMLTag.CreateTag('p');
      try
        Result.AddClassParam(ActiveCss);
        Result.AddStringParam('id', AHTMLName);
        Result.AddStringParam('style', ActiveStyle);
        Result.Contents.AddText(TextToHTML(FText));
      except
        FreeAndNil(Result);
        raise;
      end;
    end
  else
    begin
      Result := TIWHTMLTag.CreateTag('input');
      try
        Result.AddClassParam(ActiveCss);
        Result.AddStringParam('id', AHTMLName);
        Result.AddStringParam('name', AHTMLName);
        Result.AddStringParam('type', aIWBSInputType[BSInputType]);
        if ShowHint and (Hint <> '') then begin
          Result.AddStringParam('data-toggle', 'tooltip');
          Result.AddStringParam('title', Hint);
        end;
        if AutoFocus then
          Result.Add('autofocus');
        if IsReadOnly then
          Result.Add('readonly');
        if IsDisabled then
          Result.Add('disabled');
        if MaxLength > 0 then
          Result.AddIntegerParam('maxlength', MaxLength);
        Result.AddStringParam('value', TextToHTML(FText));
        if Required then
          Result.Add('required');
        if PlaceHolder <> '' then
          Result.AddStringParam('placeholder', TextToHTML(PlaceHolder));
        Result.AddStringParam('style', ActiveStyle);
      except
        FreeAndNil(Result);
        raise;
      end;
    end;

  if not (Parent is TIWBSInputGroup) and (BSInputType <> bsitHidden) then
    Result := IWBSCreateInputFormGroup(Self, Parent, Result, Caption, AHTMLName);
end;
{$endregion}

{$region 'TIWBSMemo'}
procedure TIWBSMemo.InitControl;
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
  Invalidate;
end;

procedure TIWBSMemo.SetLines(const AValue: TStringList);
begin
  FLines.Assign(AValue);
  FText := FLines.Text;
  Invalidate;
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

function TIWBSMemo.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('textarea');
  try
    Result.AddStringParam('id', AHTMLName);
    Result.AddClassParam(ActiveCss);
    Result.AddStringParam('name', AHTMLName);
    if ShowHint and (Hint <> '') then begin
      Result.AddStringParam('data-toggle', 'tooltip');
      Result.AddStringParam('title', Hint);
    end;
    if AutoFocus then
      Result.Add('autofocus');
    if IsReadOnly then
      Result.Add('readonly');
    if IsDisabled then
      Result.Add('disabled');
    if MaxLength > 0 then
      Result.AddIntegerParam('maxlength', MaxLength);
    if Required then
      Result.Add('required');
    if PlaceHolder <> '' then
      Result.AddStringParam('placeholder', TextToHTML(PlaceHolder));
    Result.AddIntegerParam('rows', FRows);
    Result.AddStringParam('style', ActiveStyle);
    Result.Contents.AddText(TextToHTML(FText,false,false));
  except
    FreeAndNil(Result);
    raise;
  end;

  if not (Parent is TIWBSInputGroup) then
    Result := IWBSCreateInputFormGroup(Self, Parent, Result, Caption, HTMLName);
end;

procedure TIWBSMemo.InternalRenderStyle(AStyle: TStrings);
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
  inherited;
  Caption := Name;
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

procedure TIWBSCheckBox.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  if FText <> FOldText then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").prop("checked", '+iif(Checked,'true','false')+');');
    FOldText := FText;
  end;
end;

function TIWBSCheckBox.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('input');
  try
    Result.AddStringParam('id', AHTMLName);
    Result.AddStringParam('name', AHTMLName);
    Result.AddClassParam(ActiveCss);
    Result.AddStringParam('type', 'checkbox');
    if IsDisabled then
      Result.Add('disabled');
    if Checked then
      Result.Add('checked');
    Result.AddStringParam('style', ActiveStyle);
  except
    FreeAndNil(Result);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, AHTMLName, 'addon')
  else
    Result := IWBSCreateCheckBoxFormGroup(Parent, Result, 'checkbox', Caption, Hint, AHTMLName, ShowHint);
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
  inherited;
  Caption := Name;
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

procedure TIWBSRadioButton.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  if FText <> FOldText then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+InputSuffix+'").prop("checked", '+iif(Checked,'true','false')+');');
    FOldText := FText;
  end;
end;

function TIWBSRadioButton.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('input');
  try
    Result.AddStringParam('id', AHTMLName+InputSuffix);
    Result.AddStringParam('name', FGroup);
    Result.AddClassParam(ActiveCss);
    Result.AddStringParam('type', 'radio');
    if IsDisabled then
      Result.Add('disabled');
    if FChecked then
      Result.Add('checked');
    Result.AddStringParam('onclick', 'radioButtonClick(event, '''+FGroup+''','''+AHTMLName+InputSuffix+''');');
    Result.AddStringParam('value', 'on');
    Result.AddStringParam('style', ActiveStyle);
  except
    FreeAndNil(Result);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, AHTMLName, 'addon')
  else
    Result := IWBSCreateCheckBoxFormGroup(Parent, Result, 'radio', Caption, Hint, AHTMLName, ShowHint);
end;
{$endregion}

{$region 'TIWBSSelect'}
procedure TIWBSSelect.InitControl;
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
end;

procedure TIWBSSelect.SetItemIndex(AValue: integer);
begin
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

procedure TIWBSSelect.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
var
  LSelectedIdx: string;
  i: integer;
begin
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
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+AHTMLName+'").val(['+LSelectedIdx+']);');
    FOldText := FText;
  end;
{$IFDEF IWBSBOOTSTRAPSELECT}
  AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+AHTMLName+'").selectpicker("refresh");');
{$ENDIF}
end;

function TIWBSSelect.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'form-control';
{$IFDEF IWBSBOOTSTRAPSELECT}
  if FSize = 1 then
    Result := Result + ' selectpicker';
{$ENDIF}
  if Css <> '' then
    Result := Result + ' ' + Css;
end;

function TIWBSSelect.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
var
  i: Integer;
begin
  Result := TIWHTMLTag.CreateTag('select');
  try
    Result.AddStringParam('id', AHTMLName);
    Result.AddClassParam(ActiveCss);
    Result.AddStringParam('name', AHTMLName);
    if FSize > 0 then
      Result.AddIntegerParam('size', FSize)
    else
      Result.AddIntegerParam('size', Items.Count);
    if FMultiSelect then
      Result.Add('multiple');
    if IsDisabled then
      Result.Add('disabled');
    if AutoFocus then
      Result.Add('autofocus');
    for i := 0 to Items.Count - 1 do begin
      with Result.Contents.AddTag('option') do begin
        AddStringParam('value', IntToStr(i));
        if FItemsSelected[i] then
          Add('selected');
        Contents.AddText(TextToHTML(iif(ItemsHaveValues, Items.Names[i], Items[i])));
      end;
    end;
  except
    FreeAndNil(Result);
    raise;
  end;

  if not (Parent is TIWBSInputGroup) then
    Result := IWBSCreateInputFormGroup(Self, Parent, Result, Caption, AHTMLName);
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

procedure TIWBSRadioGroup.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  if (FText <> FOldText) then begin
    if FItemIndex >= 0 then
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+AHTMLName+'_INPUT_'+IntToStr(FItemIndex)+'").prop("checked", true);')
    else
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+AHTMLName+' input").prop("checked", false);');
    FOldText := FText;
  end;
end;

function TIWBSRadioGroup.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
var
  i: Integer;
begin
  Result := TIWHTMLTag.CreateTag('div');
  try
    Result.AddStringParam('id', AHTMLName);
    Result.AddClassParam('radio');
    Result.AddStringParam('style', ActiveStyle);
    for i := 0 to Items.Count - 1 do begin
      with Result.Contents.AddTag('label') do begin
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
      Result.Contents.AddText('<br>');
    end;
  except
    FreeAndNil(Result);
    raise;
  end;

  if Parent is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, AHTMLName, 'addon')
  else
    Result := IWBSCreateInputFormGroup(Self, Parent, Result, Caption, AHTMLName);
end;
{$endregion}

{$IFDEF IWBSBOOTSTRAPSELECT}
initialization
  TIWBSLayoutMgr.AddLinkFile('/<iwbspath>/select/dist/css/bootstrap-select.min.css');
  TIWBSLayoutMgr.AddLinkFile('/<iwbspath>/select/dist/js/bootstrap-select.min.js');
{$ENDIF}

end.
