unit ServerController;

interface

uses
  SysUtils, Classes, IWServerControllerBase, IWBaseForm, HTTPApp,
  // For OnNewSession Event
  UserSessionUnit, IWApplication, IWAppForm, IW.Browser.Browser;

type
  TIWServerController = class(TIWServerControllerBase)
    procedure IWServerControllerBaseNewSession(ASession: TIWApplication);
    procedure IWServerControllerBaseConfig(Sender: TObject);

  private
    
  public
  end;


  function UserSession: TIWUserSession;
  function IWServerController: TIWServerController;

implementation

{$R *.dfm}

uses
  IWInit, IWGlobal, IWBSGlobal;

// *****************************************************************************
// with this global hooks you can apply a third party plugin to any component
procedure MyRenderAsync(AControl: TComponent; const AHTMLName, AInputSelector: string);
begin
  if AControl.ClassNameIs('TIWBSSelect') then
    WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+AHTMLName+'").selectpicker("refresh");');
end;

procedure MyRenderCss(AControl: TComponent; var ACss: string);
begin
  if AControl.ClassNameIs('TIWBSSelect') then
    ACss := ACss+' selectpicker';
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
{.$DEFINE CDNS}
{$IFDEF CDNS}

  gIWBSLibJQueryJs := 'https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js';

  gIWBSLibBootstrapCss := 'http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css';
  gIWBSLibBootstrapJs := 'http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js';

  gIWBSLibIWBSCss := 'https://rawgit.com/kattunga/IWBootstrapFramework/master/demo/bin/wwwroot/iwbs/iwbs.css';
  gIWBSLibIWBSJs := 'https://rawgit.com/kattunga/IWBootstrapFramework/master/demo/bin/wwwroot/iwbs/iwbs.js';

  gIWBSLibPolyFillerJs := 'https://cdnjs.cloudflare.com/ajax/libs/webshim/1.15.10/dev/polyfiller.js';

  gIWBSLibDynamicTabsCss := 'http://cdn.rawgit.com/kattunga/Bootstrap-Dynamic-Tabs/v1.0/bootstrap-dynamic-tabs.css';
  gIWBSLibDynamicTabsJs := 'http://cdn.rawgit.com/kattunga/Bootstrap-Dynamic-Tabs/v1.0/bootstrap-dynamic-tabs.js';

  // we add a third party plugin to manage selects
  IWBSAddGlobalLinkFile('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.5/css/bootstrap-select.css');
  IWBSAddGlobalLinkFile('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.5/js/bootstrap-select.js');

  // custom css for this demo
  IWBSAddGlobalLinkFile('https://rawgit.com/kattunga/IWBootstrapFramework/master/demo/bin/wwwroot/iwbsdemo.css');

{$ELSE}

  // we add a third party plugin to manage selects
  IWBSAddGlobalLinkFile('/<iwbspath>/select/dist/css/bootstrap-select.min.css');
  IWBSAddGlobalLinkFile('/<iwbspath>/select/dist/js/bootstrap-select.min.js');

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
  gIWBSOnRenderAsync := MyRenderAsync;
  gIWBSOnRenderCss := MyRenderCss;

end.

