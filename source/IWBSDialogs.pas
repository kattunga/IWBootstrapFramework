unit IWBSDialogs;

interface

uses Classes, SysUtils, Controls,
     IWControl, IWRenderContext, IWBaseRenderContext, IWHTMLTag, IWForm,
     IWBSCustomRegion, IWBSRegion, IWBSModal, IWBSButton, IWBSControls;

type
  TIWBSDialogCloseButton = (iwbsdcNone, iwbsdcCaption, iwbsdcFooter, iwbsdcBoth);

  TIWBSDialog = class(TIWBSModal)
  private
    FContent: TIWBSRegion;
    FHeader: TIWBSRegion;
    FBody: TIWBSRegion;
    FFooter: TIWBSRegion;

    FBodyControl: TIWBSText;
    FTitleControl: TIWBSLabel;

    FAsyncDismissProc: TIWBSAsyncEventProc;

    procedure SetBodyText(const Value: string);
    function GetBodyText: string;
    procedure SetTitleText(const Value: string);
    function GetTitleText: string;
  protected
    procedure DoOnAsyncHide(AParams: TStringList); override;
  public
    constructor Create(AForm: TIWForm; const ATitleText, ABodyText: string; ACloseButton: TIWBSDialogCloseButton = iwbsdcBoth; AAsyncDismissProc: TIWBSAsyncEventProc = nil); reintroduce; overload;
    constructor Create(const ATitleText, ABodyText: string; ACloseButton: TIWBSDialogCloseButton = iwbsdcBoth; AAsyncDismissProc: TIWBSAsyncEventProc = nil); reintroduce; overload;
    constructor Create(const ATitleText, ABodyText: string; AAsyncDismissProc: TIWBSAsyncEventProc); reintroduce; overload;

    function AddButton(AParent: TIWBSRegion; const ACaption: string; AAsyncClickProc: TIWBSAsyncEventProc = nil; ADismiss: boolean = True): TIWBSButton;

    function GetHeader: TIWBSRegion;
    function GetBody: TIWBSRegion;
    function GetFooter: TIWBSRegion;

    function GetBodyControl: TIWBSText;
    function GetTitleControl: TIWBSLabel;

    property BodyText: string read GetBodyText write SetBodyText;
    property TitleText: string read GetTitleText write SetTitleText;
  end;

  TIWBSAlertStyle = (bsasSuccess, bsasInfo, bsasWarning, bsasDanger);
  TIWBSAlertPosition = (bsapDefault, bsapRightTop, bsapRightCenter, bsapRightBottom);

  TIWBSAlert = class(TIWBSCustomRegion)
  private
    FAlertVisible: boolean;
    FAlertPosition: TIWBSAlertPosition;
    FAlertStyle: TIWBSAlertStyle;
    FAlertText: string;
    FFade: boolean;
    FOnAsyncClose: TIWAsyncEvent;

    FAlertLabel: TIWBSLabel;
    FCloseButton: TIWBSButton;
  protected
    procedure DoOnAsyncClose(AParams: TStringList); virtual;
    function GetCloseScript: string;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); override;
    procedure SetAlertStyle(AValue: TIWBSAlertStyle);
  public
    constructor Create(AForm: TIWForm; const AAlertText: string; AAlertStyle: TIWBSAlertStyle = bsasSuccess); reintroduce; overload;
    constructor Create(const AAlertText: string; AAlertStyle: TIWBSAlertStyle = bsasSuccess); reintroduce; overload;
    destructor Destroy; override;

    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;

    function AddButton(const ACaption: string; AAsyncClickProc: TIWBSAsyncEventProc = nil): TIWBSButton;

    property AlertStyle: TIWBSAlertStyle read FAlertStyle write SetAlertStyle default bsasSuccess;
    property AlertPosition: TIWBSAlertPosition read FAlertPosition write FAlertPosition default bsapRightTop;
    property AlertText: string read FAlertText write FAlertText;
    property Fade: boolean read FFade write FFade default True;

    property AlertLabel: TIWBSLabel read FAlertLabel;

    property OnAsyncClose: TIWAsyncEvent read FOnAsyncClose write FOnAsyncClose;
  end;

var
  sIWBSDialogCloseCaption: string = 'Close';

implementation

uses IWApplication, IWBSUtils, IWBSCommon;

