unit IWBSRestServer;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils,
  IWApplication, IW.Content.Base, IW.HTTP.Request, IW.HTTP.Reply;

type
  TIWBSRestServer = class(TContentBase)
  protected
    function Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean; override;
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

function IWBSRegisterRestCallBack(AApplication: TIWApplication; AName: string; ARestCallbackFunction: TIWBSRestCallBackFunction): string;

procedure IWBSRegisterRestServerHandler;

implementation

uses IW.Content.Handlers, IWURL, IWBaseForm, IW.Common.HttpPacket;

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

function IWBSRegisterRestCallBack(AApplication: TIWApplication; AName: string; ARestCallbackFunction: TIWBSRestCallBackFunction): string;
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
end;

procedure IWBSPerformRestCallback(AApplication: TIWApplication; const AName: string; aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings);
var
  LCallBacks: TIWCallBacksHack;
  xOwnerForm: TComponent;
  xQualifiedName: string;
  xPos: Integer;
  LCallBackProc: TObject;
begin
  TIWApplicationHack(AApplication).FCallBackProcessing := true;
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
    TIWApplicationHack(AApplication).FCallBackProcessing := false;
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
      IWBSPerformRestCallback(aSession, Doc, aRequest, aReply, aParams);
      if aReply.DataType = rtNone then
        aReply.Code := 200;
    end
  else
    aReply.Code := 404;
  Result := True;
end;

procedure IWBSRegisterRestServerHandler;
begin
  if not FIsServerRegistered then
    THandlers.Add(IWBS_RESTURLBASE, '', TIWBSRestServer.Create);

  FIsServerRegistered := True;
end;

end.
