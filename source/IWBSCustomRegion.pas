unit IWBSCustomRegion;

interface

{$Include IWBootstrap.inc}

uses
  SysUtils, Classes, Controls, Forms, StrUtils,
  IWApplication, IWBaseRenderContext,
  IWContainer, IWControl, IWHTMLContainer, IWHTML40Container, IWRegion, IWBaseHTMLControl,
  IWRenderContext, IWHTMLTag, IWBaseInterfaces, IWXMLTag,
  IWBSCommon, IWBSCommonInterfaces, IWBSLayoutMgr, IWScriptEvents, IWBSCustomEvents;

type
  TIWBSCustomRegion = class(TIWCustomRegion, IIWBSComponent, IIWBSContainer)
  private
    FOldCss: string;
    FOldStyle: string;
    FOldVisible: boolean;

    FAsyncRefreshControl: boolean;
    FRendered: boolean;
    FCustomAsyncEvents: TIWBSCustomAsyncEvents;
    FCustomRestEvents: TIWBSCustomRestEvents;
    FCss: string;
    FGridOptions: TIWBSGridOptions;
    FScript: TStringList;
    FScriptInsideTag: boolean;
    FScriptParams: TIWBSScriptParams;
    FStyle: TStringList;
    FReleased: boolean;
    FText: string;

    FCollapseVisible: boolean;
    FCollapse: boolean;

    FRawText: boolean;

    FOnAfterRender: TNotifyEvent;
    FOnAfterAsyncChange: TNotifyEvent;

    function HTMLControlImplementation: TIWHTMLControlImplementation;
    function RegionDiv: TIWHTMLTag;

    function  RenderText: string;

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
    function GetAfterRender: TNotifyEvent;
    procedure SetAfterRender(const Value: TNotifyEvent);
    procedure SetCollapse(const Value: boolean);
    procedure SetCollapseVisible(const Value: boolean);
    procedure SetRawText(const Value: boolean);
    procedure SetText(const Value: string);
    procedure SetCss(const Value: string);
    {$IFNDEF IW_14_1_0_UP}
    function IsScriptEventsStored: Boolean; virtual;
    function get_ScriptEvents: TIWScriptEvents;
    procedure set_ScriptEvents(const Value: TIWScriptEvents);
    {$ENDIF}
  protected
    FMainID: string;
    FRegionDiv: TIWHTMLTag;
    FTagName: string;

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

    property TagType: string read FTagName;
  published
    property Align;
    property BSGridOptions: TIWBSGridOptions read FGridOptions write SetGridOptions;
    property ClipRegion default False;
    property CustomAsyncEvents: TIWBSCustomAsyncEvents read GetCustomAsyncEvents write SetCustomAsyncEvents stored IsStoredCustomAsyncEvents;
    property CustomRestEvents: TIWBSCustomRestEvents read GetCustomRestEvents write SetCustomRestEvents stored IsStoredCustomRestEvents;
    property Css: string read FCss write SetCss;
    property Collapse: boolean read FCollapse write SetCollapse default False;
    property CollapseVisible: boolean read FCollapseVisible write SetCollapseVisible default False;
    property ExtraTagParams;
    property LayoutMgr;
    property RawText: boolean read FRawText write SetRawText default False;
    property RenderInvisibleControls default True;
    property ScriptEvents {$IFNDEF IW_14_1_0_UP}: TIWScriptEvents read get_ScriptEvents write set_ScriptEvents stored IsScriptEventsStored {$ENDIF};
    property Script: TStringList read GetScript write SetScript;
    property ScriptInsideTag: boolean read GetScriptInsideTag write SetScriptInsideTag default True;
    property ScriptParams: TIWBSScriptParams read GetScriptParams write SetScriptParams;
    property Style: TStringList read GetStyle write SetStyle;
    property Text: string read FText write SetText;
    property ZIndex default 0;

    // Occurs after component is rendered.
    property OnAfterRender: TNotifyEvent read GetAfterRender write SetAfterRender;

    // Occurs after component is changed on an Asyn call, it doesn't occurs if the control is fully rendered
    property OnAfterAsyncChange: TNotifyEvent read FOnAfterAsyncChange write FOnAfterAsyncChange;

    property OnHTMLTag;
  end;

implementation

