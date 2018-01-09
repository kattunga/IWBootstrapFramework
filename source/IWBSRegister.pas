unit IWBSRegister;

interface

uses Classes, SysUtils, StrUtils, DesignEditors, DesignIntf, IWDsnPaintHandlers, StrEdit;

type
  TGlyphiconEditor = class(TEnumProperty)
  public
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TIWBSStringListProperty = class(TStringListProperty)
    function GetIsDefault: Boolean; override;
  end;

  TIWBSStringProperty = class(TStringListProperty)
  private
    FStrings: TStrings;
  protected
    function GetStrings: TStrings; override;
    procedure SetStrings(const Value: TStrings); override;
  public
    destructor Destroy; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  TIWBSPaintHandlerRegion = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerCustomInput = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerCustomCheck = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerCustomButton = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerFile = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerGlyphicon = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerRadioGroup = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerText = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerLabel = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBSPaintHandlerImage = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

procedure Register;

implementation

uses Windows, Forms, Dialogs, Graphics,
     glyphicons, IWBaseControl,
     IWBSLayoutMgr, IWBSControls, IWBSCustomInput,
     IWBSCustomRegion, IWBSRegion, IWBSInputForm, IWBSModal,
     IWBSInput, IWBSButton, IWBSDropDown, IWBSTabControl, IWBSNavBar, IWBSList, IWBSDeprecated,
     IWBSCommon, IWBSCustomControl, IWBSImage, IWBSMemoHTML, IWBSButtonGroup;

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
    if Screen.Fonts.IndexOf(CNST_GLYPHICONSFONT) = -1 then
      ShowMessage('Please install "demo\bin\wwwroot\iwbs\bootstrap-3.3.5\fonts\glyphicons-halflings-regular.ttf" to render glyphicons at design time');
  end;
end;

function GetGlyphiconChar(const AGlyphicon: string; const AFallBackTo: string = ''): string;
var
  i: integer;
begin
  if (AGlyphicon <> '') then
    i := StrToIntDef(slGlyphicons.Values[AGlyphicon], 0)
  else
    i := 0;
  if i = 0 then
    Result := AFallBackTo
  else
    Result := Char(i);
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

procedure DrawGlyphicon(ACanvas: TCanvas; var ARect: TRect; AGlyphicon, AFallBackTo: string; ARight: boolean = False);
var
  c: string;
begin
  ACanvas.Font.Name := CNST_GLYPHICONSFONT;
  if AGlyphicon <> '' then
    c := GetGlyphiconChar(AGlyphicon, AFallBackTo);
  if c <> '' then
    if ARight then
      begin
        DrawTextEx(ACanvas.Handle, PChar(c), Length(c), ARect, DT_SINGLELINE+DT_VCENTER+DT_RIGHT, nil);
        Dec(ARect.Right, ACanvas.TextWidth(c)+4);
      end
    else
      begin
        DrawTextEx(ACanvas.Handle, PChar(c), Length(c), ARect, DT_SINGLELINE+DT_VCENTER, nil);
        Inc(ARect.Left, ACanvas.TextWidth(c)+4);
      end;
end;

procedure DrawControlName(ACanvas: TCanvas; ARect: TRect; const AName: string);
begin
  ACanvas.Font.Name := CNST_PROPORTIONALFONT;
  ACanvas.Font.Color := clGray;
  ACanvas.Font.Size := 8;
  ACanvas.Font.Style := [fsItalic];
  DrawTextEx(ACanvas.Handle, PChar(AName), Length(AName), ARect, DT_SINGLELINE+DT_VCENTER, nil);
  ACanvas.Font.Style := [];
end;

