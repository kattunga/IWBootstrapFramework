unit Unit2;

interface

uses
  System.Classes, System.SysUtils, System.Contnrs, Vcl.Controls, Vcl.Forms,
  IWAppForm, IWApplication, IWColor, IWTypes,
  IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWBSRegion,
  IWCompTabControl, IWBSTabControl,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWBSLayoutMgr,
  IWBSInput, IWBSControls, IWDBStdCtrls, IWDBExtCtrls,
  IWBSCustomInput, IWBSButton, IWCompText, IWCompLabel, IWVCLComponent,
  IWBSCustomControl, IW.HTTP.Request, IW.HTTP.Reply,
  IWBSDropDown, IWBSNavBar, IWBSModal, IWBSInputForm, IWBSCustomRegion, IWBSList,
  IWBSButtonGroup, IWBSRestServer;

type
  TIWForm2 = class(TIWAppForm)
    IWTabControl21: TIWBSTabControl;
    IWTabControl21Page3: TIWTabPage;
    IWBSRegion3: TIWBSRegion;
    IWBSRegion5: TIWBSRegion;
    IWBSRegion8: TIWBSRegion;
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
    IWBSRegion25: TIWBSRegion;
    IWBSRegion2: TIWBSRegion;
    IWBSRegion18: TIWBSRegion;
    IWBSInputForm3: TIWBSInputForm;
    LstFormType: TIWBSRadioGroup;
    IWBSButton35: TIWBSButton;
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
    IWBSRegion1: TIWBSRegion;
    IWBSRadioButton6: TIWBSRadioButton;
    IWBSRadioButton7: TIWBSRadioButton;
    IWBSRadioButton8: TIWBSRadioButton;
    IWBSRadioButton9: TIWBSRadioButton;
    IWTabControl21Page2: TIWTabPage;
    IWBSRegion6: TIWBSRegion;
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
    IWBSComboBox2: TIWBSSelect;
    IWBSListbox2: TIWBSSelect;
    IWBSListbox3: TIWBSSelect;
    IWBSCheckBox1: TIWBSCheckBox;
    IWTabControl21Page6: TIWTabPage;
    IWBSRegion33: TIWBSRegion;
    IWBSInput25: TIWBSInput;
    IWText2: TIWBSText;
    IWBSRegion37: TIWBSRegion;
    IWBSRegion7: TIWBSRegion;
    IWBSInputForm1: TIWBSInputForm;
    IWBSButton30: TIWBSButton;
    chkTabsJust: TIWBSCheckBox;
    chkTabsStacked: TIWBSCheckBox;
    chkTabsPills: TIWBSCheckBox;
    chkTabsFade: TIWBSCheckBox;
    IWBSRegion36: TIWBSRegion;
    IWBSButton42: TIWBSButton;
    IWBSRegion40: TIWBSRegion;
    IWBSNavBar1: TIWBSNavBar;
    IWBSButton41: TIWBSButton;
    IWBSRegion29: TIWBSRegion;
    IWBSLabel3: TIWBSLabel;
    IWBSInputForm5: TIWBSInputForm;
    IWBSButton45: TIWBSButton;
    IWBSText2: TIWBSText;
    IWBSInput26: TIWBSFile;
    IWBSInputGroup8: TIWBSInputGroup;
    IWBSInput27: TIWBSInput;
    IWBSDropDown1: TIWBSDropDown;
    IWBSNavBarHeader1: TIWBSNavBarHeader;
    IWBSButton48: TIWBSButton;
    IWBSNavBarCollapse1: TIWBSNavBarCollapse;
    IWBSList2: TIWBSList;
    IWBSButton46: TIWBSButton;
    IWBSDropDown2: TIWBSDropDown;
    IWBSButton49: TIWBSButton;
    IWTabControl21Page7: TIWTabPage;
    IWTabControl21Page8: TIWTabPage;
    IWBSList3: TIWBSList;
    IWBSButton57: TIWBSButton;
    IWBSButton58: TIWBSButton;
    IWBSButton59: TIWBSButton;
    IWBSButton60: TIWBSButton;
    IWBSRegion49: TIWBSRegion;
    IWBSLabel10: TIWBSLabel;
    IWBSLabel11: TIWBSLabel;
    IWBSLabel12: TIWBSLabel;
    IWBSLabel13: TIWBSLabel;
    IWBSLabel14: TIWBSLabel;
    IWBSLabel15: TIWBSLabel;
    IWBSRegion51: TIWBSRegion;
    IWBSRegion52: TIWBSRegion;
    IWBSRegion53: TIWBSRegion;
    IWBSRegion55: TIWBSRegion;
    IWBSButton61: TIWBSButton;
    IWBSRegion45: TIWBSRegion;
    IWBSRegion54: TIWBSRegion;
    IWBSButton62: TIWBSButton;
    IWBSButton63: TIWBSButton;
    IWBSButton64: TIWBSButton;
    IWBSButton65: TIWBSButton;
    IWBSRegion10: TIWBSRegion;
    IWBSRegion56: TIWBSRegion;
    IWBSButton66: TIWBSButton;
    IWBSButton67: TIWBSButton;
    IWBSRegion57: TIWBSRegion;
    IWBSButtonGroup1: TIWBSButtonGroup;
    IWBSButton68: TIWBSButton;
    IWBSButton69: TIWBSButton;
    IWBSButton70: TIWBSButton;
    IWBSButtonGroup2: TIWBSButtonGroup;
    IWBSButton71: TIWBSButton;
    IWBSButton72: TIWBSButton;
    IWBSButton73: TIWBSButton;
    IWBSRegion58: TIWBSRegion;
    IWBSButtonGroup3: TIWBSButtonGroup;
    IWBSButton74: TIWBSButton;
    IWBSButton75: TIWBSButton;
    IWBSButton76: TIWBSButton;
    IWBSRegion59: TIWBSRegion;
    IWBSRegion60: TIWBSRegion;
    IWBSButton1: TIWBSButton;
    IWBSButton2: TIWBSButton;
    IWBSButton3: TIWBSButton;
    IWBSButton4: TIWBSButton;
    IWBSRegion61: TIWBSRegion;
    IWBSButton13: TIWBSButton;
    IWBSButton14: TIWBSButton;
    IWBSButton15: TIWBSButton;
    IWBSButton16: TIWBSButton;
    IWBSButton17: TIWBSButton;
    IWBSButton18: TIWBSButton;
    IWBSButton19: TIWBSButton;
    IWBSButton29: TIWBSButton;
    IWBSRegion62: TIWBSRegion;
    IWBSButtonGroup4: TIWBSButtonGroup;
    IWBSButton5: TIWBSButton;
    IWBSButton6: TIWBSButton;
    IWBSButton7: TIWBSButton;
    IWBSRegion63: TIWBSRegion;
    IWBSButtonGroup5: TIWBSButtonGroup;
    IWBSButton8: TIWBSButton;
    IWBSButton9: TIWBSButton;
    IWBSDropDown3: TIWBSDropDown;
    IWBSButtonGroup6: TIWBSButtonGroup;
    IWBSButton11: TIWBSButton;
    IWBSDropDown4: TIWBSDropDown;
    IWBSRegion64: TIWBSRegion;
    IWBSRegion65: TIWBSRegion;
    IWBSButton10: TIWBSButton;
    IWTabControl21Page9: TIWTabPage;
    IWBSRegion9: TIWBSRegion;
    IWBSRegion14: TIWBSRegion;
    IWBSRegion24: TIWBSRegion;
    IWTabControl21Page10: TIWTabPage;
    IWBSRegion19: TIWBSRegion;
    IWBSRegion20: TIWBSRegion;
    IWBSLabel5: TIWBSLabel;
    IWBSRegion21: TIWBSRegion;
    IWText9: TIWBSText;
    IWBSRegion22: TIWBSRegion;
    IWText6: TIWBSText;
    IWBSRegion66: TIWBSRegion;
    IWBSRegion34: TIWBSRegion;
    IWBSModal1: TIWBSModal;
    IWBSRegion35: TIWBSRegion;
    IWBSText1: TIWBSText;
    IWBSButton39: TIWBSButton;
    IWBSButton38: TIWBSButton;
    IWBSButton40: TIWBSButton;
    IWBSButton12: TIWBSButton;
    IWBSRegion30: TIWBSRegion;
    IWBSList4: TIWBSList;
    IWBSLabel6: TIWBSLabel;
    IWBSLabel7: TIWBSLabel;
    IWBSLabel16: TIWBSLabel;
    IWBSRegion41: TIWBSRegion;
    IWBSList5: TIWBSList;
    IWBSLabel4: TIWBSLabel;
    IWBSLabel17: TIWBSLabel;
    IWBSLabel18: TIWBSLabel;
    IWBSLabel19: TIWBSLabel;
    IWBSRegion68: TIWBSRegion;
    IWBSRegion69: TIWBSRegion;
    IWBSButton56: TIWBSButton;
    IWBSButton77: TIWBSButton;
    IWBSButton78: TIWBSButton;
    IWBSRegion70: TIWBSRegion;
    IWBSList6: TIWBSList;
    IWBSButton79: TIWBSButton;
    IWBSButton80: TIWBSButton;
    IWBSButton81: TIWBSButton;
    IWBSButton82: TIWBSButton;
    IWBSRegion71: TIWBSRegion;
    IWBSList7: TIWBSList;
    IWBSButton83: TIWBSButton;
    IWBSButton84: TIWBSButton;
    IWBSList8: TIWBSList;
    IWBSButton85: TIWBSButton;
    IWBSButton86: TIWBSButton;
    IWBSButton87: TIWBSButton;
    IWBSButton88: TIWBSButton;
    IWBSRegion72: TIWBSRegion;
    IWBSList9: TIWBSList;
    IWBSButton89: TIWBSButton;
    IWBSButton90: TIWBSButton;
    IWBSButton91: TIWBSButton;
    IWBSButton92: TIWBSButton;
    IWBSRegion73: TIWBSRegion;
    IWBSRegion74: TIWBSRegion;
    IWBSLabel8: TIWBSLabel;
    IWBSLabel9: TIWBSLabel;
    IWBSLabel20: TIWBSLabel;
    IWTabControl21Page11: TIWTabPage;
    IWBSRegion67: TIWBSRegion;
    IWBSRegion4: TIWBSRegion;
    IWBSRegion38: TIWBSRegion;
    IWBSRegion39: TIWBSRegion;
    IWBSButton43: TIWBSButton;
    IWBSRegion42: TIWBSRegion;
    IWBSText3: TIWBSText;
    IWBSRegion43: TIWBSRegion;
    IWBSRegion44: TIWBSRegion;
    IWBSButton44: TIWBSButton;
    IWBSRegion46: TIWBSRegion;
    IWBSText4: TIWBSText;
    IWBSRegion47: TIWBSRegion;
    IWBSRegion48: TIWBSRegion;
    IWBSButton47: TIWBSButton;
    IWBSRegion50: TIWBSRegion;
    IWBSText5: TIWBSText;
    IWBSButton36: TIWBSButton;
    IWBSRegion75: TIWBSRegion;
    IWBSRegion76: TIWBSRegion;
    IWBSRegion77: TIWBSRegion;
    IWBSRegion32: TIWBSRegion;
    IWTabControl21Page12: TIWTabPage;
    IWBSRegion23: TIWBSRegion;
    IWBSRegion78: TIWBSRegion;
    IWBSRegion79: TIWBSRegion;
    IWBSRegion80: TIWBSRegion;
    IWBSRegion81: TIWBSRegion;
    IWBSRegion82: TIWBSRegion;
    IWBSRegion83: TIWBSRegion;
    IWBSRegion84: TIWBSRegion;
    IWBSRegion85: TIWBSRegion;
    IWBSRegion86: TIWBSRegion;
    IWBSRegion87: TIWBSRegion;
    IWBSRegion88: TIWBSRegion;
    IWBSRegion89: TIWBSRegion;
    IWBSRegion90: TIWBSRegion;
    IWBSRegion91: TIWBSRegion;
    IWBSRegion92: TIWBSRegion;
    IWBSRegion93: TIWBSRegion;
    IWBSRegion94: TIWBSRegion;
    IWBSRegion95: TIWBSRegion;
    IWBSRegion96: TIWBSRegion;
    IWBSButton99: TIWBSButton;
    procedure IWBSButton20AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton22AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton26AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton27AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton21AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton28AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton31AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton32AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton33AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton34AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton37AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton40AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton39AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton42AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSInputForm5Submit(aRequest: THttpRequest; aParams: TStrings);
    procedure IWBSButton35AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton30AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSDropDown2DropDownItems0AsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure AsyncClickBootstrapTable(
      Sender: TObject; EventParams: TStringList);
    procedure AsyncClickJQGrid(
      Sender: TObject; EventParams: TStringList);
    procedure AsyncClickBootstrapFileInput(
      Sender: TObject; EventParams: TStringList);
    procedure IWBSButton46AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSText6CustomAsyncEvents0AsyncEvent(Sender: TObject;
      EventParams: TStringList);
    procedure IWBSButton99CustomRestEvents0RestEvent(
      aApplication: TIWApplication; aRequest: THttpRequest; aReply: THttpReply;
      aParams: TStrings);
    procedure IWBSButton99AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

