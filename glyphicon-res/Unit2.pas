unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses System.StrUtils;

procedure TForm2.Button1Click(Sender: TObject);
var
  css, res: TStringList;
  i: integer;
  name, valu: string;
  intv: integer;
  sample: string;
  first: boolean;
begin
  sample := '';

  css := TStringList.Create;
  res := TStringList.Create;
  try
    res.Add('unit glyphicons;');
    res.Add('');
    res.Add('interface');
    res.Add('');
    res.Add('const');
    res.Add('  iwbsGlyphicons =');

    first := True;
    css.LoadFromFile('..\demo\bin\wwwroot\iwbs\bootstrap-3.3.5\css\bootstrap.css');
    for i := 0 to css.Count-1 do
      if AnsiStartsStr('.glyphicon-',css[i]) and AnsiContainsStr(css[i+1],'content:') then begin
        name := copy(css[i], 12, Pos(':', css[i])-12);
        valu := Copy(css[i+1], Pos('\', css[i+1])+1, MaxInt);
        valu := Copy(valu, 1, Pos('"', valu)-1);
        try
          intv := StrToInt('$'+valu);
          res.Add(IfThen(not First, '+#13#10')+#39+name+'='+IntToStr(intv)+#39);
          First := False;
          sample := sample + Char(intv);
        except
          ShowMessage('error in line '+IntToStr(i)+' '+name+' '+valu);
        end;
      end;

    res.Add(';');
    res.Add('');
    res.Add('implementation');
    res.Add('');
    res.Add('end.');
    res.SaveToFile('..\source\glyphicons.pas');
    Memo1.Text := sample;
  finally
    res.Free;
    css.Free;
  end;
end;

end.
