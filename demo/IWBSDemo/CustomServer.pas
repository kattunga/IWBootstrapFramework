unit CustomServer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, IWStandAloneServer, InContext, InHeaderList;

type
  TFCustomServer = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    IWStandAloneServer1: TIWStandAloneServer;
    memoLog: TMemo;
    procedure Image1Click(Sender: TObject);
    procedure IWStandAloneServer1DebugLog(ASender: TObject; ALog: String);
    procedure FormCreate(Sender: TObject);
  private
    procedure HeadersAvailable(AContext: TInContext; const AUri: string; AHeaders: TInHeaderList; var VContinueProcessing: Boolean);
  public
  end;

  TIWStandAloneServerHack = class(TIWStandAloneServer)
  end;

var
  FCustomServer: TFCustomServer;

implementation

{$R *.dfm}

uses
  IW.Server.Indy, IWGlobal;

procedure TFCustomServer.FormCreate(Sender: TObject);
begin
 IWStandAloneServer1.Start(TSaServerIndy);
  memoLog.Lines.Add('Server started');
  memoLog.Lines.Add('Listening on port: ' + IntToStr(GServerController.Port));
  memoLog.Lines.Add('');

  TSaServerIndy(TIWStandAloneServerHack(IWStandAloneServer1).FHttpInstance).HTTP.OnHeadersAvailable := HeadersAvailable;
end;

procedure TFCustomServer.HeadersAvailable(AContext: TInContext; const AUri: string; AHeaders: TInHeaderList; var VContinueProcessing: Boolean);
var
  ContentLength: integer;
begin
  ContentLength := StrToIntDef(AHeaders.Values['content-length'], 0);

  // limit post to 48kb
  if (ContentLength < 0) or (ContentLength > 49152) then
    VContinueProcessing := False;
end;

procedure TFCustomServer.Image1Click(Sender: TObject);
begin
  IWStandAloneServer1.Run;
end;

procedure TFCustomServer.IWStandAloneServer1DebugLog(ASender: TObject;
  ALog: String);
begin
  memoLog.Lines.Add(ALog);
end;

end.
