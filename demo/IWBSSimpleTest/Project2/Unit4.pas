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
  IWBSControls;

type
  TIWForm4 = class(TIWAppForm)
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSLabel1: TIWBSLabel;
  public
  end;

implementation

{$R *.dfm}

initialization
  TIWForm4.SetAsMainForm;

end.
