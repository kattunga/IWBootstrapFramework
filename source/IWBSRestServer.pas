unit IWBSRestServer;

{$i 'IWBootstrap.inc'}

interface

uses
  Classes, SysUtils, StrUtils,
  IWApplication, IW.Content.Base, IW.HTTP.Request, IW.HTTP.Reply;

type
  TIWBSRestServer = class(TContentBase)
  protected
    function Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): Boolean; override;
  public
    constructor Create; override;
  end;

  TIWBSRestCallBackFunction = procedure(aApplication: TIWApplication; aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings) of object;

  TIWBSCallback = class(TIWCallBack)
  protected
    FRestCallBackFunction: TIWBSRestCallBackFunction;
  public
    constructor Create(ASession: TIWApplication; AName: string; ARestCallbackFunction: TIWBSRestCallBackFunction);
    property RestCallBackFunction: TIWBSRestCallBackFunction read FRestCallBackFunction write FRestCallBackFunction;
  end;

function IWBSRegisterRestCallBack(AApplication: TIWApplication; AName: string; ARestCallbackFunction: TIWBSRestCallBackFunction; AParseFileUpload: boolean = False): string;

procedure IWBSRegisterRestServerHandler;

implementation

uses IW.Content.Handlers, IWURL, IWBaseForm, IW.Common.HttpPacket,
    {$IFDEF IW_14_0_53_UP}
     IW.Parser.Files;
    {$ELSE}
     IW.Parser.UTF8;
    {$ENDIF}

const IWBS_RESTURLBASE = '/$iwbs/';

var
  FIsServerRegistered: boolean = False;

{$region 'TIWBSRestCallback'}
{ TIWCallback }

constructor TIWBSCallback.Create(ASession: TIWApplication; AName: string; ARestCallbackFunction: TIWBSRestCallBackFunction);
begin
  inherited Create(ASession, AName, nil);
  FRestCallbackFunction := ARestCallbackFunction;
end;
{$endregion}

{$region 'RestCallBack functions'}

type TIWCallBacksHack = class(TIWCallBacks)
protected
  function QualifiedName(AOwnerForm: TComponent; const AName: string): string;
end;

type TIWApplicationHack = class(TIWApplication);

function TIWCallBacksHack.QualifiedName(AOwnerForm: TComponent; const AName: string): string;
begin
  if Assigned(AOwnerForm) and (AOwnerForm is TIWBaseForm) and not StartsText(AOwnerForm.Name + '.', AName) then
    Result := AOwnerForm.Name + '.' + AName
  else
    Result := AName;
end;

function IWBSRegisterRestCallBack(AApplication: TIWApplication; AName: string; ARestCallbackFunction: TIWBSRestCallBackFunction; AParseFileUpload: boolean = False): string;
var
  LCallBacks: TIWCallBacksHack;
  xOwnerForm: TComponent;
  xQualifiedName: string;
  xPos: Integer;
  Callback: TIWBSCallback;
  CurrMethod: TMethod;
  NewMethod: TMethod;
begin
  LCallBacks := TIWCallBacksHack(TIWApplicationHack(AApplication).FCallBacks);

  xOwnerForm := LCallBacks.GetOwnerForm;
  xQualifiedName := LCallBacks.QualifiedName(xOwnerForm, AName);
  xPos:= LCallBacks.IndexOf(xQualifiedName);
  if xPos = -1 then
    LCallBacks.AddObject(xQualifiedName, TIWBSCallback.Create(AApplication, AName, ARestCallBackFunction))
  else
    begin
      CallBack := LCallBacks.Objects[xPos] as TIWBSCallback;
      CurrMethod := TMethod(CallBack.RestCallBackFunction);
      NewMethod := TMethod(ARestCallBackFunction);
      if (NewMethod.Data <> CurrMethod.Data) or (NewMethod.Code <> CurrMethod.Code) then
        CallBack.FRestCallBackFunction := ARestCallBackFunction;
    end;

  Result := TURL.Concat(AApplication.SessionUrlBase,IWBS_RESTURLBASE+AName);
  if AParseFileUpload then
    Result := Result+'?IWFileUploader=true';
end;

procedure IWBSPerformRestCallback(AApplication: TIWApplication; const AName: string; aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings);
var
  LCallBacks: TIWCallBacksHack;
  xOwnerForm: TComponent;
  xQualifiedName: string;
  xPos: Integer;
  LCallBackProc: TObject;
begin

  {$IFDEF IW_14_0_53_UP}
  TIWApplicationHack(AApplication).SetSessionFlag(sfCallBackProcessing, True);
  {$ELSE}
  TIWApplicationHack(AApplication).FCallBackProcessing := True;
  {$ENDIF}
  try
    LCallBacks := TIWCallBacksHack(TIWApplicationHack(AApplication).FCallBacks);

    xOwnerForm := LCallBacks.GetOwnerForm;
    xQualifiedName := LCallBacks.QualifiedName(xOwnerForm, AName);
    xPos := LCallBacks.FindCallback(xQualifiedName, AName);
    if xPos >= 0 then
      begin
        LCallBackProc := LCallBacks.Objects[xPos];
        if LCallBackProc is TIWBSCallback then
          if Assigned(TIWBSCallback(LCallBackProc).FRestCallBackFunction) then
            TIWBSCallback(LCallBackProc).FRestCallBackFunction(AApplication, aRequest, aReply, aParams);
      end
    else
      begin
        aReply.Code := 404;
        aReply.CodeText := 'Not found';
      end;
  finally
    {$IFDEF IW_14_0_53_UP}
    TIWApplicationHack(AApplication).SetSessionFlag(sfCallBackProcessing, False);
    {$ELSE}
    TIWApplicationHack(AApplication).FCallBackProcessing := false;
    {$ENDIF}
  end;
end;
{$endregion}

constructor TIWBSRestServer.Create;
begin
  inherited;
  mFileMustExist := False;
end;

function TIWBSRestServer.Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean;
var
  i: integer;
  Doc: string;
begin
  i := Pos(IWBS_RESTURLBASE,aRequest.PathInfo);
  Doc := Copy(aRequest.PathInfo,i+Length(IWBS_RESTURLBASE), MaxInt);
  if Doc <> '' then
    begin
      try
        IWBSPerformRestCallback(aSession, Doc, aRequest, aReply, aParams);
        if aReply.DataType = rtNone then
          aReply.Code := 200;
      except
        on E: Exception do begin
          aReply.ResetReplyType;
          aReply.Clear;
          aReply.Code := 500;
          aReply.ContentType  := 'text/plain';
          aReply.WriteString(E.Message);
        end;
      end;
    end
  else
    aReply.Code := 404;
  Result := True;
end;

procedure IWBSRegisterRestServerHandler;
begin
  if not FIsServerRegistered then
    THandlers.Add(IWBS_RESTURLBASE, '', TIWBSRestServer.Create);

  RegisterContentType('multipart/form-data');

  FIsServerRegistered := True;
end;

end.
