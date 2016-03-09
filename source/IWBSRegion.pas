unit IWBSRegion;

interface

uses
  SysUtils, Classes, Controls, Forms, StrUtils,
  IWVCLBaseContainer, IWApplication, IWBaseRenderContext,
  IWBaseContainerLayout, IWContainer, IWControl, IWHTMLContainer, IWHTML40Container, IWRegion, IW.Common.Strings,
  IWRenderContext, IWHTMLTag, IWBaseInterfaces, IWXMLTag, IWMarkupLanguageTag, IW.Common.RenderStream,
  IWBSCommon, IWBSRegionCommon, IWBSLayoutMgr, IWScriptEvents, IWBSRestServer, IW.HTTP.Request, IW.HTTP.Reply, IWBSCustomEvents;

type
  TIWBSCustomRegion = class(TIWCustomRegion, IIWBSComponent, IIWBSContainer)
  private
    FMainID: string;
    FOldCss: string;
    FOldStyle: string;
    FOldVisible: boolean;

    FAsyncRefreshControl: boolean;
    FRendered: boolean;
    FCustomAsyncEvents: TIWBSCustomAsyncEvents;
    FCustomRestEvents: TIWBSCustomRestEvents;
    FTagType: string;
    FCss: string;
    FGridOptions: TIWBSGridOptions;
    FRegionDiv: TIWHTMLTag;
    FScript: TStringList;
    FScriptInsideTag: boolean;
    FScriptParams: TIWBSScriptParams;
    FStyle: TStringList;
    FReleased: boolean;
    FContentSuffix: string;

    FOnAfterRender: TNotifyEvent;
    FOnAfterAsyncChange: TNotifyEvent;

    function HTMLControlImplementation: TIWHTMLControlImplementation;
    function IsScriptEventsStored: Boolean; virtual;
    function RegionDiv: TIWHTMLTag;

    procedure OnScriptChange(ASender : TObject);
    procedure OnStyleChange(ASender : TObject);
    function GetCustomAsyncEvents: TIWBSCustomAsyncEvents;
    procedure SetCustomAsyncEvents(const Value: TIWBSCustomAsyncEvents);
    function GetCustomRestEvents: TIWBSCustomRestEvents;
    procedure SetCustomRestEvents(const Value: TIWBSCustomRestEvents);
    procedure SetGridOptions(const AValue: TIWBSGridOptions);
    function GetScript: TStringList;
    procedure SetScript(const AValue: TStringList);
    function GetScriptParams: TIWBSScriptParams;
    procedure SetScriptParams(const AValue: TIWBSScriptParams);
    function GetStyle: TStringList;
    procedure SetStyle(const AValue: TStringList);
    function GetScriptInsideTag: boolean;
    procedure SetScriptInsideTag(const Value: boolean);
    function get_ScriptEvents: TIWScriptEvents;
    function GetAfterRender: TNotifyEvent;
    procedure set_ScriptEvents(const Value: TIWScriptEvents);
    procedure SetAfterRender(const Value: TNotifyEvent);
  protected
    {$hints off}
    function get_Visible: Boolean; override;
    procedure set_Visible(Value: Boolean); override;
    procedure SetParent(AParent: TWinControl); override;
    {$hints on}

    function ContainerPrefix: string; override;
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    procedure InternalRenderCss(var ACss: string); virtual;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); virtual;
    procedure InternalRenderStyle(AStyle: TStringList); virtual;
    property Released: boolean read FReleased;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure RenderScripts(AComponentContext: TIWCompContext); override;
    function RenderStyle(AContext: TIWCompContext): string; override;
    function SupportsInput: Boolean;
    procedure IWComponentsChanged(AComponent: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // Let you destroy the region inside a self event handler
    procedure Release;
    procedure AsyncRefreshControl;
    procedure ResetAsyncRefreshControl;
    procedure AsyncRemoveControl;
    procedure ApplyAsyncChanges;
    function GetCssString: string;
    function GetRoleString: string; virtual;
    function IsStoredCustomAsyncEvents: Boolean;
    function IsStoredCustomRestEvents: Boolean;
    function JQSelector: string;
    procedure SetFocus; override;
  published
    property Align;
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;
    property ClipRegion default False;
    property CustomAsyncEvents: TIWBSCustomAsyncEvents read GetCustomAsyncEvents write SetCustomAsyncEvents stored IsStoredCustomAsyncEvents;
    property CustomRestEvents: TIWBSCustomRestEvents read GetCustomRestEvents write SetCustomRestEvents stored IsStoredCustomRestEvents;
    property Css: string read FCss write FCss;
    property ExtraTagParams;
    property LayoutMgr;
    property RenderInvisibleControls default True;
    property ScriptEvents: TIWScriptEvents read get_ScriptEvents write set_ScriptEvents stored IsScriptEventsStored;
    property Script: TStringList read GetScript write SetScript;
    property ScriptInsideTag: boolean read GetScriptInsideTag write SetScriptInsideTag default True;
    property ScriptParams: TIWBSScriptParams read GetScriptParams write SetScriptParams;
    property Style: TStringList read GetStyle write SetStyle;
    property ZIndex default 0;

    // Occurs after component is rendered.
    property OnAfterRender: TNotifyEvent read GetAfterRender write SetAfterRender;

    // Occurs after component is changed on an Asyn call, it doesn't occurs if the control is fully rendered
    property OnAfterAsyncChange: TNotifyEvent read FOnAfterAsyncChange write FOnAfterAsyncChange;

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
    procedure InternalRenderCss(var ACss: string); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
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
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
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
    FCollapseVisible: boolean;
    FCollapse: boolean;
    procedure SetButtonGroupOptions(AValue: TIWBSButonGroupOptions);
    procedure SetRegionType(AValue: TIWBSRegionType);
    procedure SetPanelStyle(AValue: TIWBSPanelStyle);
    procedure SetRelativeSize(AValue: TIWBSRelativeSize);
    procedure SetCollapse(const Value: boolean);
    procedure SetCollapseVisible(const Value: boolean);
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetRoleString: string; override;
  published
    property BSButtonGroupOptions: TIWBSButonGroupOptions read FButtonGroupOptions write SetButtonGroupOptions;
    property BSPanelStyle: TIWBSPanelStyle read FPanelStyle write SetPanelStyle default bspsDefault;
    property BSRegionType: TIWBSRegionType read FRegionType write SetRegionType default bsrtNone;
    property BSRelativeSize: TIWBSRelativeSize read FRelativeSize write SetRelativeSize default bsrzDefault;
    property Collapse: boolean read FCollapse write SetCollapse default False;
    property CollapseVisible: boolean read FCollapseVisible write SetCollapseVisible default False;
  end;

  TIWBSNavBarFixed = (bsnvfxNone, bsnvfxTop, bsnvfxBottom);

  TIWBSNavBar = class(TIWBSCustomRegion)
  private
    FBrand: string;
    FBrandLink: string;
    FFluid: boolean;
    FFixed: TIWBSNavBarFixed;
    FInverse: boolean;
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Brand: string read FBrand write FBrand;
    property BrandLink: string read FBrandLink write FBrandLink;
    property BSFluid: boolean read FFluid write FFluid default False;
    property BSInverse: boolean read FInverse write FInverse default False;
    property BSFixed: TIWBSNavBarFixed read FFixed write FFixed default bsnvfxNone;
  end;

  TIWBSUnorderedList = class(TIWBSCustomRegion)
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
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

function IWBSFindParentInputForm(AParent: TControl): TIWBSInputForm;

implementation

uses IWForm, IWUtils, IW.Common.System, IWContainerLayout, IWBaseHTMLControl, IWBaseHTMLInterfaces,
     IWBSUtils, IWBSInputCommon, IWBSScriptEvents, IWBSGlobal;

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
type
  TIWContainerHack = class(TIWContainer);

constructor TIWBSCustomRegion.Create(AOwner: TComponent);
begin
  inherited;
  FAsyncRefreshControl := False;
  FRendered := False;
  FReleased := False;
  FCustomAsyncEvents := nil;
  FCustomRestEvents := nil;
  FCss := '';
  FContentSuffix := '';
  FGridOptions := TIWBSGridOptions.Create;
  FMainID := '';
  FScript := TStringList.Create;
  FScript.OnChange := OnScriptChange;
  FScriptInsideTag := True;
  FScriptParams := TIWBSScriptParams.Create;
  FScriptParams.OnChange := OnScriptChange;
  FStyle := TStringList.Create;
  FStyle.OnChange := OnStyleChange;
  FStyle.NameValueSeparator := ':';
  FTagType := 'div';

  ClipRegion := False;
  RenderInvisibleControls := True;
  set_ZIndex(0);

  if name = '' then
    name := IWBSGetUniqueComponentName(Owner, Copy(ClassName,2,MaxInt));
end;

destructor TIWBSCustomRegion.Destroy;
begin
  FreeAndNil(FCustomAsyncEvents);
  FreeAndNil(FCustomRestEvents);
  FreeAndNil(FGridOptions);
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);
  inherited;