uses IWBSUtils, IWBSDialogs, unit1, unit3, FishFact, FishFactBootstrapTable, FishFactJQGrid, BootstrapFileInput,
  ServerController, IW.HTTP.FileItem, IWURL, IWUtils;

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
  cmp.AsyncClickProc := procedure(Sender: TObject; EventParams: TStringList)
                        begin
                          IWBSInput6.Text := 'this is set by anonymous procedure';
                        end;
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
end;

procedure TIWForm2.IWBSButton27AsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  cmp: TIWFrame3;
begin
  cmp := TIWFrame3.Create(Self);
  cmp.Name := IWBSGetUniqueComponentName(Self,'frame');
  cmp.Parent := Self;
end;

procedure TIWForm2.IWBSButton28AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  TIWBSDialog.Create('This is the header', 'This is the Body',
    procedure(Sender: TObject; EventParams: TStringList)
    begin
      TIWBSAlert.Create('You closed the dialog');
    end);
end;

procedure TIWForm2.IWBSButton30AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  IWTabControl21.BSTabOptions.Fade := chkTabsFade.Checked;
  IWTabControl21.BSTabOptions.Justified := chkTabsJust.Checked;
  IWTabControl21.BSTabOptions.Pills := chkTabsPills.Checked;
  IWTabControl21.BSTabOptions.Stacked := chkTabsStacked.Checked;
  IWTabControl21.AsyncRefreshControl;
