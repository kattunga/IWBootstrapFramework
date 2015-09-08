unit ServerController;
{PUBDIST}

interface

uses
  SysUtils, Classes, Forms, IWServerControllerBase, HTTPApp;

type
  TIWServerController = class(TIWServerControllerBase)
  private
  public
  end;

implementation
{$R *.dfm}

initialization
  TIWServerController.SetServerControllerClass;
  
end.
 
