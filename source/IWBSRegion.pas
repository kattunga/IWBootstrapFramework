unit IWBSRegion;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer, IWApplication, IWBaseRenderContext,
  IWBaseContainerLayout, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IW.Common.Strings,
  IWRenderContext, IWHTMLTag, IWBaseInterfaces, IWXMLTag, IWMarkupLanguageTag, IW.Common.RenderStream,
  IWBSCommon, IWBSLayoutMgr;

type

  TIWBSCustomRegion = class(TIWCustomRegion)
  private
    FAsyncDestroy: boolean;
    FCss: string;
    FFormType: TIWBSFormType;
    FGridOptions: TIWBSGridOptions;
    FLayoutMrg: boolean;
    FRegionDiv: TIWHTMLTag;
    procedure ExecuteJS(const AScript: string; AsCDATA: boolean = False);
    function GetWebApplication: TIWApplication;
  protected
    function ContainerPrefix: string; override;
    procedure AsyncSetAttributes; virtual;
    function GetClassString: string; virtual;
    function GetRoleString: string; virtual;
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    procedure InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream); virtual;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure SetGridOptions(const Value: TIWBSGridOptions);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AsyncRenderComponent(ARenderContent: boolean = False);
    property BSFormType: TIWBSFormType read FFormType write FFormType default bsftNoForm;
  published
    property Align;
    property AsyncDestroy: boolean read FAsyncDestroy write FAsyncDestroy default false;
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;
    property BSLayoutMgr: boolean read FLayoutMrg write FLayoutMrg default True;
    property ClipRegion default False;
    property Css: string read FCss write FCss;
    property StyleRenderOptions;
  end;

  TIWBSRegion = class(TIWBSCustomRegion)
  private
    FContextualStyle: TIWBSContextualStyle;
    FRegionType: TIWBSRegionType;
    FRelativeSize: TIWBSRelativeSize;
  protected
    function GetClassString: string; override;
    function GetRoleString: string; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BSContextualStyle: TIWBSContextualStyle read FContextualStyle write FContextualStyle default bsbsDefault;
    property BSFormType;
    property BSRegionType: TIWBSRegionType read FRegionType write FRegionType default bsrtIWBSRegion;
    property BSRelativeSize: TIWBSRelativeSize read FRelativeSize write FRelativeSize default bsrzDefault;
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

  TIWBSBtnGroup = class(TIWBSCustomRegion)
  private
    FBGOptions: TIWBSBtnGroupOptions;
  protected
    function GetClassString: string; override;
    function GetRoleString: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BGOptions: TIWBSBtnGroupOptions read FBGOptions write FBGOptions;
  end;

  TIWBSModal = class(TIWBSCustomRegion)
  private
    FDialogSize: TIWBSSize;
    FFade: boolean;
    FModalVisible: boolean;
    function GetShowScript: string;
    function GetHideScript: string;
  protected
    function GetClassString: string; override;
    function GetRoleString: string; override;
    procedure InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream); override;
    procedure SetModalVisible(Value: boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AsyncDestroy default true;
    property BSFade: boolean read FFade write FFade default false;
    property BSDialogSize: TIWBSSize read FDialogSize write FDialogSize default bsszDefault;
    property BSModalVisible: boolean read FModalVisible write SetModalVisible default false;
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
  FGridOptions := TIWBSGridOptions.Create(Self);
  FLayoutMrg := True;

  ClipRegion := False;
end;

destructor TIWBSCustomRegion.Destroy;
begin
  FGridOptions.Free;
  if FAsyncDestroy then
    ExecuteJS('AsyncDestroyControl("'+HTMLName+'");');
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

procedure TIWBSCustomRegion.SetGridOptions(const Value: TIWBSGridOptions);
begin
  FGridOptions.Assign(Value);
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
  if FLayoutMrg then
    if (Self.LayoutMgr = nil) or not (Self.LayoutMgr.Able) then begin
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
  FContextualStyle := bsbsDefault;
  FRegionType := bsrtIWBSRegion;
  FRelativeSize := bsrzDefault;
end;

function TIWBSRegion.GetClassString: string;
var
  s: string;
begin
  Result := aIWBSRegionType[FRegionType];

  if FRegionType = bsrtPanel then
    Result := Result + ' panel-' + aIWBSContextualStyle[FContextualStyle]

  else if (FRegionType = bsrtWell) and (FRelativeSize <> bsrzDefault) then
    Result := Result + ' well-' + aIWBSRelativeSize[FRelativeSize];

  s := inherited;
  if s <> '' then
    Result := ' ' + s;
end;

function TIWBSRegion.GetRoleString: string;
begin
  if FRegionType = bsrtButtonToolbar then
    Result := 'toolbar'
  else
    Result := '';
end;
{$endregion}

{$region 'TIWBSBtnGroup'}
constructor TIWBSBtnGroupOptions.Create(AOwner: TComponent);
begin
  FVertical := false;
  FJustified := false;
  FSize := bsszDefault;
end;

constructor TIWBSBtnGroup.Create(AOwner: TComponent);
begin
  inherited;
  FBGOptions := TIWBSBtnGroupOptions.Create(Self);
end;

destructor TIWBSBtnGroup.Destroy;
begin
  FBGOptions.Free;
  inherited;
end;

function TIWBSBtnGroup.GetClassString: string;
begin
  if FBGOptions.FVertical then
    Result := 'btn-group-vertical'
  else
    Result := 'btn-group';
  if FBGOptions.FSize <> bsszDefault then
    Result := Result + ' btn-group-'+aIWBSSize[FBGOptions.FSize];
  if FBGOptions.FJustified then
    Result := Result + ' btn-group-justified';
  Result := Result + Trim(' '+inherited);
end;

function TIWBSBtnGroup.GetRoleString: string;
begin
  Result := 'group';
end;
{$endregion}

{$region 'TIWBSModal'}
constructor TIWBSModal.Create(AOwner: TComponent);
begin
  inherited;
  FAsyncDestroy := True;
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
begin
  LCss := 'modal-dialog';
  if FDialogSize in [bsszLg,bsszSm] then
    LCss := LCss + ' modal-'+aIWBSSize[FDialogSize];
  ABuffer.WriteLine('<div class="'+LCss+'">');
  inherited;
  ABuffer.WriteLine('</div>');
  ABuffer.WriteLine('<script>');
  ABuffer.WriteLine('$("#'+HTMLName+'").on("shown.bs.modal", function() { $(this).find("[autofocus]").focus(); });');


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
{$endregion}

end.
