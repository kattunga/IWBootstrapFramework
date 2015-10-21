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
    IWBSButton198: TIWButton;
    IWBSInput1: TIWEdit;
    IWBSInput2: TIWEdit;
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
