unit Main;

interface

uses
  IWAppForm, Classes, Controls, 
  IWCompExtCtrls, IWDBExtCtrls, IWDBStdCtrls, IWDBGrids, IWCompGrids,
  IWCompEdit, IWCompLabel, IWControl, IWCompMemo, IWBaseControl, DBClient,
  DB, Forms, IWContainer, IWRegion, IWVCLBaseControl, IWVCLBaseContainer,
  IWBaseHTMLControl, IWHTMLContainer, IWHTML40Container, IWCompButton,
  IWBSRegion, IWBSInput, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWBSLayoutMgr;

type
  TformMain = class(TIWAppForm)
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
    dgrdFish: TIWDBGrid;
    IWLabelUpdate: TIWLabel;
    IWBSRegion1: TIWBSRegion;
    IWBSInputForm1: TIWBSInputForm;
    IWBSRegion2: TIWBSRegion;
    IWBSRegion3: TIWBSRegion;
    IWBSRegion4: TIWBSRegion;
    IWBSInput1: TIWBSInput;
    IWBSInput2: TIWBSInput;
    IWBSInput3: TIWBSInput;
    IWBSInput4: TIWBSInput;
    IWBSInput5: TIWBSInput;
    IWBSInput6: TIWBSInput;
    DBMemo1: TIWDBMemo;
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    IWBSRegion5: TIWBSRegion;
    IWBSButton1: TIWBSButton;
    IWBSButton2: TIWBSButton;
    IWBSButton3: TIWBSButton;
    IWBSRegion6: TIWBSRegion;
    IWDBImage1: TIWDBImage;
    IWBSButton4: TIWBSButton;
    IWBSButton5: TIWBSButton;
    IWBSButton6: TIWBSButton;
    IWBSButton7: TIWBSButton;
    IWDBNavigator1: TIWDBNavigator;
    IWButton1: TIWButton;
    procedure IWFormModuleBaseCreate(Sender: TObject);
    procedure dgrdFishRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure dgrdFishColumns0TitleClick(Sender: TObject);
    procedure dgrdFishColumns0Click(ASender: TObject;
      const AValue: String);
    procedure ButtonClick(Sender: TObject);
    procedure ButtonAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure EditAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton1AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton2AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton3AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton4AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton5AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton6AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBSButton7AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWButton1AsyncClick(Sender: TObject; EventParams: TStringList);
  protected
    procedure GoFish(const ASpeciesNo: integer);
  public
  end;

implementation
{$R *.dfm}

uses
  Graphics,
  SysUtils;

procedure TformMain.GoFish(const ASpeciesNo: integer);
begin
  ClientDataSet1.Locate('Species No', ASpeciesNo, []);
end;

procedure TformMain.IWFormModuleBaseCreate(Sender: TObject);
begin
  ClientDataSet1.LoadFromFile('biolife.cds');
end;

procedure TformMain.dgrdFishRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  // -1 is Footer Row
  if ARow = -1 then begin
    ACell.BGColor := clSilver;
    if AColumn = 0 then begin
      ACell.Font.Color := clRed;
      ACell.Text := IntToStr(dgrdFish.RecordCount) + ' fish found.';
    end;
  end else if dgrdFish.RowIsCurrent then begin
    ACell.BGColor := clYellow;
  end;
  if (AColumn = 4) and (ARow > 0) then begin
    ACell.Control := TIWDBImage.Create(Self);
    TIWDBImage(ACell.Control).DataSource := dsrcMain;
    TIWDBImage(ACell.Control).DataField := 'Graphic';
  end;
  if (AColumn = 3) and (ARow > 0) then begin
    ACell.Control := TIWButton.Create(Self);
    TIWButton(ACell.Control).Caption := ACell.Text;
    TIWButton(ACell.Control).OnClick := ButtonClick;
    TIWButton(ACell.Control).Width := 150;
    ACell.Text := '';
  end;
  if (AColumn = 2) and (ARow > 0) then begin
    ACell.Control := TIWButton.Create(Self);
    TIWButton(ACell.Control).Caption := ACell.Text;
    TIWButton(ACell.Control).OnAsyncClick := ButtonAsyncClick;
    TIWButton(ACell.Control).Width := 100;
    ACell.Text := '';
  end;
  if (AColumn = 1) and (ARow > 0) then begin
    ACell.Control := TIWEdit.Create(Self);
    TIWEdit(ACell.Control).Text := ACell.Text;
    TIWEdit(ACell.Control).OnAsyncChange := EditAsyncChange;
    TIWEdit(ACell.Control).Width := 100;
    ACell.Text := '';
  end;
end;

procedure TformMain.ButtonAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  WebApplication.ShowMessage(TIWButton(Sender).Caption);
end;

procedure TformMain.ButtonClick(Sender: TObject);
begin
  WebApplication.ShowMessage(TIWButton(Sender).Caption);
end;

procedure TformMain.EditAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  IWLabelUpdate.Text := TIWEdit(Sender).Text;
end;

procedure TformMain.IWAppFormDestroy(Sender: TObject);
begin
  ClientDataSet1.Close;
end;

procedure TformMain.IWBSButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.Edit;
end;

procedure TformMain.IWBSButton2AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.Post;
end;

procedure TformMain.IWBSButton3AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.Cancel;
end;

procedure TformMain.IWBSButton4AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.First;
end;

procedure TformMain.IWBSButton5AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.Prior;
end;

procedure TformMain.IWBSButton6AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.Next;
end;

procedure TformMain.IWBSButton7AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ClientDataSet1.Last;
end;

procedure TformMain.IWButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
//

end;

procedure TformMain.dgrdFishColumns0TitleClick(Sender: TObject);
var
  LSpeciesNo: integer;
begin
  LSpeciesNo := Trunc(ClientDataSet1SpeciesNo.Value);
  ClientDataSet1.Close; try
    ClientDataSet1.IndexFieldNames := TIWDBGridColumn(Sender).DataField;
  finally
    ClientDataSet1.LoadFromFile('biolife.cds');
  end;
  GoFish(LSpeciesNo);
end;


procedure TformMain.dgrdFishColumns0Click(ASender: TObject;
  const AValue: String);
begin
  GoFish(StrToInt(AValue));
end;

initialization
  TformMain.SetAsMainForm;

end.
