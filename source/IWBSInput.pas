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
    FLines: TStrings;
    FRows: integer;
  protected
    procedure InitControl; override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
    procedure InternalRenderStyle(AStyle: TStrings); override;
    procedure SetLines(const AValue: TStrings);
  public
    destructor Destroy; override;
    procedure SetText(const AValue: TCaption); override;
  published
    property Lines: TStrings read FLines write SetLines;
    property Rows: integer read FRows write FRows default 5;
  end;

  TIWBSCheckBox = class(TIWBSCustomTextInput)
  private
    FChecked: boolean;
    FValueChecked: string;
    FValueUnchecked: string;
  protected
    procedure InitControl; override;
    procedure CheckData; override;
//    procedure SetValue(const AValue: string; out AValueChanged: Boolean); override;
  public
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Checked: boolean read FChecked write FChecked default False;
    property ValueChecked: string read FValueChecked write FValueChecked;
    property ValueUnchecked: string read FValueUnchecked write FValueUnchecked;
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

  TIWBSSelect = class(TIWBSCustomSelectInput)
  private
    FMultiSelect: boolean;
    FSize: integer;
  protected
    procedure InitControl; override;
    procedure InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext); override;
    function InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag; override;
    procedure SetSize(AValue: integer);
  published
    property MultiSelect: boolean read FMultiSelect write FMultiSelect default False;
    property Size: integer read FSize write SetSize default 1;
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

implementation

uses IWDBCommon, IWMarkupLanguageTag, IW.Common.System,
     IWBSRegionCommon, IWBSUtils, IWBSInputCommon;

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

  if not (Parent is TIWBSInputGroup) then
    Result := IWBSCreateInputFormGroup(Self, Parent, Result, Caption, AHTMLName);
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

procedure TIWBSMemo.SetText(const AValue: TCaption);
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
  FChecked := False;
  FValueChecked := 'true';
  FValueUnchecked := 'true';
end;

procedure TIWBSCheckBox.CheckData;
begin
  inherited;
end;
{
procedure TIWBSCheckBox.SetValue(const AValue: string; out AValueChanged: Boolean);
begin
  FChecked := SameText(AValue, 'On');
  inherited;
end;
}
procedure TIWBSCheckBox.InternalRenderAsync(const AHTMLName: string; AContext: TIWCompContext);
begin
  inherited;
end;

function TIWBSCheckBox.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := Css;
end;

function TIWBSCheckBox.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext): TIWHTMLTag;
begin
 // FOldChecked := Checked;

  Result := TIWHTMLTag.CreateTag('span');
  try
    Result.AddStringParam('id', AHTMLName);
    with Result.Contents.AddTag('input') do begin
      AddClassParam(FOldCss);
      if TabOrderInterface(Self).HasTabOrder then
        AddStringParam('tabindex', IntToStr(TabOrderInterface(Self).RealTabOrder + 1));
      AddStringParam('type', 'checkbox');
      AddStringParam('id', AHTMLName + '_CHECKBOX');
      AddStringParam('name', AHTMLName + '_CHECKBOX');
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
    Result := IWBSCreateCheckBoxFormGroup(Parent, Result, 'checkbox', Caption, Hint, AHTMLName, ShowHint);
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
    Result := IWBSCreateCheckBoxFormGroup(Parent, Result, 'radio', Caption, Hint, xHTMLName, ShowHint);

  // save id of final container to set visibility
  FMainID := Result.Params.Values['id'];
end;

function TIWBSRadioButton.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
end;
{$endregion}

{$region 'TIWBSSelect'}
procedure TIWBSSelect.InitControl;
begin
  inherited;
  FMultiSelect := False;
  FSize := 1;
end;

procedure  TIWBSSelect.SetSize(AValue: integer);
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
    Result := IWBSCreateInputFormGroup(Self, Parent, Result, FCaption, xHTMLName);

  // save id of final container to set visibility
  FMainID := Result.Params.Values['id'];
end;

function TIWBSRadioGroup.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
end;
{$endregion}

end.