{$region 'TIWBSDialog'}
constructor TIWBSDialog.Create(AForm: TIWForm; const ATitleText, ABodyText: string; ACloseButton: TIWBSDialogCloseButton = iwbsdcBoth; AAsyncDismissProc: TIWBSAsyncEventProc = nil);
begin
  inherited Create(AForm);
  Parent := AForm;

  DestroyOnHide := True;
  ModalVisible := True;

  FContent := TIWBSRegion.Create(Owner);
  FContent.BSRegionType := bsrtModalContent;
  FContent.Parent := Self;

  FAsyncDismissProc := AAsyncDismissProc;

  if ACloseButton in [iwbsdcCaption, iwbsdcBoth] then
    with TIWBSButton.Create(Owner) do begin
      Parent := GetHeader;
      Top := 0;
      Left := 0;
      Caption := '';
      BSButtonStyle := bsbsClose;
      DataDismiss := bsbdModal;
    end;

  SetBodyText(ABodyText);
  SetTitleText(ATitleText);

  if ACloseButton in [iwbsdcFooter, iwbsdcBoth] then
    with TIWBSButton.Create(Owner) do begin
      Parent := GetFooter;
      Caption := sIWBSDialogCloseCaption;
      Top := 0;
      Left := MaxInt;
      DataDismiss := bsbdModal;
    end;
end;

constructor TIWBSDialog.Create(const ATitleText, ABodyText: string; AAsyncDismissProc: TIWBSAsyncEventProc);
begin
  Create(TIWForm(GGetWebApplicationThreadVar.ActiveForm), ATitleText, ABodyText, iwbsdcBoth, AAsyncDismissProc);
end;

constructor TIWBSDialog.Create(const ATitleText, ABodyText: string; ACloseButton: TIWBSDialogCloseButton = iwbsdcBoth; AAsyncDismissProc: TIWBSAsyncEventProc = nil);
begin
  Create(TIWForm(GGetWebApplicationThreadVar.ActiveForm), ATitleText, ABodyText, ACloseButton, AAsyncDismissProc);
end;

procedure TIWBSDialog.DoOnAsyncHide(AParams: TStringList);
begin
  if Assigned(FAsyncDismissProc) then
    FAsyncDismissProc(Self, AParams);
  inherited;
end;

function TIWBSDialog.GetBodyControl: TIWBSText;
begin
  if FBodyControl = nil then begin
    FBodyControl := TIWBSText.Create(Owner);
    FBodyControl.Parent := GetBody;
    FBodyControl.Top := 0;
    FBodyControl.Left := 0;
  end;
  Result := FBodyControl;
end;

function TIWBSDialog.GetBodyText: string;
begin
  if FBodyControl <> nil then
    Result := FBodyControl.Lines.Text
  else
    Result := '';
end;

function TIWBSDialog.GetTitleControl: TIWBSLabel;
begin
  if FTitleControl = nil then begin
    FTitleControl := TIWBSLabel.Create(Owner);
    FTitleControl.Parent := GetHeader;
    FTitleControl.Top := 0;
    FTitleControl.Left := 20;
  end;
  Result := FTitleControl;
end;

function TIWBSDialog.GetTitleText: string;
begin
  if FTitleControl <> nil then
    Result := FTitleControl.Caption
  else
    Result := '';
end;

function TIWBSDialog.GetHeader: TIWBSRegion;
begin
  if FHeader = nil then begin
    FHeader := TIWBSRegion.Create(Owner);
    FHeader.Parent := FContent;
    FHeader.BSRegionType := bsrtModalHeader;
    FHeader.Top := 100;
  end;
  Result := FHeader;
end;

function TIWBSDialog.GetBody: TIWBSRegion;
begin
  if FBody = nil then begin
    FBody := TIWBSRegion.Create(Owner);
    FBody.Parent := FContent;
    FBody.BSRegionType := bsrtModalBody;
    FBody.Top := 200;
  end;
  Result := FBody;
end;

function TIWBSDialog.GetFooter: TIWBSRegion;
begin
  if FFooter = nil then begin
    FFooter := TIWBSRegion.Create(Owner);
    FFooter.Parent := FContent;
    FFooter.BSRegionType := bsrtModalFooter;
    FFooter.Top := 300;
  end;
  Result := FFooter;
end;

procedure TIWBSDialog.SetBodyText(const Value: string);
begin
  if Value <> '' then
    GetBodyControl.Lines.Text := Value;
end;

procedure TIWBSDialog.SetTitleText(const Value: string);
begin
  if Value <> '' then
    GetTitleControl.Caption := Value;
