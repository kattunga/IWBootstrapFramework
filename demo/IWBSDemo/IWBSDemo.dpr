program IWBSDemo;

uses
  IWRtlFix,
  Forms,
  IWStart,
  UTF8ContentParser,
  Unit2 in 'Unit2.pas' {IWForm2: TIWAppForm},
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase},
  UserSessionUnit in 'UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  Unit1 in 'Unit1.pas' {IWFrame1: TFrame},
  Unit3 in 'Unit3.pas' {IWFrame3: TFrame},
  bootstrapFileInput in 'bootstrapFileInput.pas' {FBootstrapFileInput: TIWAppForm},
  FishFact in 'FishFact.pas' {FFishFact: TIWAppForm},
  FishFactBootstrapTable in 'FishFactBootstrapTable.pas' {FBootstrapTable: TIWAppForm},
  FishFactJQGrid in 'FishFactJQGrid.pas' {FJQGrid: TIWAppForm},
  CustomServer in 'CustomServer.pas' {FCustomServer};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Custom StandAlone Server';
  Application.CreateForm(TFCustomServer, FCustomServer);
  Application.Run;
end.
