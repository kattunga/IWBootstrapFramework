unit IWBSRegion;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer, IWApplication, IWBaseRenderContext,
  IWBaseContainerLayout, IWContainer, IWControl, IWHTMLContainer, IWHTML40Container, IWRegion, IW.Common.Strings,
  IWRenderContext, IWHTMLTag, IWBaseInterfaces, IWXMLTag, IWMarkupLanguageTag, IW.Common.RenderStream,
  IWBSCommon, IWBSRegionCommon, IWBSLayoutMgr;

type
  TIWBSCustomRegion = class(TIWCustomRegion)
  private
    FAsyncDestroy: boolean;
    FCss: string;
    FFormType: TIWBSFormType;
    FFormOptions: TIWBSFormOptions;
    FGridOptions: TIWBSGridOptions;
    FLayoutMrg: boolean;
    FRegionDiv: TIWHTMLTag;
    procedure ExecuteJS(const AScript: string; AsCDATA: boolean = False);
    function GetWebApplication: TIWApplication;
  protected
    function ContainerPrefix: string; override;
    procedure AsyncSetAttributes; virtual;
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    procedure InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream); virtual;
    procedure InitControl; override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure SetGridOptions(const Value: TIWBSGridOptions);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AsyncRenderComponent(ARenderContent: boolean = False);
    property Canvas;
    function GetClassString: string; virtual;
    function GetRoleString: string; virtual;
  published
    property Align;
    property AsyncDestroy: boolean read FAsyncDestroy write FAsyncDestroy default false;
    property BSFormType: TIWBSFormType read FFormType write FFormType default bsftNoForm;
    property BSFormOptions: TIWBSFormOptions read FFormOptions write FFormOptions;
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;
    property BSLayoutMgr: boolean read FLayoutMrg write FLayoutMrg default True;
    property ClipRegion default False;
    property Css: string read FCss write FCss;
    property StyleRenderOptions;
  end;

  TIWBSBtnGroupOptions = class(TPersistent)
  private
    FVertical: boolean;
    FJustified: boolean;
    FSize: TIWBSSize;
  public
    constructor Create(AOwner: TComponent);
  published
    property Vertical: boolean read FVertical write FVertical default false;
    property Justified: boolean read FJustified write FJustified default false;
    property Size: TIWBSSize read FSize write FSize default bsszDefault;
  end;

  TIWBSPanelStyle = (bspsDefault, bspsPrimary, bspsSuccess, bspsInfo, bspsWarning, bspsDanger);

  TIWBSRegion = class(TIWBSCustomRegion)
  private
    FButtonGroupOptions: TIWBSBtnGroupOptions;
    FPanelStyle: TIWBSPanelStyle;
    FRegionType: TIWBSRegionType;
    FRelativeSize: TIWBSRelativeSize;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetClassString: string; override;
    function GetRoleString: string; override;
    procedure SetButtonGroupOptions(Value: TIWBSBtnGroupOptions);
    procedure SetRegionType(Value: TIWBSRegionType);
    procedure SetPanelStyle(Value: TIWBSPanelStyle);
    procedure SetRelativeSize(Value: TIWBSRelativeSize);
  published
    property BSButtonGroupOptions: TIWBSBtnGroupOptions read FButtonGroupOptions write SetButtonGroupOptions;
    property BSPanelStyle: TIWBSPanelStyle read FPanelStyle write SetPanelStyle default bspsDefault;
    property BSRegionType: TIWBSRegionType read FRegionType write SetRegionType default bsrtIWBSRegion;
    property BSRelativeSize: TIWBSRelativeSize read FRelativeSize write SetRelativeSize default bsrzDefault;
  end;

  TIWBSModal = class(TIWBSCustomRegion)
  private
    FDestroyOnHide: boolean;
    FDialogSize: TIWBSSize;
    FFade: boolean;
    FModalVisible: boolean;
    FOnAsyncShow: TIWAsyncEvent;
    FOnAsyncHide: TIWAsyncEvent;
    function GetShowScript: string;
    function GetHideScript: string;
  protected
    procedure InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream); override;
    procedure SetModalVisible(Value: boolean);
    procedure DoOnAsyncShow(AParams: TStringList); virtual;
    procedure DoOnAsyncHide(AParams: TStringList); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetClassString: string; override;
    function GetRoleString: string; override;
  published
    property BSFade: boolean read FFade write FFade default false;
    property BSDialogSize: TIWBSSize read FDialogSize write FDialogSize default bsszDefault;
    property BSModalVisible: boolean read FModalVisible write SetModalVisible default false;
    property DestroyOnHide: boolean read FDestroyOnHide write FDestroyOnHide default false;
    property OnAsyncShow: TIWAsyncEvent read FOnAsyncShow write FOnAsyncShow;
    property OnAsyncHide: TIWAsyncEvent read FOnAsyncHide write FOnAsyncHide;
  end;

