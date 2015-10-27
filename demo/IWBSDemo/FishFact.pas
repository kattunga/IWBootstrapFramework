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
  IW.HTTP.Request, IW.HTTP.Reply, IWBSCustomComponent;

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
    IWBSTabControl1: TIWBSTabControl;
    IWBSTabControl1Page0: TIWTabPage;
    IWBSTabControl1Page1: TIWTabPage;
    DbTable: TIWBSCustomComponent;
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
    procedure IWBSCustomComponent1CustomRestEvents0RestEvent(
      aRequest: THttpRequest; aReply: THttpReply);
  end;

implementation
{$R *.dfm}

uses IWBSRestServer, IW.Common.Strings, IWUtils;

var
  fs: TFormatSettings;

procedure TFFishFact.IWFormModuleBaseCreate(Sender: TObject);
var
  columns: string;
  options: TStringList;
  i: integer;
begin
  //ClientDataSet1.LoadFromFile('biolife2.cds');

  // include third party grid
  IWBSLayoutMgr1.AddLinkFile('//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/bootstrap-table.min.css');
  IWBSLayoutMgr1.AddLinkFile('//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/bootstrap-table.min.js');
  IWBSLayoutMgr1.AddLinkFile('//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/locale/bootstrap-table-es-AR.min.js');

  // configure grid options
  // it's better to use any json object to do this
  // but for this demo I'll do it by hand
  columns := '[';
  for i := 0 to ClientDataSet1.FieldCount-1 do begin
    if i > 0 then
      columns := columns+',';
    columns := columns+'{"field":'+'"field'+IntToStr(i)+'","title":"'+ClientDataSet1.Fields[i].DisplayLabel+'"}';
  end;
  columns := columns+']';

  options := TStringList.Create;
  try
    options.NameValueSeparator := ':';
    options.Delimiter := ',';
    options.QuoteChar := ' ';
    options.StrictDelimiter := True;

    options.Values['url'] := '"%dataurl%"';
    options.Values['columns'] := columns;
    options.Values['pagination'] := 'true';
    options.Values['sidePagination'] := '"server"';

    DbTable.ScriptParams.Values['options'] := '{'+options.DelimitedText+'}';
  finally
    options.Free;
  end;
end;

procedure TFFishFact.IWBSButton1Click(Sender: TObject);
begin
  Release;
end;

procedure TFFishFact.IWBSCustomComponent1CustomRestEvents0RestEvent(
  aRequest: THttpRequest; aReply: THttpReply);
var
  data: string;
  line: string;
  bmrk: TBookmark;
  r, i, f, t: integer;
begin
  f := StrToIntDef(aRequest.QueryFields.Values['offset'],0);
  t := Min(f+StrToIntDef(aRequest.QueryFields.Values['limit'],10), ClientDataSet1.RecordCount);

  ClientDataSet1.DisableControls;
  bmrk := ClientDataSet1.Bookmark;
  try
    data := '';
    for r := f+1 to t do begin
      ClientDataSet1.RecNo := r;

      line := '';
      for i := 0 to ClientDataSet1.FieldCount-1 do begin
        if i > 0 then
          line := line+',';
        if ClientDataSet1.Fields[i] is TNumericField then
          line := line+'"field'+IntToStr(i)+'":'+FloatToStr(ClientDataSet1.Fields[i].AsFloat,fs)
        else if (ClientDataSet1.Fields[i] is TStringField) or (ClientDataSet1.Fields[i] is TMemoField) then
          line := line+'"field'+IntToStr(i)+'":"'+EscapeJsonString(ClientDataSet1.Fields[i].AsString)+'"'
        else
          line := line+'"field'+IntToStr(i)+'":""';

      end;
      if data <> '' then
        data := data+',';
      data := data+'{'+line+'}';
    end;
    aReply.WriteString('{"total": '+IntToStr(ClientDataSet1.RecordCount)+', "rows": ['+data+']}');
  finally
    ClientDataSet1.GotoBookmark(bmrk);
    ClientDataSet1.EnableControls;
  end;
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

  fs := TFormatSettings.Create('en-US');

  // this enable the rest event server
  IWBSRegisterRestServerHandler;

end.
