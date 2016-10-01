unit Unit4;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWCompButton,
  Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompEdit, Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWBSRegion, IWBSCustomControl, IWBSButton,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWBSLayoutMgr, IWBSImage, IWBSCustomInput, IWBSInput,
  IWCompMemo, IWBSList, IWBSNavBar, IWBSCustomRegion;

type
  TIWForm4 = class(TIWAppForm)
    IWBSRegion1: TIWBSRegion;
    IWBSNavBar1: TIWBSNavBar;
    IWBSList1: TIWBSList;
    IWBSRegion2: TIWBSRegion;
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSButton1: TIWBSButton;
    IWBSButton2: TIWBSButton;
    IWBSButton3: TIWBSButton;
    IWBSButton4: TIWBSButton;
  public
  end;

implementation

{$R *.dfm}


initialization
  TIWForm4.SetAsMainForm;

end.
