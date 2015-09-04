unit IWBSInput;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, IWVCLBaseControl, IWScriptEvents,
  IWRenderContext, IWHTMLTag, IWXMLTag,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWCompMemo, IWCompCheckBox, IWCompRadioButton, IWCompListbox, IWCompButton,
  IWBSRegion, IWBSCommon;

type
  TIWBSInputType = (bsitText, bsitPassword, bsitDateTime, bsitDateTimeLocal, bsitDate, bsitMonth, bsitTime, bsitWeek, bsitNumber, bsitEmail, bsitUrl, bsitSearch, bsitTel, bsitColor);

  TIWBSInput = class(TIWCustomEdit)
  private
    FAutoFocus: boolean;
    FCaption: string;
    FInputType: TIWBSInputType;
    FPlaceHolder: string;
    FTextAlignment: TIWBSTextAlignment;
    FTextCase: TIWBSTextCase;
    function StyleValue(AContext: TIWCompContext): string;
  protected
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  published
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property BSTextAlignment: TIWBSTextAlignment read FTextAlignment write FTextAlignment default bstaDefault;
    property BSTextCase: TIWBSTextCase read FTextCase write FTextCase default bstcDefault;
    property Caption: string read FCaption write FCaption;
    property InputType: TIWBSInputType read FInputType write FInputType default bsitText;
    property PlaceHolder: string read FPlaceHolder write FPlaceHolder;
  end;

  TIWBSMemo = class(TIWCustomMemo)
  private
    FAutoFocus: boolean;
    FCaption: string;
    FMaxLength: integer;
    FPlaceHolder: string;
    FReadOnly: boolean;
    FRows: integer;
    FTextAlignment: TIWBSTextAlignment;
    FTextCase: TIWBSTextCase;
    function StyleValue(AContext: TIWCompContext): string;
  protected
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  published
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property BSTextAlignment: TIWBSTextAlignment read FTextAlignment write FTextAlignment default bstaDefault;
    property BSTextCase: TIWBSTextCase read FTextCase write FTextCase default bstcDefault;
    property Caption: string read FCaption write FCaption;
    property Enabled;
    property MaxLength: integer read FMaxLength write FMaxLength default 0;
    property PlaceHolder: string read FPlaceHolder write FPlaceHolder;
    property ReadOnly: boolean read FReadOnly write FReadOnly default false;
    property Rows: integer read FRows write FRows default 5;
  end;

  TIWBSCheckBox = class(TIWCheckBox)
  private
    FAutoFocus: boolean;
    FInline: boolean;
    FReadOnly: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property BSInline: boolean read FInline write FInline default false;
    property ReadOnly: boolean read FReadOnly write FReadOnly default false;
  end;

  TIWBSRadioButton = class(TIWRadioButton)
  private
    FAutoFocus: boolean;
    FReadOnly: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property AutoFocus: boolean read FAutoFocus write FAutoFocus default false;
    property ReadOnly: boolean read FReadOnly write FReadOnly default false;
  end;

  TIWBSListbox = class(TIWListbox)
  private
    FAutoFocus: boolean;
    FCaption: string;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Caption: string read FCaption write FCaption;
  end;

  TIWBSComboBox = class(TIWComboBox)
  private
    FAutoFocus: boolean;
    FCaption: string;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Caption: string read FCaption write FCaption;
  end;

  TIWBSButtonStyle = (bsbsDefault, bsbsPrimary, bsbsSuccess, bsbsInfo, bsbsWarning, bsbsDanger, bsbsLink, bsbsClose);
  TIWBSButtonDataDismiss = (bsbdNone, bsbdModal, bsbdAlert);

  TIWBSButton = class(TIWButton)
  private
    FDataDismiss: TIWBSButtonDataDismiss;
    FButtonSize: TIWBSSize;
    FButtonStyle: TIWBSButtonStyle;
    FGlyphicon: string;
    FAsyncClickProc: TIWBSAsyncClickProc;
    procedure DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
    procedure SetAsyncClickProc(Value: TIWBSAsyncClickProc);
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    property AsyncClickProc: TIWBSAsyncClickProc read FAsyncClickProc write SetAsyncClickProc;
  published
    property BSButtonSize: TIWBSSize read FButtonSize write FButtonSize default bsszDefault;
    property BSButtonStyle: TIWBSButtonStyle read FButtonStyle write FButtonStyle default bsbsDefault;
    property BSDataDismiss: TIWBSButtonDataDismiss read FDataDismiss write FDataDismiss default bsbdNone;
    property BSGlyphicon: string read FGlyphicon write FGlyphicon;
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

uses IWBaseInterfaces, IWColor, Graphics, IWBSRegionCommon, IWBSUtils;

