unit Unit4;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWCompButton,
  Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompEdit, Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWBSRegion, IWBSCustomControl, IWBSButton,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWBSLayoutMgr, IWBSImage, IWBSCustomInput, IWBSInput,
  IWCompMemo;

type
  TIWForm4 = class(TIWAppForm)
    IWButton1: TIWButton;
    IWMemo1: TIWMemo;
  public
  end;

implementation

{$R *.dfm}


initialization
  TIWForm4.SetAsMainForm;

end.
