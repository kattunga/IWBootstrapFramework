unit Unit2;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Controls, Vcl.Forms, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWBSRegion,
  IWCompTabControl, IWBSTabControl,
  IWCompButton,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWBSLayoutMgr,
  IWBSInput, IWBSControls, IWDBStdCtrls, IWDBExtCtrls,
  IWBSCustomInput, IWBSButton, IWCompText, IWCompLabel, IWVCLComponent,
  IWBSCustomControl, IWCGJQControl, IWCGJQRegion, IWBSCGJQRegion,
  IWCGJQThemeSwitcher, IWCGJQButton;

type
  TIWForm2 = class(TIWAppForm)
    IWTabControl21: TIWBSTabControl;
    IWTabControl21Page3: TIWTabPage;
    IWBSRegion3: TIWBSCGJQRegion;
    IWBSRegion5: TIWBSCGJQRegion;
    IWBSRegion8: TIWBSCGJQRegion;
    IWBSRegion10: TIWBSCGJQRegion;
    IWBSBtnToolBar1: TIWBSCGJQRegion;
    IWBSBtnGroup1: TIWBSCGJQRegion;
    IWBSButton1: TIWBSButton;
    IWBSButton2: TIWBSButton;
    IWBSButton3: TIWBSButton;
    IWBSButton4: TIWBSButton;
    IWBSBtnGroup2: TIWBSCGJQRegion;
    IWBSButton5: TIWBSButton;
    IWBSButton6: TIWBSButton;
    IWBSButton7: TIWBSButton;
    IWBSButton8: TIWBSButton;
    IWBSBtnGroup3: TIWBSCGJQRegion;
    IWBSButton9: TIWBSButton;
    IWBSButton10: TIWBSButton;
    IWBSButton11: TIWBSButton;
    IWBSButton12: TIWBSButton;
    IWBSBtnGroup4: TIWBSCGJQRegion;
    IWBSButton13: TIWBSButton;
    IWBSButton14: TIWBSButton;
    IWBSButton15: TIWBSButton;
    IWBSButton16: TIWBSButton;
    IWBSButton17: TIWBSButton;
    IWBSButton18: TIWBSButton;
    IWBSButton19: TIWBSButton;
    IWTabControl21Page4: TIWTabPage;
    IWTabControl21Page0: TIWTabPage;
    IWTabControl21Page1: TIWTabPage;
    IWBSRegion15: TIWBSCGJQRegion;
    IWBSInputGroup1: TIWBSInputGroup;
    IWBSButton22: TIWBSButton;
    IWBSInput8: TIWBSInput;
    IWBSInputGroup2: TIWBSInputGroup;
    IWBSButton23: TIWBSButton;
    IWBSInput9: TIWBSInput;
    IWBSInputGroup3: TIWBSInputGroup;
    IWBSButton24: TIWBSButton;
    IWBSInput10: TIWBSInput;
    IWBSButton25: TIWBSButton;
    IWBSRegion16: TIWBSCGJQRegion;
    IWBSInputGroup4: TIWBSInputGroup;
    IWBSInput11: TIWBSInput;
    IWBSInputGroup5: TIWBSInputGroup;
    IWBSInput12: TIWBSInput;
    IWBSRadioButton5: TIWBSRadioButton;
    IWTabControl21Page5: TIWTabPage;
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSInputGroup6: TIWBSInputGroup;
    IWBSInput4: TIWBSInput;
    IWBSGlyphicon1: TIWBSGlyphicon;
    IWBSGlyphicon2: TIWBSGlyphicon;
    IWBSInputGroup7: TIWBSInputGroup;
    IWBSInput5: TIWBSInput;
    IWBSLabel1: TIWBSLabel;
    IWBSLabel2: TIWBSLabel;
    IWBSButton29: TIWBSButton;
    IWBSRegion25: TIWBSCGJQRegion;
    IWBSRegion2: TIWBSCGJQRegion;
    IWBSRegion18: TIWBSCGJQRegion;
    IWBSInputForm3: TIWBSInputForm;
    LstFormType: TIWBSRadioGroup;
    IWBSInputForm2: TIWBSInputForm;
    IWBSInput1: TIWBSInput;
    IWBSInput2: TIWBSInput;
    IWBSInput3: TIWBSInput;
    IWBSMemo2: TIWBSMemo;
    IWBSButton20: TIWBSButton;
    IWBSInput7: TIWBSInput;
    IWBSInput14: TIWBSInput;
    IWBSInput15: TIWBSInput;
    IWBSInput16: TIWBSInput;
    IWBSInput17: TIWBSInput;
    IWBSInput18: TIWBSInput;
    IWBSInput19: TIWBSInput;
    IWBSInput20: TIWBSInput;
    IWBSInput21: TIWBSInput;
    IWBSInput22: TIWBSInput;
    IWBSRegion1: TIWBSCGJQRegion;
    IWBSRadioButton6: TIWBSRadioButton;
    IWBSRadioButton7: TIWBSRadioButton;
    IWBSRadioButton8: TIWBSRadioButton;
    IWBSRadioButton9: TIWBSRadioButton;
    IWBSRegion29: TIWBSCGJQRegion;
    IWTabControl21Page2: TIWTabPage;
    IWBSRegion4: TIWBSCGJQRegion;
    IWBSButton36: TIWBSButton;
    IWText3: TIWBSText;
    IWBSRegion6: TIWBSCGJQRegion;
    IWBSRegion30: TIWBSCGJQRegion;
    IWBSRegion9: TIWBSCGJQRegion;
    IWBSRegion14: TIWBSCGJQRegion;
    IWBSRegion24: TIWBSCGJQRegion;
    IWBSRegion19: TIWBSCGJQRegion;
    IWBSRegion20: TIWBSCGJQRegion;
    IWBSRegion23: TIWBSCGJQRegion;
    IWBSRegion22: TIWBSCGJQRegion;
    IWBSInputForm4: TIWBSInputForm;
    IWBSRegion12: TIWBSCGJQRegion;
    IWBSButton27: TIWBSButton;
    IWBSRegion26: TIWBSCGJQRegion;
    IWBSButton28: TIWBSButton;
    IWBSRegion13: TIWBSCGJQRegion;
    IWBSButton31: TIWBSButton;
    IWBSInput23: TIWBSInput;
    IWBSRegion17: TIWBSCGJQRegion;
    IWBSButton26: TIWBSButton;
    IWBSRegion11: TIWBSCGJQRegion;
    IWBSButton21: TIWBSButton;
    IWBSInput6: TIWBSInput;
    IWBSRegion27: TIWBSCGJQRegion;
    IWBSButton32: TIWBSButton;
    IWBSRegion28: TIWBSCGJQRegion;
    IWBSButton33: TIWBSButton;
    IWBSInput24: TIWBSInput;
    IWBSRegion31: TIWBSCGJQRegion;
    IWBSButton34: TIWBSButton;
    IWBSInput13: TIWBSInput;
    IWBSRadioGroup1: TIWBSRadioGroup;
    IWBSComboBox2: TIWBSSelect;
    IWBSListbox2: TIWBSSelect;
    IWBSListbox3: TIWBSSelect;
    IWBSCheckBox1: TIWBSCheckBox;
    IWTabControl21Page6: TIWTabPage;
    IWBSButton37: TIWBSButton;
    IWBSRegion32: TIWBSCGJQRegion;
    IWBSRegion33: TIWBSCGJQRegion;
    IWBSInput25: TIWBSInput;
    IWText5: TIWBSText;
    IWText1: TIWBSText;
    IWText4: TIWBSText;
    IWText10: TIWBSText;
    IWText8: TIWBSText;
    IWText7: TIWBSText;
    IWText6: TIWBSText;
    IWText11: TIWBSText;
    IWText2: TIWBSText;
    IWBSRegion34: TIWBSCGJQRegion;
    IWBSModal1: TIWBSModal;
    IWBSButton40: TIWBSButton;
    IWBSRegion35: TIWBSCGJQRegion;
    IWBSText1: TIWBSText;
    IWBSButton39: TIWBSButton;
    IWBSButton38: TIWBSButton;
    IWBSButton41: TIWBSButton;
    IWBSRegion37: TIWBSCGJQRegion;
    IWBSRegion7: TIWBSCGJQRegion;
    IWBSInputForm1: TIWBSInputForm;
    IWBSButton30: TIWBSButton;
    chkContFluid: TIWBSCheckBox;
    chkTabsJust: TIWBSCheckBox;
    chkTabsStacked: TIWBSCheckBox;
    chkTabsPills: TIWBSCheckBox;
    chkTabsFade: TIWBSCheckBox;
    IWBSRegion36: TIWBSCGJQRegion;
    IWBSButton42: TIWBSButton;
    IWBSRegion21: TIWBSCGJQRegion;
    IWText9: TIWBSText;
    IWBSButton35: TIWCGJQButton;
    procedure IWBSButton20AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton22AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton26AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton27AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton21AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton28AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton31AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton32AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton33AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWBSButton34AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton37AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton40AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton39AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton42AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton35JQButtonOptionsClick(Sender: TObject;
      AParams: TStringList);
    procedure IWBSButton30AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton36AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

