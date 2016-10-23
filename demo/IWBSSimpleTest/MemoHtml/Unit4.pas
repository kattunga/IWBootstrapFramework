unit Unit4;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWCompButton,
  Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompEdit, Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWBSRegion, IWBSCustomControl, IWBSButton,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWBSLayoutMgr, IWBSImage, IWBSCustomInput, IWBSInput,
  IWCompMemo, IWBSList, IWBSNavBar, IWBSCustomRegion, IWBSMemoHtml;

type
  TIWForm4 = class(TIWAppForm)
    IWBSRegion1: TIWBSRegion;
    IWBSNavBar1: TIWBSNavBar;
    IWBSList1: TIWBSList;
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSMemoHtml1: TIWBSMemoHtml;
    IWBSButton1: TIWBSButton;
    IWBSMemo1: TIWBSMemo;
    IWBSButton2: TIWBSButton;
    procedure IWBSButton1AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton2AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

procedure TIWForm4.IWBSButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSMemoHtml1.Text := IWBSMemo1.Text;
end;

procedure TIWForm4.IWBSButton2AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSMemo1.Text := IWBSMemoHtml1.Text;
end;

initialization
  TIWForm4.SetAsMainForm;

end.
