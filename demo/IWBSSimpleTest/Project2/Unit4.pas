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
  IWCompFileUploader, IWCompFile, Vcl.Graphics;

type
  TIWForm4 = class(TIWAppForm)
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSRegion3: TIWBSRegion;
    IWBSInputForm1: TIWBSInputForm;
    IWBSTabControl1: TIWBSTabControl;
    IWBSTabControl1Page0: TIWTabPage;
    IWBSTabControl1Page1: TIWTabPage;
    IWBSButton2: TIWBSButton;
    IWBSInput1: TIWBSInput;
    IWBSButton1: TIWBSButton;
    IWBSInput2: TIWBSInput;
    IWBSFile1: TIWBSFile;
    procedure IWBSButton1AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

uses IW.HTTP.FileItem;

procedure TIWForm4.IWBSButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
//
end;

initialization
  TIWForm4.SetAsMainForm;

end.
