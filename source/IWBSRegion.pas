unit IWBSRegion;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, System.StrUtils,
  IWVCLBaseContainer, IWApplication, IWBaseRenderContext,
  IWBaseContainerLayout, IWContainer, IWControl, IWHTMLContainer, IWHTML40Container, IWRegion, IW.Common.Strings,
  IWRenderContext, IWHTMLTag, IWBaseInterfaces, IWXMLTag, IWMarkupLanguageTag, IW.Common.RenderStream,
  IWBSCommon, IWBSRegionCommon, IWBSLayoutMgr, IWScriptEvents, IWBSRestServer, IW.HTTP.Request, IW.HTTP.Reply;

type
  TIWBSCustomRegion = class(TIWCustomRegion, IIWBSComponent, IIWBSContainer)
  private
    FOldCss: string;
    FOldStyle: string;
    FOldVisible: boolean;

    FAsyncRefreshControl: boolean;
    FCustomAsyncEvents: TOwnedCollection;
    FCustomRestEvents: TOwnedCollection;
    FTagType: string;
    FCss: string;
    FGridOptions: TIWBSGridOptions;
    FRegionDiv: TIWHTMLTag;
    FScript: TStringList;
    FScriptParams: TStringList;
    FStyle: TStringList;
    FReleased: boolean;
    FContentSuffix: string;
    FOnRenderAsync: TNotifyEvent;

    function HTMLControlImplementation: TIWHTMLControlImplementation;
    function IsScriptEventsStored: Boolean; virtual;
    function RegionDiv: TIWHTMLTag;

    procedure SetGridOptions(const AValue: TIWBSGridOptions);
    procedure SetScript(const AValue: TStringList);
    procedure SetScriptParams(const AValue: TStringList);
    function GetStyle: TStringList;
    procedure SetStyle(const AValue: TStringList);
    procedure OnScriptChange(ASender : TObject);
    procedure OnStyleChange(ASender : TObject);
    function ReadCustomAsyncEvents: TOwnedCollection;
    function ReadCustomRestEvents: TOwnedCollection;
    procedure SetCustomAsyncEvents(const Value: TOwnedCollection);
    procedure SetCustomRestEvents(const Value: TOwnedCollection);
  protected
    function ContainerPrefix: string; override;
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    function InternalRenderScript: string;
    property Released: boolean read FReleased;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure RenderScripts(AComponentContext: TIWCompContext); override;
    function RenderStyle(AContext: TIWCompContext): string; override;
    function SupportsInput: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Release;
    procedure AsyncRefreshControl;
    procedure AsyncRemoveControl;
    function GetClassString: string; virtual;
    function GetRoleString: string; virtual;
    function IsStoredCustomAsyncEvents: Boolean;
    function IsStoredCustomRestEvents: Boolean;
  published
    property Align;
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;
    property ClipRegion default False;
    property CustomAsyncEvents: TOwnedCollection read ReadCustomAsyncEvents write SetCustomAsyncEvents stored IsStoredCustomAsyncEvents;
    property CustomRestEvents: TOwnedCollection read ReadCustomRestEvents write SetCustomRestEvents stored IsStoredCustomRestEvents;
    property Css: string read FCss write FCss;
    property ExtraTagParams;
    property RenderInvisibleControls default False;
    property ScriptEvents: TIWScriptEvents read get_ScriptEvents write set_ScriptEvents stored IsScriptEventsStored;
    property Script: TStringList read FScript write SetScript;
    property ScriptParams: TStringList read FScriptParams write SetScriptParams;
    property Style: TStringList read GetStyle write SetStyle;
    property ZIndex default 0;

    property OnRenderAsync: TNotifyEvent read FOnRenderAsync write FOnRenderAsync;
    property OnHTMLTag;
  end;

  TIWBSFormEncType = (iwbsfeDefault, iwbsfeMultipart, iwbsfeText);

  TIWBSInputFormSubmitEvent = procedure(aRequest: THttpRequest; aParams: TStrings) of object;

  TIWBSInputForm = class(TIWBSCustomRegion)
  private
    FEncType: TIWBSFormEncType;
    FFormType: TIWBSFormType;
    FFormOptions: TIWBSFormOptions;
    FOnSubmit: TIWBSInputFormSubmitEvent;
    procedure DoSubmit(aApplication: TIWApplication; aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings);
  protected
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetClassString: string; override;
    function GetRoleString: string; override;
  published
    property BSFormType: TIWBSFormType read FFormType write FFormType default bsftVertical;
    property BSFormOptions: TIWBSFormOptions read FFormOptions write FFormOptions;
    property EncType: TIWBSFormEncType read FEncType write FEncType default iwbsfeDefault;
    property OnSubmit: TIWBSInputFormSubmitEvent read FOnSubmit write FOnSubmit;
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

  TIWBSFormControl = class(TIWBSCustomRegion)
  private
    FCaption: string;
  public
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Caption: string read FCaption write FCaption;
  end;

  TIWBSRegion = class(TIWBSCustomRegion)
  private
    FButtonGroupOptions: TIWBSButonGroupOptions;
    FPanelStyle: TIWBSPanelStyle;
    FRegionType: TIWBSRegionType;
    FRelativeSize: TIWBSRelativeSize;
    procedure SetButtonGroupOptions(AValue: TIWBSButonGroupOptions);
    procedure SetRegionType(AValue: TIWBSRegionType);
    procedure SetPanelStyle(AValue: TIWBSPanelStyle);
    procedure SetRelativeSize(AValue: TIWBSRelativeSize);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetClassString: string; override;
    function GetRoleString: string; override;
  published
    property BSButtonGroupOptions: TIWBSButonGroupOptions read FButtonGroupOptions write SetButtonGroupOptions;
    property BSPanelStyle: TIWBSPanelStyle read FPanelStyle write SetPanelStyle default bspsDefault;
    property BSRegionType: TIWBSRegionType read FRegionType write SetRegionType default bsrtIWBSRegion;
    property BSRelativeSize: TIWBSRelativeSize read FRelativeSize write SetRelativeSize default bsrzDefault;
    property LayoutMgr;
  end;

  TIWBSNavBarFixed = (bsnvfxNone, bsnvfxTop, bsnvfxBottom);

  TIWBSNavBar = class(TIWBSCustomRegion)
  private
    FBrand: string;
    FBrandLink: string;
    FFluid: boolean;
    FFixed: TIWBSNavBarFixed;
    FInverse: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    function GetClassString: string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Brand: string read FBrand write FBrand;
    property BrandLink: string read FBrandLink write FBrandLink;
    property BSFluid: boolean read FFluid write FFluid default False;
    property BSInverse: boolean read FInverse write FInverse default False;
    property BSFixed: TIWBSNavBarFixed read FFixed write FFixed default bsnvfxNone;
  end;

  TIWBSUnorderedList = class(TIWBSCustomRegion)
  public
    constructor Create(AOwner: TComponent); override;
    function GetClassString: string; override;
  end;

  TIWBSModal = class(TIWBSCustomRegion)
  private
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
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetClassString: string; override;
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

