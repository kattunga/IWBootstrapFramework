// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program IWBSDemo;

uses
//  FastMM4,
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  UTF8ContentParser,
  Unit2 in 'Unit2.pas' {IWForm2: TIWAppForm},
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase},
  UserSessionUnit in 'UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  Unit1 in 'Unit1.pas' {IWFrame1: TFrame},
  Unit3 in 'Unit3.pas' {IWFrame3: TFrame},
  IWBSDialogs in '..\..\source\IWBSDialogs.pas',
  FishFact in 'FishFact.pas' {FFishFact: TIWAppForm};

{$R *.res}

begin
  TIWStart.Execute(True);
end.
