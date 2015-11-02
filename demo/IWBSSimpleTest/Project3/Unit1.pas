unit Unit1;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWBSLayoutMgr,
  Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWBSCustomControl, IWBSButton, Vcl.Forms, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWBSRegion;

type
  TIWForm1 = class(TIWAppForm)
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    rgn1: TIWBSRegion;
    rgn2: TIWBSRegion;
    btn1: TIWBSButton;
    procedure btn1AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

uses Unit2, IWBSUtils;


procedure TIWForm1.btn1AsyncClick(Sender: TObject;
  EventParams: TStringList);

begin
  with TIWFrame2.Create(WebApplication) do
  begin
    Name := IWBSGetUniqueComponentName(Self, 'frame');
    Parent := Self.rgn2;
  end;
end;

initialization
  TIWForm1.SetAsMainForm;

end.
