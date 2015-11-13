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
  IWCompFileUploader, Vcl.Graphics, IWBSDropDown;

type
  TIWForm4 = class(TIWAppForm)
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSRegion3: TIWBSRegion;
    IWBSNavBar1: TIWBSNavBar;
    IWBSUnorderedList1: TIWBSUnorderedList;
    IWBSDropDown1: TIWBSDropDown;
    IWBSRegion1: TIWBSRegion;
    IWBSDropDown2: TIWBSDropDown;
    IWBSDropDown3: TIWBSDropDown;
    IWBSButton1: TIWBSButton;
    IWBSInputGroup1: TIWBSInputGroup;
    IWBSInput1: TIWBSInput;
    IWBSDropDown4: TIWBSDropDown;
    IWBSTabControl1: TIWBSTabControl;
    IWBSTabControl1Page0: TIWTabPage;
    IWBSTabControl1Page1: TIWTabPage;
    IWBSTabControl1Page2: TIWTabPage;
    IWBSButton2: TIWBSButton;
    IWBSInput2: TIWBSInput;
    IWBSInput3: TIWBSInput;
    procedure IWBSButton1AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

uses IW.HTTP.FileItem;

procedure TIWForm4.IWBSButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSTabControl1.ActivePage := 1;
end;

initialization
  TIWForm4.SetAsMainForm;

end.
