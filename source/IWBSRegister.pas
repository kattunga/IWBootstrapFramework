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

  TIWBSPaintHandlerCustomInput = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerButton = class (TIWPaintHandlerButton)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerGlyphicon = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerRadioGroup = class (TIWPaintHandlerRegion)
  public
    procedure Paint; override;
  end;

procedure Register;

implementation

uses DesignIntf, Winapi.Windows, Vcl.Forms, Vcl.Dialogs, Vcl.Graphics,
     IWBaseControl,
     IWBSLayoutMgr, IWBSControls, IWBSCustomInput,
     IWBSRegion, IWBSInput, IWBSButton, IWBSTabControl, IWBSCommon;

const
  CNST_DEFAULTFONTNAME = 'Tahoma';
  CNST_GLYPHICONSFONT = 'GLYPHICONS Halflings';
  CNST_PROPORTIONALFONT = 'Courier New';

var
  slGlyphicons: TStringList;
  lFontAdvice: boolean = True;

// advice to install glyphicon font
procedure GlyphiconsFontAdvice;
begin
  if lFontAdvice then begin
    lFontAdvice := False;
    if Screen.Fonts.IndexOf(CNST_GLYPHICONSFONT) = 0 then
      ShowMessage('Please install "demo\bin\wwwroot\iwbs\bootstrap-3.3.5\fonts\glyphicons-halflings-regular.ttf" to render glyphicons at design time');
  end;
end;

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
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Color := clGray;
    s := TIWBSCustomRegion(Control).GetClassString;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth-w-10, 2, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect,s,[]);
  end;
end;

procedure TIWBSPaintHandlerCustomInput.Paint;
var
  LRect, LCaret: TRect;
  s, c: string;
  LMultiLine: boolean;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);

  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
  ControlCanvas.Font.Size := 10;
  ControlCanvas.Font.Color := clBlack;
  ControlCanvas.Rectangle(LRect);

  Inc(LRect.Top, 2);
  Inc(LRect.Left, 2);
  Dec(LRect.Bottom, 2);
  Dec(LRect.Right, 2);
  ControlCanvas.Pen.Color := clLtGray;
  ControlCanvas.Rectangle(LRect);

  if Control is TIWBSCustomInput then begin
    LMultiLine := False;

    s := TIWBSCustomInput(Control).DataField;
    if Control is TIWBSCustomTextInput then
      begin
        if s = '' then
          s := TIWBSInput(Control).Text;
        if s = '' then begin
          s := TIWBSInput(Control).PlaceHolder;
          ControlCanvas.Font.Color := clLtGray;
        end;
        if Control is TIWBSMemo then
          LMultiLine := True;
      end
    else if Control is TIWBSSelect then
      begin
        LMultiLine := TIWBSSelect(Control).Size <> 1;
        if s = '' then
          if LMultiLine then
            s := TIWBSSelect(Control).Items.Text
          else if TIWBSSelect(Control).Items.Count > 0 then
            s := TIWBSSelect(Control).Items[0];
        if not LMultiLine then begin
          LCaret := Rect(LRect.Right-18,LRect.Top+1,LRect.Right-1,LRect.Bottom-1);
          ControlCanvas.Font.Name := CNST_GLYPHICONSFONT;
          ControlCanvas.Brush.Color := clLtGray;
          ControlCanvas.Rectangle(LCaret);
          c := Char(StrToInt(slGlyphicons.Values['chevron-down']));
          DrawTextEx(ControlCanvas.Handle, PChar(c), 1, LCaret, DT_CENTER+DT_SINGLELINE+DT_VCENTER, nil);
          ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
          ControlCanvas.Brush.Color := clWhite;
          Dec(LRect.Right, 20);
        end;
      end;

    Inc(LRect.Top, 1);
    Inc(LRect.Left, 8);
    Dec(LRect.Bottom, 1);
    Dec(LRect.Right, 8);
    if LMultiLine then
      ControlCanvas.TextRect(LRect,s,[])
    else
      DrawTextEx(ControlCanvas.Handle, PChar(s), Length(s), LRect, DT_SINGLELINE+DT_VCENTER, nil);
  end;
end;

procedure TIWBSPaintHandlerButton.Paint;
var
  LRect : TRect;
  s: string;
  th: integer;