implementation

uses IWForm, IWUtils, IWContainerLayout, IWBSUtils;

{$region 'THackCustomRegion'}
type
  THackTIWHTML40Container = class(TIWHTML40Container)
  private
    procedure CallInheritedRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
  end;

procedure THackTIWHTML40Container.CallInheritedRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  inherited RenderComponents(AContainerContext, APageContext);
end;
{$endregion}

{$region 'TIWBSCustomRegion'}
constructor TIWBSCustomRegion.Create(AOwner: TComponent);
begin
  inherited;
  FAsyncDestroy := False;
  FCss := '';
  FFormType := bsftNoForm;
  FGridOptions := TIWBSGridOptions.Create;
  FFormOptions := TIWBSFormOptions.Create;
  FLayoutMrg := True;
  ClipRegion := False;
end;

destructor TIWBSCustomRegion.Destroy;
begin
  FFormOptions.Free;
  FGridOptions.Free;
  if FAsyncDestroy then
    ExecuteJS('AsyncDestroyControl("'+HTMLName+'");');

  IWBSUnregisterCallbacks(HTMLName, GetWebApplication);
  inherited;
end;

function TIWBSCustomRegion.GetWebApplication: TIWApplication;
begin
  if ContainerContext <> nil then
    Result := ContainerContext.WebApplication
  else if (ParentContainer <> nil) and (ParentContainer.ContainerContext <> nil) then
    Result := ParentContainer.ContainerContext.WebApplication
  else
    Result := nil;
end;

procedure TIWBSCustomRegion.ExecuteJS(const AScript: string; AsCDATA: boolean = False);
var
  LWebApplication: TIWApplication;
begin
  LWebApplication := GetWebApplication;
  if not (csLoading in ComponentState) and (LWebApplication <> nil )then
    if AsCDATA then
      LWebApplication.CallBackResponse.AddJavaScriptToExecuteAsCDATA(AScript)
    else
      LWebApplication.CallBackResponse.AddJavaScriptToExecute(AScript);
end;

function TIWBSCustomRegion.GetClassString: string;
begin
  Result := FGridOptions.GetClassString;
  if FCss <> '' then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + FCss;
  end;
end;

function TIWBSCustomRegion.GetRoleString: string;
begin
  result := '';
end;

procedure TIWBSCustomRegion.AsyncSetAttributes;
begin
  ExecuteJS('$("#'+HTMLName+'").attr("class","'+GetClassString+'");');
  if GetRoleString <> '' then
    ExecuteJS('$("#'+HTMLName+'").attr("role","'+GetRoleString+'");');
end;

procedure TIWBSCustomRegion.AsyncRenderComponent(ARenderContent: boolean = False);
var
  LParentContainer: TIWContainer;
  LWebApplication: TIWApplication;

  LHTMLName: string;
  LContName: string;
  LPageContext: TIWBasePageContext;
  LComponentContext: TIWBaseComponentContext;
  LBuffer: TIWRenderStream;
  LScript: string;

  LTag: TIWMarkupLanguageTag;
begin
  // get base container
  LParentContainer := TIWContainer(ParentContainer.InterfaceInstance);
  if LParentContainer is TIWCustomRegion then
    LContName := TIWCustomRegion(LParentContainer).HTMLName
  else if LParentContainer is TIWForm then
    LContName := 'body'
  else
    Exit;

  // get webapplication
  LWebApplication := GetWebApplication;

  // if not callback exit now
  if not LWebApplication.IsCallBack or not LWebApplication.CallBackProcessing then
    Exit;

  // read only one time
  LHTMLName := HTMLName;

  // is there any other way to get the pagecontext ????
  if LWebApplication.ActiveForm is TIWForm then
    LPageContext := TIWForm(LWebApplication.ActiveForm).PageContext
  else
    Exit;

  // create dom element if not found
  if FRegionDiv = nil then begin
    // render self and add to parent container
    LComponentContext := TIWCompContext.Create(Self, ParentContainer.ContainerContext , LPageContext);
    LTag := RenderMarkupLanguageTag(LComponentContext);
    LTag := DoPostRenderProcessing(LTag, LComponentContext, Self);
    if (not Visible) and LParentContainer.RenderInvisibleControls then
      if StyleRenderOptions.UseDisplay then
        LTag.AddStringParam('style', 'display: none;' + LTag.Params.Values['style'])
      else
        LTag.AddStringParam('style', 'visibility: hidden;' + LTag.Params.Values['style']);
    LComponentContext.MarkupLanguageTag := LTag;
    ParentContainer.ContainerContext.AddComponent(LComponentContext);
    ExecuteJS('AsyncCreateControl("div","'+LHTMLName+'","'+LContName+'");', True);
  end;

  // render tag properties
  AsyncSetAttributes;

  // render child components
  if ARenderContent then begin
    LBuffer := TIWRenderStream.Create(True, True);
    try
      ContainerContext := InitContainerContext(LWebApplication);
      FRegionDiv.Contents.Clear;
      InternalRenderComponents(ContainerContext, LPageContext, LBuffer);

      LScript := LBuffer.AsString;
      LScript := RemoveCRLF(LScript);
      LScript := StringReplace(Lscript,'"','\"',[rfReplaceAll]);
      ExecuteJS('$("#'+LHTMLName+'").html("'+LScript+'");', True);
    finally
      LayoutMgr.SetContainer(nil);
      FreeAndNil(LBuffer);
    end;
  end;
