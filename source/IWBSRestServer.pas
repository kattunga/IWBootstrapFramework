unit IWBSRestServer;

interface

uses
  Classes, SysUtils, IWApplication,
  IW.Content.Base, IW.HTTP.Request, IW.HTTP.Reply;

type
  TIWBSRestServer = class(TContentBase)
  protected
    function Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication): boolean; override;
  public
    constructor Create; override;
  end;

implementation

uses IW.Content.Handlers;

constructor TIWBSRestServer.Create;
begin
  inherited;
  mFileMustExist := False;
end;

function TIWBSRestServer.Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication): boolean;
begin

end;

initialization
  THandlers.Add('', 'Reports.html', TIWBSRestServer.Create);

end.