procedure TIWBSPaintHandlerRegion.Paint;
var
  LRect : TRect;
  s: string;
  w: integer;
  LLines: string;
  LScript: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBSCustomRegion(Control) do begin
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Size := 10;
    ControlCanvas.Font.Color := clGray;
    ControlCanvas.Font.Style := [];

    // draw css classes
    s := GetCssString;
    if Control is TIWBSFormControl then begin
      if s <> '' then
        s := ' '+s;
      s := 'form-control'+s;
    end;
    s := '['+s+']';
    if not RawText then
      s := '<'+TagType+'> ' + s;
    s := Name+' '+s;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth-w-10, 2, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect,s,[]);

    // draw embeded text and script
    LLines := Text;
    if RawText then
      begin
        ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
        if Script.Count > 0 then
          LScript := #13#10'<script>'#13#10+Script.Text+'</script>'
        else
          LScript := '';
        LLines := '<'+TagType+'>'+IfThen(LLines <> '',#13#10+LLines);
        if ScriptInsideTag then
          LLines := LLines+LScript;
        LLines := LLines+#13#10'</'+TagType+'>';
        if not ScriptInsideTag then
          LLines := LLines+LScript;
      end
    else
      begin
        ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
        if Control is TIWBSRegion then
          case TIWBSRegion(Control).TagType of
            bsttDiv, bsttP: ControlCanvas.Font.Height := -12;
            bsttH1: ControlCanvas.Font.Height := -36;
            bsttH2: ControlCanvas.Font.Height := -30;
            bsttH3: ControlCanvas.Font.Height := -24;
            bsttH4: ControlCanvas.Font.Height := -18;
            bsttH5: ControlCanvas.Font.Height := -14;
            bsttH6: ControlCanvas.Font.Height := -12;
          end;
      end;

    if LLines <> '' then begin
      LRect := Rect(10, 18, Control.Width-10, Control.Height-3);
      ControlCanvas.Font.Color := clBlack;
      ControlCanvas.TextRect(LRect,LLines,[]);
    end;
  end;
end;

procedure TIWBSPaintHandlerCustomInput.Paint;
var
  LRect, LIcon: TRect;
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
          LIcon := Rect(LRect.Right-18,LRect.Top+1,LRect.Right-1,LRect.Bottom-1);
          ControlCanvas.Font.Name := CNST_GLYPHICONSFONT;
          ControlCanvas.Brush.Color := clLtGray;
          ControlCanvas.Rectangle(LIcon);
          c := GetGlyphiconChar('chevron-down', 'V');
          if c <> '' then begin
            DrawTextEx(ControlCanvas.Handle, PChar(c), 1, LIcon, DT_CENTER+DT_SINGLELINE+DT_VCENTER, nil);
            ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
            ControlCanvas.Brush.Color := clWhite;
            Dec(LRect.Right, 20);
          end;
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

procedure TIWBSPaintHandlerCustomCheck.Paint;
var
  LRect, LIcon: TRect;
  LGlyp, LCaption: string;
  c: string;
begin
  if Control is TIWBSRadioButton then
    begin
      LGlyp := 'record';
      LCaption := TIWBSCheckBox(Control).Caption;
    end
  else if Control is TIWBSCheckBox then
    begin
      LGlyp := 'ok';
      LCaption := TIWBSCheckBox(Control).Caption;
    end
  else
    begin
      LGlyp := '';
      LCaption := '';
    end;

  if LGlyp <> '' then begin
    LIcon := Rect(0, 0, 16,Control.Height);
    ControlCanvas.Font.Name := CNST_GLYPHICONSFONT;
    ControlCanvas.Font.Size := 8;
    c := GetGlyphiconChar(LGlyp,'X');
    DrawTextEx(ControlCanvas.Handle, PChar(c), 1, LIcon, DT_SINGLELINE+DT_VCENTER, nil);
  end;

  if LCaption <> '' then begin
    LRect := Rect(17, 0, Control.Width, Control.Height);
    ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
    ControlCanvas.Font.Size := 10;
    DrawTextEx(ControlCanvas.Handle, PChar(LCaption), Length(LCaption), LRect, DT_SINGLELINE+DT_VCENTER, nil);
  end;
end;

procedure TIWBSPaintHandlerCustomButton.Paint;
var
  LRect : TRect;
  s: string;
begin
  GlyphiconsFontAdvice;

  if not (Control is TIWBSCustomButton) then Exit;

  with TIWBSCustomButton(Control) do begin
    LRect := Rect(0, 0, Width, Height);
    case BSButtonStyle of
      bsbsDefault:
        begin
          ControlCanvas.Brush.Color := clWhite;
          ControlCanvas.Pen.Color := clGray;
          if Enabled then
            ControlCanvas.Font.Color := clBlack
          else
            ControlCanvas.Font.Color := clDkGray;
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
    case BSButtonSize of
      bsszLg: ControlCanvas.Font.Height := -18;
      bsszMd, bsszDefault: ControlCanvas.Font.Height := -14;
      bsszSm: ControlCanvas.Font.Height := -12;
      bsszXs: ControlCanvas.Font.Height := -10;
    end;

    if not (Control is TIWBSDropDown) and (BSGlyphicon <> '') then
      DrawGlyphicon(ControlCanvas,LRect,BSGlyphicon,'');

    s := Caption;
    if (s = '') and (BSButtonStyle = bsbsClose) then
      s := 'X';
    if s <> '' then begin
      ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
      DrawTextEx(ControlCanvas.Handle, PChar(s), Length(s), LRect, DT_SINGLELINE+DT_VCENTER, nil);
    end;

    if Control is TIWBSDropDown then
      if BSGlyphicon <> '' then
        DrawGlyphicon(ControlCanvas,LRect,BSGlyphicon,'', True)
      else
        DrawGlyphicon(ControlCanvas,LRect,'chevron-down', 'V', True);

    if not (Control is TIWBSDropDown) and (BSGlyphicon = '') and (s = '') then
      DrawControlName(ControlCanvas, LRect, Name);
  end;
end;

procedure TIWBSPaintHandlerFile.Paint;
var
  LRect: TRect;
  s: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);

  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
  ControlCanvas.Font.Size := 10;
  ControlCanvas.Font.Color := clBlack;
  ControlCanvas.Rectangle(LRect);

  Inc(LRect.Top, 1);
  Inc(LRect.Left, 8);
  Dec(LRect.Bottom, 1);
  Dec(LRect.Right, 8);
  s := 'File Input';
  DrawTextEx(ControlCanvas.Handle, PChar(s), Length(s), LRect, DT_SINGLELINE+DT_VCENTER, nil);