uses IWBSUtils, IWBSRegionCommon, IWBSDialogs, unit1, unit3, FishFact,
  ServerController;

procedure TIWForm2.IWAppFormCreate(Sender: TObject);
begin
  ExtraHeader.Add('<link href="'+IWServerController.URLBase+'/iwbscgdevtoolsdemo.css" rel="stylesheet">');
end;

procedure TIWForm2.IWBSButton20AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSInput1.Text := 'this text was filled with ajax';
  IWBSMemo2.Lines.Values['type datetimelocal'] := IWBSInput14.Text;
  IWBSMemo2.Lines.Values['type date'] := IWBSInput7.Text;
  IWBSMemo2.Lines.Values['type month'] := IWBSInput15.Text;
  IWBSMemo2.Lines.Values['type time'] := IWBSInput16.Text;
  IWBSMemo2.Lines.Values['type week'] := IWBSInput17.Text;
  IWBSMemo2.Lines.Values['type number'] := IWBSInput2.Text;
  IWBSMemo2.Lines.Values['type color'] := IWBSinput22.Text;
end;

procedure TIWForm2.IWBSButton21AsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  cmp: TIWBSButton;
begin
  cmp := TIWBSButton.Create(Self);
  cmp.Parent := IWBSRegion11;
  cmp.Top := 20;
  cmp.AsyncClickProc := procedure(EventParams: TStringList)
                        begin
                          IWBSInput6.Text := 'this is set by anonymous procedure';
                        end;
  IWBSRegion11.AjaxReRender;