{$region 'help functions'}
function CreateButtonFormGroup(AParentContainer: IIWBaseContainer; ATag: TIWHTMLTag; const AHTMLName: string): TIWHTMLTag;
var
  LTag: TIWHTMLTag;
begin
  if (AParentContainer.InterfaceInstance is TIWBSCustomRegion) and (TIWBSCustomRegion(AParentContainer.InterfaceInstance).BSFormType <> bsftNoForm) then
    begin
      Result := TIWHTMLTag.CreateTag('div');
      Result.AddClassParam('form-group');
      Result.AddStringParam('id',AHTMLName+'_FG');
      if TIWBSCustomRegion(AParentContainer.InterfaceInstance).BSFormType = bsftHorizontal then
        begin
          LTag := Result.Contents.AddTag('div');
          LTag.AddClassParam(TIWBSCustomRegion(AParentContainer.InterfaceInstance).BSFormOptions.GetOffsetClassString);
          LTag.Contents.AddTagAsObject(aTag);
        end
      else
        Result.Contents.AddTagAsObject(aTag);
    end
  else
    Result := ATag;
end;

function CreateInputFormGroup(AParentContainer: IIWBaseContainer; ATag: TIWHTMLTag; const ACaption, AHTMLName: string): TIWHTMLTag;
var
  lablTag, editTag: TIWHTMLTag;
begin
  if ACaption <> '' then
    begin
      Result := TIWHTMLTag.CreateTag('div');
      try
        Result.AddClassParam('form-group');
        Result.AddStringParam('id',AHTMLName+'_FG');
        lablTag := Result.Contents.AddTag('label');
        lablTag.AddClassParam('control-label');
        lablTag.AddStringParam('for', AHTMLName);
        lablTag.Contents.AddText(TIWBaseHTMLControl.TextToHTML(ACaption));
        if (AParentContainer.InterfaceInstance is TIWBSCustomRegion) and (TIWBSCustomRegion(AParentContainer.InterfaceInstance).BSFormType = bsftHorizontal) then
          begin
            lablTag.AddClassParam(TIWBSCustomRegion(AParentContainer.InterfaceInstance).BSFormOptions.CaptionsSize.GetClassString);
            editTag := Result.Contents.AddTag('div');
            editTag.AddClassParam(TIWBSCustomRegion(AParentContainer.InterfaceInstance).BSFormOptions.InputsSize.GetClassString);
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
    Result := CreateButtonFormGroup(AParentContainer, ATag, AHTMLName);
end;

function CreateCheckBoxLabel(AParentContainer: IIWBaseContainer; Tag: TIWHTMLTag; const css, Caption, Hint, HTMLName: string; ShowHint: boolean): TIWHTMLTag;
var
  lablTag: TIWHTMLTag;
begin
  if Caption <> '' then
    begin
      Result := TIWHTMLTag.CreateTag('div');
      try
        Result.AddClassParam(css);
        if (AParentContainer.InterfaceInstance is TIWBSCustomRegion) and (TIWBSCustomRegion(AParentContainer.InterfaceInstance).BSFormType = bsftHorizontal) then
          Result.AddClassParam(TIWBSCustomRegion(AParentContainer.InterfaceInstance).BSFormOptions.GetOffsetClassString);

        lablTag := Result.Contents.AddTag('label');
        lablTag.AddStringParam('id', HTMLName+'_CHKBCAPTION');
        if ShowHint and (Hint <> '') then begin
          lablTag.AddStringParam('data-toggle', 'tooltip');
          lablTag.AddStringParam('title', Hint);
        end;
        lablTag.Contents.AddTagAsObject(Tag);
        lablTag.Contents.AddText(TIWBaseHTMLControl.TextToHTML(Caption));
      except
        FreeAndNil(Result);
        FreeAndNil(Tag);
        raise;
      end;
    end
  else
    Result := Tag;
end;
{$endregion}

{$region 'TIWBSInput'}
const
  aIWBSInputType: array[bsitText..bsitColor] of string = ('text', 'password', 'datetime', 'datetime-local', 'date', 'month', 'time', 'week', 'number', 'email', 'url', 'search', 'tel', 'color');

constructor TIWBSInput.Create(AOwner: TComponent);
begin
  inherited;
  FAutoFocus := False;
  FCaption := '';
  FInputType := bsitText;
  FTextAlignment := bstaDefault;
  FTextCase := bstcDefault;
end;

function TIWBSInput.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
begin
  Result := TIWXMLTag.CreateTag('control');
  try
    Result.AddStringParam('id', HTMLName);
    Result.AddStringParam('type', aIWBSInputType[FInputType]);
    RenderAsyncProperty('readonly', Result, ReadOnly);
    RenderAsyncProperty('enabled', Result, Enabled);
    RenderAsyncPropertyAsString('text', Result, Text, false);
    RenderAsyncPropertyAsString('maxlength', Result, IntToStr(MaxLength), true);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TIWBSInput.StyleValue(AContext: TIWCompContext): string;
