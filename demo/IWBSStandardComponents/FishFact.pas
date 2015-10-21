unit FishFact;

interface

uses
  IWAppForm, Classes, Controls, 
  IWCompExtCtrls, IWDBExtCtrls, IWDBStdCtrls, IWDBGrids, IWCompGrids,
  IWCompEdit, IWCompLabel, IWControl, IWCompMemo, IWBaseControl, DBClient,
  DB, Forms, IWContainer, IWRegion, IWVCLBaseControl, IWVCLBaseContainer,
  IWBaseHTMLControl, IWHTMLContainer, IWHTML40Container, IWCompButton,
  IWBSRegion, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWBSLayoutMgr,
  Vcl.Graphics, IWCompCheckbox, IWCompListbox, IWCompText, IWHTMLControls,
  MidasLib, IWBSCustomControl, IWBSControls, IWBSButton;

type
  TFFishFact = class(TIWAppForm)
    dsrcMain: TDataSource;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1SpeciesNo: TFloatField;
    ClientDataSet1Notes: TMemoField;
    ClientDataSet1Length_In: TFloatField;
    ClientDataSet1Lengthcm: TFloatField;
    ClientDataSet1SpeciesName: TStringField;
    ClientDataSet1Common_Name: TStringField;
    ClientDataSet1Category: TStringField;
    ClientDataSet1Graphic: TGraphicField;
    IWBSRegion1: TIWBSRegion;
    IWBSInputForm1: TIWBSInputForm;
    IWBSRegion2: TIWBSRegion;
    IWBSRegion3: TIWBSRegion;
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSRegion6: TIWBSRegion;
    ClientDataSet1FoundDate: TDateTimeField;
    ClientDataSet1Option: TStringField;
    ClientDataSet1Check: TStringField;
    IWBSRegion4: TIWBSRegion;
    IWBSRegion7: TIWBSRegion;
    IWBSRegion5: TIWBSRegion;
    btnEdit: TIWBSButton;
    btnPost: TIWBSButton;
    btnCancel: TIWBSButton;
    btnFirst: TIWBSButton;
    btnPrior: TIWBSButton;
    btnNext: TIWBSButton;
    btnLast: TIWBSButton;
    IWBSRegion8: TIWBSRegion;
    IWImage1: TIWDBImage;
    IWBSLabel1: TIWDBLabel;
    IWBSFormControl1: TIWBSFormControl;
    IWBSInput8: TIWDBEdit;
    IWBSFormControl2: TIWBSFormControl;
    IWBSFormControl3: TIWBSFormControl;
    IWBSFormControl4: TIWBSFormControl;
    IWBSFormControl5: TIWBSFormControl;
    IWBSFormControl6: TIWBSFormControl;
    IWBSFormControl7: TIWBSFormControl;
    IWBSFormControl8: TIWBSFormControl;
    IWBSFormControl9: TIWBSFormControl;
    IWBSInput1: TIWDBEdit;
    IWBSInput2: TIWDBEdit;
    IWBSInput3: TIWDBEdit;
    IWBSInput4: TIWDBEdit;
    IWBSInput5: TIWDBEdit;
    IWBSInput6: TIWDBEdit;
    IWBSInput7: TIWDBEdit;
    IWBDBComboBox: TIWDBComboBox;
    IWBSFormControl10: TIWBSFormControl;
    IWDBListbox1: TIWDBListbox;
    IWBSFormControl11: TIWBSFormControl;
    IWDBCheckBox1: TIWDBCheckBox;
    IWBSFormControl12: TIWBSFormControl;
    IWDBMemo1: TIWDBMemo;
    IWBSFormControl13: TIWBSFormControl;
    IWDBRadioGroup1: TIWDBRadioGroup;
    IWButton1: TIWButton;
    IWText1: TIWText;
    procedure IWFormModuleBaseCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnEditAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnPostAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnCancelAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnFirstAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnPriorAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnNextAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnLastAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dsrcMainStateChange(Sender: TObject);
    procedure IWButton1Click(Sender: TObject);
  public
  end;

implementation
{$R *.dfm}

uses ServerController;

procedure TFFishFact.IWFormModuleBaseCreate(Sender: TObject);
begin
  //ClientDataSet1.LoadFromFile('biolife2.cds');
end;

procedure TFFishFact.IWAppFormDestroy(Sender: TObject);
begin
  //ClientDataSet1.Close;
end;

procedure TFFishFact.IWButton1Click(Sender: TObject);
begin
  Release;
end;

procedure TFFishFact.btnEditAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.Edit;
end;

procedure TFFishFact.btnPostAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.Post;
end;

procedure TFFishFact.btnCancelAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.Cancel;
end;

procedure TFFishFact.btnFirstAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.First;
end;

procedure TFFishFact.btnPriorAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.Prior;
end;

procedure TFFishFact.dsrcMainStateChange(Sender: TObject);
begin
  btnPost.Enabled := ClientDataSet1.State in dsEditModes;
  btnCancel.Enabled := btnPost.Enabled;
  btnEdit.Enabled := not btnPost.Enabled;

  btnPrior.Enabled := btnEdit.Enabled;
  btnFirst.Enabled := btnEdit.Enabled;
  btnNext.Enabled := btnEdit.Enabled;
  btnLast.Enabled := btnEdit.Enabled;
end;

procedure TFFishFact.btnNextAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.Next;
end;

procedure TFFishFact.btnLastAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.Last;
end;

initialization
  TFFishFact.SetAsMainForm;

end.
