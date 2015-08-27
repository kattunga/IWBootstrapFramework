unit Unit1;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  Vcl.Controls, Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWBSRegion, IWCompEdit, IWBSInput,
  IWCompText, IWBSComponentsHacks;

type
  TIWForm1 = class(TIWAppForm)
    IWBSBtnGroup1: TIWBSBtnGroup;
    IWBSRegion1: TIWBSRegion;
    IWBSInput1: TIWBSInput;
    IWButton1: TIWButton;
    IWButton2: TIWButton;
    IWBSRegion2: TIWBSRegion;
    IWText1: TIWText;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}

uses IWBSUtils;

procedure TIWForm1.IWAppFormCreate(Sender: TObject);
begin
  IWBSEnable('','/iwbs', Self, True);
end;

procedure TIWForm1.IWAppFormRender(Sender: TObject);
begin
  ResetTabOrders(IWBSRegion1, stXY);
end;

initialization
  TIWForm1.SetAsMainForm;

end.
