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
    procedure IWBSButton1AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton3AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

uses IW.HTTP.FileItem;

procedure TIWForm4.IWBSButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
//
end;

procedure TIWForm4.IWBSButton3AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSDropDown1.DropDownItems.Add;
  TForm(IWBSDropDown1).OnClick
end;

initialization
  TIWForm4.SetAsMainForm;

end.
