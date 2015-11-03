unit IWBSRegionCommon;

interface
  uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.Forms,
       IWContainer, IWHTML40Container, IWRenderContext, IWBaseRenderContext, IW.Common.RenderStream, IWtypes,
       IWApplication, IWHTMLTag, IWBaseInterfaces,
       IWBSCommon;

type
  TIWBSFormType = (bsftInline, bsftHorizontal, bsftVertical);

type
  TIWBSRegionType = (bsrtNone, bsrtContainer, bsrtContainerFluid, bsrtRow, bsrtColumn,
                     bsrtFormGroup,
                     bsrtJumbotron, bsrtPageHeader, bsrtWell,
                     bsrtIWBSRegion, bsrtIWBSToolbar,
                     bsrtButtonToolbar, bsrtButtonGroup,
                     bsrtModalContent, bsrtModalHeader, bsrtModalTitle, bsrtModalBody, bsrtModalFooter,
                     bsrtPanel, bsrtPanelBody, bsrtPanelHeading, bsrtPanelTitle, bsrtPanelFooter);

const
  aIWBSRegionType: array [bsrtNone..bsrtPanelFooter] of string =
                    ('', 'container', 'container-fluid', 'row', 'column',
                     'form-group',
                     'jumbotron', 'page-header', 'well',
                     'iwbs-region', 'iwbs-toolbar',
                     'btn-toolbar', 'btn-group',
                     'modal-content', 'modal-header', 'modal-title', 'modal-body', 'modal-footer',
                     'panel', 'panel-body', 'panel-heading', 'panel-title', 'panel-footer');

type
  TIWBSButonGroupOptions = class(TPersistent)
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

  TIWBSFormOptions = class(TPersistent)
  private
    FCaptionsSize: TIWBSGridOptions;
    FInputsSize: TIWBSGridOptions;
  protected
    procedure SetCaptionsSize(const Value: TIWBSGridOptions);
    procedure SetInputsSize(const Value: TIWBSGridOptions);
  public
    constructor Create;
    destructor Destroy; override;
    function GetOffsetClassString: string;
  published
    property CaptionsSize: TIWBSGridOptions read FCaptionsSize write SetCaptionsSize;
    property InputsSize: TIWBSGridOptions read FInputsSize write SetInputsSize;
  end;

  IIWBSContainer = interface(IIWBaseContainer)
    ['{819FB21E-8204-450F-8778-3DEB56FDB062}']
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
    function ParentContainer: IIWBaseContainer;
    function RegionDiv: TIWHTMLTag;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag;

    function get_ContainerContext: TIWContainerContext;
    procedure set_ContainerContext(const AContainerContext: TIWContainerContext);
    function get_HTMLName: String;

    property ContainerContext: TIWContainerContext read get_ContainerContext write set_ContainerContext;
    property HTMLName: string read get_HTMLName;
  end;

  TIWBSRegionCommon = class
  private
    class function RenderHTMLTag(AContainer: IIWBSContainer; AContext: TIWCompContext): string;
  public
    class procedure DisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);
    class procedure PrepareChildComponentsForRender(AContainer: IIWBaseContainer);
    class procedure RenderAsync(AContainer: IIWBSContainer; AContext: TIWCompContext);
    class procedure RenderComponents(AContainer: IIWBSContainer; AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
  end;

implementation

uses IWHTML40Interfaces, IWRegion, IWForm, IWBaseHTMLInterfaces,
     IWBSLayoutMgr, IWBSUtils, IWBSGlobal;

{$region 'TIWBSBtnGroupOptions'}
constructor TIWBSButonGroupOptions.Create(AOwner: TComponent);
begin
  FVertical := false;
  FJustified := false;
  FSize := bsszDefault;
end;
{$endregion}

{$region 'TIWBSFormOptions'}
constructor TIWBSFormOptions.Create;
begin
  FCaptionsSize := TIWBSGridOptions.Create;
  FInputsSize := TIWBSGridOptions.Create;
end;

destructor TIWBSFormOptions.Destroy;
begin
  FreeAndNil(FCaptionsSize);
  FreeAndNil(FInputsSize);
  inherited;
end;

procedure TIWBSFormOptions.SetCaptionsSize(const Value: TIWBSGridOptions);
begin
  FCaptionsSize.Assign(Value);
end;

procedure TIWBSFormOptions.SetInputsSize(const Value: TIWBSGridOptions);
begin
  FInputsSize.Assign(Value);
end;

function TIWBSFormOptions.GetOffsetClassString: string;
begin
  Result := FCaptionsSize.GetGridClassString(
    FCaptionsSize.GridXSOffset+FCaptionsSize.GridXSSpan+FInputsSize.GridXSOffset,
    FCaptionsSize.GridSMOffset+FCaptionsSize.GridSMSpan+FInputsSize.GridSMOffset,
    FCaptionsSize.GridMDOffset+FCaptionsSize.GridMDSpan+FInputsSize.GridMDOffset,
    FCaptionsSize.GridLGOffset+FCaptionsSize.GridLGSpan+FInputsSize.GridLGOffset,
    FInputsSize.GridXSSpan,
    FInputsSize.GridSMSpan,
    FInputsSize.GridMDSpan,
    FInputsSize.GridLGSpan);
end;
{$endregion}

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

{$region 'TIWBSRegionCommon'}
class procedure TIWBSRegionCommon.DisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);
begin
  StyleRenderOptions.RenderAbsolute := False;
  StyleRenderOptions.RenderBorder := False;
  StyleRenderOptions.RenderFont := False;
  StyleRenderOptions.RenderPadding := False;
  StyleRenderOptions.RenderPosition := False;
  StyleRenderOptions.RenderSize := False;
  StyleRenderOptions.RenderZIndex := False;
