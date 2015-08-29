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
    FChildRenderOptions: TIWBSChildRenderOptions;
    FCss: string;
    FGridOptions: TIWBSGridOptions;
    FFormType: TIWBSFormType;
    FRegionDiv: TIWHTMLTag;
  protected
    function ContainerPrefix: string; override;
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    procedure InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream);
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure SetGridOptions(const Value: TIWBSGridOptions);
    property BSFormType: TIWBSFormType read FFormType write FFormType default bsftNoForm;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AsyncRenderContent;
  published
    property BSChildRenderOptions: TIWBSChildRenderOptions read FChildRenderOptions write FChildRenderOptions default [bschDisablePosition, bschDisableSize, bschDisableFont];
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;
    property Css: string read FCss write FCss;
  end;

  TIWBSRegion = class(TIWBSCustomRegion)
  private
    FRegionType: TIWBSRegionType;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Align;
    property BSRegionType: TIWBSRegionType read FRegionType write FRegionType default bsrtIWBSRegion;
    property BSFormType;
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
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property BGOptions: TIWBSBtnGroupOptions read FBGOptions write FBGOptions;
  end;

  TIWBSBtnToolBar = class(TIWBSCustomRegion)
  public
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  end;

  TIWBSModal = class(TIWBSCustomRegion)
  private
    FDialogSize: TIWBSSize;
    FFade: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    property BSFade: boolean read FFade write FFade default false;
    property BSDialogSize: TIWBSSize read FDialogSize write FDialogSize default bsszDefault;
  end;

implementation

uses IWForm, IWUtils, IWContainerLayout;

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

  FChildRenderOptions := [bschDisablePosition, bschDisableSize, bschDisableFont];
  FCss := '';
  FGridOptions := TIWBSGridOptions.Create(Self);
  FFormType := bsftNoForm;

  ClipRegion := False;
end;

procedure TIWBSCustomRegion.AsyncRenderContent;
var
  APageContext: TIWBasePageContext;
  AContainerContext: TIWContainerContext;
  LBuffer: TIWRenderStream;
  LScript: string;
begin
  if not (ContainerContext.WebApplication.IsCallBack) or not (ContainerContext.WebApplication.ActiveForm is TIWForm) then
    Exit;

  APageContext := TIWForm(ContainerContext.WebApplication.ActiveForm).PageContext;
  AContainerContext := TIWContainerContext.Create(ContainerContext.WebApplication, CacheControls);
  LBuffer := TIWRenderStream.Create(True, True);
  try
    FRegionDiv.Contents.Clear;

    LayoutMgr.SetContainer(Self);
    InternalRenderComponents(AContainerContext, APageContext, LBuffer);

    LScript := LBuffer.AsString;
    LScript := RemoveCRLF(LScript);
    LScript := StringReplace(Lscript,'"','\"',[rfReplaceAll]);
    ContainerContext.WebApplication.CallBackResponse.AddJavaScriptToExecuteAsCDATA('$("#'+HTMLName+'").html("'+LScript+'");');
  finally
    LayoutMgr.SetContainer(nil);
    FreeAndNil(LBuffer);
    FreeAndNil(AContainerContext);
  end;
end;

destructor TIWBSCustomRegion.Destroy;
begin
  FGridOptions.Free;
  inherited;
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
  Result := TIWContainerContext.Create(AWebApplication, CacheControls);
  if (Self.LayoutMgr = nil) or not (Self.LayoutMgr.Able) then begin
    Self.LayoutMgr := TIWBSLayoutMgr.Create(Self);
    TIWBSLayoutMgr(Self.LayoutMgr).BSFormType := FFormType;
  end;
  LayoutMgr.SetContainer(Self);
  Result.LayoutManager := LayoutMgr;
end;

procedure TIWBSCustomRegion.InternalRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext; ABuffer: TIWRenderStream);
begin
  IWBSPrepareChildComponentsForRender(Self, FFormType, FChildRenderOptions);
  try
    THackTIWHTML40Container(Self).CallInheritedRenderComponents(AContainerContext, APageContext);
    LayoutMgr.ProcessControls(AContainerContext, TIWBaseHTMLPageContext(APageContext));
    LayoutMgr.Process(ABuffer, AContainerContext, APageContext);
  finally
    LayoutMgr.SetContainer(nil);
    FRegionDiv.Contents.AddBuffer(ABuffer);
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
  finally
    FreeAndNil(LBuffer);
  end;
end;

function TIWBSCustomRegion.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := '';
end;

function TIWBSCustomRegion.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  FRegionDiv := TIWHTMLTag.CreateTag('div');
  FRegionDiv.AddClassParam(FCss);
  FGridOptions.RenderHTMLTag(FRegionDiv);
  Result := FRegionDiv;
end;
{$endregion}

{$region 'TIWBSRegion'}
constructor TIWBSRegion.Create(AOwner: TComponent);
begin
  inherited;
  FRegionType := bsrtIWBSRegion;
end;

function TIWBSRegion.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result.AddClassParam(aIWBSRegionType[FRegionType]);
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

function TIWBSBtnGroup.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  if FBGOptions.FVertical then
    Result.AddClassParam('btn-group-vertical')
  else
    Result.AddClassParam('btn-group');
  if FBGOptions.FSize <> bsszDefault then
    Result.AddClassParam('btn-group-'+aIWBSSize[FBGOptions.FSize]);
  if FBGOptions.FJustified then
    Result.AddClassParam('btn-group-justified');
  Result.AddStringParam('role','group');
end;
{$endregion}

{$region 'TIWBSBtnToolBar'}
function TIWBSBtnToolBar.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result.AddClassParam('btn-toolbar');
  Result.AddStringParam('role','toolbar');
end;
{$endregion}

{$region 'TIWBSModal'}
constructor TIWBSModal.Create(AOwner: TComponent);
begin
  inherited;
  FDialogSize := bsszDefault;
  FFade := false;
end;

function TIWBSModal.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result.AddClassParam('modal');
  if FFade then
    Result.AddClassParam('fade');
  Result.AddStringParam('role','dialog');
  FRegionDiv := Result.Contents.AddTag('div');
  FRegionDiv.AddClassParam('modal-dialog');
  if FDialogSize in [bsszLg,bsszSm] then
    FRegionDiv.AddClassParam('modal-'+aIWBSSize[FDialogSize]);
  Result := FRegionDiv;
end;
{$endregion}

end.
