unit Unit3;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWBSRegion, IWCompEdit, IWBSInput,
  IWCompLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompButton, IWBSCustomInput, IWBSButton, IWBSCustomControl, IWBSControls;

type
  TIWFrame3 = class(TFrame)
    IWBSRegion1: TIWBSRegion;
    IWBSModal1: TIWBSModal;
    IWBSRegion2: TIWBSRegion;
    IWBSRegion3: TIWBSRegion;
    IWBSRegion4: TIWBSRegion;
    IWBSInput1: TIWBSInput;
    IWBSButton199: TIWBSButton;
    IWBSSelect1: TIWBSSelect;
    IWBSButton1: TIWBSButton;
    IWLabel4: TIWBSLabel;
    IWLabel2: TIWBSLabel;
    IWLabel1: TIWBSLabel;
    procedure IWBSButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TIWFrame3.IWBSButton1Click(Sender: TObject);
begin
//
end;

end.
