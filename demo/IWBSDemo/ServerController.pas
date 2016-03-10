unit ServerController;

interface

{.$DEFINE CDNS}
{.$DEFINE BOOTSTRAPSELECT}

uses
  SysUtils, Classes, IWServerControllerBase, IWBaseForm, HTTPApp,
  // For OnNewSession Event
  UserSessionUnit, IWApplication, IWAppForm, IW.Browser.Browser;

type
  TIWServerController = class(TIWServerControllerBase)
    procedure IWServerControllerBaseNewSession(ASession: TIWApplication);
    procedure IWServerControllerBaseConfig(Sender: TObject);
  end;

  function UserSession: TIWUserSession;
  function IWServerController: TIWServerController;

implementation

{$R *.dfm}

uses
  IWInit, IWGlobal, IWBSGlobal, IWBSInput;

// *****************************************************************************
// with this global hooks you can apply a third party plugin to any component
// where for example we apply the excelent https://silviomoreto.github.io/bootstrap-select/
procedure MyRenderAsync(AControl: TComponent; const AHTMLName, AInputSelector: string);
begin
  if AControl is TIWBSSelect then
    WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+AHTMLName+'").selectpicker("refresh");');
end;

procedure MyBeforeRender(AControl: TComponent);
begin
  if AControl is TIWBSSelect then
    TIWBSSelect(AControl).Css := 'selectpicker';
end;

// *****************************************************************************

function IWServerController: TIWServerController;
begin
  Result := TIWServerController(GServerController);
end;

function UserSession: TIWUserSession;
begin
  Result := TIWUserSession(WebApplication.Data);
end;

procedure TIWServerController.IWServerControllerBaseConfig(Sender: TObject);
begin

  // This framework requires to disable IW embeded JQuery
  JavaScriptOptions.RenderjQuery := False;

  // here we can change IWBootstrap library files location to for example public cdns,
  // ATTENTION!!!, this can't be done after this event because global variables are not thread safe
{$IFDEF CDNS}

  gIWBSLibJQueryJs := 'https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js';

  gIWBSLibBootstrapCss := 'http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css';
  gIWBSLibBootstrapJs := 'http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js';

  gIWBSLibIWBSCss := 'https://cdn.rawgit.com/kattunga/IWBootstrapFramework/v1.2/demo/bin/wwwroot/iwbs/iwbs.css';
  gIWBSLibIWBSJs := 'https://cdn.rawgit.com/kattunga/IWBootstrapFramework/v1.2/demo/bin/wwwroot/iwbs/iwbs.js';

  gIWBSLibPolyFillerJs := 'https://cdnjs.cloudflare.com/ajax/libs/webshim/1.15.10/dev/polyfiller.js';

  gIWBSLibDynamicTabsCss := 'http://cdn.rawgit.com/kattunga/Bootstrap-Dynamic-Tabs/v1.0/bootstrap-dynamic-tabs.css';
  gIWBSLibDynamicTabsJs := 'http://cdn.rawgit.com/kattunga/Bootstrap-Dynamic-Tabs/v1.0/bootstrap-dynamic-tabs.js';

  // we add a third party plugin to manage selects (https://silviomoreto.github.io/bootstrap-select)
  {$IFDEF BOOTSTRAPSELECT}
  IWBSAddGlobalLinkFile('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.5/css/bootstrap-select.css');
  IWBSAddGlobalLinkFile('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.5/js/bootstrap-select.js');
  {$ENDIF}

  // custom css for this demo
  IWBSAddGlobalLinkFile('https://cdn.rawgit.com/kattunga/IWBootstrapFramework/v1.2/demo/bin/wwwroot/iwbsdemo.css');

{$ELSE}

  // we add a third party plugin to manage selects
  {$IFDEF BOOTSTRAPSELECT}
  IWBSAddGlobalLinkFile('/<iwbspath>/select/dist/css/bootstrap-select.min.css');
  IWBSAddGlobalLinkFile('/<iwbspath>/select/dist/js/bootstrap-select.min.js');
  {$ENDIF}

  // custom css for this demo
  IWBSAddGlobalLinkFile('/iwbsdemo.css');

{$ENDIF}

  // I set the cache to a local directory, this is only to see how many temporary files are created
  CacheDir := ExtractFilePath(ParamStr(0))+'temp';
end;

procedure TIWServerController.IWServerControllerBaseNewSession(
  ASession: TIWApplication);
begin
  ASession.Data := TIWUserSession.Create(nil, ASession);
end;

initialization
  TIWServerController.SetServerControllerClass;

  // set global events
{$IFDEF BOOTSTRAPSELECT}
  gIWBSOnRenderAsync := MyRenderAsync;
  gIWBSOnBeforeRender := MyBeforeRender;
{$ENDIF}

end.