end;

function TIWBSCustomRegion.get_ScriptEvents: TIWScriptEvents;
begin
  Result := inherited get_ScriptEvents;
end;

function TIWBSCustomRegion.get_Visible: Boolean;
begin
  if (Parent is TFrame) and (Name = 'IWFrameRegion') then
    Result := Parent.Visible
  else
    Result := inherited;
end;

procedure TIWBSCustomRegion.set_ScriptEvents(const Value: TIWScriptEvents);
begin
  inherited set_ScriptEvents(Value);
end;

procedure TIWBSCustomRegion.set_Visible(Value: Boolean);
begin
  inherited;
  if (Parent is TFrame) and (Name = 'IWFrameRegion') and (Parent.Visible <> Value) then
    Parent.Visible := Value;
end;

procedure TIWBSCustomRegion.SetParent(AParent: TWinControl);
begin
  inherited;
  if (Parent is TFrame) and (Name <> 'IWFrameRegion') and (Parent.FindComponent('IWFrameRegion') = nil) then
    Name := 'IWFrameRegion';
end;

function TIWBSCustomRegion.JQSelector: string;
begin
  Result := '$("#'+HTMLName+'")';
end;

procedure TIWBSCustomRegion.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBSCustomRegion.ResetAsyncRefreshControl;
begin
  FAsyncRefreshControl := False;
