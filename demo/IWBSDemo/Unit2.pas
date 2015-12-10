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
  IWBSCustomControl, IW.HTTP.Request, IW.HTTP.Reply, IWCompFileUploader,
  IWBSDropDown;

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
    IWBSRegion30: TIWBSRegion;
    IWBSRegion9: TIWBSRegion;
    IWBSRegion14: TIWBSRegion;
    IWBSRegion24: TIWBSRegion;
    IWBSRegion19: TIWBSRegion;
    IWBSRegion20: TIWBSRegion;
    IWBSRegion21: TIWBSRegion;
    IWBSRegion22: TIWBSRegion;
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
    IWBSButton37: TIWBSButton;
    IWBSRegion32: TIWBSRegion;
    IWBSRegion33: TIWBSRegion;
    IWBSInput25: TIWBSInput;
    IWText5: TIWBSText;
    IWText1: TIWBSText;
    IWText4: TIWBSText;
    IWText10: TIWBSText;
    IWText9: TIWBSText;
    IWText6: TIWBSText;
    IWText11: TIWBSText;
    IWText2: TIWBSText;
    IWBSRegion34: TIWBSRegion;
    IWBSModal1: TIWBSModal;
    IWBSButton40: TIWBSButton;
    IWBSRegion35: TIWBSRegion;
    IWBSText1: TIWBSText;
    IWBSButton39: TIWBSButton;
    IWBSButton38: TIWBSButton;
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
    IWBSUnorderedList1: TIWBSUnorderedList;
    IWBSButton41: TIWBSButton;
    IWBSRegion29: TIWBSRegion;
    IWBSLabel3: TIWBSLabel;
    IWBSInputForm5: TIWBSInputForm;
    IWBSButton45: TIWBSButton;
    IWBSText2: TIWBSText;
    IWBSButton46: TIWBSButton;
    IWBSInput26: TIWBSFile;
    IWBSInputGroup8: TIWBSInputGroup;
    IWBSInput27: TIWBSInput;
    IWBSDropDown1: TIWBSDropDown;
    IWBSDropDown2: TIWBSDropDown;
    IWBSButton36: TIWBSButton;
    IWBSRegion4: TIWBSRegion;
    IWBSRegion38: TIWBSRegion;
    IWBSRegion39: TIWBSRegion;
    IWBSRegion42: TIWBSRegion;
    IWBSText3: TIWBSText;
    IWBSRegion43: TIWBSRegion;
    IWBSRegion44: TIWBSRegion;
    IWBSRegion46: TIWBSRegion;
    IWBSText4: TIWBSText;
    IWBSRegion47: TIWBSRegion;
    IWBSRegion48: TIWBSRegion;
    IWBSRegion50: TIWBSRegion;
    IWBSText5: TIWBSText;
    IWBSLabel4: TIWBSLabel;
    IWBSButton43: TIWBSButton;
    IWBSButton44: TIWBSButton;
    IWBSButton47: TIWBSButton;
    IWBSLabel5: TIWBSLabel;
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
    procedure IWBSDropDown2DropDownItems1DropDownItems0AsyncClick(
      Sender: TObject; EventParams: TStringList);
    procedure IWBSDropDown2DropDownItems1DropDownItems1AsyncClick(
      Sender: TObject; EventParams: TStringList);
    procedure IWBSDropDown2DropDownItems1DropDownItems2AsyncClick(
      Sender: TObject; EventParams: TStringList);
    procedure IWBSButton46AsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

uses IWBSUtils, IWBSRegionCommon, IWBSDialogs, unit1, unit3, FishFact, FishFactBootstrapTable, FishFactJQGrid, BootstrapFileInput,
  ServerController, IW.HTTP.FileItem, IWURL;

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
  TIWBSDialog.Create('This is the header', 'This is the Body');
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
      procedure(EventParams: TStringList)
      begin
        IWBSInput23.Text := 'You pressed OK!';
      end).DataDismiss := bsbdModal;
  end;
end;

procedure TIWForm2.IWBSButton32AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  TIWBSAlert.Create('This is simple Alert');
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

procedure TIWForm2.IWBSDropDown2DropDownItems0AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  with TFFishFact.Create(WebApplication) do begin
    IWBSRegion1.BSRegionType := Self.IWBSRegion3.BSRegionType;
    IWBSInputForm1.BSFormType := Self.IWBSInputForm2.BSFormType;
    Show;
  end;
end;

procedure TIWForm2.IWBSDropDown2DropDownItems1DropDownItems0AsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  with TFBootstrapTable.Create(WebApplication) do begin
    IWBSRegion1.BSRegionType := Self.IWBSRegion3.BSRegionType;
    Show;
  end;
end;

procedure TIWForm2.IWBSDropDown2DropDownItems1DropDownItems1AsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  with TFJQGrid.Create(WebApplication) do begin
    IWBSRegion1.BSRegionType := Self.IWBSRegion3.BSRegionType;
    Show;
  end;
end;

procedure TIWForm2.IWBSDropDown2DropDownItems1DropDownItems2AsyncClick(
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

initialization
  TIWForm2.SetAsMainForm;

end.