end;

procedure TIWBSCustomRegion.InitControl;
begin
  inherited;
  if name = '' then
    name := IWBSGetUniqueComponentName(Owner, Copy(ClassName,2,MaxInt));
end;

procedure TIWBSCustomRegion.SetGridOptions(const Value: TIWBSGridOptions);
begin
  FGridOptions.Assign(Value);
  Invalidate;
end;

function TIWBSCustomRegion.ContainerPrefix: string;
begin
  if Owner is TFrame then begin
    Result := UpperCase(TFrame(Owner).Name);
  end else
  if isBaseContainer(Parent) then begin
    Result := BaseContainerInterface(Parent).ContainerPrefix;
  end else begin
    Result := UpperCase(Name);
  end;
end;

function TIWBSCustomRegion.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  if FLayoutMrg then begin
    if not (Self.LayoutMgr is TIWBSLayoutMgr) then
      Self.LayoutMgr := TIWBSLayoutMgr.Create(Self);
    TIWBSLayoutMgr(Self.LayoutMgr).BSFormType := FFormType;
  end;
  Result := inherited;
end;

function TIWBSCustomRegion.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
begin
  result := nil;
end;

procedure TIWBSCustomRegion.InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream);
begin
  if FLayoutMrg then
    IWBSPrepareChildComponentsForRender(Self, FFormType);
  try
    THackTIWHTML40Container(Self).CallInheritedRenderComponents(AContainerContext, APageContext);
    LayoutMgr.ProcessControls(AContainerContext, TIWBaseHTMLPageContext(APageContext));
    LayoutMgr.Process(ABuffer, AContainerContext, APageContext);
  finally
    LayoutMgr.SetContainer(nil);
  end;
end;

procedure TIWBSCustomRegion.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
var
  LBuffer: TIWRenderStream;
begin
  ContainerContext := AContainerContext;
  LBuffer := TIWRenderStream.Create(True, True);
  try
    InternalRenderComponents(AContainerContext, APageContext, LBuffer);
    FRegionDiv.Contents.AddBuffer(LBuffer);
  finally
    FreeAndNil(LBuffer);
  end;
end;

function TIWBSCustomRegion.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  FRegionDiv := TIWHTMLTag.CreateTag('div');
  FRegionDiv.AddClassParam(GetClassString);
  FRegionDiv.AddStringParam('role',GetRoleString);
  Result := FRegionDiv;
end;
{$endregion}

{$region 'TIWBSRegion'}
constructor TIWBSRegion.Create(AOwner: TComponent);
begin
  inherited;
  FButtonGroupOptions := TIWBSBtnGroupOptions.Create(Self);
  FPanelStyle := bspsDefault;
  FRegionType := bsrtIWBSRegion;
  FRelativeSize := bsrzDefault;
end;

destructor TIWBSRegion.Destroy;
begin
  FButtonGroupOptions.Free;
  inherited;
end;

function TIWBSRegion.GetClassString: string;
const
  aIWBSPanelStyle: array[bspsDefault..bspsDanger] of string = ('panel-default', 'panel-primary', 'panel-success', 'panel-info', 'panel-warning', 'panel-danger');
var
  s: string;
begin
  Result := aIWBSRegionType[FRegionType];

  if FRegionType = bsrtPanel then
    Result := Result + ' ' + aIWBSPanelStyle[FPanelStyle]

  else if (FRegionType = bsrtWell) and (FRelativeSize <> bsrzDefault) then
    Result := Result + ' well-' + aIWBSRelativeSize[FRelativeSize]

  else if FRegionType = bsrtButtonGroup then
    begin
      if FButtonGroupOptions.Vertical then
        Result := Result + '-vertical';
      if FButtonGroupOptions.FSize <> bsszDefault then
        Result := Result + ' btn-group-'+aIWBSSize[FButtonGroupOptions.FSize];
      if FButtonGroupOptions.FJustified then
        Result := Result + ' btn-group-justified';
    end;

  s := inherited;
  if s <> '' then
    Result := Result + ' ' + s;
