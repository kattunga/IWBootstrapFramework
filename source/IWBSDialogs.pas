unit IWBSDialogs;

interface

uses System.Classes, System.SysUtils, Vcl.Controls,
     IWControl, IWRenderContext, IWBaseRenderContext, IW.Common.RenderStream, IWHTMLTag,
     IWBSRegion, IWBSInput, IWBSControls;

type
  TIWBSDialog = class(TIWBSModal)
  private
    FContent: TIWBSRegion;
    FTitle: TIWBSRegion;
    FHeader: TIWBSRegion;
    FBody: TIWBSRegion;
    FFooter: TIWBSRegion;

    FTitleText: string;
    FHeaderText: string;
    FBodyText: string;
    FFooterText: string;
    FCloseButton: boolean;
  public
    constructor Create(const AHeaderText, ABodyText: string); reintroduce;

    procedure Show;
    function AddButton(AParent: TIWBSRegion; const ACaption: string; AAsyncClickProc: TIWBSAsyncClickProc): TIWBSButton;

    function GetTitle: TIWBSRegion;
    function GetHeader: TIWBSRegion;
    function GetBody: TIWBSRegion;
    function GetFooter: TIWBSRegion;

    property TitleText: string read FTitleText write FTitleText;
    property HeaderText: string read FHeaderText write FHeaderText;
    property BodyText: string read FBodyText write FBodyText;
    property FooterText: string read FFooterText write FFooterText;

    property CloseButton: boolean read FCloseButton write FCloseButton;
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
    procedure InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream); override;
    procedure DoOnAsyncClose(AParams: TStringList); virtual;
    function GetCloseScript: string;
    procedure SetAlertStyle(AValue: TIWBSAlertStyle);
  public
    constructor Create(const AAlertText: string; AAlertStyle: TIWBSAlertStyle = bsasSuccess); reintroduce;
    destructor Destroy; override;

    procedure Show;
    function AddButton(const ACaption: string; AAsyncClickProc: TIWBSAsyncClickProc): TIWBSButton;

    property AlertStyle: TIWBSAlertStyle read FAlertStyle write SetAlertStyle default bsasSuccess;
    property AlertPosition: TIWBSAlertPosition read FAlertPosition write FAlertPosition default bsapRightTop;
    property AlertText: string read FAlertText write FAlertText;
    property Fade: boolean read FFade write FFade default True;

    property AlertLabel: TIWBSLabel read FAlertLabel;

    function GetClassString: string; override;
    property OnAsyncClose: TIWAsyncEvent read FOnAsyncClose write FOnAsyncClose;
  end;

var
  sIWBSDialogCloseCaption: string = 'Close';

implementation

uses IWInit, IWBSRegionCommon;

{$region 'TIWBSDialog'}
constructor TIWBSDialog.Create(const AHeaderText, ABodyText: string);
begin
  inherited Create(WebApplication.ActiveForm);
  Parent := TWinControl(WebApplication.ActiveForm);

  DestroyOnHide := True;
  BSModalVisible := True;

  FContent := TIWBSRegion.Create(Owner);
  FContent.BSRegionType := bsrtModalContent;
  FContent.Parent := Self;

  FHeaderText := AHeaderText;
  FBodyText := ABodyText;
  FCloseButton := True;
end;

procedure SetTitleLabel(const AValue: string);
begin
  if AValue <> '' then begin
  end;
end;

function TIWBSDialog.GetTitle: TIWBSRegion;
begin
  if FTitle = nil then begin
    FTitle := TIWBSRegion.Create(Owner);
    FTitle.Parent := FContent;
    FTitle.BSRegionType := bsrtModalTitle;
    FTitle.Top := 0;
  end;
  Result := FTitle;
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