uses
  IWBSUtils, IWBSScriptEvents, IWBSGlobal;

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
  FGridOptions := TIWBSGridOptions.Create(Self);
  FMainID := '';
  FScript := TStringList.Create;
  FScript.OnChange := OnScriptChange;
  FScriptInsideTag := True;
  FScriptParams := TIWBSScriptParams.Create;
  FScriptParams.OnChange := OnScriptChange;
  FStyle := TStringList.Create;
  FStyle.OnChange := OnStyleChange;
  FStyle.NameValueSeparator := ':';
  FTagName := 'div';

  ClipRegion := False;
  RenderInvisibleControls := True;
  ZIndex := 0;

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

{$IFNDEF IW_14_1_0_UP}
function TIWBSCustomRegion.get_ScriptEvents: TIWScriptEvents;
begin
  Result := inherited get_ScriptEvents;
end;

procedure TIWBSCustomRegion.set_ScriptEvents(const Value: TIWScriptEvents);
begin
  inherited set_ScriptEvents(Value);
end;

function TIWBSCustomRegion.IsScriptEventsStored: Boolean;
begin
  Result := ScriptEvents.Count > 0;
end;
{$ENDIF}

function TIWBSCustomRegion.get_Visible: Boolean;
begin
  if (Parent is TFrame) and (Name = 'IWFrameRegion') then
    Result := Parent.Visible
  else
    Result := inherited;
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

procedure TIWBSCustomRegion.SetRawText(const Value: boolean);
begin
  FRawText := Value;
  AsyncRefreshControl;
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
  TIWBSCommon.AsyncRemoveControl(FMainID);
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

procedure TIWBSCustomRegion.SetCollapse(const Value: boolean);
begin
  FCollapse := Value;
  Invalidate;
end;

procedure TIWBSCustomRegion.SetCollapseVisible(const Value: boolean);
begin
  FCollapseVisible := Value;
  Invalidate;
end;

procedure TIWBSCustomRegion.SetCss(const Value: string);
begin
  FCss := Value;
  Invalidate;
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

procedure TIWBSCustomRegion.SetText(const Value: string);
begin
  FText := TrimRight(Value);
  AsyncRefreshControl;
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
  if FCollapse then begin
    TIWBSCommon.AddCssClass(ACss, 'collapse');
    if FCollapseVisible then
      TIWBSCommon.AddCssClass(ACss, 'in');
  end;
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
      TIWBSCommon.SetAsyncClass(xApplication, xHTMLName, RenderCSSClass(nil), FOldCss);
      TIWBSCommon.SetAsyncStyle(xApplication, xHTMLName, RenderStyle(nil), FOldStyle);
      TIWBSCommon.SetAsyncVisible(xApplication, FMainID, Visible, FOldVisible);

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

  FRegionDiv := TIWHTMLTag.CreateTag(FTagName);
  FRegionDiv.AddStringParam('id',HTMLName);
  FRegionDiv.AddClassParam(FOldCss);
  FRegionDiv.AddStringParam('role',GetRoleString);
  FRegionDiv.AddStringParam('style',RenderStyle(AContext));

  if FText <> '' then
    FRegionDiv.Contents.AddText(RenderText);

  IWBSRenderScript(Self, AContext, FRegionDiv);
  FMainID := FRegionDiv.Params.Values['id'];

  if gIWBSAttributeCmpName <> '' then
    FRegionDiv.Params.Values[gIWBSAttributeCmpName] := name;

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

function TIWBSCustomRegion.RenderText: string;
var
  i: integer;
  LLines: TStringList;
  lHTMLName: string;
begin
  if RawText then
    begin
      lHTMLName := HTMLName;

      LLines := TStringList.Create;
      try
        LLines.Text := FText;

        // replace params before custom events
        LLines.Text := TIWBSCommon.ReplaceParams(Self, LLines.Text);

        // replace inner events calls
        if IsStoredCustomAsyncEvents then
          for i := 0 to CustomAsyncEvents.Count-1 do
            TIWBSCustomAsyncEvent(CustomAsyncEvents.Items[i]).ParseParam(lHTMLName, LLines);

        // replace inner events calls
        if IsStoredCustomRestEvents then
          for i := 0 to CustomRestEvents.Count-1 do
            TIWBSCustomRestEvent(CustomRestEvents.Items[i]).ParseParam(LLines);

        Result := LLines.Text;
      finally
        LLines.Free;
      end;
    end
  else
    Result := TIWBaseHTMLControl.TextToHTML(FText);
end;

end.
