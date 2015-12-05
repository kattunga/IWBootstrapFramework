unit Unit4;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWCompButton,
  Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompEdit, Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWBSRegion, IWBSCustomControl, IWBSButton,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWBSLayoutMgr;

type
  TIWForm4 = class(TIWAppForm)
    GridNavBar: TIWBSNavBar;
    BtnSav: TIWBSButton;
    BtnPrn: TIWBSButton;
    BtnGra: TIWBSButton;
    BtnCan: TIWBSButton;
    BtnIns: TIWBSButton;
    BtnDel: TIWBSButton;
    BtnMod: TIWBSButton;
    BtnCls: TIWBSButton;
    IWBSLayoutMgr1: TIWBSLayoutMgr;
  public
  end;

implementation

{$R *.dfm}


initialization
  TIWForm4.SetAsMainForm;

end.