end;

procedure TIWBSCustomRegion.ApplyAsyncChanges;
begin
  if FAsyncRefreshControl or not FRendered then
    raise Exception.Create('Cannot apply changes now, control should be full refreshed');
  RenderAsync(nil);
  DoRefreshControl := False;
end;

procedure TIWBSCustomRegion.AsyncRemoveControl;
begin
  TIWBSCommon.AsyncRemoveControl(HTMLName);
  FAsyncRefreshControl := False;
  FRendered := False;
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

procedure TIWBSCustomRegion.SetFocus;
begin
  IWBSExecuteAsyncJScript(JQSelector+'.focus()');
end;

function TIWBSCustomRegion.IsScriptEventsStored: Boolean;
begin
  Result := ScriptEvents.Count > 0;
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

function TIWBSCustomRegion.GetAfterRender: TNotifyEvent;
begin
  Result := FOnAfterRender;
end;

function TIWBSCustomRegion.GetCssString: string;
begin
  Result := RenderCSSClass(nil);
end;

function TIWBSCustomRegion.GetCustomAsyncEvents: TIWBSCustomAsyncEvents;
begin
  if FCustomAsyncEvents = nil then
    FCustomAsyncEvents := TIWBSCustomAsyncEvents.Create(Self);
  Result := FCustomAsyncEvents;
end;

function TIWBSCustomRegion.GetCustomRestEvents: TIWBSCustomRestEvents;
begin
  if FCustomRestEvents = nil then
    FCustomRestEvents := TIWBSCustomRestEvents.Create(Self);
  Result := FCustomRestEvents;
end;

procedure TIWBSCustomRegion.SetAfterRender(const Value: TNotifyEvent);
begin
  FOnAfterRender := Value;
end;

procedure TIWBSCustomRegion.SetCustomAsyncEvents(const Value: TIWBSCustomAsyncEvents);
begin
  FCustomAsyncEvents.Assign(Value);
end;

procedure TIWBSCustomRegion.SetCustomRestEvents(const Value: TIWBSCustomRestEvents);
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