function IWBSFindParentInputForm(AParent: TControl): TIWBSInputForm;

implementation

uses IWForm, IWUtils, IW.Common.System, IWContainerLayout, IWBaseHTMLControl, IWBaseHTMLInterfaces,
     IWBSUtils, IWBSInputCommon, IWBSScriptEvents, IWBSGlobal, IWBSCustomEvents;

{$region 'help functions'}
function IWBSFindParentInputForm(AParent: TControl): TIWBSInputForm;
begin
  if AParent is TIWBSInputForm then
    Result := TIWBSInputForm(AParent)
  else if AParent.Parent <> nil then
    Result := IWBSFindParentInputForm(AParent.Parent)
  else
    Result := nil;
end;
{$endregion}

{$region 'TIWBSCustomRegion'}
constructor TIWBSCustomRegion.Create(AOwner: TComponent);
begin
  inherited;
  FAsyncRefreshControl := True;
  FReleased := False;
  FCss := '';
  FContentSuffix := '';
  FGridOptions := TIWBSGridOptions.Create;
  FScript := TStringList.Create;
  FScript.OnChange := OnScriptChange;
  FScriptParams := TStringList.Create;
  FScriptParams.OnChange := OnScriptChange;
  FStyle := TStringList.Create;
  FStyle.OnChange := OnStyleChange;
  FStyle.NameValueSeparator := ':';
  FTagType := 'div';
  ClipRegion := False;
  RenderInvisibleControls := False;
  ZIndex := 0;

  if name = '' then
    name := IWBSGetUniqueComponentName(Owner, Copy(ClassName,2,MaxInt));
end;

destructor TIWBSCustomRegion.Destroy;
begin
  FreeAndNil(FGridOptions);
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);
  inherited;
end;

procedure TIWBSCustomRegion.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBSCustomRegion.AsyncRemoveControl;
begin
  TIWBSCommon.AsyncRemoveControl(HTMLName);
end;

procedure TIWBSCustomRegion.Release;
var
  LWebApplication: TIWApplication;
