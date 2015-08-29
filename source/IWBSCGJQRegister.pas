unit IWBSCGJQRegister;

interface

uses System.Classes, DesignEditors;

procedure Register;

implementation

uses DesignIntf, Winapi.Windows,
     IWBaseControl,
     IWCGDsnPaint,
     IWBSCGJQRegion;

procedure Register;
begin
  RegisterComponents('IW BootsTrap', [TIWBSCGJQRegion]);
end;

initialization
  IWRegisterPaintHandler('TIWBSCGJQRegion',TIWCGPaintHandlerRegion);

finalization
  IWUnRegisterPaintHandler('TIWBSCGJQRegion');

end.
