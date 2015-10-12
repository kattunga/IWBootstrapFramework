unit IWBSInput;

interface

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
    procedure CheckData; override;
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
    procedure InternalRenderStyle(AStyle: TStrings); override;
  public
    destructor Destroy; override;
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
    procedure InitControl; override;
    procedure CheckData; override;
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean); override;
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
    procedure SetChecked(AValue: boolean);
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
    procedure InitControl; override;
    procedure CheckData; override;
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean); override;
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
    procedure SetChecked(AValue: boolean);
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
    FMultiSelect: boolean;
    FSelectedItems: TStringList;
    FSize: integer;
    procedure OnSelectedItemsChange(ASender : TObject);
    procedure SetSelectedItems(AValue: TStringList);
    procedure SetSize(AValue: integer);
  protected
    procedure InitControl; override;
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
  public
    destructor Destroy; override;
  published
    property MultiSelect: boolean read FMultiSelect write FMultiSelect default False;
    property SelectedItems: TStringList read FSelectedItems write SetSelectedItems;
    property Size: integer read FSize write SetSize default 1;
  end;

  TIWBSRadioGroup = class(TIWBSCustomSelectInput)
  protected
    procedure InitControl; override;
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
  end;

implementation

uses IW.Common.System, IWBSUtils, IWBSInputCommon;

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
        if AutoFocus then
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
        if PlaceHolder <> '' then
          Result.AddStringParam('placeholder', TextToHTML(PlaceHolder));
        Result.AddStringParam('style', FOldStyle);
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
  Text := FLines.Text;
  Invalidate;
end;

procedure TIWBSMemo.CheckData;
begin
  inherited;
  FLines.Text := Text;
  Text := FLines.Text;  // this autoadjust linebreaks
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
    Result.AddClassParam(FOldCss);
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
    Result.AddStringParam('style', FOldStyle);
    Result.Contents.AddText(TextToHTML(Text,false,false));
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
  Caption := Name;
end;

procedure TIWBSCheckBox.InitControl;
begin
  inherited;
  FChecked := False;
  FValueChecked := 'true';
  FValueUnchecked := 'false';
  Text := FValueUnchecked;
end;

procedure TIWBSCheckBox.SetChecked(AValue: boolean);
begin
  FChecked := AValue;
  if AValue then
    Text := FValueChecked
  else
    Text := FValueUnchecked;
  Invalidate;
end;

procedure TIWBSCheckBox.CheckData;
begin
  inherited;
  FChecked := Text = FValueChecked;
end;

procedure TIWBSCheckBox.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: boolean);
begin
  if ASubmitValue = 'on' then
    ATextValue := FValueChecked
  else
    ATextValue := FValueUnchecked;
end;

procedure TIWBSCheckBox.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  if Text <> FOldText then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+FInputSuffix+'").prop("checked", '+iif(Checked,'true','false')+');');
    FOldText := Text;
  end;
end;

function TIWBSCheckBox.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('input');
  try
    Result.AddStringParam('id', AHTMLName);
    Result.AddStringParam('name', AHTMLName);
    Result.AddClassParam(FOldCss);
    Result.AddStringParam('type', 'checkbox');
    if IsDisabled then
      Result.Add('disabled');
    if Checked then
      Result.Add('checked');
    Result.AddStringParam('style', FOldStyle);
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
  Caption := Name;
end;

procedure TIWBSRadioButton.InitControl;
begin
  inherited;
  FChecked := False;
  FGroup := 'group';
  FInputSuffix := '_INPUT';
  FSaveUnchecked := True;
  FValueChecked := 'true';
  FValueUnchecked := 'false';
  Text := FValueUnchecked;
end;

procedure TIWBSRadioButton.SetChecked(AValue: boolean);
begin
  FChecked := AValue;
  if AValue then
    Text := FValueChecked
  else
    Text := FValueUnchecked;
  Invalidate;
end;

procedure TIWBSRadioButton.CheckData;
begin
  inherited;
  FChecked := Text = FValueChecked;
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
  if Text <> FOldText then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+FInputSuffix+'").prop("checked", '+iif(Checked,'true','false')+');');
    FOldText := Text;
  end;
end;

function TIWBSRadioButton.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('input');
  try
    Result.AddStringParam('id', AHTMLName+FInputSuffix);
    Result.AddStringParam('name', FGroup);
    Result.AddClassParam(FOldCss);
    Result.AddStringParam('type', 'radio');
    if IsDisabled then
      Result.Add('disabled');
    if FChecked then
      Result.Add('checked');
    Result.AddStringParam('onclick', 'radioButtonClick(event, '''+FGroup+''','''+AHTMLName+FInputSuffix+''');');
    Result.AddStringParam('value', 'on');
    Result.AddStringParam('style', FOldStyle);
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
  FSelectedItems := TStringList.Create;
  FSelectedItems.OnChange := OnSelectedItemsChange;
  FSize := 1;
end;

destructor TIWBSSelect.Destroy;
begin
  FreeAndNil(FSelectedItems);
  inherited;
end;

procedure TIWBSSelect.OnSelectedItemsChange(ASender : TObject);
begin
  Invalidate;
end;

procedure TIWBSSelect.SetSelectedItems(AValue: TStringList);
begin
  FSelectedItems.Assign(AValue);
  Invalidate;
end;

procedure TIWBSSelect.SetSize(AValue: integer);
begin
  FSize := AValue;
  Invalidate;
end;

procedure TIWBSSelect.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  if (Text <> FOldText) then begin
    if ItemIndex >= 0 then
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+AHTMLName+' option:eq('+IntToStr(ItemIndex)+')").prop("selected", true);')
    else
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+AHTMLName+' option").prop("selected", false);');
    FOldText := Text;
  end;
end;

function TIWBSSelect.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
var
  i: Integer;
begin
  Result := TIWHTMLTag.CreateTag('select');
  try
    Result.AddStringParam('id', AHTMLName);
    Result.AddClassParam(FOldCss);
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
        if i = ItemIndex then
          Add('selected');
        Contents.AddText(TextToHTML(iif(ItemsHaveValues, Items.Names[i], Items[i]), false, true));
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
procedure TIWBSRadioGroup.InitControl;
begin
  inherited;
  FInputSelector := ' input';
  FInputSuffix := '_INPUT';
end;

procedure TIWBSRadioGroup.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  if (Text <> FOldText) then begin
    if ItemIndex >= 0 then
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+AHTMLName+'_INPUT_'+IntToStr(ItemIndex)+'").prop("checked", true);')
    else
      AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+AHTMLName+' input").prop("checked", false);');
    FOldText := Text;
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
    Result.AddStringParam('style', FOldStyle);
    for i := 0 to Items.Count - 1 do begin
      with Result.Contents.AddTag('label') do begin
        with Contents.AddTag('input') do begin
          AddStringParam('type', 'radio');
          Add(iif(ItemIndex = i, 'checked'));
          AddStringParam('name', AHTMLName + FInputSuffix);
          AddStringParam('id', AHTMLName + FInputSuffix+'_'+IntToStr(i));
          AddStringParam('value', IntToStr(i));
          if IsDisabled then
            Add('disabled');
        end;
        Contents.AddText(TextToHTML(iif(ItemsHaveValues, Items.Names[i], Items[i]), false, true));
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

end.
