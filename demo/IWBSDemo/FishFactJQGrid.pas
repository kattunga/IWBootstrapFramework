unit FishFactJQGrid;

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
  IW.HTTP.Request, IW.HTTP.Reply, IWApplication;

type
  TFJQGrid = class(TIWAppForm)
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
    IWBSRegion2: TIWBSRegion;
    IWBSRegion3: TIWBSRegion;
    IWBSLayoutMgr1: TIWBSLayoutMgr;
    ClientDataSet1FoundDate: TDateTimeField;
    ClientDataSet1Option: TStringField;
    ClientDataSet1Check: TStringField;
    DbTable: TIWBSCustomComponent;
    IWText1: TIWBSText;
    IWBSRegion8: TIWBSNavBar;
    IWBSButton1: TIWBSButton;
    IWBSRegion4: TIWBSRegion;
    procedure IWFormModuleBaseCreate(Sender: TObject);
    procedure DbTableCustomAjaxEvents0AsyncEvent(aParams: TStringList);
    procedure DbTableCustomRestEvents0RestEvent(aApplication: TIWApplication;
      aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings);
    procedure IWBSButton1AsyncClick(Sender: TObject; EventParams: TStringList);
  end;

implementation
{$R *.dfm}

uses IWBSRestServer, IW.Common.Strings, IWBSDialogs;

var
  fs: TFormatSettings;

procedure TFJQGrid.IWFormModuleBaseCreate(Sender: TObject);
var
  columns: string;
  options: TStringList;
  i: integer;
begin
  //ClientDataSet1.LoadFromFile('biolife2.cds');

  // include third party grid https://github.com/wenzhixin/bootstrap-table
  IWBSLayoutMgr1.AddLinkFile('https://cdn.rawgit.com/tonytomov/jqGrid/v5.0.1/js/jquery.jqGrid.js');
  IWBSLayoutMgr1.AddLinkFile('https://cdn.rawgit.com/tonytomov/jqGrid/v5.0.1/css/ui.jqgrid-bootstrap.css');

  // configure grid options
  // it's better to use any json object to do this, but for this demo I'll do it by hand
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
    options.Values['mobileResponsive'] := 'true';
    options.Values['paginationVAlign'] := '"top"';

    DbTable.ScriptParams.Values['options'] := '{'+options.DelimitedText+'}';
  finally
    options.Free;
  end;
end;

procedure TFJQGrid.DbTableCustomAjaxEvents0AsyncEvent(
  aParams: TStringList);
begin
  TIWBSAlert.Create('You clicked field '+aParams.Values['field']+' row '+aParams.Values['row.field0']).Show;
end;

procedure TFJQGrid.DbTableCustomRestEvents0RestEvent(
  aApplication: TIWApplication; aRequest: THttpRequest; aReply: THttpReply;
  aParams: TStrings);
var
  data: string;
  line: string;
  bmrk: TBookmark;
  r, i, f, t: integer;
begin
  // here we return the data in json format
  // see format on: http://bootstrap-table.wenzhixin.net.cn/getting-started/#usage-via-javascript
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

procedure TFJQGrid.IWBSButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  Release;
end;

initialization
  fs := TFormatSettings.Create('en-US');

  // this enable the rest event server
  IWBSRegisterRestServerHandler;

end.
