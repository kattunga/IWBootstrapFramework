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
    constructor Create(AOwner: TComponent); override;

    class function CreateEx(AOwner: TComponent; const AHeaderText, ABodyText: string): TIWBSDialog;

    function Show: TIWBSDialog;
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
    FBodyText: string;
    FFade: boolean;
    FOnAsyncClose: TIWAsyncEvent;
  protected
    procedure InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream); override;
    procedure DoOnAsyncClose(AParams: TStringList); virtual;
    function GetCloseScript: string;
    procedure SetAlertStyle(AValue: TIWBSAlertStyle);
  public
    constructor Create(AParent: TWinControl; const ABodyText: string; AAlertStyle: TIWBSAlertStyle = bsasSuccess); reintroduce;
    destructor Destroy; override;

    function Show: TIWBSAlert;

    property AlertStyle: TIWBSAlertStyle read FAlertStyle write SetAlertStyle default bsasSuccess;
    property AlertPosition: TIWBSAlertPosition read FAlertPosition write FAlertPosition default bsapRightTop;
    property BodyText: string read FBodyText write FBodyText;
    property Fade: boolean read FFade write FFade default True;

    function GetClassString: string; override;
    property OnAsyncClose: TIWAsyncEvent read FOnAsyncClose write FOnAsyncClose;
  end;

var
  sIWBSDialogCloseCaption: string = 'Close';

implementation

uses IWInit, IWBSRegionCommon;

{$region 'TIWBSDialog'}
constructor TIWBSDialog.Create(AOwner: TComponent);
begin
  inherited;

  DestroyOnHide := True;
  BSModalVisible := True;

  FContent := TIWBSRegion.Create(Owner);
  FContent.BSRegionType := bsrtModalContent;
  FContent.Parent := Self;
end;

class function TIWBSDialog.CreateEx(AOwner: TComponent; const AHeaderText, ABodyText: string): TIWBSDialog;
begin
  Result := Create(AOwner);
  Result.Parent := TWinControl(WebApplication.ActiveForm);
  Result.HeaderText := AHeaderText;
  Result.BodyText := ABodyText;
  Result.CloseButton := True;
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

function TIWBSDialog.Show: TIWBSDialog;
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

  Result := Self;
end;

function TIWBSDialog.AddButton(AParent: TIWBSRegion; const ACaption: string; AAsyncClickProc: TIWBSAsyncClickProc): TIWBSButton;
begin
  Result := TIWBSButton.Create(Owner);
  Result.Parent := AParent;
  Result.Caption := ACaption;
  Result.BSDataDismiss := bsbdModal;
  Result.AsyncClickProc := AAsyncClickProc;
end;
{$endregion}

{$region 'TIWBSAlert'}
constructor TIWBSAlert.Create(AParent: TWinControl; const ABodyText: string; AAlertStyle: TIWBSAlertStyle = bsasSuccess);
begin
  inherited Create(AParent.Owner);
  Parent := AParent;
  FAlertVisible := False;
  FAlertPosition := bsapRightTop;
  FAlertStyle := bsasSuccess;
  AsyncDestroy := True;
  FBodyText := ABodyText;
  FFade := True;
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

  ABuffer.WriteLine('<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>');
  ABuffer.WriteLine(FBodyText);

  // scripts area
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

function TIWBSAlert.Show: TIWBSAlert;
begin
  AsyncRenderComponent(true);
  Result := Self;
end;
{$endregion}

end.