end;

procedure TIWForm2.IWBSButton31AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  with TIWBSDialog.Create('This is the header', 'Press ok to set text to input IWBSInput23') do begin
    AddButton(GetFooter, 'ok',
      procedure(Sender: TObject; EventParams: TStringList)
      begin
        IWBSInput23.Text := 'You pressed OK!';
      end).DataDismiss := bsbdModal;
  end;
end;

procedure TIWForm2.IWBSButton32AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  TIWBSAlert.Create('This is simple Alert', bsasWarning);
end;

procedure TIWForm2.IWBSButton33AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  with TIWBSAlert.Create('<strong>This is an Alert with a button with AsynClick event</strong><br>') do begin
    AlertLabel.RawText := True;
    AddButton('ok',
      procedure(Sender: TObject; EventParams: TStringList)
      begin
        IWBSInput24.Text := 'You pressed OK in the alert!';
      end);
  end;
end;

procedure TIWForm2.IWBSButton34AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  raise Exception.Create('Error Message');
end;

procedure TIWForm2.IWBSButton35AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  if LstFormType.ItemIndex = 0 then
    IWBSInputForm2.BSFormType := bsftVertical
  else if LstFormType.ItemIndex = 1 then
    IWBSInputForm2.BSFormType := bsftHorizontal
  else if LstFormType.ItemIndex = 2 then
    IWBSInputForm2.BSFormType := bsftInline;
  IWBSInputForm2.AsyncRefreshControl;
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