procedure TIWBSCustomRegion.SetScriptInsideTag(const Value: boolean);
begin
  FScriptInsideTag := Value;
end;

procedure TIWBSCustomRegion.SetScriptParams(const AValue: TIWBSScriptParams);
begin
  FScriptParams.Assign(AValue);
end;

function TIWBSCustomRegion.GetScript: TStringList;
begin
  Result := FScript;
end;

function TIWBSCustomRegion.GetScriptInsideTag: boolean;
begin
  Result := FScriptInsideTag;
end;

function TIWBSCustomRegion.GetScriptParams: TIWBSScriptParams;
begin
  Result := FScriptParams;
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

procedure TIWBSCustomRegion.IWComponentsChanged(AComponent: TComponent);
   procedure NotifyParentContainer(AParent: TWinControl);
   begin
     if (AParent is TIWContainer) then
       TIWContainerHack(AParent).IWComponentsChanged(AComponent)
     else if AParent.Parent <> nil then
       NotifyParentContainer(AParent.Parent);
   end;
begin
  if not (csDestroying in ComponentState) and Assigned(Parent) then
    NotifyParentContainer(Parent);
end;

procedure TIWBSCustomRegion.InternalRenderCss(var ACss: string);
begin
  //
end;

procedure TIWBSCustomRegion.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  //
end;

procedure TIWBSCustomRegion.InternalRenderStyle(AStyle: TStringList);
begin
  //
end;

function TIWBSCustomRegion.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
  xApplication: TIWApplication;
begin
  Result := nil;
  xHTMLName := HTMLName;

  if FAsyncRefreshControl or not FRendered then
    begin
      TIWBSRegionCommon.CancelChildAsyncRender(Self);
      TIWBSCommon.RenderAsync(xHTMLName, Self, AContext);
    end
  else
    begin
      if AContext = nil then
        xApplication := GGetWebApplicationThreadVar
      else
        xApplication := AContext.WebApplication;
      SetAsyncClass(xApplication, xHTMLName, RenderCSSClass(nil), FOldCss);
      SetAsyncStyle(xApplication, xHTMLName, RenderStyle(nil), FOldStyle);
      SetAsyncVisible(xApplication, FMainID, Visible, FOldVisible);

      if Assigned(FOnAfterAsyncChange) then
        FOnAfterAsyncChange(Self);

      if Assigned(gIWBSOnAfterAsyncChange) then
        gIWBSOnAfterAsyncChange(Self, xHTMLName);
    end;
end;

procedure TIWBSCustomRegion.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  TIWBSRegionCommon.RenderComponents(Self, AContainerContext, APageContext);
end;

function TIWBSCustomRegion.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := FGridOptions.GetClassString;
  if FCss <> '' then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + FCss;
  end;
  InternalRenderCss(Result);
end;

function TIWBSCustomRegion.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;

  FRegionDiv := TIWHTMLTag.CreateTag(FTagType);
  FRegionDiv.AddStringParam('id',HTMLName);
  FRegionDiv.AddClassParam(FOldCss);
  FRegionDiv.AddStringParam('role',GetRoleString);
  FRegionDiv.AddStringParam('style',RenderStyle(AContext));

  IWBSRenderScript(Self, AContext, FRegionDiv);
  FMainID := FRegionDiv.Params.Values['id'];

  Result := FRegionDiv;

  FAsyncRefreshControl := False;
  FRendered := True;
end;

procedure TIWBSCustomRegion.RenderScripts(AComponentContext: TIWCompContext);
begin
  //
end;

function TIWBSCustomRegion.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := TIWBSCommon.RenderStyle(Self);
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

procedure TIWBSInputForm.InternalRenderCss(var ACss: string);
begin
  if FFormType = bsftInline then
    TIWBSCommon.AddCssClass(ACss, 'form-inline')
  else if FFormType = bsftHorizontal then
    TIWBSCommon.AddCssClass(ACss, 'form-horizontal');
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

procedure TIWBSInputGroup.InternalRenderCss(var ACss: string);
begin
  TIWBSCommon.AddCssClass(ACss, 'input-group');
  if FRelativeSize <> bsrzDefault then
    TIWBSCommon.AddCssClass(ACss, 'input-group-'+aIWBSRelativeSize[FRelativeSize]);
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
  FRegionType := bsrtNone;
  FRelativeSize := bsrzDefault;