begin
  Result := HTMLControlImplementation.RenderStyle(AContext);
  if toTColor(WebFont.Color) <> clNone then
    Result := Result + 'color:' + ColorToRGBString(WebFont.Color) + ';';
  if StyleRenderOptions.RenderBorder and (FControlBorderWidth > 0) then
    Result := Result + 'border: ' + IntToStr(FControlBorderWidth) + 'px inset;';
end;

function TIWBSInput.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  Result := TIWHTMLTag.CreateTag('input');
  try
    Result.AddClassParam('form-control');
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
    if not Enabled then
      Result.Add('disabled');
    if MaxLength > 0 then
      Result.AddIntegerParam('maxlength', MaxLength);
    Result.AddStringParam('value', TextToHTML(Text));
    if Required then
      Result.Add('required');
    if FPlaceHolder <> '' then
      Result.AddStringParam('placeholder', TextToHTML(FPlaceHolder));
    if FTextAlignment <> bstaDefault then
      Result.AddClassParam(aIWBSTextAlignment[FTextAlignment]);
    if FTextCase <> bstcDefault then
      Result.AddClassParam(aIWBSTextCase[FTextCase]);
    Result.AddStringParam('style', StyleValue(AContext));
  except
    FreeAndNil(Result);
    raise;
  end;
  Result := CreateInputFormGroup(ParentContainer, Result, FCaption, xHTMLName);
end;

function TIWBSInput.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
end;
{$endregion}

{$region 'TIWBSMemo'}
constructor TIWBSMemo.Create(AOwner: TComponent);
begin
  inherited;
  FAutoFocus := False;
  FCaption := '';
  FMaxLength := 0;
  FRows := 5;
  FReadOnly := False;
  FTextAlignment := bstaDefault;
  FTextCase := bstcDefault;
end;

function TIWBSMemo.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  s: string;
begin
  Result := TIWXMLTag.CreateTag('control');
  try
    Result.AddStringParam('id', HTMLName);
    Result.AddStringParam('type', 'iwbsmemo');
    RenderAsyncProperty('autofocus', Result, FAutoFocus);
    RenderAsyncProperty('readonly', Result, ReadOnly);
    RenderAsyncProperty('disabled', Result, not Enabled);
    RenderAsyncPropertyAsString('maxlength', Result, IntToStr(FMaxLength), true);
    RenderAsyncProperty('required', Result, Required);
    RenderAsyncPropertyAsString('placeholder', Result, TextToHTML(FPlaceHolder), true);
    RenderAsyncPropertyAsString('rows', Result, IntToStr(FRows), true);
    RenderAsyncPropertyAsString('style', Result, StyleValue(AContext), True);
    with Result.Contents.AddTag('text') do begin
      S := TextToHTML(Text, false, false);
      if not FEndsWithCRLF and (Length(S) >= Length(sLineBreak)) then
        SetLength(S, Length(S) - Length(sLineBreak));
      Contents.AddText(S);
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TIWBSMemo.StyleValue(AContext: TIWCompContext): string;
begin
  Result := HTMLControlImplementation.RenderStyle(AContext);
  if toTColor(BGColor) <> clNone then
    result := result + 'background-color: ' + ColorToRGBString(BGColor) + ';';
  if not FVertScrollBar then
    Result := Result + 'overflow: hidden;';
  if FInvisibleBorder then
    Result := Result + 'border-style: none;'
  else if StyleRenderOptions.RenderBorder and (FControlBorderWidth <> 0) then
    Result := Result + 'border: ' + IntToStr(FControlBorderWidth) + 'px inset;';
  case ResizeDirection of
    rdNone: Result := Result + 'resize:none;';
    rdBoth: Result := Result + 'resize:both;';
    rdVertical: Result := Result + 'resize:vertical;';
    rdHorizontal: Result := Result + 'resize:horizontal;';
  end;
end;

function TIWBSMemo.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
  s: string;