end;

procedure TIWBSPaintHandlerGlyphicon.Paint;
var
  LRect : TRect;
  c: string;
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
      c := GetGlyphiconChar(TIWBSGlyphicon(Control).BSGlyphicon);
      if c <> '' then
        ControlCanvas.TextRect(LRect, LRect.Left, (LRect.Bottom-LRect.Top-th) div 2, c);
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

procedure TIWBSPaintHandlerText.Paint;
var
  LRect: TRect;
  LLines, LScript: string;
begin
  with TIWBSText(Control) do begin
    LRect := Rect(0, 0, Control.Width, Control.Height);
    ControlCanvas.Brush.Color := clWhite;
    ControlCanvas.Pen.Color := clGray;
    ControlCanvas.Rectangle(LRect);

    if RawText then
      ControlCanvas.Font.Name := CNST_PROPORTIONALFONT
    else
      ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
    ControlCanvas.Font.Size := 10;
    ControlCanvas.Font.Color := clBlack;

    LLines := DataField;
    if LLines = '' then
      LLines := Trim(Lines.Text);

    if RawText then begin
      if Script.Count > 0 then
        LScript := #13#10'<script>'#13#10+Script.Text+'</script>'
      else
        LScript := '';
      LLines := '<'+TagType+'>'+IfThen(LLines <> '',#13#10+LLines);
      if ScriptInsideTag then
        LLines := LLines+LScript;
      LLines := LLines+#13#10'</'+TagType+'>';
      if not ScriptInsideTag then
        LLines := LLines+LScript;
    end;

    Inc(LRect.Top, 1);
    Inc(LRect.Left, 8);
    Dec(LRect.Bottom, 1);
    Dec(LRect.Right, 8);
    ControlCanvas.TextRect(LRect,LLines,[])
  end;
end;

procedure TIWBSPaintHandlerLabel.Paint;
var
  LRect: TRect;
  lCaption: string;
begin
  with TIWBSLabel(Control) do begin
    LRect := Rect(0, 0, Control.Width, Control.Height);

    ControlCanvas.Brush.Color := clWhite;
    ControlCanvas.Pen.Color := clGray;
    ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
    ControlCanvas.Font.Size := 10;
    ControlCanvas.Font.Color := clBlack;
    lCaption := Caption;

    if DataField <> '' then
      DrawControlName(ControlCanvas, LRect, DataField)
    else if lCaption <> '' then
      ControlCanvas.TextRect(LRect,lCaption,[])
    else
      DrawControlName(ControlCanvas, LRect, Name);
  end;
end;

procedure TIWBSPaintHandlerImage.Paint;
var
  LRect, LImageRect: TRect;
  LPicture: TPicture;
  LText, LImageFile: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  LImageRect := LRect;
  LText := '';

  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBSImage(Control) do begin
    if Assigned(DataSource) and (DataField <> '') then
      begin
        LText := DataSource.Name+'.['+DataField+']';
        Inc(LImageRect.Top,40);
        Inc(LImageRect.Left,40);
        Dec(LImageRect.Bottom,40);
        Dec(LImageRect.Right,40);
      end;

    if Assigned(Picture) and Assigned(Picture.Graphic) and (not Picture.Graphic.Empty) then
      begin
        if LText <> '' then
          LText := LText+#13#10'Fallback to picture';
        ControlCanvas.StretchDraw(LImageRect, Picture.Graphic);
      end

    else if ImageFile <> '' then
      begin
        LImageFile := GetFixedFilePath;
        if FileExists(LImageFile) then
          begin
            LPicture := TPicture.Create;
            try
              if LText = '' then begin
                Inc(LImageRect.Top,20);
                Inc(LImageRect.Left,20);
                Dec(LImageRect.Bottom,20);
                Dec(LImageRect.Right,20);
              end;
              LPicture.LoadFromFile(LImageFile);
              if Assigned(LPicture.Graphic) and (not LPicture.Graphic.Empty) then
                ControlCanvas.StretchDraw(LImageRect, LPicture.Graphic);
            except
              on E: Exception do
                LText := E.Message;
            end;
            LPicture.Free;
          end;
        if LText <> '' then
          LText := LText+#13#10'Fallback to ';
        LText := LText + 'File="'+ImageFile+'"';
      end

    else if ImageSrc <> '' then
      begin
        if LText <> '' then
          LText := LText+#13#10'Fallback to ';
        LText := LText + 'Src="'+ImageSrc+'"';
      end;
  end;
  if LText <> '' then begin
    Inc(LRect.Top,5);
    Inc(LRect.Left,5);
    Dec(LRect.Bottom,5);
    Dec(LRect.Right,5);
    ControlCanvas.Brush.Style := bsClear;
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Color := clGray;
    ControlCanvas.TextRect(LRect,LText,[]);
  end;
end;

{ TCaptionEditorOld }

destructor TIWBSStringProperty.Destroy;
begin
  FreeAndNil(FStrings);
  inherited;
end;

function TIWBSStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes - [paReadOnly];
end;

function TIWBSStringProperty.GetStrings: TStrings;
begin
  if FStrings = nil then
    FStrings := TStringList.Create;
  FStrings.Text := GetStrValue;
  Result := FStrings;
end;

function TIWBSStringProperty.GetValue: string;
begin
  Result := GetStrValue;
end;

procedure TIWBSStringProperty.SetStrings(const Value: TStrings);
begin
  SetStrValue(TrimRight(Value.Text));
end;

procedure TIWBSStringProperty.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

{ TIWBSStringListProperty }

function TIWBSStringListProperty.GetIsDefault: Boolean;
var
  l: TStrings;
begin
  l := GetStrings;
  if l <> nil then
    Result := l.Count = 0
  else
    Result := True;
end;

procedure Register;
begin
  RegisterComponents('IW BootsTrap', [TIWBSLayoutMgr]);

  RegisterComponents('IW BootsTrap', [TIWBSRegion]);
  RegisterComponents('IW BootsTrap', [TIWBSInputForm]);
  RegisterComponents('IW BootsTrap', [TIWBSInputGroup]);
  RegisterComponents('IW BootsTrap', [TIWBSFormControl]);
  RegisterComponents('IW BootsTrap', [TIWBSUnorderedList]);
  RegisterComponents('IW BootsTrap', [TIWBSModal]);

  RegisterComponents('IW BootsTrap', [TIWBSList]);

  RegisterComponents('IW BootsTrap', [TIWBSButtonGroup]);

  RegisterComponents('IW BootsTrap', [TIWBSNavBar]);
  RegisterComponents('IW BootsTrap', [TIWBSNavBarHeader]);
  RegisterComponents('IW BootsTrap', [TIWBSNavBarCollapse]);

  RegisterComponents('IW BootsTrap', [TIWBSInput]);
  RegisterComponents('IW BootsTrap', [TIWBSMemo]);
  RegisterComponents('IW BootsTrap', [TIWBSMemoHtml]);
  RegisterComponents('IW BootsTrap', [TIWBSSelect]);

  RegisterComponents('IW BootsTrap', [TIWBSCheckBox]);
  RegisterComponents('IW BootsTrap', [TIWBSRadioButton]);

  RegisterComponents('IW BootsTrap', [TIWBSRadioGroup]);

  RegisterComponents('IW BootsTrap', [TIWBSButton]);
  RegisterComponents('IW BootsTrap', [TIWBSDropDown]);

  RegisterComponents('IW BootsTrap', [TIWBSLabel]);
  RegisterComponents('IW BootsTrap', [TIWBSText]);

  RegisterComponents('IW BootsTrap', [TIWBSGlyphicon]);
  RegisterPropertyEditor(TypeInfo(string), TIWBSGlyphicon, 'BSGlyphicon', TGlyphiconEditor);

  RegisterComponents('IW BootsTrap', [TIWBSImage]);

  RegisterComponents('IW BootsTrap', [TIWBSFile]);

  RegisterComponents('IW BootsTrap', [TIWBSTabControl]);

  RegisterPropertyEditor(TypeInfo(TStrings), TIWBSCustomControl, '', TIWBSStringListProperty);

  RegisterPropertyEditor(TypeInfo(TStrings), TIWBSCustomRegion, '', TIWBSStringListProperty);
  RegisterPropertyEditor(TypeInfo(string), TIWBSCustomRegion, 'Text', TIWBSStringProperty);
  RegisterPropertyEditor(TypeInfo(string), TIWBSCustomButton, 'BSGlyphicon', TGlyphiconEditor);
  RegisterPropertyEditor(TypeInfo(string), TIWBSCustomButton, 'Caption', TIWBSStringProperty);

  UnlistPublishedProperty(TIWBSCustomControl, 'SkinId');
  UnlistPublishedProperty(TIWBSCustomControl, 'StyleRenderOptions');

  UnlistPublishedProperty(TIWBSCustomRegion, 'TabOrder');
  UnlistPublishedProperty(TIWBSCustomRegion, 'OnAlignInsertBefore');
  UnlistPublishedProperty(TIWBSCustomRegion, 'OnAlignPosition');

  UnlistPublishedProperty(TIWBSTabControl, 'ActiveTabFont');
  UnlistPublishedProperty(TIWBSTabControl, 'InactiveTabFont');
  UnlistPublishedProperty(TIWBSTabControl, 'ActiveTabColor');
  UnlistPublishedProperty(TIWBSTabControl, 'InactiveTabColor');
end;

initialization
  slGlyphicons := TStringList.Create;
  slGlyphicons.Text := iwbsGlyphicons;

  IWRegisterPaintHandler('TIWBSRegion',TIWBSPaintHandlerRegion);
  IWRegisterPaintHandler('TIWBSInputForm',TIWBSPaintHandlerRegion);
  IWRegisterPaintHandler('TIWBSInputGroup',TIWBSPaintHandlerRegion);
  IWRegisterPaintHandler('TIWBSFormControl',TIWBSPaintHandlerRegion);
  IWRegisterPaintHandler('TIWBSUnorderedList',TIWBSPaintHandlerRegion);
  IWRegisterPaintHandler('TIWBSModal',TIWBSPaintHandlerRegion);

  IWRegisterPaintHandler('TIWBSList',TIWBSPaintHandlerRegion);

  IWRegisterPaintHandler('TIWBSButtonGroup',TIWBSPaintHandlerRegion);

  IWRegisterPaintHandler('TIWBSNavBar',TIWBSPaintHandlerRegion);
  IWRegisterPaintHandler('TIWBSNavBarHeader',TIWBSPaintHandlerRegion);
  IWRegisterPaintHandler('TIWBSNavBarCollapse',TIWBSPaintHandlerRegion);

  IWRegisterPaintHandler('TIWBSInput',TIWBSPaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBSMemo',TIWBSPaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBSMemoHtml',TIWBSPaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBSSelect',TIWBSPaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBSCheckBox',TIWBSPaintHandlerCustomCheck);
  IWRegisterPaintHandler('TIWBSRadioButton',TIWBSPaintHandlerCustomCheck);
  IWRegisterPaintHandler('TIWBSRadioGroup',TIWBSPaintHandlerRadioGroup);

  IWRegisterPaintHandler('TIWBSButton',TIWBSPaintHandlerCustomButton);

  IWRegisterPaintHandler('TIWBSDropDown',TIWBSPaintHandlerCustomButton);

  IWRegisterPaintHandler('TIWBSLabel',TIWBSPaintHandlerLabel);

  IWRegisterPaintHandler('TIWBSGlyphicon',TIWBSPaintHandlerGlyphicon);

  IWRegisterPaintHandler('TIWBSText',TIWBSPaintHandlerText);

  IWRegisterPaintHandler('TIWBSImage',TIWBSPaintHandlerImage);

  IWRegisterPaintHandler('TIWBSFile',TIWBSPaintHandlerFile);

  IWRegisterPaintHandler('TIWBSTabControl',TIWPaintHandlerTabControl);

finalization
  slGlyphicons.Free;

  IWUnRegisterPaintHandler('TIWBSRegion');
  IWUnRegisterPaintHandler('TIWBSInputForm');
  IWUnRegisterPaintHandler('TIWBSInputGroup');
  IWUnRegisterPaintHandler('TIWBSFormControl');
  IWUnRegisterPaintHandler('TIWBSUnorderedList');
  IWUnRegisterPaintHandler('TIWBSModal');

  IWUnRegisterPaintHandler('TIWBSList');

  IWUnRegisterPaintHandler('TIWBSButtonGroup');

  IWUnRegisterPaintHandler('TIWBSNavBar');
  IWUnRegisterPaintHandler('TIWBSNavBarHeader');
  IWUnRegisterPaintHandler('TIWBSNavBarCollapse');

  IWUnRegisterPaintHandler('TIWBSInput');
  IWUnRegisterPaintHandler('TIWBSMemo');
  IWUnRegisterPaintHandler('TIWBSMemoHtml');
  IWUnRegisterPaintHandler('TIWBSSelect');
  IWUnRegisterPaintHandler('TIWBSCheckBox');
  IWUnRegisterPaintHandler('TIWBSRadioButton');
  IWUnRegisterPaintHandler('TIWBSRadioGroup');

  IWUnRegisterPaintHandler('TIWBSButton');
  IWUnRegisterPaintHandler('TIWBSDropDown');

  IWUnRegisterPaintHandler('TIWBSLabel');

  IWUnRegisterPaintHandler('TIWBSGlyphicon');

  IWUnRegisterPaintHandler('TIWBSText');

  IWUnRegisterPaintHandler('TIWBSImage');

  IWUnRegisterPaintHandler('TIWBSTabControl');

end.