end;

procedure TIWForm2.IWBSButton22AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSInput8.Text := 'you pressed a button';
end;

procedure TIWForm2.IWBSButton26AsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  cmp: TIWFrame1;
begin
  cmp := TIWFrame1.Create(Self);
  cmp.Name := IWBSGetUniqueComponentName(Self,'frame');
  cmp.Parent := IWBSRegion17;
  cmp.IWBSRegion1.AsyncRefreshControl;
end;

procedure TIWForm2.IWBSButton27AsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  cmp: TIWFrame3;
begin
  cmp := TIWFrame3.Create(Self);
  cmp.Name := IWBSGetUniqueComponentName(Self,'frame');
  cmp.Parent := Self;
  cmp.IWBSModal1.AsyncRefreshControl;
end;

procedure TIWForm2.IWBSButton28AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  TIWBSDialog.Create('This is the header', 'This is the Body').Show;
end;

procedure TIWForm2.IWBSButton30AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  chkTabsFade.TabOrder := 0;

  IWTabControl21.BSTabOptions.Fade := chkTabsFade.Checked;
  IWTabControl21.BSTabOptions.Justified := chkTabsJust.Checked;
  IWTabControl21.BSTabOptions.Pills := chkTabsPills.Checked;
  IWTabControl21.BSTabOptions.Stacked := chkTabsStacked.Checked;

  if chkContFluid.Checked then
    IWBSRegion3.BSRegionType := TIWBSRegionType.bsrtContainerFluid
  else
    IWBSRegion3.BSRegionType := TIWBSRegionType.bsrtContainer;
  IWBSRegion3.AjaxReRender;
end;

procedure TIWForm2.IWBSButton31AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  with TIWBSDialog.Create('This is the header', 'Press ok to set text to input IWBSInput23') do begin
    AddButton(GetFooter, 'ok',
      procedure(EventParams: TStringList)
      begin
        IWBSInput23.Text := 'You pressed OK!';
      end);
    Show;
  end;
end;

procedure TIWForm2.IWBSButton32AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  TIWBSAlert.Create('This is simple Alert').Show;
end;

procedure TIWForm2.IWBSButton33AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  with TIWBSAlert.Create('<strong>This is an Alert with a button with AsynClick event</strong><br>') do begin
    AlertLabel.RawText := True;
    AddButton('ok',
      procedure(EventParams: TStringList)
      begin
        IWBSInput24.Text := 'You pressed OK in the alert!';
      end);
    Show;
  end;
end;

procedure TIWForm2.IWBSButton34AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  raise Exception.Create('Error Message');
end;

procedure TIWForm2.IWBSButton35JQButtonOptionsClick(Sender: TObject;
  AParams: TStringList);
begin
  if LstFormType.ItemIndex = 0 then
    IWBSInputForm2.BSFormType := bsftVertical
  else if LstFormType.ItemIndex = 1 then
    IWBSInputForm2.BSFormType := bsftHorizontal
  else if LstFormType.ItemIndex = 2 then
    IWBSInputForm2.BSFormType := bsftInline;
  IWBSREgion25.AjaxReRender;
end;

procedure TIWForm2.IWBSButton36AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  with TFFishFact.Create(WebApplication) do begin
    IWBSRegion1.BSRegionType := Self.IWBSRegion3.BSRegionType;
    IWBSInputForm1.BSFormType := Self.IWBSInputForm2.BSFormType;
    Show;
  end;
end;

procedure TIWForm2.IWBSButton37AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSRegion32.Visible := not IWBSRegion32.Visible;
  IWBSInput25.Visible := IWBSRegion32.Visible;
end;

procedure TIWForm2.IWBSButton39AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSModal1.ModalVisible := False;
end;

procedure TIWForm2.IWBSButton40AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSModal1.ModalVisible := True;
end;

procedure TIWForm2.IWBSButton42AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWTabControl21.SetTabPageVisibility(IWTabControl21Page5, not IWTabControl21Page5.Visible);
end;

initialization
  TIWForm2.SetAsMainForm;

end.