begin
  xHTMLName := HTMLName;

  Result := TIWHTMLTag.CreateTag('textarea');
  try
    Result.AddStringParam('id', xHTMLName);
    Result.AddClassParam('form-control');
    Result.AddStringParam('name', xHTMLName);
    if ShowHint and (Hint <> '') then begin
      Result.AddStringParam('data-toggle', 'tooltip');
      Result.AddStringParam('title', Hint);
    end;
    if FAutoFocus then
      Result.Add('autofocus');
    if ReadOnly then
      Result.Add('readonly');
    if not Enabled then
      Result.Add('disabled');
    if FMaxLength > 0 then
      Result.AddIntegerParam('maxlength', FMaxLength);
    if Required then
      Result.Add('required');
    if FPlaceHolder <> '' then
      Result.AddStringParam('placeholder', TextToHTML(FPlaceHolder));
    if FTextAlignment <> bstaDefault then
      Result.AddClassParam(aIWBSTextAlignment[FTextAlignment]);
    if FTextCase <> bstcDefault then
      Result.AddClassParam(aIWBSTextCase[FTextCase]);
    Result.AddIntegerParam('rows', FRows);
    Result.AddStringParam('style', StyleValue(AContext));

    s := TextToHTML(Text,false,false);
    if not FEndsWithCRLF and (Length(S) >= Length(sLineBreak)) then
      SetLength(S, Length(S) - Length(sLineBreak));
    Result.Contents.AddText(s);
  except
    FreeAndNil(Result);
    raise;
  end;
  Result := CreateInputFormGroup(ParentContainer, Result, FCaption, HTMLName);
end;

function TIWBSMemo.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
end;
{$endregion}

{$region 'TIWBSCheckBox'}
constructor TIWBSCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  FAutoFocus := False;
  FInline := False;
end;

function TIWBSCheckBox.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  Result := TIWHTMLTag.CreateTag('input');
  try
    Result.AddStringParam('id', xHTMLName+'_CHECKBOX');
    Result.AddStringParam('name', xHTMLName+'_CHECKBOX');
    Result.AddStringParam('type', 'checkbox');
    Result.AddStringParam('value', 'on');
    if FAutoFocus then
      Result.Add('autofocus');
    if ReadOnly then
      Result.Add('readonly');
    if not Enabled then
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
    if FInline then
      Result := CreateCheckBoxLabel(ParentContainer, Result, 'checkbox-inline', Caption, Hint, xHTMLName, ShowHint)
    else
      Result := CreateCheckBoxLabel(ParentContainer, Result, 'checkbox', Caption, Hint, xHTMLName, ShowHint);
end;
{$endregion}

{$region 'TIWBSRadioButton'}
constructor TIWBSRadioButton.Create(AOwner: TComponent);
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
    if ReadOnly then
      Result.Add('readonly');
    if not Enabled then
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
    Result := CreateCheckBoxLabel(ParentContainer, Result, 'radio', Caption, Hint, xHTMLName, ShowHint);
end;
{$endregion}

{$region 'TIWBSListbox'}
constructor TIWBSListbox.Create(AOwner: TComponent);
begin
  inherited;
  FAutoFocus := False;
  FCaption := '';
end;

function TIWBSListbox.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result.AddClassParam('form-control');
  Result := CreateInputFormGroup(ParentContainer, Result, FCaption, HTMLName);
end;
{$endregion}

{$region 'TIWBSComboBox'}
constructor TIWBSComboBox.Create(AOwner: TComponent);
begin
  inherited;
  FAutoFocus := False;
  FCaption := '';
end;

function TIWBSComboBox.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result.AddClassParam('form-control');
  Result := CreateInputFormGroup(ParentContainer, Result, FCaption, HTMLName);
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

function TIWBSButton.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
const
  aIWBSButtonStyle: array[bsbsDefault..bsbsClose] of string = ('btn-default', 'btn-primary', 'btn-success', 'btn-info', 'btn-warning', 'btn-danger', 'btn-link', 'close');
  aIWBSButtonDataDismiss: array[bsbdNone..bsbdAlert] of string = ('', 'modal', 'alert');
var
  s: string;
  gspan: TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('button');
  try
    Result.AddStringParam('id', HTMLName);
    Result.AddClassParam('btn');
    if FButtonSize <> bsszDefault then
      Result.AddClassParam('btn-'+aIWBSSize[FButtonSize]);
    Result.AddClassParam(aIWBSButtonStyle[FButtonStyle]);
    if not Enabled then
      Result.AddClassParam('disabled');
    if FDataDismiss <> bsbdNone then
      Result.AddStringParam('data-dismiss', aIWBSButtonDataDismiss[FDataDismiss]);
    Result.AddStringParam('type', 'button');
    if ShowHint and (Hint <> '') then begin
      Result.AddStringParam('data-toggle', 'tooltip');
      Result.AddStringParam('title', Hint);
    end;
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

  if ParentContainer.InterfaceInstance is TIWBSInputGroup then
    Result := IWBSCreateInputGroupAddOn(Result, 'btn')
  else
    Result := CreateButtonFormGroup(ParentContainer, Result, HTMLName);

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
  Result := CreateInputFormGroup(ParentContainer, Result, FCaption, HTMLName);
end;
{$endregion}

end.
