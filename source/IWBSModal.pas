unit IWBSModal;

interface

uses
  SysUtils, Classes, Controls, StrUtils,
  IWApplication, IWControl, IWRenderContext, IWHTMLTag,
  IWBSCommon,
  IWBSCustomregion;

type
  TIWBSModal = class(TIWBSCustomRegion)
  private
    FWrapperSuffix: string;
    FDestroyOnHide: boolean;
    FDialogSize: TIWBSSize;
    FFade: boolean;
    FModalVisible: boolean;
    FOnAsyncShow: TIWAsyncEvent;
    FOnAsyncHide: TIWAsyncEvent;
  protected
    function GetShowScript: string;
    function GetHideScript: string;
    procedure SetModalVisible(AValue: boolean);
    procedure DoOnAsyncShow(AParams: TStringList); virtual;
    procedure DoOnAsyncHide(AParams: TStringList); virtual;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetRoleString: string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property BSFade: boolean read FFade write FFade default false;
    property BSDialogSize: TIWBSSize read FDialogSize write FDialogSize default bsszDefault;
    property ModalVisible: boolean read FModalVisible write SetModalVisible default false;
    property DestroyOnHide: boolean read FDestroyOnHide write FDestroyOnHide default false;
    property OnAsyncShow: TIWAsyncEvent read FOnAsyncShow write FOnAsyncShow;
    property OnAsyncHide: TIWAsyncEvent read FOnAsyncHide write FOnAsyncHide;
  end;

implementation

uses
  IWBSUtils;

constructor TIWBSModal.Create(AOwner: TComponent);
begin
  inherited;
  FDestroyOnHide := False;
  FDialogSize := bsszDefault;
  FFade := false;
  FModalVisible := false;
  FWrapperSuffix := '_wrp';
end;

destructor TIWBSModal.Destroy;
begin
  SetModalVisible(False);
  inherited;
end;

procedure TIWBSModal.InternalRenderCss(var ACss: string);
begin
  TIWBSCommon.AddCssClass(ACss, 'modal-dialog');
  if FDialogSize in [bsszLg,bsszSm] then
    TIWBSCommon.AddCssClass(ACss, 'modal-'+aIWBSSize[FDialogSize]);
  inherited;
end;

function TIWBSModal.GetRoleString: string;
begin
  Result := 'dialog';
end;

function TIWBSModal.GetShowScript: string;
begin
  Result := '$("#'+HTMLName+FWrapperSuffix+'").modal({backdrop: "static", "keyboard": true});';
end;

function TIWBSModal.GetHideScript: string;
begin
  Result := '$("#'+HTMLName+FWrapperSuffix+'").modal("hide");';
end;

procedure TIWBSModal.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  AScript.Add('$("#'+AHTMLName+FWrapperSuffix+'").off("shown.bs.modal").on("shown.bs.modal", function() { var elem; elem = $(this).find("[autofocus]"); if (elem.length !== 0) {elem.focus();} else {$(this).find("button:last").focus(); } });');
  if Assigned(FOnAsyncShow) then begin
    AScript.Add('$("#'+AHTMLName+FWrapperSuffix+'").off("show.bs.modal").on("show.bs.modal", function(e){ executeAjaxEvent("", null, "'+AHTMLName+'.DoOnAsyncShow", true, null, true); });');
    AContext.WebApplication.RegisterCallBack(AHTMLName+'.DoOnAsyncShow', DoOnAsyncShow);
  end;
  AScript.Add('$("#'+AHTMLName+FWrapperSuffix+'").off("hidden.bs.modal").on("hidden.bs.modal", function(e){ executeAjaxEvent("", null, "'+AHTMLName+'.DoOnAsyncHide", true, null, true); });');
  AContext.WebApplication.RegisterCallBack(AHTMLName+'.DoOnAsyncHide', DoOnAsyncHide);
  if FModalVisible then
    AScript.Add(GetShowScript);
  inherited;
end;

function TIWBSModal.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  lCss: string;
begin
  inherited;

  FMainID := HTMLName+FWrapperSuffix;
  Result := TIWHTMLTag.CreateTag('div');
  Result.Contents.AddTagAsObject(FRegionDiv);
  Result.AddStringParam('id', FMainID);
  lCss := 'modal';
  if FFade then
    TIWBSCommon.AddCssClass(lCss, 'fade');
  Result.AddClassParam(LCss);
end;

procedure TIWBSModal.SetModalVisible(AValue: boolean);
begin
  if AValue <> FModalVisible then begin
    if not (csDesigning in ComponentState) and not (csLoading in ComponentState)  then
      if AValue then
        IWBSExecuteAsyncJScript(GetShowScript)
      else
        IWBSExecuteAsyncJScript(GetHideScript);
    FModalVisible := AValue;
  end;
end;

procedure TIWBSModal.DoOnAsyncShow(AParams: TStringList);
begin
  FOnAsyncShow(Self, AParams);
end;

procedure TIWBSModal.DoOnAsyncHide(AParams: TStringList);
begin
  FModalVisible := False;
  if Assigned(FOnAsyncHide) then
    FOnAsyncHide(Self, AParams);
  if FDestroyOnHide then begin
    AsyncRemoveControl;
    Release;
  end;
end;

end.