end;

class procedure TIWBSRegionCommon.PrepareChildComponentsForRender(AContainer: IIWBaseContainer);
var
  i: integer;
  LComponent: TComponent;
  LFrameRegion: TComponent;
  LRegion: TIWRegion;
  LBaseControl: IIWBaseControl;
  LHTML40Control: IIWHTML40Control;
begin
  for i := 0 to AContainer.IWComponentsCount - 1 do begin

    LComponent := AContainer.Component[i];

    // if user forgot to delete the IWRegion of the TFrame
    if LComponent is TFrame then
      begin
        LFrameRegion := TFrame(LComponent).FindComponent('IWFrameRegion');
        if LFrameRegion is TIWRegion then begin
          LRegion := TIWRegion(LFrameRegion);
          if LRegion.LayoutMgr = nil then
            LRegion.LayoutMgr := TIWBSLayoutMgr.Create(AContainer.InterfaceInstance);
          LRegion.LayoutMgr.SetContainer(LRegion);
          PrepareChildComponentsForRender(LRegion);
        end;
     end

    // tab pages of TIWBSTabControl are still TIWTabPage
    else if LComponent.ClassName = 'TIWTabPage' then
      begin
        LRegion := TIWRegion(LComponent);
        if LRegion.LayoutMgr = nil then
          LRegion.LayoutMgr := TIWBSLayoutMgr.Create(AContainer.InterfaceInstance);
        LRegion.LayoutMgr.SetContainer(LRegion);
        PrepareChildComponentsForRender(LRegion);
      end;

    // disable child StyleRenderOptions
    LBaseControl := BaseControlInterface(LComponent);
    if Assigned(LBaseControl) then begin
      LHTML40Control := HTML40ControlInterface(AContainer.Component[i]);
      DisableRenderOptions(LHTML40Control.StyleRenderOptions);
    end;

    // global hook
    if Assigned(gIWBSOnBeforeRender) then
      gIWBSOnBeforeRender(LComponent);

  end;
end;

class procedure TIWBSRegionCommon.RenderAsync(AContainer: IIWBSContainer; AContext: TIWCompContext);
var
  LParentContainer: IIWBaseHTMLComponent;
  LParentSl: string;
  LHtmlTag: string;
begin
  // get base container
  if AContainer.ParentContainer.InterfaceInstance is TIWForm then
    LParentSl := 'body'
  else
    begin
      LParentContainer := BaseHTMLComponentInterface(AContainer.ParentContainer.InterfaceInstance);
      if LParentContainer <> nil then
        LParentSl := '#'+LParentContainer.HTMLName
      else
        Exit;
    end;
  LHtmlTag := RenderHtmlTag(AContainer, AContext);
  AContext.WebApplication.CallBackResponse.AddJavaScriptToExecuteAsCDATA('AsyncRenderControl("'+AContainer.HTMLName+'", "'+LParentSl+'", "'+IWBSTextToJsParamText(LHtmlTag)+'");')
end;

class procedure TIWBSRegionCommon.RenderComponents(AContainer: IIWBSContainer; AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
var
  LBuffer: TIWRenderStream;
begin
  PrepareChildComponentsForRender(AContainer);
  AContainer.ContainerContext := AContainerContext;
  LBuffer := TIWRenderStream.Create(True, True);
  try
    THackTIWHTML40Container(AContainer.InterfaceInstance).CallInheritedRenderComponents(AContainerContext, APageContext);
    THackTIWHTML40Container(AContainer.InterfaceInstance).LayoutMgr.ProcessControls(AContainerContext, TIWBaseHTMLPageContext(APageContext));
    THackTIWHTML40Container(AContainer.InterfaceInstance).LayoutMgr.Process(LBuffer, AContainerContext, APageContext);
    AContainer.RegionDiv.Contents.AddBuffer(LBuffer);
  finally
    THackTIWHTML40Container(AContainer.InterfaceInstance).LayoutMgr.SetContainer(nil);
    FreeAndNil(LBuffer);
  end;
end;

class function TIWBSRegionCommon.RenderHTMLTag(AContainer: IIWBSContainer; AContext: TIWCompContext): string;
var
  LBuffer: TIWRenderStream;
  LTag: TIWHTMLTag;
begin
  LTag := AContainer.RenderHTML(AContext);
  try
    if not TControl(AContainer.InterfaceInstance).Visible then
      TIWBSCommon.SetNotVisible(LTag.Params);

    // render child components
    RenderComponents(AContainer, AContainer.InitContainerContext(AContext.WebApplication), AContext.PageContext);

    LBuffer := TIWRenderStream.Create(True, True);
    try
      LTag.Render(LBuffer);
      Result := LBuffer.AsString;
    finally
      LBuffer.Free;
    end;
  finally
    LTag.Free;
  end;
end;
{$endregion}

end.
