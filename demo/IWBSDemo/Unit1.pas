unit Unit1;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWCompButton, IWBSInput,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit,
  IWBSRegion, IWHTMLContainer, IWHTML40Container, IWVCLComponent,
  IWBSCustomInput, IWBSButton, IWBSCustomControl;

type
  TIWFrame1 = class(TFrame)
    IWBSRegion1: TIWBSRegion;
    IWBSInput1: TIWBSInput;
    IWBSButton198: TIWBSButton;
    IWBSInput2: TIWBSInput;
    IWBSButton1: TIWBSButton;
    procedure IWBSButton198AsyncClick(Sender: TObject;
      EventParams: TStringList);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TIWFrame1.IWBSButton198AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSInput2.Text := IWBSInput1.Text;
end;

end.
