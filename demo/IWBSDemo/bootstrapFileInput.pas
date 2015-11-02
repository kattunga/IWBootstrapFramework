unit bootstrapFileInput;

interface

uses
  IWAppForm, Classes, Controls, System.StrUtils, System.SysUtils, Math,
  IWCompExtCtrls, IWDBExtCtrls, IWDBStdCtrls, IWDBGrids, IWCompGrids,
  IWCompEdit, IWCompLabel, IWControl, IWCompMemo, IWBaseControl, DBClient,
  DB, Forms, IWContainer, IWRegion, IWVCLBaseControl, IWVCLBaseContainer,
  IWBaseHTMLControl, IWHTMLContainer, IWHTML40Container, IWCompButton,
  IWBSRegion, IWBSInput, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWBSLayoutMgr, IWBSControls,
  Vcl.Graphics, IWCompCheckbox, IWCompListbox, IWCompText, IWHTMLControls,
  MidasLib, IWBSCustomInput, IWBSButton, IWBSCustomControl, IWBSImage,
  IWCompTabControl, IWBSTabControl,
  IW.HTTP.Request, IW.HTTP.Reply, IWApplication;

type
  TFBootstrapFileInput = class(TIWAppForm)
    IWBSRegion1: TIWBSRegion;
    IWBSRegion2: TIWBSRegion;
    IWBSRegion3: TIWBSRegion;
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWText1: TIWBSText;
    IWBSRegion8: TIWBSNavBar;
    IWBSButton1: TIWBSButton;
    IWBSRegion4: TIWBSRegion;
    IWBSText2: TIWBSText;
    IWBSInput1: TIWBSFile;
    procedure IWFormModuleBaseCreate(Sender: TObject);
    procedure IWBSButton1Click(Sender: TObject);
    procedure IWBSInput1CustomRestEvents0RestEvent(aApplication: TIWApplication;
      aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings);
    procedure IWBSInput1CustomAsyncEvents0AsyncEvent(aParams: TStringList);
  end;

implementation
{$R *.dfm}

uses IWBSRestServer, IW.HTTP.FileItem;

var
  fs: TFormatSettings;

procedure TFBootstrapFileInput.IWBSInput1CustomAsyncEvents0AsyncEvent(
  aParams: TStringList);
begin
  IWBSText2.AsyncRefreshControl;
end;

procedure TFBootstrapFileInput.IWBSInput1CustomRestEvents0RestEvent(
  aApplication: TIWApplication; aRequest: THttpRequest; aReply: THttpReply;
  aParams: TStrings);
var
  AStream: TStringStream;
  i: integer;
begin
  // get file s
  for i := 0 to aRequest.Files.Count-1 do begin
    AStream := TStringStream.Create;
    try
      THttpFile(aRequest.Files[i]).SaveToStream(AStream);
      IWBSText2.Lines.Add('File: '+THttpFile(aRequest.Files[i]).FileName);
      IWBSText2.Lines.Add(AStream.DataString);
    finally
      AStream.Free;
    end;
  end;
  aReply.WriteString('{"id": "1"}');
end;

procedure TFBootstrapFileInput.IWFormModuleBaseCreate(Sender: TObject);
begin
  // include third party plugin
  IWBSLayoutMgr1.AddLinkFile('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/4.2.7/css/fileinput.min.css');
  IWBSLayoutMgr1.AddLinkFile('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/4.2.7/js/fileinput.min.js');
end;

procedure TFBootstrapFileInput.IWBSButton1Click(Sender: TObject);
begin
  Release;
end;

initialization
  fs := TFormatSettings.Create('en-US');

  // this enable the rest event server
  IWBSRegisterRestServerHandler;

end.