begin
  GlyphiconsFontAdvice;

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

    ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
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
      ControlCanvas.Font.Name := CNST_GLYPHICONSFONT;
      s := Char(StrToInt(slGlyphicons.Values[TIWBSButton(Control).BSGlyphicon]));
      ControlCanvas.TextRect(LRect, LRect.Left, (LRect.Height-th) div 2, s);
      Inc(LRect.Left, th);
    except
    end;

    s := TIWBSButton(Control).Caption;
    if (s = '') and (TIWBSButton(Control).BSButtonStyle = bsbsClose) then
      s := 'X';
    if s <> '' then begin
      ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
      ControlCanvas.TextRect(LRect, LRect.Left, (LRect.Height-th) div 2, s);
    end;
  end;
end;

procedure TIWBSPaintHandlerGlyphicon.Paint;
var
  LRect : TRect;
  s: string;
  th: integer;
begin
  GlyphiconsFontAdvice;

  if Control is TIWBSGlyphicon then begin
    LRect := Rect(0, 0, Control.Width, Control.Height);
    ControlCanvas.FillRect(LRect);

    if TIWBSGlyphicon(Control).BSGlyphicon <> '' then
    try
      ControlCanvas.Font.Name := CNST_GLYPHICONSFONT;
      ControlCanvas.Font.Style := [fsBold];
      ControlCanvas.Font.Height := -14;
      th := ControlCanvas.TextHeight('X');
      s := Char(StrToInt(slGlyphicons.Values[TIWBSGlyphicon(Control).BSGlyphicon]));
      ControlCanvas.TextRect(LRect, LRect.Left, (LRect.Height-th) div 2, s);
      Inc(LRect.Left, th);
    except
    end;
  end;
end;

procedure TIWBSPaintHandlerRadioGroup.Paint;
var
  LRect : TRect;
  s: string;
  w: integer;
begin
  if Control is TIWBSRadioGroup then begin
    LRect := Rect(0, 0, Control.Width, Control.Height);
    ControlCanvas.Brush.Color := clWhite;
    ControlCanvas.Pen.Color := clBlack;
    ControlCanvas.Rectangle(LRect);

    Inc(LRect.Top, 5);
    Inc(LRect.Left, 5);
    Dec(LRect.Right, 5);
    Dec(LRect.Bottom, 5);

    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Color := clGray;
    s := 'RadioGroup';
    w := ControlCanvas.TextWidth(s);
    ControlCanvas.TextRect(LRect,Control.ClientWidth-w-10, 5, s);

    ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
    ControlCanvas.Font.Color := clBlack;
    ControlCanvas.Font.Size := 10;
    s := TIWBSRadioGroup(Control).Items.Text;
    ControlCanvas.TextRect(LRect,s,[]);
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

  UnlistPublishedProperty(TIWBSCustomInput, 'SkinId');
  UnlistPublishedProperty(TIWBSCustomInput, 'StyleRenderOptions');

  RegisterComponents('IW BootsTrap', [TIWBSInput]);
  RegisterComponents('IW BootsTrap', [TIWBSMemo]);

  RegisterComponents('IW BootsTrap', [TIWBSSelect]);

  RegisterComponents('IW BootsTrap', [TIWBSCheckBox]);
  UnlistPublishedProperty(TIWBSCheckBox, 'Style');

  RegisterComponents('IW BootsTrap', [TIWBSRadioButton]);

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

  IWRegisterPaintHandler('TIWBSInput',TIWBSPaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBSMemo',TIWBSPaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBSCheckBox',TIWBSPaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBSRadioButton',TIWPaintHandlerRadioButton);
  IWRegisterPaintHandler('TIWBSSelect',TIWBSPaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBSRadioGroup',TIWBSPaintHandlerRadioGroup);

  IWRegisterPaintHandler('TIWBSButton',TIWBSPaintHandlerButton);

  IWRegisterPaintHandler('TIWBSLabel',TIWPaintHandlerLabel);

  IWRegisterPaintHandler('TIWBSGlyphicon',TIWBSPaintHandlerGlyphicon);

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
  IWUnRegisterPaintHandler('TIWBSSelect');
  IWUnRegisterPaintHandler('TIWBSRadioGroup');

  IWUnRegisterPaintHandler('TIWBSButton');

  IWUnRegisterPaintHandler('TIWBSLabel');

  IWUnRegisterPaintHandler('TIWBSGlyphicon');

  IWUnRegisterPaintHandler('TIWBSText');

  IWUnRegisterPaintHandler('TIWBSImage');

  IWUnRegisterPaintHandler('TIWBSTabControl');

end.
