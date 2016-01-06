unit IWBSImageUtils;

interface

uses Classes, Db;

function IWBSGetFieldBlobStream(ADataSet: TDataSet; AField: TBlobField): TStream;

implementation

{$region 'FieldBlobStream'}
// this comes from TBlobField.SaveToStreamPersist, is the only way to directly obtain a valid image without usen a TPicture
type
  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;

function IWBSGetFieldBlobStream(ADataSet: TDataSet; AField: TBlobField): TStream;
var
  Size: Longint;
  GraphicHeader: TGraphicHeader;
begin
  Result := ADataSet.CreateBlobStream(AField, bmRead);
  Size := Result.Size;
  if Size >= SizeOf(TGraphicHeader) then begin
    Result.Read(GraphicHeader, SizeOf(GraphicHeader));
    if (GraphicHeader.Count <> 1) or (GraphicHeader.HType <> $0100) or
      (GraphicHeader.Size <> Size - SizeOf(GraphicHeader)) then
      Result.Position := 0;
  end;
end;
{
function GetFieldBlobStream(ADataSet: TDataSet; AField: TBlobField): TStream;
var
  Size: Longint;
  Header: TBytes;
  GraphicHeader: TGraphicHeader;
begin
  Result := ADataSet.CreateBlobStream(AField, bmRead);
  Size := Result.Size;
  if Size >= SizeOf(TGraphicHeader) then begin
    SetLength(Header, SizeOf(TGraphicHeader));
    Result.Read(Header, 0, Length(Header));
    Move(Header[0], GraphicHeader, SizeOf(TGraphicHeader));
    if (GraphicHeader.Count <> 1) or (GraphicHeader.HType <> $0100) or
      (GraphicHeader.Size <> Size - SizeOf(GraphicHeader)) then
      Result.Position := 0;
  end;
end;
}
{$endregion}

end.
