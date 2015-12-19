unit IWBSRegionCommon;

interface
  uses System.Classes, System.SysUtils, Vcl.Forms,
       IWContainer, IWHTML40Container, IWRenderContext, IWBaseRenderContext, IW.Common.RenderStream, IWtypes, IWBaseInterfaces,
       IWBSCommon;

type
  TIWBSFormType = (bsftInline, bsftHorizontal, bsftVertical);

type
  TIWBSRegionType = (bsrtNone, bsrtContainer, bsrtContainerFluid, bsrtRow, bsrtColumn,
                     bsrtFormGroup,
                     bsrtJumbotron, bsrtPageHeader, bsrtWell,
                     bsrtIWBSRegion, bsrtIWBSToolbar,
                     bsrtButtonToolbar, bsrtButtonGroup,
                     bsrtModalContent, bsrtModalHeader, bsrtModalBody, bsrtModalFooter,
                     bsrtPanelGroup, bsrtPanel, bsrtPanelBody, bsrtPanelHeading, bsrtPanelFooter);

const
  aIWBSRegionType: array [bsrtNone..bsrtPanelFooter] of string =
                    ('', 'container', 'container-fluid', 'row', 'column',
                     'form-group',
                     'jumbotron', 'page-header', 'well',
                     'iwbs-region', 'iwbs-toolbar',
                     'btn-toolbar', 'btn-group',
                     'modal-content', 'modal-header', 'modal-body', 'modal-footer',
                     'panel-group', 'panel', 'panel-body', 'panel-heading', 'panel-footer');

type
  TIWBSButonGroupOptions = class(TPersistent)
  private
    FVertical: boolean;
    FJustified: boolean;
    FSize: TIWBSSize;
  public
    constructor Create(AOwner: TComponent);
    procedure Assign(Source: TPersistent); override;
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
    procedure Assign(Source: TPersistent); override;
  published
    property CaptionsSize: TIWBSGridOptions read FCaptionsSize write SetCaptionsSize;
    property InputsSize: TIWBSGridOptions read FInputsSize write SetInputsSize;
  end;

  TIWBSRegionCommon = class
  public
    class procedure CancelChildAsyncRender(AControl: TComponent);
    class procedure DisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);
    class procedure PrepareChildComponentsForRender(AContainer: IIWBaseContainer);
    class procedure RenderComponents(AContainer: IIWBSContainer; AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
  end;

implementation

uses IWHTML40Interfaces, IWRegion, IWForm, IWBaseHTMLInterfaces, IWMarkupLanguageTag,
     IWBSLayoutMgr, IWBSUtils, IWBSGlobal;

{$region 'TIWBSBtnGroupOptions'}
constructor TIWBSButonGroupOptions.Create(AOwner: TComponent);
begin
  FVertical := false;
  FJustified := false;
  FSize := bsszDefault;
end;

procedure TIWBSButonGroupOptions.Assign(Source: TPersistent);
begin
  if Source is TIWBSButonGroupOptions then
    begin
      Vertical := TIWBSButonGroupOptions(Source).Vertical;
      Justified := TIWBSButonGroupOptions(Source).Justified;
      Size := TIWBSButonGroupOptions(Source).Size;
    end
  else
    inherited;
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

procedure TIWBSFormOptions.Assign(Source: TPersistent);
begin
  if Source is TIWBSFormOptions then
    begin
      CaptionsSize.Assign(TIWBSFormOptions(Source).CaptionsSize);
      InputsSize.Assign(TIWBSFormOptions(Source).InputsSize);
    end
  else
    inherited;
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

    // TFrame
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

    // execute global OnRender hook
    if Assigned(gIWBSOnRender) then
      gIWBSOnRender(LComponent);
  end;
end;

class procedure TIWBSRegionCommon.RenderComponents(AContainer: IIWBSContainer; AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
var
  LBuffer: TIWRenderStream;
  LContentTag: TIWBinaryElement;
  i, j: integer;
begin
  PrepareChildComponentsForRender(AContainer);
  AContainer.ContainerContext := AContainerContext;
  LBuffer := TIWRenderStream.Create(True, True);
  try
    THackTIWHTML40Container(AContainer.InterfaceInstance).CallInheritedRenderComponents(AContainerContext, APageContext);
    THackTIWHTML40Container(AContainer.InterfaceInstance).LayoutMgr.ProcessControls(AContainerContext, TIWBaseHTMLPageContext(APageContext));
    THackTIWHTML40Container(AContainer.InterfaceInstance).LayoutMgr.Process(LBuffer, AContainerContext, APageContext);

    // insert content before scripts
    LContentTag := TIWBinaryElement.Create(nil);
    LContentTag.Buffer.Stream.CopyFrom(LBuffer.Stream, 0);
    j := -1;
    for i := 0 to AContainer.RegionDiv.Contents.Count-1 do
      if AContainer.RegionDiv.Contents.Items[i] is TIWMarkupLanguageTag then
        if TIWMarkupLanguageTag(AContainer.RegionDiv.Contents.Items[i]).Tag = 'script' then
          j := i;
    if j >= 0 then
      AContainer.RegionDiv.Contents.Insert(j, LContentTag)
    else
      AContainer.RegionDiv.Contents.Add(LContentTag);
  finally
    THackTIWHTML40Container(AContainer.InterfaceInstance).LayoutMgr.SetContainer(nil);
    FreeAndNil(LBuffer);
  end;
end;


class procedure TIWBSRegionCommon.CancelChildAsyncRender(AControl: TComponent);
var
  i: integer;
  LComponent: IIWBSComponent;
  LContainer: IIWBaseContainer;
begin
  AControl.GetInterface(IIWBSComponent, LComponent);
  if LComponent <> nil then
    LComponent.ResetAsyncRefreshControl;

  if AControl is TFrame then
    for i := 0 to AControl.ComponentCount-1 do
      CancelChildAsyncRender(AControl.Components[i])
  else
    begin
      AControl.GetInterface(IIWBaseContainer, LContainer);
      if LContainer <> nil then
        for i := 0 to LContainer.IWComponentsCount-1 do
          CancelChildAsyncRender(LContainer.Component[i])
    end;
end;
{$endregion}

end.
