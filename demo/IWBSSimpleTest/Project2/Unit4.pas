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
  IWBSControls, IWCompTabControl, IWBSTabControl;

type
  TIWForm4 = class(TIWAppForm)
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSRegion3: TIWBSRegion;
    IWBSButton1: TIWBSButton;
    IWBSText2: TIWBSText;
    procedure IWBSButton2Click(Sender: TObject);
    procedure IWBSButton3AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton1AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

procedure TIWForm4.IWBSButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSText2.Lines.Insert(2, '<li>pepe</li>');
end;

procedure TIWForm4.IWBSButton2Click(Sender: TObject);
begin
//
end;

procedure TIWForm4.IWBSButton3AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
//
end;

initialization
  TIWForm4.SetAsMainForm;

end.