begin
  if Released then Exit;

  FReleased := True;
  Hide;

  LWebApplication := GGetWebApplicationThreadVar;
  if LWebApplication <> nil then
    if Parent is TFrame then
      LWebApplication.ReleaseForm(Parent)
    else
      LWebApplication.ReleaseForm(Self);
end;

function TIWBSCustomRegion.IsScriptEventsStored: Boolean;
begin
  Result := ScriptEvents.Count > 0;
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

procedure TIWBSCustomRegion.SetGridOptions(const AValue: TIWBSGridOptions);
begin
  FGridOptions.Assign(AValue);
  Invalidate;
end;

procedure TIWBSCustomRegion.OnScriptChange( ASender : TObject );
begin
  AsyncRefreshControl;
end;

procedure TIWBSCustomRegion.OnStyleChange( ASender : TObject );
begin
  Invalidate;
end;

function TIWBSCustomRegion.ReadCustomAsyncEvents: TOwnedCollection;
begin
  if FCustomAsyncEvents = nil then
    FCustomAsyncEvents := TOwnedCollection.Create(Self, TIWBSCustomAsyncEvent);
  Result := FCustomAsyncEvents;
end;

function TIWBSCustomRegion.ReadCustomRestEvents: TOwnedCollection;
begin
  if FCustomRestEvents = nil then
    FCustomRestEvents := TOwnedCollection.Create(Self, TIWBSCustomRestEvent);
  Result := FCustomRestEvents;
end;

procedure TIWBSCustomRegion.SetCustomAsyncEvents(const Value: TOwnedCollection);
begin
  FCustomAsyncEvents.Assign(Value);
end;

procedure TIWBSCustomRegion.SetCustomRestEvents(const Value: TOwnedCollection);
begin
  FCustomRestEvents.Assign(Value);
end;

function TIWBSCustomRegion.IsStoredCustomAsyncEvents: boolean;
begin
  Result := (FCustomAsyncEvents <> nil) and (FCustomAsyncEvents.Count > 0);
end;

function TIWBSCustomRegion.IsStoredCustomRestEvents: boolean;
begin
  Result := (FCustomRestEvents <> nil) and (FCustomRestEvents.Count > 0);
end;

procedure TIWBSCustomRegion.SetScript(const AValue: TStringList);
begin
  FScript.Assign(AValue);
end;

procedure TIWBSCustomRegion.SetScriptParams(const AValue: TStringList);
begin
  FScriptParams.Assign(AValue);
end;

function TIWBSCustomRegion.GetStyle: TStringList;
begin
  Result := FStyle;
end;

procedure TIWBSCustomRegion.SetStyle(const AValue: TStringList);
begin
  FStyle.Assign(AValue);
end;

function TIWBSCustomRegion.ContainerPrefix: string;
begin
  if Owner is TFrame then
    Result := UpperCase(TFrame(Owner).Name)
  else if isBaseContainer(Parent) then
    Result := BaseContainerInterface(Parent).ContainerPrefix
  else
    Result := UpperCase(Name);
end;

function TIWBSCustomRegion.HTMLControlImplementation: TIWHTMLControlImplementation;
begin
  Result := ControlImplementation;
end;

function TIWBSCustomRegion.RegionDiv: TIWHTMLTag;
begin
  Result := FRegionDiv;
end;

function TIWBSCustomRegion.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  if not (Self.LayoutMgr is TIWBSLayoutMgr) then
    Self.LayoutMgr := TIWBSLayoutMgr.Create(Self);
  Result := inherited;
end;

function TIWBSCustomRegion.SupportsInput: Boolean;
begin
  Result := False;
end;

function TIWBSCustomRegion.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
begin
  Result := nil;
  xHTMLName := HTMLName;

  if FAsyncRefreshControl then
    TIWBSRegionCommon.RenderAsync(Self, AContext)
  else
    begin
      SetAsyncClass(AContext, xHTMLName, RenderCSSClass(AContext), FOldCss);
      SetAsyncStyle(AContext, xHTMLName, RenderStyle(AContext), FOldStyle);
      SetAsyncVisible(AContext, xHTMLName, Visible, FOldVisible);
    end;

  if Assigned(FOnRenderAsync) then
    FOnRenderAsync(Self);

  if Assigned(gIWBSOnRenderAsync) then
    gIWBSOnRenderAsync(Self, xHTMLName);
end;

procedure TIWBSCustomRegion.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  TIWBSRegionCommon.RenderComponents(Self, AContainerContext, APageContext);
end;

function TIWBSCustomRegion.InternalRenderScript: string;
begin
  Result := TIWBSCommon.ReplaceParams(HTMLName, FScript.Text, FScriptParams);
end;

