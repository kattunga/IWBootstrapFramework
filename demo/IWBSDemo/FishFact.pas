unit FishFact;

interface

uses
  IWAppForm, Classes, Controls, System.StrUtils, System.SysUtils, Math,
  IWCompExtCtrls, IWDBExtCtrls, IWDBStdCtrls, IWDBGrids, IWCompGrids,
  IWCompEdit, IWCompLabel, IWControl, IWCompMemo, IWBaseControl, DBClient,
  DB, Forms, IWContainer, IWRegion, IWVCLBaseControl, IWVCLBaseContainer,
  IWBaseHTMLControl, IWHTMLContainer, IWHTML40Container, IWCompButton,
  IWBSRegion, IWBSInput, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWBSLayoutMgr, IWBSControls,
  Vcl.Graphics, IWCompCheckbox, IWCompListbox, IWCompText, IWHTMLControls,
  MidasLib, IWBSCustomInput, IWBSButton, IWBSCustomControl, IWBSImage,
  IWCompTabControl, IWBSTabControl,
  IW.HTTP.Request, IW.HTTP.Reply, IWBSCustomComponent, Vcl.Imaging.jpeg;

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
    ClientDataSet1FoundDate: TDateTimeField;
    ClientDataSet1Option: TStringField;
    ClientDataSet1Check: TStringField;
    IWBSRegion8: TIWBSRegion;
    IWBSButton1: TIWBSButton;
    IWText1: TIWBSText;
    IWBSRegion6: TIWBSRegion;
    IWBSImage1: TIWBSImage;
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
    IWBSInput8: TIWBSInput;
    IWBSInput1: TIWBSInput;
    IWBSInput2: TIWBSInput;
    IWBSInput3: TIWBSInput;
    IWBSInput4: TIWBSInput;
    IWBSInput5: TIWBSInput;
    IWBSInput6: TIWBSInput;
    IWBSInput7: TIWBSInput;
    IWBSListbox2: TIWBSSelect;
    IWBSListbox1: TIWBSSelect;
    IWBSCheckBox1: TIWBSCheckBox;
    IWBSMemo1: TIWBSMemo;
    IWBSRadioGroup1: TIWBSRadioGroup;
    IWBSRegion9: TIWBSRegion;
    IWBSRadioButton1: TIWBSRadioButton;
    IWBSRadioButton2: TIWBSRadioButton;
    IWBSRadioButton3: TIWBSRadioButton;
    IWBSText1: TIWBSText;
    procedure IWFormModuleBaseCreate(Sender: TObject);
    procedure btnEditAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnPostAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnCancelAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnFirstAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnPriorAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnNextAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnLastAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dsrcMainStateChange(Sender: TObject);
    procedure IWBSButton1Click(Sender: TObject);
  end;

implementation

{$R *.dfm}

uses IWTypes;

procedure TFFishFact.IWFormModuleBaseCreate(Sender: TObject);
begin
  //ClientDataSet1.LoadFromFile('biolife2.cds');
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

end.
