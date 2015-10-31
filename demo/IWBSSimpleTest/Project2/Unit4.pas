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
    IWBSText2: TIWBSText;
    IWBSImage1: TIWBSImage;
    IWBSButton1: TIWBSButton;
    IWBSRegion1: TIWBSRegion;
    procedure IWBSButton1AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

uses IW.HTTP.FileItem;

procedure TIWForm4.IWBSButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
//  IWBSText2.Lines.Insert(2, '<li>pepe</li>');

  with TIWBSButton.Create(Self) do begin
    Parent := IWBSRegion1;
  end;
end;

initialization
  TIWForm4.SetAsMainForm;

end.
