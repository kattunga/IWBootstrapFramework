unit Unit4;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Vcl.Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompExtCtrls,
  IWDBExtCtrls, IWBSInput, IWCompEdit, IWCompButton, IWCompListbox, IWDBStdCtrls,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWBSLayoutMgr, Vcl.Forms, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWBSRegion, IWBSCustomInput,
  IWBSButton, IWCompRadioButton, IWCompMemo, IWCompCheckbox, IWBSCustomControl,
  IWBSControls, IWCompTabControl, IWBSTabControl, IWBSImage, Vcl.Imaging.jpeg,
  IWCompFileUploader, IWCompFile;

type
  TIWForm4 = class(TIWAppForm)
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSRegion3: TIWBSRegion;
    IWBSText2: TIWBSText;
    IWBSImage1: TIWBSImage;
    IWDBImage1: TIWDBImage;
    IWFile1: TIWFile;
    IWBSInputForm1: TIWBSInputForm;
    IWBSInput1: TIWBSInput;
    IWBSButton1: TIWBSButton;
    IWFileUploader1: TIWFileUploader;
    IWFile2: TIWFile;
    procedure IWBSButton2Click(Sender: TObject);
    procedure IWBSButton3AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton1Click(Sender: TObject);
    procedure IWFileUploader1AsyncUploadCompleted(Sender: TObject; var DestPath,
      FileName: string; var SaveFile, Overwrite: Boolean);
  public
  end;

implementation

{$R *.dfm}

uses IW.HTTP.FileItem;

procedure TIWForm4.IWBSButton1Click(Sender: TObject);
var
  f: THttpFile;
begin
  f := WebApplication.FindFile(IWBSInput1.Text);
  if f <> nil then
    f.SaveToFile('pepe.txt');

 // IWFileUploader1.SaveToFile(IWBSInput1.Text,'pepe.txt',true);
end;

procedure TIWForm4.IWBSButton2Click(Sender: TObject);
begin
//
end;

procedure TIWForm4.IWBSButton3AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
//
end;

procedure TIWForm4.IWFileUploader1AsyncUploadCompleted(Sender: TObject;
  var DestPath, FileName: string; var SaveFile, Overwrite: Boolean);
begin
  DestPath := WebApplication.ApplicationPath;
  FileName := 'pepe';
  SaveFile := True;
  Overwrite := True;
end;

initialization
  TIWForm4.SetAsMainForm;

end.
