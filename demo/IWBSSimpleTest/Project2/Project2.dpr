program Project2;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  UTF8ContentParser,
  Unit4 in 'Unit4.pas' {IWForm4: TIWAppForm},
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase},
  UserSessionUnit in 'UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  IWBSScriptEvents in '..\..\..\source\IWBSScriptEvents.pas';

{$R *.res}

begin
  TIWStart.Execute(True);
end.
