unit Unit3;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWBSRegion, IWCompEdit, IWBSInput,
  IWCompLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompButton;

type
  TIWFrame3 = class(TFrame)
    IWBSRegion1: TIWBSRegion;
    IWBSModal1: TIWBSModal;
    IWBSRegion2: TIWBSRegion;
    IWBSRegion3: TIWBSRegion;
    IWBSRegion4: TIWBSRegion;
    IWBSRegion5: TIWBSRegion;
    IWLabel1: TIWLabel;
    IWLabel2: TIWLabel;
    IWLabel3: TIWLabel;
    IWLabel4: TIWLabel;
    IWBSInput1: TIWBSInput;
    IWBSButton199: TIWBSButton;
    procedure IWBSButton199AsyncClick(Sender: TObject; EventParams: TStringList);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TIWFrame3.IWBSButton199AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  Free;
end;

end.