procedure TIWBSCustomRegion.RenderScripts(AComponentContext: TIWCompContext);
begin
  //
end;

function TIWBSCustomRegion.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := TIWBSCommon.RenderStyle(Self);
end;

function TIWBSCustomRegion.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := Css;
end;

function TIWBSCustomRegion.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;

  FRegionDiv := TIWHTMLTag.CreateTag(FTagType);
  FRegionDiv.AddStringParam('id',HTMLName);
  FRegionDiv.AddClassParam(GetClassString);
  FRegionDiv.AddStringParam('role',GetRoleString);
  FRegionDiv.AddStringParam('style',RenderStyle(AContext));
  Result := FRegionDiv;

  IWBSRenderScript(Self, AContext, Result);
  FAsyncRefreshControl := False;
end;
{$endregion}

{$region 'TIWBSInputForm'}
constructor TIWBSInputForm.Create(AOwner: TComponent);
begin
  inherited;
  FEncType := iwbsfeDefault;
  FFormOptions := TIWBSFormOptions.Create;
  FFormType := bsftVertical;
  FTagType := 'form'
end;

destructor TIWBSInputForm.Destroy;
begin
  FreeAndNil(FFormOptions);
  inherited;
end;

function TIWBSInputForm.GetClassString: string;
var
  s: string;
begin
  if FFormType = bsftInline then
    Result := 'form-inline'
  else if FFormType = bsftHorizontal then
    Result := 'form-horizontal';
  s := inherited;
  if s <> '' then
    Result := Result + ' ' + s;
end;

function TIWBSInputForm.GetRoleString: string;
begin
  Result := 'form';
end;

procedure TIWBSInputForm.DoSubmit(aApplication: TIWApplication; aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings);
begin
  if Assigned(FOnSubmit) then
    FOnSubmit(aRequest, aParams);
  aReply.SendRedirect(aApplication.SessionInternalUrlBase);
end;

function TIWBSInputForm.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  LParentForm: TIWBSInputForm;
begin
  LParentForm := IWBSFindParentInputForm(Parent);
  if LParentForm <> nil then
    raise Exception.Create('forms can not be nested, you try to put '+Name+' inside '+LParentForm.Name);

  Result := inherited;

  if Assigned(FOnSubmit) then
    begin
      Result.AddStringParam('method', 'post');
      if FEncType = iwbsfeMultipart then
        Result.AddStringParam('enctype', 'multipart/form-data')
      else if FEncType = iwbsfeText then
        Result.AddStringParam('enctype', 'text/plain');
      Result.AddStringParam('action', IWBSRegisterRestCallBack(AContext.WebApplication, HTMLName+'.FormSubmit', DoSubmit, (FEncType = iwbsfeMultipart)));
    end
  else
    Result.AddStringParam('onSubmit', 'return FormDefaultSubmit();');
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
  Result := IWBSCreateInputFormGroup(Self, Parent, Result, FCaption, HTMLName);
end;
{$endregion}

{$region 'TIWBSFormControl'}
function TIWBSFormControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := Inherited;
  Result := IWBSCreateInputFormGroup(Self, Parent, Result, FCaption, HTMLName);
end;
{$endregion}

{$region 'TIWBSRegion'}
constructor TIWBSRegion.Create(AOwner: TComponent);
begin
  inherited;
  FButtonGroupOptions := TIWBSButonGroupOptions.Create(Self);
  FPanelStyle := bspsDefault;
  FRegionType := bsrtIWBSRegion;
  FRelativeSize := bsrzDefault;
end;

destructor TIWBSRegion.Destroy;
begin
  FreeAndNil(FButtonGroupOptions);
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
      if FButtonGroupOptions.Size <> bsszDefault then
        Result := Result + ' btn-group-'+aIWBSSize[FButtonGroupOptions.Size];
      if FButtonGroupOptions.Justified then
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

procedure TIWBSRegion.SetButtonGroupOptions(AValue: TIWBSButonGroupOptions);
begin
  FButtonGroupOptions.Assign(AValue);
  Invalidate;
end;

procedure TIWBSRegion.SetRegionType(AValue: TIWBSRegionType);
begin
  FRegionType := AValue;
  Invalidate;
end;

procedure TIWBSRegion.SetPanelStyle(AValue: TIWBSPanelStyle);
begin
  FPanelStyle := AValue;
  Invalidate;
end;

procedure TIWBSRegion.SetRelativeSize(AValue: TIWBSRelativeSize);
begin
  FRelativeSize := AValue;
  Invalidate;
end;
{$endregion}

