unit Unit4;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWCompButton,
  Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompEdit, Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWBSRegion, IWBSCustomControl, IWBSButton,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWBSLayoutMgr, IWBSImage;

type
  TIWForm4 = class(TIWAppForm)
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSRegion1: TIWBSRegion;
    IWBSImage1: TIWBSImage;
  public
  end;

implementation

{$R *.dfm}


initialization
  TIWForm4.SetAsMainForm;

end.
