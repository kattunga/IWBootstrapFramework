unit IWBSMemoHtml;

interface

uses
  SysUtils, Classes, StrUtils,
  IWRenderContext, IWApplication, IWBSInput;

type
  TIWBSMemoHtml = class(TIWBSMemo)
  protected
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); override;
  end;

implementation

uses IWBSGlobal, IWBSUtils;

procedure TIWBSMemoHtml.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;
  IWBSExecuteAsyncJScript(AApplication,'$("#'+AHTMLName+'").summernote("'+IfThen(IsReadOnly or IsDisabled, 'disable', 'enable')+'");', False, True);
end;

procedure TIWBSMemoHtml.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
var
  s: string;
begin
  inherited;
  s := '$("#'+AHTMLName+'").summernote({ callbacks: { onChange: function(contents, $editable) { $("#'+AHTMLName+'").change(); } } })';
  if IsReadOnly or IsDisabled then
    s := s + '.summernote("disable")';
  s := s+';';
  AScript.Add(s);
end;

initialization
  gIWBSLibSummerNote := True;

end.