procedure TIWForm2.IWBSButton46AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  if IWBSRegion3.BSRegionType = TIWBSRegionType.bsrtContainer then
    IWBSRegion3.BSRegionType := TIWBSRegionType.bsrtContainerFluid
  else
    IWBSRegion3.BSRegionType := TIWBSRegionType.bsrtContainer;
  IWBSRegion3.AsyncRefreshControl;
end;

procedure TIWForm2.IWBSButton99AsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  href: string;
begin
  href := IWBSButton99.CustomRestEvents[0].RestEventPath;
  IWBSExecuteAsyncJScript(JsRedirect(href),True);
end;

procedure TIWForm2.IWBSButton99CustomRestEvents0RestEvent(
  aApplication: TIWApplication; aRequest: THttpRequest; aReply: THttpReply;
  aParams: TStrings);
begin
  aReply.Headers.Values['Content-Disposition'] := Format('attachment; filename="%s";', ['ThisIsYourFile.exe']);
  aReply.SendFile(ParamStr(0), True, False);
end;

procedure TIWForm2.IWBSDropDown2DropDownItems0AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  with TFFishFact.Create(WebApplication) do begin
    IWBSRegion1.BSRegionType := Self.IWBSRegion3.BSRegionType;
    IWBSInputForm1.BSFormType := Self.IWBSInputForm2.BSFormType;
    Show;
  end;
