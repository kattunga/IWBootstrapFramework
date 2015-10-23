unit IWBSRegionCommon;

interface
  uses System.Classes, Vcl.Controls, Vcl.Forms,
       IWContainer, IWBSCommon, IWRenderContext;

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

procedure IWBSPrepareChildComponentsForRender(AContainer: TIWContainer);

implementation

uses IWBaseInterfaces, IWHTML40Interfaces,
     IWRegion, IWBSLayoutMgr, IWBSUtils;

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
  FCaptionsSize.Free;
  FInputsSize.Free;
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

procedure IWBSPrepareChildComponentsForRender(AContainer: TIWContainer);
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
            LRegion.LayoutMgr := TIWBSLayoutMgr.Create(AContainer);
          LRegion.LayoutMgr.SetContainer(LRegion);
          IWBSPrepareChildComponentsForRender(LRegion);
        end;
     end

    // tab pages of TIWBSTabControl are still TIWTabPage
    else if LComponent.ClassName = 'TIWTabPage' then
      begin
        LRegion := TIWRegion(LComponent);
        if LRegion.LayoutMgr = nil then
          LRegion.LayoutMgr := TIWBSLayoutMgr.Create(AContainer);
        LRegion.LayoutMgr.SetContainer(LRegion);
        IWBSPrepareChildComponentsForRender(LRegion);
      end;

    // disable child StyleRenderOptions
    LBaseControl := BaseControlInterface(LComponent);
    if Assigned(LBaseControl) then begin
      LHTML40Control := HTML40ControlInterface(AContainer.Component[i]);
      IWBSDisableRenderOptions(LHTML40Control.StyleRenderOptions);
    end;
  end;
end;

end.
