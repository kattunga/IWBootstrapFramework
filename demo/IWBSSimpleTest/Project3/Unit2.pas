unit Unit2;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWBSRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWBSCustomControl, IWBSButton, IWBSCustomInput,
  IWBSInput;

type
  TIWFrame2 = class(TFrame)
    IWBSModal1: TIWBSModal;
    rgn1: TIWBSRegion;
    btn1: TIWBSButton;
    inp1: TIWBSMemo;
    procedure btn1AsyncClick(Sender: TObject; EventParams: TStringList);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ServerController;

procedure TIWFrame2.btn1AsyncClick(Sender: TObject; EventParams: TStringList);
begin
  UserSession.WebApplication.ShowMessage('The memo content is:' + inp1.Text);

end;

end.