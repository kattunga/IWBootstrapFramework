unit Unit4;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Vcl.Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompExtCtrls,
  IWDBExtCtrls, IWBSInput, IWCompEdit, IWCompButton, IWCompListbox, IWDBStdCtrls,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWBSLayoutMgr, Vcl.Forms, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWBSRegion, IWBSCustomInput,
  IWBSButton, IWCompRadioButton;

type
  TIWForm4 = class(TIWAppForm)
    IWBSRadioGroup1: TIWBSRadioGroup;
    IWBSButton1: TIWBSButton;
    IWBSButton2: TIWBSButton;
    IWBSInput1: TIWBSInput;
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSButton3: TIWBSButton;
    IWBSCheckBox1: TIWBSCheckBox;
    IWBSRadioButton1: TIWBSRadioButton;
    IWBSRadioButton2: TIWBSRadioButton;
    procedure IWBSButton1AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton3AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

procedure TIWForm4.IWBSButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
//
end;

procedure TIWForm4.IWBSButton3AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSRadioGroup1.Visible := not IWBSRadioGroup1.Visible;
end;

initialization
  TIWForm4.SetAsMainForm;

end.