end;

destructor TIWBSRegion.Destroy;
begin
  FreeAndNil(FButtonGroupOptions);
  inherited;
end;

procedure TIWBSRegion.InternalRenderCss(var ACss: string);
const
  aIWBSPanelStyle: array[bspsDefault..bspsDanger] of string = ('panel-default', 'panel-primary', 'panel-success', 'panel-info', 'panel-warning', 'panel-danger');
begin
  TIWBSCommon.AddCssClass(ACss, aIWBSRegionType[FRegionType]);


  if FRegionType = bsrtPanel then
    TIWBSCommon.AddCssClass(ACss, aIWBSPanelStyle[FPanelStyle])

  else if (FRegionType = bsrtWell) and (FRelativeSize <> bsrzDefault) then
    TIWBSCommon.AddCssClass(ACss, ' well-' + aIWBSRelativeSize[FRelativeSize])

  else if FRegionType = bsrtButtonGroup then
    begin
      if FButtonGroupOptions.Vertical then
        ACss := ACss + '-vertical';
      if FButtonGroupOptions.Size <> bsszDefault then
        ACss := ACss + ' btn-group-'+aIWBSSize[FButtonGroupOptions.Size];
      if FButtonGroupOptions.Justified then
        ACss := ACss + ' btn-group-justified';
    end;

  if FCollapse then begin
    TIWBSCommon.AddCssClass(ACss, 'collapse');
    if FCollapseVisible then
      TIWBSCommon.AddCssClass(ACss, 'in');
  end;
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

procedure TIWBSRegion.SetCollapse(const Value: boolean);
begin
  FCollapse := Value;
  Invalidate;
end;

procedure TIWBSRegion.SetCollapseVisible(const Value: boolean);
begin
  FCollapseVisible := Value;
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

procedure TIWBSNavBar.InternalRenderCss(var ACss: string);
begin
  TIWBSCommon.AddCssClass(ACss, 'navbar navbar-'+iif(FInverse,'inverse', 'default'));
  if FFixed = bsnvfxTop then
    TIWBSCommon.AddCssClass(ACss, 'navbar-fixed-top')
  else if FFixed = bsnvfxBottom then
    TIWBSCommon.AddCssClass(ACss, ' navbar-fixed-bottom');
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

procedure TIWBSUnorderedList.InternalRenderCss(var ACss: string);
begin
  if Parent.ClassName = 'TIWBSNavBar' then
    TIWBSCommon.AddCssClass(ACss, 'nav navbar-nav')
  else
    TIWBSCommon.AddCssClass(ACss, 'list-group');
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

procedure TIWBSModal.InternalRenderCss(var ACss: string);
begin
  TIWBSCommon.AddCssClass(ACss, 'modal');
  if FFade then
    TIWBSCommon.AddCssClass(ACss, 'fade');
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

procedure TIWBSModal.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  inherited;
  AScript.Add('$("#'+AHTMLName+'").off("shown.bs.modal").on("shown.bs.modal", function() { var elem; elem = $(this).find("[autofocus]"); if (elem.length !== 0) {elem.focus();} else {$(this).find("button:last").focus(); } });');
  if Assigned(FOnAsyncShow) then begin
    AScript.Add('$("#'+AHTMLName+'").off("show.bs.modal").on("show.bs.modal", function(e){ executeAjaxEvent("", null, "'+AHTMLName+'.DoOnAsyncShow", true, null, true); });');
    AContext.WebApplication.RegisterCallBack(AHTMLName+'.DoOnAsyncShow', DoOnAsyncShow);
  end;
  AScript.Add('$("#'+AHTMLName+'").off("hidden.bs.modal").on("hidden.bs.modal", function(e){ executeAjaxEvent("", null, "'+AHTMLName+'.DoOnAsyncHide", true, null, true); });');
  AContext.WebApplication.RegisterCallBack(AHTMLName+'.DoOnAsyncHide', DoOnAsyncHide);
  if FModalVisible then
    AScript.Add(GetShowScript);
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
