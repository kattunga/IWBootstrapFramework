program Fishfact;

uses
  DBClient,
  Forms,
  IWStart,
  UTF8ContentParser,
  Main in 'Main.pas' {formMain: TIWFormModuleBase},
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase};

{$R *.res}

begin
  TIWStart.Execute(True);
end.

