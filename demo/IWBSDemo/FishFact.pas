unit FishFact;

interface

uses
  IWAppForm, Classes, Controls, 
  IWCompExtCtrls, IWDBExtCtrls, IWDBStdCtrls, IWDBGrids, IWCompGrids,
  IWCompEdit, IWCompLabel, IWControl, IWCompMemo, IWBaseControl, DBClient,
  DB, Forms, IWContainer, IWRegion, IWVCLBaseControl, IWVCLBaseContainer,
  IWBaseHTMLControl, IWHTMLContainer, IWHTML40Container, IWCompButton,
  IWBSRegion, IWBSInput, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWBSLayoutMgr, IWBSControls,
  Vcl.Graphics, IWCompCheckbox, IWCompListbox, IWCompText, IWHTMLControls,
  MidasLib, IWBSCustomInput, IWBSButton, IWBSCustomControl, IWBSImage;

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
    IWBSInput1: TIWBSInput;
    IWBSInput2: TIWBSInput;
    IWBSInput3: TIWBSInput;
    IWBSInput4: TIWBSInput;
    IWBSInput5: TIWBSInput;
    IWBSInput6: TIWBSInput;
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSRegion6: TIWBSRegion;
    IWBSImage1: TIWBSImage;
    IWBSMemo1: TIWBSMemo;
    ClientDataSet1FoundDate: TDateTimeField;
    IWBSInput7: TIWBSInput;
    ClientDataSet1Option: TStringField;
    ClientDataSet1Check: TStringField;
    IWBSRegion4: TIWBSRegion;
    IWBSLabel1: TIWBSLabel;
    IWBSRegion7: TIWBSRegion;
    IWBSRegion5: TIWBSRegion;
    btnEdit: TIWBSButton;
    btnPost: TIWBSButton;
    btnCancel: TIWBSButton;
    btnFirst: TIWBSButton;
    btnPrior: TIWBSButton;
    btnNext: TIWBSButton;
    btnLast: TIWBSButton;
    IWBSRadioGroup1: TIWBSRadioGroup;
    IWBSRegion8: TIWBSRegion;
    IWBSButton1: TIWBSButton;
    IWText1: TIWBSText;
    IWBSInput8: TIWBSInput;
    IWBSListbox1: TIWBSSelect;
    IWBSListbox2: TIWBSSelect;
    IWBSCheckBox1: TIWBSCheckBox;
    IWBSRegion9: TIWBSRegion;
    IWBSRadioButton1: TIWBSRadioButton;
    IWBSRadioButton2: TIWBSRadioButton;
    IWBSRadioButton3: TIWBSRadioButton;
    IWBSText1: TIWBSText;
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
    procedure IWBSButton1Click(Sender: TObject);
  public
  end;

implementation
{$R *.dfm}

uses ServerController;

procedure TFFishFact.IWFormModuleBaseCreate(Sender: TObject);
begin
  //ClientDataSet1.LoadFromFile('biolife2.cds');
  ExtraHeader.Add('<link href="'+IWServerController.URLBase+'/iwbsdemo.css" rel="stylesheet">');
end;

procedure TFFishFact.IWAppFormDestroy(Sender: TObject);
begin
  //ClientDataSet1.Close;
end;

procedure TFFishFact.IWBSButton1Click(Sender: TObject);
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
