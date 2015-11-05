unit Unit4;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWCompButton,
  Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompEdit;

type
  TIWForm4 = class(TIWAppForm)
    IWEdit1: TIWEdit;
    IWButton1: TIWButton;
    procedure IWButton1Click(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}


procedure TIWForm4.IWButton1Click(Sender: TObject);
begin
//
end;

initialization
  TIWForm4.SetAsMainForm;

end.
