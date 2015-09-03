unit IWBSRegister;

interface

uses System.Classes, DesignEditors, IWDsnPaintHandlers;

type
  TGlyphiconEditor = class(TEnumProperty)
  public
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TIWBSPaintHandlerBSRegion = class (TIWPaintHandlerRegion)
  public
    procedure Paint; override;
  end;

procedure Register;

implementation

uses DesignIntf, Winapi.Windows, Vcl.Graphics,
     IWBaseControl,
     IWBSLayoutMgr, IWBSRegion, IWBSControls, IWBSInput, IWBSTabControl;

function TGlyphiconEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

procedure TGlyphiconEditor.GetValues(Proc: TGetStrProc);
var
  rs: TResourceStream;
  sl: TStringList;
  i: integer;
begin
  try
    sl := TStringList.Create;
    rs := TResourceStream.Create(hinstance, 'GlyphiconListNames', RT_RCDATA); // from https://gist.github.com/cdevroe/fb674eb895bd4b2f56d9
    try
      sl.LoadFromStream(rs);
      for i := 0 to sl.Count-1 do
        Proc(sl[i]);
    finally
      sl.Free;
      rs.Free;
    end;
  except

  end;
end;

procedure TGlyphiconEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

procedure TIWBSPaintHandlerBSRegion.Paint;
var
  LRect : TRect;
  s: string;
  w: integer;
begin
  inherited;
  if Control is TIWBSCustomRegion then begin
    ControlCanvas.Font.Name := 'Courier New';
    ControlCanvas.Font.Color := clGray;
    s := TIWBSCustomRegion(Control).GetClassString;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth-w-10, 2, Control.Width, 20);
    ControlCanvas.TextRect(LRect,s,[]);
  end;
end;

procedure Register;
begin
  RegisterComponents('IW BootsTrap', [TIWBSLayoutMgr]);

  RegisterComponents('IW BootsTrap', [TIWBSRegion]);
  RegisterComponents('IW BootsTrap', [TIWBSInputGroup]);
  RegisterComponents('IW BootsTrap', [TIWBSModal]);
  UnlistPublishedProperty(TIWBSCustomRegion, 'OnAlignInsertBefore');
  UnlistPublishedProperty(TIWBSCustomRegion, 'OnAlignPosition');

  RegisterComponents('IW BootsTrap', [TIWBSInput]);
  UnlistPublishedProperty(TIWBSInput, 'Alignment');
  UnlistPublishedProperty(TIWBSInput, 'Editable');
  UnlistPublishedProperty(TIWBSInput, 'NonEditableAsLabel');

  RegisterComponents('IW BootsTrap', [TIWBSMemo]);
  UnlistPublishedProperty(TIWBSMemo, 'Editable');

  RegisterComponents('IW BootsTrap', [TIWBSCheckBox]);
  UnlistPublishedProperty(TIWBSCheckBox, 'Editable');

  RegisterComponents('IW BootsTrap', [TIWBSRadioButton]);

  RegisterComponents('IW BootsTrap', [TIWBSListBox]);

  RegisterComponents('IW BootsTrap', [TIWBSComboBox]);

  RegisterComponents('IW BootsTrap', [TIWBSButton]);
  RegisterPropertyEditor(TypeInfo(string), TIWBSButton,'BSGlyphicon', TGlyphiconEditor);

  RegisterComponents('IW BootsTrap', [TIWBSLabel]);

  RegisterComponents('IW BootsTrap', [TIWBSGlyphicon]);
  RegisterPropertyEditor(TypeInfo(string), TIWBSGlyphicon,'BSGlyphicon', TGlyphiconEditor);

  RegisterComponents('IW BootsTrap', [TIWBSTabControl]);
  UnlistPublishedProperty(TIWBSTabControl, 'ActiveTabFont');
  UnlistPublishedProperty(TIWBSTabControl, 'InactiveTabFont');
  UnlistPublishedProperty(TIWBSTabControl, 'ActiveTabColor');
  UnlistPublishedProperty(TIWBSTabControl, 'InactiveTabColor');
end;

initialization
  IWRegisterPaintHandler('TIWBSRegion',TIWBSPaintHandlerBSRegion);
  IWRegisterPaintHandler('TIWBSInputGroup',TIWBSPaintHandlerBSRegion);
  IWRegisterPaintHandler('TIWBSModal',TIWBSPaintHandlerBSRegion);

  IWRegisterPaintHandler('TIWBSInput',TIWPaintHandlerEdit);
  IWRegisterPaintHandler('TIWBSMemo',TIWPaintHandlerMemo);
  IWRegisterPaintHandler('TIWBSCheckBox',TIWPaintHandlerCheckBox);
  IWRegisterPaintHandler('TIWBSRadioButton',TIWPaintHandlerRadioButton);
  IWRegisterPaintHandler('TIWBSListBox',TIWPaintHandlerListBox);
  IWRegisterPaintHandler('TIWBSComboBox',TIWPaintHandlerComboBox);

  IWRegisterPaintHandler('TIWBSButton',TIWPaintHandlerButton);

  IWRegisterPaintHandler('TIWBSLabel',TIWPaintHandlerLabel);

  IWRegisterPaintHandler('TIWBSTabControl',TIWPaintHandlerTabControl);

finalization
  IWUnRegisterPaintHandler('TIWBSRegion');
  IWUnRegisterPaintHandler('TIWBSInputGroup');
  IWUnRegisterPaintHandler('TIWBSModal');

  IWUnRegisterPaintHandler('TIWBSInput');
  IWUnRegisterPaintHandler('TIWBSMemo');
  IWUnRegisterPaintHandler('TIWBSCheckBox');
  IWUnRegisterPaintHandler('TIWBSRadioButton');
  IWUnRegisterPaintHandler('TIWBSListBox');
  IWUnRegisterPaintHandler('TIWBSComboBox');

  IWUnRegisterPaintHandler('TIWBSButton');

  IWUnRegisterPaintHandler('TIWBSLabel');

  IWUnRegisterPaintHandler('TIWBSTabControl');

end.