end;

function TIWBSRegion.GetRoleString: string;
begin
  if FRegionType = bsrtButtonToolbar then
    Result := 'toolbar'
  else if FRegionType = bsrtButtonGroup then
    Result := 'group'
  else
    Result := '';
end;

procedure TIWBSRegion.SetButtonGroupOptions(Value: TIWBSBtnGroupOptions);
begin
  FButtonGroupOptions.Assign(Value);
  Invalidate;
end;

procedure TIWBSRegion.SetRegionType(Value: TIWBSRegionType);
begin
  FRegionType := Value;
  Invalidate;
end;

procedure TIWBSRegion.SetPanelStyle(Value: TIWBSPanelStyle);
begin
  FPanelStyle := Value;
  Invalidate;
end;

procedure TIWBSRegion.SetRelativeSize(Value: TIWBSRelativeSize);
begin
  FRelativeSize := Value;
  Invalidate;
end;
{$endregion}

{$region 'TIWBSBtnGroupOptions'}
constructor TIWBSBtnGroupOptions.Create(AOwner: TComponent);
begin
  FVertical := false;
  FJustified := false;
  FSize := bsszDefault;
end;
{$endregion}

{$region 'TIWBSModal'}
constructor TIWBSModal.Create(AOwner: TComponent);
begin
  inherited;
  FAsyncDestroy := True;
  FDestroyOnHide := False;
  FDialogSize := bsszDefault;
  FFade := false;
  FModalVisible := false;
end;

destructor TIWBSModal.Destroy;
begin
  SetModalVisible(False);
  inherited;
end;

function TIWBSModal.GetClassString: string;
begin
  Result := 'modal';
  if FFade then
    Result := Result + ' fade';
  Result := Result + Trim(' '+inherited);
end;

function TIWBSModal.GetRoleString: string;
begin
  Result := 'dialog';
end;

function TIWBSModal.GetShowScript: string;
begin
  Result := '$("#'+HTMLName+'").modal({backdrop: "static", "keyboard": true});';
end;

function TIWBSModal.GetHideScript: string;
begin
  Result := '$("#'+HTMLName+'").modal("hide");';
end;

procedure TIWBSModal.InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream);
var
  LCss: string;
  xHTMLName: string;
begin
  LCss := 'modal-dialog';
  if FDialogSize in [bsszLg,bsszSm] then
    LCss := LCss + ' modal-'+aIWBSSize[FDialogSize];
  ABuffer.WriteLine('<div class="'+LCss+'">');
  inherited;
  ABuffer.WriteLine('</div>');

  // scripts area
  xHTMLName := HTMLName;
  ABuffer.WriteLine('<script>');
  ABuffer.WriteLine('$("#'+HTMLName+'").on("shown.bs.modal", function() { $(this).find("[autofocus]").focus(); });');
  if Assigned(FOnAsyncShow) then begin
    ABuffer.WriteLine('$("#'+xHTMLName+'").on("shown.bs.modal", function(e){ console.log(e); executeAjaxEvent("&page="+e.target.tabIndex, null, "'+xHTMLName+'.DoOnAsyncShow", true, null, true); });');
    AContainerContext.WebApplication.RegisterCallBack(xHTMLName+'.DoOnAsyncShow', DoOnAsyncShow);
  end;
  if Assigned(FOnAsyncHide) or FDestroyOnHide then begin
    ABuffer.WriteLine('$("#'+xHTMLName+'").on("hidden.bs.modal", function(e){ console.log(e); executeAjaxEvent("&page="+e.target.tabIndex, null, "'+xHTMLName+'.DoOnAsyncHide", true, null, true); });');
    AContainerContext.WebApplication.RegisterCallBack(xHTMLName+'.DoOnAsyncHide', DoOnAsyncHide);
  end;
  if FModalVisible then
    ABuffer.WriteLine(GetShowScript);
  ABuffer.WriteLine('</script>');
end;

procedure TIWBSModal.SetModalVisible(Value: boolean);
begin
  if Value <> FModalVisible then begin
    if Value then
      ExecuteJS(GetShowScript)
    else
      ExecuteJS(GetHideScript);
    FModalVisible := Value;
  end;
end;

procedure TIWBSModal.DoOnAsyncShow(AParams: TStringList);
begin
  FOnAsyncShow(Self, AParams);
end;

procedure TIWBSModal.DoOnAsyncHide(AParams: TStringList);
begin
  if Assigned(FOnAsyncHide) then
    FOnAsyncHide(Self, AParams);
  if FDestroyOnHide then begin
    AsyncDestroy := True;
    Free;
  end;
end;
{$endregion}

end.
