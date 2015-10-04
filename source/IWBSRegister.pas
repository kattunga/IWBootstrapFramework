unit IWBSRegister;

interface

uses System.Classes, System.SysUtils, DesignEditors, IWDsnPaintHandlers;

type
  TGlyphiconEditor = class(TEnumProperty)
  public
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TIWBSPaintHandlerRegion = class (TIWPaintHandlerRegion)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerMemo = class (TIWPaintHandlerMemo)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerButton = class (TIWPaintHandlerButton)
  public
    procedure Paint; override;
  end;

procedure Register;

implementation

uses DesignIntf, Winapi.Windows, Vcl.Graphics,
     IWBaseControl,
     IWBSLayoutMgr, IWBSRegion, IWBSControls, IWBSInput, IWBSTabControl, IWBSCommon;

var
  slGlyphicons: TStringList;

procedure LoadGlyphicons;
var
  rs: TResourceStream;
begin
  try
    rs := TResourceStream.Create(hinstance, 'GlyphiconListNames', RT_RCDATA); // from https://gist.github.com/cdevroe/fb674eb895bd4b2f56d9
    slGlyphicons.LoadFromStream(rs);
  except
  end;
end;

function TGlyphiconEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

procedure TGlyphiconEditor.GetValues(Proc: TGetStrProc);
var
  i: integer;
begin
  for i := 0 to slGlyphicons.Count-1 do
    Proc(slGlyphicons.Names[i]);
end;

procedure TGlyphiconEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

procedure TIWBSPaintHandlerRegion.Paint;
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
    LRect := Rect(Control.ClientWidth-w-10, 2, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect,s,[]);
  end;
end;

procedure TIWBSPaintHandlerMemo.Paint;
var
  LRect : TRect;
  s: string;
begin
  inherited;
  if Control is TIWBSMemo then begin
    ControlCanvas.Brush.Color := clWhite;
    s := TIWBSMemo(Control).DataField;
    LRect := Rect(5, 5, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect,s,[]);
  end;
end;

procedure TIWBSPaintHandlerButton.Paint;
var
  LRect : TRect;
  s: string;
  th: integer;
begin
  inherited;
  if Control is TIWBSButton then begin
    LRect := Rect(0, 0, Control.Width, Control.Height);
    case TIWBSButton(Control).BSButtonStyle of
      bsbsDefault:
        begin
          ControlCanvas.Brush.Color := clWhite;
          ControlCanvas.Pen.Color := clGray;
          ControlCanvas.Font.Color := clBlack;
        end;
      bsbsPrimary:
        begin
          ControlCanvas.Brush.Color := clWebBlue;
          ControlCanvas.Pen.Color := clWebBlue;
          ControlCanvas.Font.Color := clWhite;
        end;
      bsbsSuccess:
        begin
          ControlCanvas.Brush.Color := clWebLimeGreen;
          ControlCanvas.Pen.Color := clWebLimeGreen;
          ControlCanvas.Font.Color := clWhite;
        end;
      bsbsInfo:
        begin
          ControlCanvas.Brush.Color := clWebSkyBlue;
          ControlCanvas.Pen.Color := clWebSkyBlue;
          ControlCanvas.Font.Color := clWhite;
        end;
      bsbsWarning:
        begin
          ControlCanvas.Brush.Color := clWebGoldenRod;
          ControlCanvas.Pen.Color := clWebGoldenRod;
          ControlCanvas.Font.Color := clWhite;
        end;
      bsbsDanger:
        begin
          ControlCanvas.Brush.Color := clWebFirebrick;
          ControlCanvas.Pen.Color := clWebFirebrick;
          ControlCanvas.Font.Color := clWhite;
        end;
      bsbsLink:
        begin
          ControlCanvas.Brush.Color := clWhite;
          ControlCanvas.Pen.Color := clWhite;
          ControlCanvas.Font.Color := clWebBlue;
        end;
      bsbsClose:
        begin
          ControlCanvas.Brush.Color := clWhite;
          ControlCanvas.Pen.Color := clWhite;
          ControlCanvas.Font.Color := clGray;
        end;
    end;
    ControlCanvas.Rectangle(LRect);

    Inc(LRect.Top);
    Inc(LRect.Left, 10);
    Dec(LRect.Bottom);
    Dec(LRect.Right, 10);

    ControlCanvas.Font.Name := 'Tahoma';
    ControlCanvas.Font.Style := [fsBold];
    case TIWBSButton(Control).BSButtonSize of
      bsszLg: ControlCanvas.Font.Height := -18;
      bsszMd, bsszDefault: ControlCanvas.Font.Height := -14;
      bsszSm: ControlCanvas.Font.Height := -12;
      bsszXs: ControlCanvas.Font.Height := -10;
    end;

    th := ControlCanvas.TextHeight('X');

    if TIWBSButton(Control).BSGlyphicon <> '' then
    try
      ControlCanvas.Font.Name := 'GLYPHICONS Halflings';
      s := Char(StrToInt(slGlyphicons.Values[TIWBSButton(Control).BSGlyphicon]));
      ControlCanvas.TextRect(LRect, LRect.Left, (LRect.Height-th) div 2, s);
      Inc(LRect.Left, th);
    except
    end;

    s := TIWBSButton(Control).Caption;
    if s <> '' then begin
      ControlCanvas.Font.Name := 'Tahoma';
      ControlCanvas.TextRect(LRect, LRect.Left, (LRect.Height-th) div 2, s);
    end;
  end;
