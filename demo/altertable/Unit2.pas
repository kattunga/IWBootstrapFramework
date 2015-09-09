unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Datasnap.DBClient,
  Vcl.Grids, Vcl.DBGrids;

type
  TForm2 = class(TForm)
    ClientDataSet1: TClientDataSet;
    ClientDataSet2: TClientDataSet;
    Button2: TButton;
    ClientDataSet1SpeciesNo: TFloatField;
    ClientDataSet1Notes: TMemoField;
    ClientDataSet1Length_In: TFloatField;
    ClientDataSet1Lengthcm: TFloatField;
    ClientDataSet1SpeciesName: TStringField;
    ClientDataSet1Common_Name: TStringField;
    ClientDataSet1Category: TStringField;
    ClientDataSet1Graphic: TGraphicField;
    ClientDataSet2SpeciesNo: TFloatField;
    ClientDataSet2Notes: TMemoField;
    ClientDataSet2Length_In: TFloatField;
    ClientDataSet2Lengthcm: TFloatField;
    ClientDataSet2SpeciesName: TStringField;
    ClientDataSet2Common_Name: TStringField;
    ClientDataSet2Category: TStringField;
    ClientDataSet2Graphic: TGraphicField;
    ClientDataSet2FoundDate: TDateTimeField;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ClientDataSet2Option: TStringField;
    ClientDataSet2Check: TStringField;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
  while not ClientDataSet1.Eof do begin
    ClientDataSet2.Append;
    ClientDataSet2.CopyFields(ClientDataSet1);
    ClientDataSet2FoundDate.Value := now;
    ClientDataSet2Option.Value := '1';
    ClientDataSet2Check.Value := 'Y';
    ClientDataSet2.Post;
    ClientDataSet1.Next;
  end;
  ClientDataSet2.SaveToFile('biolife2.cds');
end;

end.
