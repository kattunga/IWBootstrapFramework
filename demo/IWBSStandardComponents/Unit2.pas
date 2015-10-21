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
  IWBSCustomControl, IWCompEdit, IWCompExtCtrls, IWCompCheckbox, IWCompMemo,
  IWCompListbox, IWCompRadioButton;

type
  TIWForm2 = class(TIWAppForm)
    IWTabControl21: TIWBSTabControl;
    IWBSRegion3: TIWBSRegion;
    IWBSRegion5: TIWBSRegion;
    IWBSRegion8: TIWBSRegion;
    IWTabControl21Page4: TIWTabPage;
    IWTabControl21Page0: TIWTabPage;
    IWTabControl21Page1: TIWTabPage;
    IWTabControl21Page5: TIWTabPage;
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSRegion25: TIWBSRegion;
    IWBSRegion2: TIWBSRegion;
    IWBSRegion18: TIWBSRegion;
    IWBSInputForm3: TIWBSInputForm;
    IWText2: TIWText;
    IWBSInputForm2: TIWBSInputForm;
    IWBSButton20: TIWBSButton;
    IWBSRegion29: TIWBSRegion;
    IWTabControl21Page2: TIWTabPage;
    IWBSRegion4: TIWBSRegion;
    IWBSRegion6: TIWBSRegion;
    IWBSRegion7: TIWBSRegion;
    IWBSInputForm1: TIWBSInputForm;
    IWBSRegion30: TIWBSRegion;
    IWBSInputForm4: TIWBSInputForm;
    IWBSRegion12: TIWBSRegion;
    IWBSRegion26: TIWBSRegion;
    IWBSRegion13: TIWBSRegion;
    IWBSRegion17: TIWBSRegion;
    IWBSRegion31: TIWBSRegion;
    IWImageFile1: TIWImageFile;
    IWBSRegion9: TIWBSRegion;
    IWButton1: TIWButton;
    IWEdit1: TIWEdit;
    IWBSFormControl1: TIWBSFormControl;
    IWBSFormControl2: TIWBSFormControl;
    IWBSFormControl3: TIWBSFormControl;
    IWBSFormControl4: TIWBSFormControl;
    IWBSFormControl5: TIWBSFormControl;
    IWBSInput23: TIWEdit;
    IWBSInput1: TIWEdit;
    IWBSInput3: TIWEdit;
    IWBSInput13: TIWEdit;
    IWBSMemo2: TIWMemo;
    IWBSListbox2: TIWComboBox;
    IWBSFormControl6: TIWBSFormControl;
    IWBSListbox3: TIWListbox;
    IWBSFormControl7: TIWBSFormControl;
    IWBSCheckBox1: TIWCheckBox;
    IWBSFormControl12: TIWBSFormControl;
    IWBSButton36: TIWButton;
    IWText3: TIWText;
    IWBSButton35: TIWButton;
    chkContFluid: TIWCheckBox;
    chkTabsJust: TIWCheckBox;
    chkTabsStacked: TIWCheckBox;
    chkTabsPills: TIWCheckBox;
    chkTabsFade: TIWCheckBox;
    rbFormVertical: TIWRadioButton;
    rbFormHorizontal: TIWRadioButton;
    rbFormInline: TIWRadioButton;
    IWRadioButton1: TIWRadioButton;
    IWRadioButton2: TIWRadioButton;
    IWRadioButton3: TIWRadioButton;
    IWRadioButton4: TIWRadioButton;
    IWBSButton30: TIWButton;
    IWBSButton27: TIWButton;
    IWBSButton28: TIWButton;
    IWBSButton31: TIWButton;
    IWBSButton26: TIWButton;
    IWBSButton34: TIWButton;
    procedure IWBSButton20AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton26AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton27AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton30Click(Sender: TObject);
    procedure IWBSButton28AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton31AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton35Click(Sender: TObject);
    procedure IWBSButton36Click(Sender: TObject);
    procedure IWBSButton34AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWButton1AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

uses IWBSUtils, IWBSRegionCommon, IWBSDialogs, unit1, unit3, FishFact,
  ServerController;

procedure TIWForm2.IWBSButton20AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWBSInput1.Text := 'this text was filled with ajax';
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

procedure TIWForm2.IWBSButton34AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  raise Exception.Create('Error Message');
end;

procedure TIWForm2.IWBSButton35Click(Sender: TObject);
begin
  if rbFormVertical.Checked then
    IWBSInputForm2.BSFormType := bsftVertical
  else if rbFormHorizontal.Checked then
    IWBSInputForm2.BSFormType := bsftHorizontal
  else if rbFormInline.Checked then
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

procedure TIWForm2.IWButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWEdit1.Visible := not IWEdit1.Visible;
end;

initialization
  TIWForm2.SetAsMainForm;

  TIWBSLayoutMgr.AddLinkFile('iwbsstandarddemo.css');

end.