end;

function TIWBSDialog.AddButton(AParent: TIWBSRegion; const ACaption: string; AAsyncClickProc: TIWBSAsyncEventProc = nil; ADismiss: boolean = True): TIWBSButton;
begin
  Result := TIWBSButton.Create(Owner);
  Result.Parent := AParent;
  Result.Caption := ACaption;
  if Assigned(AAsyncClickProc) then
    begin
      Result.AsyncClickProc :=
        procedure(Sender: TObject; EventParams: TStringList)
        begin
          AAsyncClickProc(Sender, EventParams);
          if ADismiss then begin
            FAsyncDismissProc := nil;
            ModalVisible := False;
          end;
        end;
    end
  else
    Result.DataDismiss := bsbdModal;
end;
{$endregion}

{$region 'TIWBSAlert'}
constructor TIWBSAlert.Create(AForm: TIWForm; const AAlertText: string; AAlertStyle: TIWBSAlertStyle = bsasSuccess);
begin
  inherited Create(AForm);
  Parent := AForm;
  FAlertVisible := False;
  FAlertPosition := bsapRightTop;
  FAlertStyle := AAlertStyle;
  FAlertText := AAlertText;
  FFade := True;

  FAlertLabel := TIWBSLabel.Create(Self);
  FAlertLabel.Parent := Self;
  FAlertLabel.Name := Name+'_LABEL';
  FAlertLabel.Caption := AAlertText;
  FCloseButton := TIWBSButton.Create(Self);
  FCloseButton.Parent := Self;
  FCloseButton.Name := Name+'_CLOSEBTN';
  FCloseButton.Caption := '';
  FCloseButton.BSButtonStyle := bsbsClose;
  FCloseButton.DataDismiss := bsbdAlert;
end;

constructor TIWBSAlert.Create(const AAlertText: string; AAlertStyle: TIWBSAlertStyle = bsasSuccess);
begin
  Create(TIWForm(GGetWebApplicationThreadVar.ActiveForm), AAlertText, AAlertStyle);
end;

destructor TIWBSAlert.Destroy;
begin
  if FAlertVisible then begin
    IWBSExecuteAsyncJScript(GetCloseScript);
    FAlertVisible := False;
  end;
  inherited;
end;

procedure TIWBSAlert.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  inherited;
  AScript.Add('$("#'+AHTMLName+'").on("closed.bs.alert", function(e){ executeAjaxEvent("", null, "'+AHTMLName+'.DoOnAsyncClose", true, null, true); });');
  AContext.WebApplication.RegisterCallBack(AHTMLName+'.DoOnAsyncClose', DoOnAsyncClose);
end;

function TIWBSAlert.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  Result := inherited;


  FAlertVisible := True;
end;

procedure TIWBSAlert.SetAlertStyle(AValue: TIWBSAlertStyle);
begin
  FAlertStyle := AValue;
end;

procedure TIWBSAlert.InternalRenderCss(var ACss: string);
const
  aIWBSAlertStyle: array[bsasSuccess..bsasDanger] of string = ('success', 'info', 'warning', 'danger');
  aIWBSAlertPosition: array[bsapRightTop..bsapRightBottom] of string = ('right-top', 'right-center', 'right-bottom');
begin
  TIWBSCommon.AddCssClass(ACss, 'alert alert-' + aIWBSAlertStyle[FAlertStyle]);
  if FFade then
    TIWBSCommon.AddCssClass(ACss, 'fade in');
  if FAlertPosition <> bsapDefault then
    TIWBSCommon.AddCssClass(ACss, 'flyover flyover-' + aIWBSAlertPosition[FAlertPosition]);
  inherited;
end;

function TIWBSAlert.GetCloseScript: string;
begin
  Result := '$("#'+HTMLName+'").alert("close");';
end;

procedure TIWBSAlert.DoOnAsyncClose(AParams: TStringList);
begin
  if Assigned(FOnAsyncClose) then
    FOnAsyncClose(Self, AParams);
  FAlertVisible := False;
  Free;
end;

function TIWBSAlert.AddButton(const ACaption: string; AAsyncClickProc: TIWBSAsyncEventProc = nil): TIWBSButton;
begin
  Result := TIWBSButton.Create(Owner);
  Result.Parent := Self;
  Result.Caption := ACaption;
  Result.AsyncClickProc := AAsyncClickProc;
end;
{$endregion}

end.
