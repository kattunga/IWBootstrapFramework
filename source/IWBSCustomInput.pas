unit IWBSCustomInput;

interface

uses
  IWVCLComponent, Graphics, Forms, Classes, IWControl,
  IWBaseControl, IWTypes, IWScriptEvents, IWHTMLTag, IWColor,
  IWXMLTag, IWRenderContext, IWBaseInterfaces, IWCompButton, IWApplication,
  IWHTML40Interfaces;

type
  TIWCustomInput = class(TIWCustomControl, IIWInputControl, IIWSubmitControl, IIWInputControl40)
  protected
    FMaxLength: Integer;
    FOnSubmit: TNotifyEvent;
    FReadOnly: Boolean;
    FRequired: Boolean;
    FSubmitParam : String;
    FStyle: TStrings;
    FTagType: string;

    procedure InitControl; override;
    procedure DoSubmit;
    procedure SetMaxLength(const AValue:integer);
    procedure SetReadOnly(const AValue:boolean);
    procedure SetRequired(const AValue:boolean);
    procedure SetStyle(const AValue: TStrings);
    procedure SetValue(const AValue: string); virtual;
    procedure Submit(const AValue: string); override;
    function FormHasOnDefaultActionSet:boolean;
    function get_ShouldRenderTabOrder: boolean;override;

    property MaxLength: Integer read FMaxLength write SetMaxLength;
    property ReadOnly: boolean read FReadOnly write SetReadOnly;
  public
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderStyle(AContext: TIWCompContext): string; override;
    function GetSubmitParam : String;
  published
    property DoSubmitValidation;

    property ExtraTagParams;
    property FriendlyName;

    property Required: Boolean read FRequired write SetRequired default False;
    property ScriptEvents;
    property SubmitOnAsyncEvent;
    property Style: TStrings read FStyle write SetStyle;
    property TabOrder;

    property OnSubmit: TNotifyEvent read FOnSubmit write FOnSubmit;

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
  end;

implementation

uses
  SysUtils, IW.Browser.Browser, IW.Browser.InternetExplorer, IW.Browser.WebKit, IW.Browser.Opera,
  IWAppForm, IWBaseForm, IWCompLabel, IWResourceStrings, IWServerControllerBase,
  IW.Common.System, IW.Common.Strings, IWGlobal, IWForm, IWRegion, IW.Common.RenderStream,
  IWBaseHTMLControl, IWException, IWMarkupLanguageTag;

procedure TIWCustomInput.InitControl;
begin
  inherited;
  FNeedsFormTag := True;
  Height := 21;
  Width := 121;
  FCanReceiveFocus := True;
  FNonEditableAsLabel := False;
  FReadOnly := False;
  FRequired := False;
  FStyle := TStringList.Create;
  FStyle.NameValueSeparator := ':';
end;

function TIWCustomInput.GetSubmitParam: String;
begin
  Result := FSubmitParam;
end;

function TIWCustomInput.get_ShouldRenderTabOrder: boolean;
begin
  result := Editable or (NonEditableAsLabel = false);
end;

function TIWCustomInput.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
begin
  Result := nil;
end;

function TIWCustomInput.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := nil;
end;

function TIWCustomInput.FormHasOnDefaultActionSet:boolean;
var
  LForm: TIWBaseForm;
begin
  Result := false;
  LForm := OwnerForm;
  if Assigned(LForm) then
    if LForm is TIWForm then
      result := Assigned( TIWForm(LForm).OnDefaultAction );
end;

procedure TIWCustomInput.DoSubmit;
begin
  if Assigned(OnSubmit) then
    OnSubmit(Self)
  else if FormHasOnDefaultActionSet then
    TIWForm(OwnerForm).OnDefaultAction(Self);
end;

procedure TIWCustomInput.Submit(const AValue: string);
begin
  FSubmitParam := AValue;
  DoSubmit;
end;

function TIWCustomInput.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := '';
end;

procedure TIWCustomInput.SetMaxLength(const AValue:integer);
begin
  if FMaxLength <> AValue then
  begin
    FMaxLength := AValue;
    Invalidate;
  end;
end;

procedure TIWCustomInput.SetReadOnly(const AValue:boolean);
begin
  if FReadOnly <> AValue then
  begin
    FReadOnly := AValue;
    Invalidate;
  end;
end;

procedure TIWCustomInput.SetRequired(const AValue:boolean);
begin
  if FRequired <> AValue then begin
    FRequired := AValue;
    Invalidate;
  end;
end;

procedure TIWCustomInput.SetValue(const AValue: string);
begin
  if RequiresUpdateNotification(Parent) then
    UpdateNotifiedInterface(Parent).NotifyUpdate(Self,AValue);
  if Text <> AValue then begin
    Text := AValue;
    DoRefreshControl := False;
  end;
end;

procedure TIWCustomInput.SetStyle(const AValue: TStrings);
begin
  FStyle.Assign(AValue);
  Invalidate;
end;

end.
