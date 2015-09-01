unit IWBSUtils;

interface

uses System.Classes, System.SysUtils, Windows,
     IWAppForm, IWtypes, IWContainer, IWBSCommon;

// put this function in the form oncreate event to enable the bootstrap framework, we should move the code to the TIWBSLayoutMgr
procedure IWBSEnable(const base, path: string; Form: TIWAppForm; ncButton: boolean; WebShimm: boolean);

// Disable all RenderOptions at one time
procedure IWBSDisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);

// this procedure set non IWBootrap components to be compatible with the framework
procedure IWBSPrepareChildComponentsForRender(AContainer: TIWContainer; AFormType: TIWBSFormType);

// this help to create unique component names at runtime for example form Frames
function  IWBSGetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;

const
  jqlibversion = '1.11.3';
  bslibversion = '3.3.5';

var
  IWBSLibraryPath: string = '/iwbs';
  IWBSRefreshCacheParam: string;

implementation

uses Vcl.Forms,
     IWRegion, IWBaseInterfaces, IWHTML40Interfaces, IWBSLayoutMgr, IWCompTabControl;

procedure IWBSEnable(const base, path: string; Form: TIWAppForm; ncButton: boolean; WebShimm: boolean);
begin
  Form.PreHeader.Add('<meta name="viewport" content="width=device-width, initial-scale=1">');

  // jquery
  Form.PreHeader.Add('<script type="text/javascript" src="'+base+path+'/jquery-'+jqlibversion+'.min.js"></script>');

  // bootstrap
  Form.ContentFiles.Add(path+'/bootstrap-'+bslibversion+'/css/bootstrap.min.css');
  Form.PreHeader.Add('<script type="text/javascript" src="'+base+path+'/bootstrap-'+bslibversion+'/js/bootstrap.min.js"></script>');

  // add missing html5 functionality to most browsers
  // http://afarkas.github.io/webshim/demos/index.html
  // see also http://modernizr.com/
  if WebShimm then
    Form.PreHeader.Add('<script type="text/javascript" src="'+base+path+'/webshim-1.15.8/js-webshim/minified/polyfiller.js"></script>');

  // iwbs
  Form.ContentFiles.Add(path+'/iwbs.css?v='+IWBSRefreshCacheParam);
  Form.PreHeader.Add('<script type="text/javascript" src="'+base+path+'/iwbs.js?v='+IWBSRefreshCacheParam+'"></script>');

  // disable bootstap button plugin for no conflict with CGDevtools jQButton
  if ncButton then
    Form.ExtraHeader.Add('<script type="text/javascript">$.fn.button.noConflict();</script>');
end;

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