{$region 'TIWBSNavBar'}
constructor TIWBSNavBar.Create(AOwner: TComponent);
begin
  inherited;
  FFluid := False;
  FFixed := bsnvfxNone;
  FInverse := False;
  FTagType := 'nav';
end;

function TIWBSNavBar.GetClassString: string;
var
  s: string;
begin
  Result := 'navbar navbar-'+iif(FInverse,'inverse', 'default');
  if FFixed = bsnvfxTop then
    Result := Result + ' navbar-fixed-top'
  else if FFixed = bsnvfxBottom then
    Result := Result + ' navbar-fixed-bottom';
  s := inherited;
  if s <> '' then
    Result := Result + ' ' + s;
end;

function TIWBSNavBar.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName+'_body';

  Result := Inherited;
  with Result.Contents.AddTag('div') do begin
    AddClassParam('container'+iif(FFluid, '-fluid'));
    with Contents.AddTag('div') do begin
      AddClassParam('navbar-header');
      with Contents.AddTag('a') do begin
        AddClassParam('navbar-brand');
        AddStringParam('href',iif(FBrandLink <> '', FBrandLink, '#'));
        AddStringParam('target','_blank');
        Contents.AddText(FBrand);
      end;
      with Contents.AddTag('button') do begin
        AddStringParam('type','button');
        AddClassParam('navbar-toggle');
        AddStringParam('data-toggle','collapse');
        AddStringParam('data-target','#'+xHTMLName);
        Contents.AddTag('span').AddClassParam('icon-bar');
        Contents.AddTag('span').AddClassParam('icon-bar');
        Contents.AddTag('span').AddClassParam('icon-bar');
      end;
    end;
    FRegionDiv := Contents.AddTag('div');
    FRegionDiv.AddClassParam('collapse');
    FRegionDiv.AddClassParam('navbar-collapse');
    FRegionDiv.AddStringParam('id',xHTMLName);
  end;
end;
{$endregion}

{$region 'TIWBSUnorderedList'}
constructor TIWBSUnorderedList.Create(AOwner: TComponent);
begin
  inherited;
  FTagType := 'ul';
end;

function TIWBSUnorderedList.GetClassString: string;
var
  s: string;
begin
  if Parent.ClassName = 'TIWBSNavBar' then
    Result := 'nav navbar-nav'
  else
    Result := 'list-group';
  s := inherited;
  if s <> '' then
    Result := Result + ' ' + s;
end;
{$endregion}

{$region 'TIWBSModal'}
constructor TIWBSModal.Create(AOwner: TComponent);
begin
  inherited;
  FDestroyOnHide := False;
  FDialogSize := bsszDefault;
  FFade := false;
  FModalVisible := false;
  FContentSuffix := '_dialog'
end;

destructor TIWBSModal.Destroy;
begin
  SetModalVisible(False);
  inherited;
end;

function TIWBSModal.GetClassString: string;
var
  s: string;
begin
  Result := 'modal';
  if FFade then
    Result := Result + ' fade';
  s := inherited;
  if s <> '' then
    Result := Result + ' ' + s;
  Result := Result + s;
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

function TIWBSModal.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  LCss: string;
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  Result := inherited;

  // container
  FRegionDiv := Result.Contents.AddTag('div');
  FRegionDiv.AddStringParam('id',xHTMLName+FContentSuffix);
  LCss := 'modal-dialog';
  if FDialogSize in [bsszLg,bsszSm] then
    LCss := LCss + ' modal-'+aIWBSSize[FDialogSize];
  FRegionDiv.AddClassParam(LCss);

  // add script (should be moved to InternalRenderScript)
  with Result.Contents.AddTag('script').Contents do begin
    AddText('$("#'+xHTMLName+'").off("shown.bs.modal").on("shown.bs.modal", function() { $(this).find("[autofocus]").focus(); });'+LF);
    if Assigned(FOnAsyncShow) then begin
      AddText('$("#'+xHTMLName+'").off("show.bs.modal").on("show.bs.modal", function(e){ executeAjaxEvent("", null, "'+xHTMLName+'.DoOnAsyncShow", true, null, true); });'+LF);
      AContext.WebApplication.RegisterCallBack(xHTMLName+'.DoOnAsyncShow', DoOnAsyncShow);
    end;
    AddText('$("#'+xHTMLName+'").off("hidden.bs.modal").on("hidden.bs.modal", function(e){ executeAjaxEvent("", null, "'+xHTMLName+'.DoOnAsyncHide", true, null, true); });'+LF);
    AContext.WebApplication.RegisterCallBack(xHTMLName+'.DoOnAsyncHide', DoOnAsyncHide);
    if FModalVisible then
      AddText(GetShowScript+LF);
  end;
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
{$endregion}

end.
