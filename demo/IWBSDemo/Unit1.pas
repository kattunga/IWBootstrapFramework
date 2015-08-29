unit Unit1;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWCompButton, IWBSInput,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit,
  IWBSRegion, IWHTMLContainer, IWHTML40Container, IWVCLComponent;

type
  TIWFrame1 = class(TFrame)
    IWFrameRegion: TIWRegion;
    IWBSRegion1: TIWBSRegion;
    IWBSInput1: TIWBSInput;
    IWBSButton1: TIWBSButton;
    procedure IWBSButton1AsyncClick(Sender: TObject; EventParams: TStringList);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TIWFrame1.IWBSButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSInput1.Text := 'Seted by ajax'
end;

end.