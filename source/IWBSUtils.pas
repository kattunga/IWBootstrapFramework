unit IWBSUtils;

interface

uses System.Classes, System.SysUtils, Windows,
     IWAppForm, IWtypes, IWContainer, IWBSCommon;

// Disable all RenderOptions at one time
procedure IWBSDisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);

// this procedure set non IWBootrap components to be compatible with the framework
procedure IWBSPrepareChildComponentsForRender(AContainer: TIWContainer; AFormType: TIWBSFormType);

// this help to create unique component names at runtime for example form Frames
function  IWBSGetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;

implementation

uses Vcl.Forms,
     IWRegion, IWBaseInterfaces, IWHTML40Interfaces, IWBSLayoutMgr, IWCompTabControl;

procedure IWBSDisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);
begin
  StyleRenderOptions.RenderAbsolute := False;
  StyleRenderOptions.RenderBorder := False;
  StyleRenderOptions.RenderFont := False;
  StyleRenderOptions.RenderPadding := False;
  StyleRenderOptions.RenderPosition := False;
  StyleRenderOptions.RenderSize := False;
  StyleRenderOptions.RenderStatus := False;
end;

procedure IWBSPrepareChildComponentsForRender(AContainer: TIWContainer; AFormType: TIWBSFormType);
var
  i: integer;
  LComponent: TComponent;
  LFrameRegion: TComponent;
  LRegion: TIWRegion;
  LTabPage: IWBSCommon.TIWTabPage;
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
          if LRegion.LayoutMgr = nil then begin
            LRegion.LayoutMgr := TIWBSLayoutMgr.Create(AContainer);
            TIWBSLayoutMgr(LRegion.LayoutMgr).BSFormType := AFormType;
          end;
          LRegion.LayoutMgr.SetContainer(LRegion);
          IWBSPrepareChildComponentsForRender(LRegion, AFormType);
        end;
     end

    // tab pages of TIWBSTabControl are still TIWTabPage
    else if LComponent is IWCompTabControl.TIWTabPage then
      begin
        LTabPage := IWBSCommon.TIWTabPage(LComponent);
        if LTabPage.LayoutMgr = nil then begin
          LTabPage.LayoutMgr := TIWBSLayoutMgr.Create(AContainer);
          TIWBSLayoutMgr(LTabPage.LayoutMgr).BSFormType := AFormType;
        end;
        LTabPage.LayoutMgr.SetContainer(LTabPage);
        IWBSPrepareChildComponentsForRender(LTabPage, AFormType);
      end;

    // disable child StyleRenderOptions
    LBaseControl := BaseControlInterface(LComponent);
    if Assigned(LBaseControl) then begin
      LHTML40Control := HTML40ControlInterface(AContainer.Component[i]);
      IWBSDisableRenderOptions(LHTML40Control.StyleRenderOptions);
    end;
  end;
end;

function IWBSGetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;
var
  i: Integer;
begin
  Result:= APrefix;
  i:= 0;
  while Assigned(AOwner.FindComponent(Result)) do begin
    inc(i);
    Result:= APrefix + IntToStr(i);
  end;
end;

initialization
  IWBSRefreshCacheParam := FormatDateTime('yyyymmddhhnnsszzz', now);

end.