end;

procedure TIWForm2.AsyncClickBootstrapTable(
  Sender: TObject; EventParams: TStringList);
begin
  with TFBootstrapTable.Create(WebApplication) do begin
    IWBSRegion1.BSRegionType := Self.IWBSRegion3.BSRegionType;
    Show;
  end;
end;

procedure TIWForm2.AsyncClickJQGrid(
  Sender: TObject; EventParams: TStringList);
begin
  with TFJQGrid.Create(WebApplication) do begin
    IWBSRegion1.BSRegionType := Self.IWBSRegion3.BSRegionType;
    Show;
  end;
end;

procedure TIWForm2.AsyncClickBootstrapFileInput(
  Sender: TObject; EventParams: TStringList);
begin
  with TFBootstrapFileInput.Create(WebApplication) do begin
    IWBSRegion1.BSRegionType := Self.IWBSRegion3.BSRegionType;
    IWBSInputForm1.BSFormType := Self.IWBSInputForm2.BSFormType;
    Show;
  end;
end;

procedure TIWForm2.IWBSInputForm5Submit(aRequest: THttpRequest;
  aParams: TStrings);
var
  AStream: TStringStream;
  i: integer;
begin
  // I manually set this page because this submit doen't set it
  IWTabControl21.ActivePage := IWTabControl21.Pages.IndexOf(IWTabControl21Page6);

  // get file s
  for i := 0 to aRequest.Files.Count-1 do begin
    AStream := TStringStream.Create;
    try
      THttpFile(aRequest.Files[i]).SaveToStream(AStream);
      IWBSText2.Lines.Add('File: '+THttpFile(aRequest.Files[i]).FileName);
      IWBSText2.Lines.Add(AStream.DataString);
    finally
      AStream.Free;
    end;
  end;
end;

procedure TIWForm2.IWBSText6CustomAsyncEvents0AsyncEvent(Sender: TObject;
  EventParams: TStringList);
begin
  TIWBSAlert.Create('You pressed a link');
end;

initialization
  TIWForm2.SetAsMainForm;

end.
