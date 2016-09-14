unit CustomServer;

interface

uses
  Windows, ShellApi, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  IW.Server.HTTPIndy,
  InContext, InHeaderList, Vcl.Imaging.jpeg;

type
  TFCustomServer = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    memoLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    FHTTP: THTTPServerIndy;

    procedure HeadersAvailable(AContext: TInContext; const AUri: string; AHeaders: TInHeaderList; var VContinueProcessing: Boolean);
  public
  end;

var
  FCustomServer: TFCustomServer;

implementation

{$R *.dfm}

uses
  IWServerSession, IWGlobal, inGlobal;

procedure TFCustomServer.FormCreate(Sender: TObject);
begin
  if gSC <> nil then
    Exit;
  gAppInit;

  if (not Assigned(gHttpExecuteHook)) then
    gHttpExecuteHook := IWServerSession.HttpExecute;

  FHTTP := THTTPServerIndy.Create(Self);
  FHTTP.OnHeadersAvailable := HeadersAvailable;
  FHTTP.KeepAlive := gSC.HttpKeepAlive;

  // this is for linux (with wine)
  if GetEnvironmentVariable('SHELL') <> '' then
    FHTTP.ReuseSocket := rsTrue;

  FHTTP.InitHTTP;

  memoLog.Lines.Add('Server started');
  memoLog.Lines.Add('Listening on port: ' + IntToStr(GServerController.Port));
  memoLog.Lines.Add('');
end;

procedure TFCustomServer.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FHTTP);
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
var
  LURL: string;
begin
  LURL := 'http://127.0.0.1'+':' + IntToStr(gSC.Port)+'/$/start';
  ShellAPI.ShellExecute(0, PChar('open'), PChar(LURL), nil, nil, SW_SHOWNORMAL);
end;

end.