procedure TIWBSDialog.Show;
begin
  // title
  if FTitleText <> '' then
    with TIWBSLabel.Create(Owner) do begin
      Parent := GetTitle;
      Caption := FTitleText;
    end;

  // header
  if FHeaderText <> '' then
    with TIWBSLabel.Create(Owner) do begin
      Parent := GetHeader;
      Caption := FHeaderText;
    end;
  with TIWBSButton.Create(Owner) do begin
    Parent := GetHeader;
    Caption := '';
    BSButtonStyle := bsbsClose;
    BSDataDismiss := bsbdModal;
  end;

  // body
  with TIWBSLabel.Create(Owner) do begin
    Parent := GetBody;
    Caption := FBodyText;
  end;

  // footer
  if (FHeaderText <> '') or FCloseButton then begin
    with TIWBSLabel.Create(Owner) do begin
      Parent := GetFooter;
      Caption := FFooterText;
    end;
    with TIWBSButton.Create(Owner) do begin
      Parent := GetFooter;
      Caption := sIWBSDialogCloseCaption;
      BSDataDismiss := bsbdModal;
    end;
  end;

  AsyncRenderComponent(true);
end;

function TIWBSDialog.AddButton(AParent: TIWBSRegion; const ACaption: string; AAsyncClickProc: TIWBSAsyncClickProc): TIWBSButton;
begin
  Result := TIWBSButton.Create(Owner);
  Result.Parent := AParent;
  Result.Caption := ACaption;
  Result.BSDataDismiss := bsbdModal;
  Result.LockOnAsyncEvents := [aeClick];
  Result.AsyncClickProc := AAsyncClickProc;
end;
{$endregion}

{$region 'TIWBSAlert'}
constructor TIWBSAlert.Create(const AAlertText: string; AAlertStyle: TIWBSAlertStyle = bsasSuccess);
begin
  inherited Create(WebApplication.ActiveForm);
  Parent := TWinControl(WebApplication.ActiveForm);
  FAlertVisible := False;
  FAlertPosition := bsapRightTop;
  FAlertStyle := bsasSuccess;
  AsyncDestroy := True;
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
  FCloseButton.BSDataDismiss := bsbdAlert;
end;

destructor TIWBSAlert.Destroy;
begin
  if FAlertVisible then begin
    ExecuteJS(GetCloseScript);
    FAlertVisible := False;
  end;
  inherited;
end;

procedure TIWBSAlert.InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream);
var
  xHTMLName: string;
begin
  inherited;

  xHTMLName := HTMLName;
  ABuffer.WriteLine('<script>');
  ABuffer.WriteLine('$("#'+xHTMLName+'").on("closed.bs.alert", function(e){ executeAjaxEvent("", null, "'+xHTMLName+'.DoOnAsyncClose", true, null, true); });');
  AContainerContext.WebApplication.RegisterCallBack(xHTMLName+'.DoOnAsyncClose', DoOnAsyncClose);
  ABuffer.WriteLine('</script>');

  FAlertVisible := True;
end;

procedure TIWBSAlert.SetAlertStyle(AValue: TIWBSAlertStyle);
begin
  FAlertStyle := AValue;
end;

function TIWBSAlert.GetClassString: string;
const
  aIWBSAlertStyle: array[bsasSuccess..bsasDanger] of string = ('success', 'info', 'warning', 'danger');
  aIWBSAlertPosition: array[bsapRightTop..bsapRightBottom] of string = ('right-top', 'right-center', 'right-bottom');
begin
  Result := 'alert alert-' + aIWBSAlertStyle[FAlertStyle];
  if FFade then
    Result := Result + ' fade in';
  if FAlertPosition <> bsapDefault then
    Result := Result+ ' flyover flyover-' + aIWBSAlertPosition[FAlertPosition]
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

procedure TIWBSAlert.Show;
begin
  AsyncRenderComponent(true);
end;

function TIWBSAlert.AddButton(const ACaption: string; AAsyncClickProc: TIWBSAsyncClickProc): TIWBSButton;
begin
  Result := TIWBSButton.Create(Owner);
  Result.Parent := Self;
  Result.Caption := ACaption;
  Result.BSDataDismiss := bsbdAlert;
  Result.AsyncClickProc := AAsyncClickProc;
end;
{$endregion}

end.
