unit Unit2;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Controls, Vcl.Forms, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit,
  IWBSRegion, IWBSTabControl, IWCompButton, IWCompExtCtrls, IWDBStdCtrls,
  IWBSInput, IWCompTabControl, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWCompLabel, IWCompCheckbox,
  IWCompText, IWCompMemo, IWLayoutMgrForm, IWBSLayoutMgr,
  IWCompRadioButton, IWCompOrderedListbox, IWHTMLControls, IWCompListbox,
  IWCompGrids, Vcl.Imaging.jpeg;

type
  TIWForm2 = class(TIWAppForm)
    IWTabControl21: TIWBSTabControl;
    IWTabControl21Page0: TIWTabPage;
    IWTabControl21Page1: TIWTabPage;
    IWBSRegion3: TIWBSRegion;
    IWBSButton30: TIWBSButton;
    IWBSRegion4: TIWBSRegion;
    IWBSRegion5: TIWBSRegion;
    IWLabel1: TIWLabel;
    IWBSRegion6: TIWBSRegion;
    IWBSRegion7: TIWBSRegion;
    IWBSRegion8: TIWBSRegion;
    IWBSRegion10: TIWBSRegion;
    IWBSBtnToolBar1: TIWBSBtnToolBar;
    IWBSBtnGroup1: TIWBSBtnGroup;
    IWBSButton1: TIWBSButton;
    IWBSButton2: TIWBSButton;
    IWBSButton3: TIWBSButton;
    IWBSButton4: TIWBSButton;
    IWBSBtnGroup2: TIWBSBtnGroup;
    IWBSButton5: TIWBSButton;
    IWBSButton6: TIWBSButton;
    IWBSButton7: TIWBSButton;
    IWBSButton8: TIWBSButton;
    IWBSBtnGroup3: TIWBSBtnGroup;
    IWBSButton9: TIWBSButton;
    IWBSButton10: TIWBSButton;
    IWBSButton11: TIWBSButton;
    IWBSButton12: TIWBSButton;
    IWBSBtnGroup4: TIWBSBtnGroup;
    IWBSButton13: TIWBSButton;
    IWBSButton14: TIWBSButton;
    IWBSButton15: TIWBSButton;
    IWBSButton16: TIWBSButton;
    IWBSButton17: TIWBSButton;
    IWBSButton18: TIWBSButton;
    IWBSButton19: TIWBSButton;
    IWBSInput4: TIWBSInput;
    IWBSInput5: TIWBSInput;
    IWBSInput6: TIWBSInput;
    IWBSMemo1: TIWBSMemo;
    IWText2: TIWText;
    IWBSRegion1: TIWBSRegion;
    IWBSRegion11: TIWBSRegion;
    IWBSRegion12: TIWBSRegion;
    IWTabControl21Page2: TIWTabPage;
    IWBSRegion9: TIWBSRegion;
    IWText1: TIWText;
    chkTabsFade: TIWBSCheckBox;
    chkTabsJust: TIWBSCheckBox;
    chkTabsPills: TIWBSCheckBox;
    chkTabsStacked: TIWBSCheckBox;
    chkContFluid: TIWBSCheckBox;
    IWBSRadioButton1: TIWBSRadioButton;
    IWBSRadioButton2: TIWBSRadioButton;
    IWBSRadioButton3: TIWBSRadioButton;
    IWBSRadioButton4: TIWBSRadioButton;
    IWBSCheckBox1: TIWBSCheckBox;
    IWBSCheckBox2: TIWBSCheckBox;
    IWBSListbox1: TIWBSListbox;
    IWBSComboBox1: TIWBSComboBox;
    IWTabControl21Page3: TIWTabPage;
    IWBSRegion2: TIWBSRegion;
    IWText3: TIWText;
    IWBSRegion13: TIWBSRegion;
    IWBSInput1: TIWBSInput;
    IWBSInput2: TIWBSInput;
    IWBSInput3: TIWBSInput;
    IWBSMemo2: TIWBSMemo;
    IWBSListbox2: TIWBSListbox;
    IWBSComboBox2: TIWBSComboBox;
    IWBSRegion14: TIWBSRegion;
    IWText4: TIWText;
    IWBSButton20: TIWBSButton;
    IWBSInput7: TIWBSInput;
    IWBSButton21: TIWBSButton;
    IWTabControl21Page4: TIWTabPage;
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
    IWBSInput13: TIWBSInput;
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
    IWTabControl21Page5: TIWTabPage;
    IWBSRegion17: TIWBSRegion;
    IWBSButton26: TIWBSButton;
    IWBSButton27: TIWBSButton;
    IWTabControl21Page6: TIWTabPage;
    IWBSRegion18: TIWBSRegion;
    IWButton1: TIWButton;
    IWCheckBox1: TIWCheckBox;
    IWComboBox1: TIWComboBox;
    IWEdit1: TIWEdit;
    IWGrid1: TIWGrid;
    IWImage1: TIWImage;
    IWLabel2: TIWLabel;
    IWListbox1: TIWListbox;
    IWMemo1: TIWMemo;
    IWRadioGroup1: TIWRadioGroup;
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    procedure IWButton1AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton20AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton22AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton26AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton27AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWGrid1RenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure IWBSButton30Click(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}

uses IWBSUtils, IWBSCommon, unit1, unit3;

procedure TIWForm2.IWBSButton20AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSInput1.Text := 'this text was filled with ajax';
end;

procedure TIWForm2.IWBSButton22AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSInput8.Text := 'you pressed left button';
end;

procedure TIWForm2.IWBSButton26AsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  cmp: TIWFrame1;
begin
  cmp := TIWFrame1.Create(Self);
  cmp.Name := IWBSGetUniqueComponentName(Self,'frame');
  cmp.Parent := IWBSRegion17;
//  IWBSRegion17.AsyncRenderComponent(true);
  cmp.IWBSRegion1.AsyncRenderComponent(true);
end;

procedure TIWForm2.IWBSButton27AsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  cmp: TIWFrame3;
begin
  cmp := TIWFrame3.Create(Self);
  cmp.Name := IWBSGetUniqueComponentName(Self,'frame');
  cmp.Parent := IWBSRegion17;
//  IWBSRegion17.AsyncRenderComponent(true);
  cmp.IWBSModal1.AsyncRenderComponent(true);
end;

procedure TIWForm2.IWButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSInput4.ReadOnly := true;
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

  if chkContFluid.Checked then
    IWBSRegion3.BSRegionType := TIWBSRegionType.bsrtContainerFluid
  else
    IWBSRegion3.BSRegionType := TIWBSRegionType.bsrtContainer;
end;

initialization
  TIWForm2.SetAsMainForm;

end.