end;

procedure Register;
begin
  RegisterComponents('IW BootsTrap', [TIWBSLayoutMgr]);

  RegisterComponents('IW BootsTrap', [TIWBSRegion]);
  RegisterComponents('IW BootsTrap', [TIWBSInputForm]);
  RegisterComponents('IW BootsTrap', [TIWBSInputGroup]);
  RegisterComponents('IW BootsTrap', [TIWBSModal]);
  UnlistPublishedProperty(TIWBSCustomRegion, 'OnAlignInsertBefore');
  UnlistPublishedProperty(TIWBSCustomRegion, 'OnAlignPosition');

  RegisterComponents('IW BootsTrap', [TIWBSInput]);
  UnlistPublishedProperty(TIWBSInput, 'Alignment');
  UnlistPublishedProperty(TIWBSInput, 'NonEditableAsLabel');

  RegisterComponents('IW BootsTrap', [TIWBSMemo]);

  RegisterComponents('IW BootsTrap', [TIWBSCheckBox]);
  UnlistPublishedProperty(TIWBSCheckBox, 'Style');

  RegisterComponents('IW BootsTrap', [TIWBSRadioButton]);

  RegisterComponents('IW BootsTrap', [TIWBSListBox]);

  RegisterComponents('IW BootsTrap', [TIWBSComboBox]);

  RegisterComponents('IW BootsTrap', [TIWBSRadioGroup]);

  RegisterComponents('IW BootsTrap', [TIWBSButton]);
  RegisterPropertyEditor(TypeInfo(string), TIWBSButton,'BSGlyphicon', TGlyphiconEditor);

  RegisterComponents('IW BootsTrap', [TIWBSLabel]);

  RegisterComponents('IW BootsTrap', [TIWBSText]);

  RegisterComponents('IW BootsTrap', [TIWBSGlyphicon]);
  RegisterPropertyEditor(TypeInfo(string), TIWBSGlyphicon,'BSGlyphicon', TGlyphiconEditor);

  RegisterComponents('IW BootsTrap', [TIWBSImage]);

  RegisterComponents('IW BootsTrap', [TIWBSTabControl]);
  UnlistPublishedProperty(TIWBSTabControl, 'ActiveTabFont');
  UnlistPublishedProperty(TIWBSTabControl, 'InactiveTabFont');
  UnlistPublishedProperty(TIWBSTabControl, 'ActiveTabColor');
  UnlistPublishedProperty(TIWBSTabControl, 'InactiveTabColor');
end;

initialization
  slGlyphicons := TStringList.Create;
  LoadGlyphicons;

  IWRegisterPaintHandler('TIWBSRegion',TIWBSPaintHandlerRegion);
  IWRegisterPaintHandler('TIWBSInputForm',TIWBSPaintHandlerRegion);
  IWRegisterPaintHandler('TIWBSInputGroup',TIWBSPaintHandlerRegion);
  IWRegisterPaintHandler('TIWBSModal',TIWBSPaintHandlerRegion);

  IWRegisterPaintHandler('TIWBSInput',TIWPaintHandlerEdit);
  IWRegisterPaintHandler('TIWBSMemo',TIWBSPaintHandlerMemo);
  IWRegisterPaintHandler('TIWBSCheckBox',TIWPaintHandlerCheckBox);
  IWRegisterPaintHandler('TIWBSRadioButton',TIWPaintHandlerRadioButton);
  IWRegisterPaintHandler('TIWBSListBox',TIWPaintHandlerListBox);
  IWRegisterPaintHandler('TIWBSComboBox',TIWPaintHandlerComboBox);

  IWRegisterPaintHandler('TIWBSButton',TIWBSPaintHandlerButton);

  IWRegisterPaintHandler('TIWBSLabel',TIWPaintHandlerLabel);

  IWRegisterPaintHandler('TIWBSText',TIWPaintHandlerText);

  IWRegisterPaintHandler('TIWBSImage',TIWPaintHandlerImage);

  IWRegisterPaintHandler('TIWBSTabControl',TIWPaintHandlerTabControl);

finalization
  slGlyphicons.Free;

  IWUnRegisterPaintHandler('TIWBSRegion');
  IWUnRegisterPaintHandler('TIWBSInputForm');
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

  IWUnRegisterPaintHandler('TIWBSText');

  IWUnRegisterPaintHandler('TIWBSImage');

  IWUnRegisterPaintHandler('TIWBSTabControl');

end.
