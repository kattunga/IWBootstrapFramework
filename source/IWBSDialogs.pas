unit IWBSDialogs;

interface

uses System.Classes, System.SysUtils, Vcl.Controls,
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

    class function CreateEx(const AHeader, ABody: string): TIWBSDialog;

    procedure Show;
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

var
  sIWBSDialogCloseCaption: string = 'Close';

implementation

uses IWInit, IWBSRegionCommon;

constructor TIWBSDialog.Create(AOwner: TComponent);
begin
  inherited;

  DestroyOnHide := True;
  BSModalVisible := True;

  FContent := TIWBSRegion.Create(Owner);
  FContent.BSRegionType := bsrtModalContent;
  FContent.Parent := Self;
end;

class function TIWBSDialog.CreateEx(const AHeader, ABody: string): TIWBSDialog;
begin
  Result := Create(WebApplication);
  Result.Parent := TWinControl(WebApplication.ActiveForm);
  Result.HeaderText := AHeader;
  Result.BodyText := ABody;
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
  end;
  Result := FTitle;
end;

function TIWBSDialog.GetHeader: TIWBSRegion;
begin
  if FHeader = nil then begin
    FHeader := TIWBSRegion.Create(Owner);
    FHeader.Parent := FContent;
    FHeader.BSRegionType := bsrtModalHeader;
  end;
  Result := FHeader;
end;

function TIWBSDialog.GetBody: TIWBSRegion;
begin
  if FBody = nil then begin
    FBody := TIWBSRegion.Create(Owner);
    FBody.Parent := FContent;
    FBody.BSRegionType := bsrtModalBody;
  end;
  Result := FBody;
end;

function TIWBSDialog.GetFooter: TIWBSRegion;
begin
  if FFooter = nil then begin
    FFooter := TIWBSRegion.Create(Owner);
    FFooter.Parent := FContent;
    FFooter.BSRegionType := bsrtModalFooter;
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

end.
