unit Unit4;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWCompButton,
  Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompEdit, Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWBSRegion, IWBSCustomControl, IWBSButton;

type
  TIWForm4 = class(TIWAppForm)
    IWBSButton1: TIWBSButton;
  public
  end;

implementation

{$R *.dfm}


initialization
  TIWForm4.SetAsMainForm;

end.
