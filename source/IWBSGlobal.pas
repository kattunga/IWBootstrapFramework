unit IWBSGlobal;

interface

uses System.Classes, System.SysUtils, IWHTMLTag, IWBSLayoutMgr;

// ATENTION!!!!, Global files should only be modified in TIWServerController.OnConfig event, they are not Thread Safe.
// only boolean vars (for enable/disable plugins) could be changed anytime, because boleans vars work with attomic read/write
var
  // paths to framework JS and CSS files
  gIWBSLibPath: string = '/iwbs/';

  // path for JQuery library (required)
  gIWBSLibJQueryJs: string = '/<iwbspath>/jquery-1.11.3.min.js';

  // path for bootstrap library (required)
  gIWBSLibBootstrapCss: string = '/<iwbspath>/bootstrap-3.3.5/css/bootstrap.min.css';
  gIWBSLibBootstrapJs: string = '/<iwbspath>/bootstrap-3.3.5/js/bootstrap.min.js';

  // path for iwbs support files (required)
  gIWBSLibIWBSCss: string = '/<iwbspath>/iwbs.css';
  gIWBSLibIWBSJs: string = '/<iwbspath>/iwbs.js';

  // path for Polyfiller library, it provides full support for html5 to older browsers (optional)
  gIWBSLibPolyFiller: boolean = True;
  gIWBSLibPolyFillerJs: string = '/<iwbspath>/webshim-1.15.8/js-webshim/minified/polyfiller.js';

  // path for Dynamic Tabs plugin (optional)
  gIWBSLibDynamicTabs: boolean = True;
  gIWBSLibDynamicTabsCss: string = '/<iwbspath>/dyntabs/bootstrap-dynamic-tabs.css';
  gIWBSLibDynamicTabsJs: string = '/<iwbspath>/dyntabs/bootstrap-dynamic-tabs.js';

  // configurations for design time grid
  gIWBSRenderingSortMethod: TIWBSRenderingSortMethod = bsrmSortYX;
  gIWBSRenderingGridPrecision: integer = 12;

  // server start timestamp value in format string, it is usefull to force client refresh cache browsers of included files
  gIWBSRefreshCacheParam: string = '';

  // global hook events, let you customize controls in a simple way
  gIWBSOnRenderAsync: procedure(AControl: TComponent; const AHTMLName);
  gIWBSOnBeforeRender: procedure(AControl: TComponent);
  gIWBSOnHTMLTag: procedure(AControl: TComponent; const AHTMLName: string; ATag: TIWHTMLTag);

  // global link files to include in every page
  gIWBSLinkFiles: TStringList = nil;

  // global enable inputtag, usually not necessary to enable
  gIWBSEnableTabIndex: boolean = False;

procedure IWBSAddGlobalLinkFile(const AFile: string);

implementation

// to add global files should be done only in initialization section, it's not thread safe
procedure IWBSAddGlobalLinkFile(const AFile: string);
begin
  if gIWBSLinkFiles = nil then begin
    gIWBSLinkFiles := TStringList.Create;
    gIWBSLinkFiles.Sorted := True;
  end;
  if gIWBSLinkFiles.IndexOf(AFile) = -1 then
    gIWBSLinkFiles.Add(AFile);
end;

initialization
  gIWBSRefreshCacheParam := FormatDateTime('yyyymmddhhnnsszzz', now);

finalization
  FreeAndNil(gIWBSLinkFiles);

end.
