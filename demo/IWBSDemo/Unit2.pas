unit Unit2;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Controls, Vcl.Forms, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit,
  IWBSRegion, IWBSTabControl, IWCompButton, IWCompExtCtrls,
  IWBSInput, IWCompTabControl, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWCompLabel, IWCompCheckbox,
  IWCompText, IWCompMemo, IWLayoutMgrForm, IWBSLayoutMgr,
  IWCompRadioButton, IWCompOrderedListbox, IWHTMLControls, IWCompListbox,
  IWCompGrids, Vcl.Imaging.jpeg, IWBSControls, IWDBStdCtrls, IWDBExtCtrls;

type
  TIWForm2 = class(TIWAppForm)
    IWTabControl21: TIWBSTabControl;
    IWTabControl21Page3: TIWTabPage;
    IWBSRegion3: TIWBSRegion;
    IWBSRegion5: TIWBSRegion;
    IWBSRegion8: TIWBSRegion;
    IWBSRegion10: TIWBSRegion;
    IWBSBtnToolBar1: TIWBSRegion;
    IWBSBtnGroup1: TIWBSRegion;
    IWBSButton1: TIWBSButton;
    IWBSButton2: TIWBSButton;
    IWBSButton3: TIWBSButton;
    IWBSButton4: TIWBSButton;
    IWBSBtnGroup2: TIWBSRegion;
    IWBSButton5: TIWBSButton;
    IWBSButton6: TIWBSButton;
    IWBSButton7: TIWBSButton;
    IWBSButton8: TIWBSButton;
    IWBSBtnGroup3: TIWBSRegion;
    IWBSButton9: TIWBSButton;
    IWBSButton10: TIWBSButton;
    IWBSButton11: TIWBSButton;
    IWBSButton12: TIWBSButton;
    IWBSBtnGroup4: TIWBSRegion;
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
    IWBSRegion15: TIWBSRegion;
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
    IWBSRegion16: TIWBSRegion;
    IWText5: TIWText;
    IWBSInputGroup4: TIWBSInputGroup;
    IWBSInput11: TIWBSInput;
    IWBSCheckBox3: TIWBSCheckBox;
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
    IWBSRegion25: TIWBSRegion;
    IWBSRegion2: TIWBSRegion;
    IWBSRegion18: TIWBSRegion;
    IWBSInputForm3: TIWBSInputForm;
    LstFormType: TIWBSRadioGroup;
    IWBSButton35: TIWBSButton;
    IWText2: TIWText;
    IWBSInputForm2: TIWBSInputForm;
    IWBSInput1: TIWBSInput;
    IWBSInput2: TIWBSInput;
    IWBSInput3: TIWBSInput;
    IWBSMemo2: TIWBSMemo;
    IWBSListbox2: TIWBSListbox;
    IWBSComboBox2: TIWBSComboBox;
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
    IWBSListbox3: TIWBSListbox;
    IWBSCheckBox4: TIWBSCheckBox;
    IWBSRegion1: TIWBSRegion;
    IWBSRadioButton6: TIWBSRadioButton;
    IWBSRadioButton7: TIWBSRadioButton;
    IWBSRadioButton8: TIWBSRadioButton;
    IWBSRadioButton9: TIWBSRadioButton;
    IWBSRegion29: TIWBSRegion;
    IWTabControl21Page2: TIWTabPage;
    IWBSRegion4: TIWBSRegion;
    IWBSButton36: TIWBSButton;
    IWText3: TIWBSText;
    IWBSRegion6: TIWBSRegion;
    IWBSRegion7: TIWBSRegion;
    IWBSInputForm1: TIWBSInputForm;
    IWBSButton30: TIWBSButton;
    chkContFluid: TIWBSCheckBox;
    chkTabsJust: TIWBSCheckBox;
    chkTabsStacked: TIWBSCheckBox;
    chkTabsPills: TIWBSCheckBox;
    chkTabsFade: TIWBSCheckBox;
    chkTabsResponsive: TIWBSCheckBox;
    IWBSRegion30: TIWBSRegion;
    IWBSRegion9: TIWBSRegion;
    IWText1: TIWText;
    IWBSRegion14: TIWBSRegion;
    IWText4: TIWText;
    IWBSRegion24: TIWBSRegion;
    IWText10: TIWText;
    IWBSRegion19: TIWBSRegion;
    IWBSRegion20: TIWBSRegion;
    IWText8: TIWText;
    IWBSRegion23: TIWBSRegion;
    IWText7: TIWText;
    IWBSRegion21: TIWBSRegion;
    IWText9: TIWText;
    IWBSRegion22: TIWBSRegion;
    IWText6: TIWText;
    IWBSInputForm4: TIWBSInputForm;
    IWBSRegion12: TIWBSRegion;
    IWBSButton27: TIWBSButton;
    IWBSRegion26: TIWBSRegion;
    IWBSButton28: TIWBSButton;
    IWBSRegion13: TIWBSRegion;
    IWBSButton31: TIWBSButton;
    IWBSInput23: TIWBSInput;
    IWBSRegion17: TIWBSRegion;
    IWBSButton26: TIWBSButton;
    IWBSRegion11: TIWBSRegion;
    IWBSButton21: TIWBSButton;
    IWBSInput6: TIWBSInput;
    IWBSRegion27: TIWBSRegion;
    IWBSButton32: TIWBSButton;
    IWBSRegion28: TIWBSRegion;
    IWBSButton33: TIWBSButton;
    IWBSInput24: TIWBSInput;
    IWBSRegion31: TIWBSRegion;
    IWBSButton34: TIWBSButton;
    IWBSInput13: TIWBSInput;
    IWBSRadioGroup1: TIWBSRadioGroup;
    procedure IWBSButton20AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton22AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton26AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton27AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWGrid1RenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure IWBSButton30Click(Sender: TObject);
    procedure IWBSButton21AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton28AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton31AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton32AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton33AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton35Click(Sender: TObject);
    procedure IWBSButton36Click(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWBSButton34AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

uses IWBSUtils, IWBSRegionCommon, IWBSDialogs, unit1, unit3, FishFact,
  ServerController;

procedure TIWForm2.IWAppFormCreate(Sender: TObject);
begin
  ExtraHeader.Add('<link href="'+IWServerController.URLBase+'/iwbsdemo.css" rel="stylesheet">');
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
  IWBSRegion11.AsyncRenderComponent(true);
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
  cmp.IWBSRegion1.AsyncRenderComponent(true);
end;

procedure TIWForm2.IWBSButton27AsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  cmp: TIWFrame3;
begin
  cmp := TIWFrame3.Create(Self);
  cmp.Name := IWBSGetUniqueComponentName(Self,'frame');
  cmp.Parent := Self;
  cmp.IWBSModal1.AsyncRenderComponent(true);
end;

procedure TIWForm2.IWBSButton28AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  TIWBSDialog.Create('This is the header', 'This is the Body').Show;
end;

procedure TIWForm2.IWGrid1RenderCell(ACell: TIWGridCell; const ARow,
  AColumn: Integer);
begin
  ACell.Text := 'Cell '+IntToStr(ARow)+' / '+IntToStr(AColumn);
end;

procedure TIWForm2.IWBSButton30Click(Sender: TObject);
begin
  chkTabsFade.TabOrder := 0;

  IWTabControl21.BSTabOptions.Fade := chkTabsFade.Checked;
  IWTabControl21.BSTabOptions.Justified := chkTabsJust.Checked;
  IWTabControl21.BSTabOptions.Pills := chkTabsPills.Checked;
  IWTabControl21.BSTabOptions.Stacked := chkTabsStacked.Checked;
  IWTabControl21.BSTabOptions.Responsive := chkTabsResponsive.Checked;

  if chkContFluid.Checked then
    IWBSRegion3.BSRegionType := TIWBSRegionType.bsrtContainerFluid
  else
    IWBSRegion3.BSRegionType := TIWBSRegionType.bsrtContainer;
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

procedure TIWForm2.IWBSButton35Click(Sender: TObject);
begin
  if LstFormType.ItemIndex = 0 then
    IWBSInputForm2.BSFormType := bsftVertical
  else if LstFormType.ItemIndex = 1 then
    IWBSInputForm2.BSFormType := bsftHorizontal
  else if LstFormType.ItemIndex = 2 then
    IWBSInputForm2.BSFormType := bsftInline;
end;

procedure TIWForm2.IWBSButton36Click(Sender: TObject);
begin
  with TFFishFact.Create(WebApplication) do begin
    IWBSRegion1.BSRegionType := Self.IWBSRegion3.BSRegionType;
    IWBSInputForm1.BSFormType := Self.IWBSInputForm2.BSFormType;
    Show;
  end;
end;

initialization
  TIWForm2.SetAsMainForm;

end.
