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
  IWCompGrids, Vcl.Imaging.jpeg, IWBSControls;

type
  TIWForm2 = class(TIWAppForm)
    IWTabControl21: TIWBSTabControl;
    IWTabControl21Page3: TIWTabPage;
    IWBSRegion3: TIWBSRegion;
    IWBSButton30: TIWBSButton;
    IWBSRegion4: TIWBSRegion;
    IWBSRegion5: TIWBSRegion;
    IWLabel1: TIWLabel;
    IWBSRegion6: TIWBSRegion;
    IWBSRegion7: TIWBSRegion;
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
    IWBSRegion9: TIWBSRegion;
    IWText1: TIWText;
    chkTabsFade: TIWBSCheckBox;
    chkTabsJust: TIWBSCheckBox;
    chkTabsPills: TIWBSCheckBox;
    chkTabsStacked: TIWBSCheckBox;
    chkContFluid: TIWBSCheckBox;
    IWTabControl21Page0: TIWTabPage;
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
    IWBSRegion19: TIWBSRegion;
    IWBSRegion20: TIWBSRegion;
    IWBSRegion21: TIWBSRegion;
    IWBSRegion22: TIWBSRegion;
    IWBSRegion23: TIWBSRegion;
    IWText6: TIWText;
    IWText7: TIWText;
    IWText8: TIWText;
    IWText9: TIWText;
    IWBSRegion24: TIWBSRegion;
    IWText10: TIWText;
    IWBSCheckBox4: TIWBSCheckBox;
    IWBSRegion25: TIWBSRegion;
    IWBSRadioButton6: TIWBSRadioButton;
    IWBSRadioButton7: TIWBSRadioButton;
    IWBSRadioButton8: TIWBSRadioButton;
    IWBSRadioButton9: TIWBSRadioButton;
    LstFormType: TIWBSListbox;
    IWBSRegion1: TIWBSRegion;
    IWLabel3: TIWLabel;
    IWEdit2: TIWEdit;
    IWBSInputGroup6: TIWBSInputGroup;
    IWBSInput4: TIWBSInput;
    IWBSGlyphicon1: TIWBSGlyphicon;
    IWBSGlyphicon2: TIWBSGlyphicon;
    IWBSInputGroup7: TIWBSInputGroup;
    IWBSInput5: TIWBSInput;
    IWBSLabel1: TIWBSLabel;
    IWBSLabel2: TIWBSLabel;
    IWBSRegion11: TIWBSRegion;
    IWBSButton26: TIWBSButton;
    IWBSButton21: TIWBSButton;
    IWBSInput6: TIWBSInput;
    IWBSRegion12: TIWBSRegion;
    IWBSButton27: TIWBSButton;
    IWBSRegion26: TIWBSRegion;
    IWBSButton28: TIWBSButton;
    IWBSButton29: TIWBSButton;
    procedure IWBSButton20AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton22AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton26AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton27AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWGrid1RenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure IWBSButton30Click(Sender: TObject);
    procedure IWBSButton21AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton28AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

uses IWBSUtils, IWBSRegionCommon, unit1, unit3;

procedure TIWForm2.IWBSButton20AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSInput1.Text := 'this text was filled with ajax';
  IWBSMemo2.Text := IWBSinput22.Text;
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
var
  cmp: TIWBSModal;
  cnt, bdy, hdr: TIWBSRegion;
begin
  cmp := TIWBSModal.Create(Self);
  cmp.Parent := Self;
  cmp.DestroyOnHide := True;
  cmp.BSModalVisible := True;
  cnt := TIWBSRegion.Create(Self);
  cnt.BSRegionType := bsrtModalContent;
  cnt.Parent := cmp;

  hdr := TIWBSRegion.Create(Self);
  hdr.BSRegionType := bsrtModalHeader;
  hdr.Parent := cnt;
  hdr.Top := 0;
  with TIWBSLabel.Create(Self) do begin
    Parent := hdr;
    Caption := 'this is the header';
  end;
  with TIWBSButton.Create(Self) do begin
    Parent := hdr;
    Caption := '';
    BSButtonStyle := bsbsClose;
    BSDataDismiss := bsbdModal;
  end;

  bdy := TIWBSRegion.Create(Self);
  bdy.BSRegionType := bsrtModalBody;
  bdy.Parent := cnt;
  bdy.Top := 30;
  with TIWBSLabel.Create(Self) do begin
    Parent := bdy;
    Caption := 'this is the body';
  end;

  cmp.AsyncRenderComponent(true);
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

  if LstFormType.SelectedText = 'form-vertical' then
    IWBSRegion13.BSFormType := bsftVertical
  else if LstFormType.SelectedText = 'form-horizontal' then
    IWBSRegion13.BSFormType := bsftHorizontal
  else if LstFormType.SelectedText = 'form-inline' then
    IWBSRegion13.BSFormType := bsftInline
  else
    IWBSRegion13.BSFormType := bsftNoForm
end;

initialization
  TIWForm2.SetAsMainForm;

end.
