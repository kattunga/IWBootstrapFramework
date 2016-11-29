unit IWBSCommon;

interface

{$Include IWBootstrap.inc}

uses Classes, SysUtils, StrUtils, Forms,
     IWApplication, IWRenderContext, IWControl, IWHTML40Interfaces, IWBaseHTMLInterfaces, IWTypes,
     IWBaseInterfaces, IWHTMLTag, IWBaseRenderContext,
     {$IFDEF IW_14_1_0_UP} IW.Common.StrLists, {$ENDIF}
     IWBSJsonDataObjects, IWBSCommonInterfaces;

const
  EOL = #13#10;

type
  TIWBSTextAlignment = (bstaDefault, bstaLeft, bstaCenter, bstaRight, bstaJustify, bstaNowrap);
  TIWBSTextCase = (bstcDefault, bstcLowercase, bstcUppercase, bstcCapitalize);
  TIWBSSize = (bsszDefault, bsszLg, bsszMd, bsszSm, bsszXs);
  TIWBSRelativeSize = (bsrzDefault, bsrzLg, bsrzSm);
  TIWBSResizeDirection = (bsrdDefault, bsrdNone, bsrdBoth, bsrdVertical, bsrdHorizontal);

const
  aIWBSRelativeSize: array[bsrzDefault..bsrzSm] of string = ('', 'lg', 'sm');
  aIWBSSize: array[bsszDefault..bsszXs] of string = ('', 'lg', 'md', 'sm', 'xs');
  aIWBSTextAlignment: array[bstaDefault..bstaNowrap] of string = ('', 'text-left', 'text-center', 'text-right', 'text-justify', 'text-nowrap');
  aIWBSTextCase: array[bstcDefault..bstcCapitalize] of string = ('', 'text-lowercase', 'text-uppercase', 'text-capitalize');
  aIWBSResizeDirection: array[bsrdDefault..bsrdHorizontal] of string = ('', 'none', 'both', 'vertical', 'horizontal');

type
  TIWBSGridVisibility = (bsgvDefault, bsgvBlock, bsgvInline, bsgvInlineBlock, bsgvHidden);
  TIWBSGridFloat = (bsgfNone, bsgfLeft, bsgfRight);

  TIWBSGridOptions = class(TPersistent)
  private
    FFloat: TIWBSGridFloat;
    FOwner: IIWBaseControl;
    FGridXsOffset: integer;
    FGridXsSpan: integer;
    FGridSmOffset: integer;
    FGridSmSpan: integer;
    FGridMDOffset: integer;
    FGridMdSpan: integer;
    FGridLGOffset: integer;
    FGridLGspan: integer;
    FVisibilityXs: TIWBSGridVisibility;
    FVisibilitySm: TIWBSGridVisibility;
    FVisibilityMd: TIWBSGridVisibility;
    FVisibilityLg: TIWBSGridVisibility;
    FVisibilityPr: TIWBSGridVisibility;
    procedure SetVisibilityLg(const Value: TIWBSGridVisibility);
    procedure SetVisibilityMd(const Value: TIWBSGridVisibility);
    procedure SetVisibilityPr(const Value: TIWBSGridVisibility);
    procedure SetVisibilitySm(const Value: TIWBSGridVisibility);
    procedure SetVisibilityXs(const Value: TIWBSGridVisibility);
    procedure SetFloat(const Value: TIWBSGridFloat);
    procedure SetGridLGOffset(const Value: integer);
    procedure SetGridLGspan(const Value: integer);
    procedure SetGridMDOffset(const Value: integer);
    procedure SetGridMdSpan(const Value: integer);
    procedure SetGridSmOffset(const Value: integer);
    procedure SetGridSmSpan(const Value: integer);
    procedure SetGridXsOffset(const Value: integer);
    procedure SetGridXsSpan(const Value: integer);
  public
    constructor Create(AOwner: IIWBaseControl); virtual;

    procedure Assign(Source: TPersistent); override;
    function GetClassString(ACustomXsOffset, ACustomSmOffset, ACustomMdOffset, ACustomLgOffset: integer): string; overload;
    function GetClassString: string; overload;
  published
    property Float: TIWBSGridFloat read FFloat write SetFloat default bsgfNone;
    property GridXsOffset: integer read FGridXsOffset write SetGridXsOffset default 0;
    property GridXsSpan: integer read FGridXsSpan write SetGridXsSpan default 0;
    property GridSmOffset: integer read FGridSmOffset write SetGridSmOffset default 0;
    property GridSmSpan: integer read FGridSmSpan write SetGridSmSpan default 0;
    property GridMdOffset: integer read FGridMDOffset write SetGridMDOffset default 0;
    property GridMdSpan: integer read FGridMdSpan write SetGridMdSpan default 0;
    property GridLgOffset: integer read FGridLGOffset write SetGridLGOffset default 0;
    property GridLgSpan: integer read FGridLGspan write SetGridLGspan default 0;
    property VisibilityXs: TIWBSGridVisibility read FVisibilityXs write SetVisibilityXs default bsgvDefault;
    property VisibilitySm: TIWBSGridVisibility read FVisibilitySm write SetVisibilitySm default bsgvDefault;
    property VisibilityMd: TIWBSGridVisibility read FVisibilityMd write SetVisibilityMd default bsgvDefault;
    property VisibilityLg: TIWBSGridVisibility read FVisibilityLg write SetVisibilityLg default bsgvDefault;
    property VisibilityPrint: TIWBSGridVisibility read FVisibilityPr write SetVisibilityPr default bsgvDefault;
  end;

  TIWBSCommon = class
  public
    class procedure AddCssClass(var ACss: string; const AClass: string);
    class procedure AsyncRemoveControl(const AHTMLName: string);
    class procedure DoAfterRender(AControl: TComponent);
    class procedure RenderAsync(const AHTMLName: string; AControl: IIWBSComponent; AContext: TIWCompContext);
    class function RenderHTMLTag(AControl: IIWBSComponent; AContext: TIWCompContext): string;
    class function RenderStyle(AComponent: IIWBSComponent): string;
    class function ReplaceParams(AComponent: IIWBSComponent; const AScript: string; AFrom: integer = 1): string;
    class procedure SetNotVisible(AParams: {$IFDEF IW_14_1_0_UP} TIWNameValueList {$ELSE} TStrings {$ENDIF});
    class procedure ValidateParamName(const AName: string);
    class procedure ValidateTagName(const AName: string);

    class procedure SetAsyncDisabled(AApplication: TIWApplication; const AHTMLName: string; Value: boolean; var OldValue: boolean);
    class procedure SetAsyncReadOnly(AApplication: TIWApplication; const AHTMLName: string; Value: boolean; var OldValue: boolean);
    class procedure SetAsyncVisible(AApplication: TIWApplication; const AHTMLName: string; Value: boolean; var OldValue: boolean);
    class procedure SetAsyncClass(AApplication: TIWApplication; const AHTMLName: string; const Value: string; var OldValue: string);
    class procedure SetAsyncStyle(AApplication: TIWApplication; const AHTMLName: string; const Value: string; var OldValue: string);
    class procedure SetAsyncChecked(AApplication: TIWApplication; const AHTMLName: string; const Value: boolean; var OldValue: boolean);
    class procedure SetAsyncText(AApplication: TIWApplication; const AHTMLName: string; const Value: string; var OldValue: string);
    class procedure SetAsyncHtml(AApplication: TIWApplication; const AHTMLName: string; const Value: string; var OldValue: string);
  end;

  TIWBSRegionCommon = class
  public
    class procedure CancelChildAsyncRender(AControl: TComponent);
    class procedure DisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);
    class procedure PrepareChildComponentsForRender(AContainer: IIWBaseContainer);
    class procedure RenderComponents(AContainer: IIWBSContainer; AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
  end;


implementation

uses IW.Common.System, IW.Common.RenderStream, IWBaseHTMLControl, IWForm, IWRegion, IWMarkupLanguageTag, IWHTML40Container,
     IWBSUtils, IWBSGlobal, IWBSNavBar, IWBSCustomRegion,
     IWBSLayoutMgr;

{$region 'TIWBSGridOptions'}
constructor TIWBSGridOptions.Create(AOwner: IIWBaseControl);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TIWBSGridOptions.GetClassString(ACustomXsOffset, ACustomSmOffset, ACustomMdOffset, ACustomLgOffset: integer): string;
  procedure AddCssValue(var s: string; const Value: string);
  begin
    if s <> '' then
      s := s + ' ';
    s := s + Value;
  end;
var
  lNavBar: boolean;
begin
  Result := '';
  if ACustomXsOffset+FGridXsOffset > 0 then
    AddCssValue(Result, 'col-xs-offset-'+IntToStr(ACustomXsOffset+FGridXsOffset));
  if ACustomSmOffset+FGridSmOffset > 0 then
    AddCssValue(Result, 'col-sm-offset-'+IntToStr(ACustomSmOffset+FGridSmOffset));
  if ACustomMdOffset+FGridMDOffset > 0 then
    AddCssValue(Result, 'col-md-offset-'+IntToStr(ACustomMdOffset+FGridMDOffset));
  if ACustomLgOffset+FGridLGOffset > 0 then
    AddCssValue(Result, 'col-lg-offset-'+IntToStr(ACustomLgOffset+FGridLGOffset));

  if (FGridXsSpan > 0) then
    AddCssValue(Result, 'col-xs-'+IntToStr(FGridXsSpan));
  if (FGridSmSpan > 0) then
    AddCssValue(Result, 'col-sm-'+IntToStr(FGridSmSpan));
  if (FGridMdSpan > 0) then
    AddCssValue(Result, 'col-md-'+IntToStr(FGridMdSpan));
  if (FGridLGspan > 0) then
    AddCssValue(Result, 'col-lg-'+IntToStr(FGridLGspan));

  if FVisibilityXs = bsgvBlock then
    AddCssValue(Result, 'visible-xs-block')
  else if FVisibilityXs = bsgvInline then
    AddCssValue(Result, 'visible-xs-inline')
  else if FVisibilityXs = bsgvInlineBlock then
    AddCssValue(Result, 'visible-xs-inline-block')
  else if FVisibilityXs = bsgvHidden then
    AddCssValue(Result, 'hidden-xs');

  if FVisibilitySm = bsgvBlock then
    AddCssValue(Result, 'visible-sm-block')
  else if FVisibilitySm = bsgvInline then
    AddCssValue(Result, 'visible-sm-inline')
  else if FVisibilitySm = bsgvInlineBlock then
    AddCssValue(Result, 'visible-sm-inline-block')
  else if FVisibilitySm = bsgvHidden then
    AddCssValue(Result, 'hidden-sm');

  if FVisibilityMd = bsgvBlock then
    AddCssValue(Result, 'visible-md-block')
  else if FVisibilityMd = bsgvInline then
    AddCssValue(Result, 'visible-md-inline')
  else if FVisibilityMd = bsgvInlineBlock then
    AddCssValue(Result, 'visible-md-inline-block')
  else if FVisibilityMd = bsgvHidden then
    AddCssValue(Result, 'hidden-md');

  if FVisibilityLg = bsgvBlock then
    AddCssValue(Result, 'visible-lg-block')
  else if FVisibilityLg = bsgvInline then
    AddCssValue(Result, 'visible-lg-inline')
  else if FVisibilityLg = bsgvInlineBlock then
    AddCssValue(Result, 'visible-lg-inline-block')
  else if FVisibilityLg = bsgvHidden then
    AddCssValue(Result, 'hidden-lg');

  if FVisibilityPr = bsgvBlock then
    AddCssValue(Result, 'visible-print-block')
  else if FVisibilityPr = bsgvInline then
    AddCssValue(Result, 'visible-print-inline')
  else if FVisibilityPr = bsgvInlineBlock then
    AddCssValue(Result, 'visible-print-inline-block')
  else if FVisibilityPr = bsgvHidden then
    AddCssValue(Result, 'hidden-print');

  if FFloat <> bsgfNone then begin
    lNavBar := (FOwner is TIWBSCustomRegion);
    if FFloat = bsgfLeft then
      if lNavBar then
        AddCssValue(Result, 'navbar-left')
      else
        AddCssValue(Result, 'pull-left')
    else if FFloat = bsgfRight then
      if lNavBar then
        AddCssValue(Result, 'navbar-right')
      else
        AddCssValue(Result, 'pull-right');
  end;
end;

procedure TIWBSGridOptions.SetFloat(const Value: TIWBSGridFloat);
begin
  FFloat := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetGridLGOffset(const Value: integer);
begin
  FGridLGOffset := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetGridLGspan(const Value: integer);
begin
  FGridLGspan := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetGridMDOffset(const Value: integer);
begin
  FGridMDOffset := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetGridMdSpan(const Value: integer);
begin
  FGridMdSpan := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetGridSmOffset(const Value: integer);
begin
  FGridSmOffset := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetGridSmSpan(const Value: integer);
begin
  FGridSmSpan := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetGridXsOffset(const Value: integer);
begin
  FGridXsOffset := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetGridXsSpan(const Value: integer);
begin
  FGridXsSpan := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetVisibilityLg(const Value: TIWBSGridVisibility);
begin
  FVisibilityLg := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetVisibilityMd(const Value: TIWBSGridVisibility);
begin
  FVisibilityMd := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetVisibilityPr(const Value: TIWBSGridVisibility);
begin
  FVisibilityPr := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetVisibilitySm(const Value: TIWBSGridVisibility);
begin
  FVisibilitySm := Value;
  FOwner.Invalidate;
end;

procedure TIWBSGridOptions.SetVisibilityXs(const Value: TIWBSGridVisibility);
begin
  FVisibilityXs := Value;
  FOwner.Invalidate;
end;

function TIWBSGridOptions.GetClassString: string;
begin
  Result := GetClassString(0, 0, 0, 0);
end;

procedure TIWBSGridOptions.Assign(Source: TPersistent);
begin
  if Source is TIWBSGridOptions then
    begin
      GridXSOffset := TIWBSGridOptions(Source).GridXSOffset;
      GridXSSpan := TIWBSGridOptions(Source).GridXSSpan;
      GridSMOffset := TIWBSGridOptions(Source).GridSMOffset;
      GridSMSpan := TIWBSGridOptions(Source).GridSMSpan;
      GridMDOffset := TIWBSGridOptions(Source).GridMDOffset;
      GridMDSpan := TIWBSGridOptions(Source).GridMDSpan;
      GridLGOffset := TIWBSGridOptions(Source).GridLGOffset;
      GridLGSpan := TIWBSGridOptions(Source).GridLGSpan;
    end
  else
    inherited;
end;
{$endregion}

{$region 'TIWBSCommon'}
class procedure TIWBSCommon.AddCssClass(var ACss: string; const AClass: string);
begin
  if ACss <> '' then
    ACss := ACss+' ';
  ACss := ACss+AClass;
end;

class procedure TIWBSCommon.AsyncRemoveControl(const AHTMLName: string);
begin
  IWBSExecuteAsyncJScript('AsyncDestroyControl("'+AHTMLName+'");', False, True);
end;

class procedure TIWBSCommon.DoAfterRender(AControl: TComponent);
var
  i: integer;
  LComponent: IIWBSComponent;
  LContainer: IIWBaseContainer;
begin
  AControl.GetInterface(IIWBSComponent, LComponent);
  if LComponent <> nil then begin
    if Assigned(LComponent.OnAfterRender) then
      LComponent.OnAfterRender(LComponent.InterfaceInstance);

    if Assigned(gIWBSOnAfterRender) then
      gIWBSOnAfterRender(LComponent.InterfaceInstance);
  end;

  if AControl is TFrame then
    for i := 0 to AControl.ComponentCount-1 do
      DoAfterRender(AControl.Components[i])
  else
    begin
      AControl.GetInterface(IIWBaseContainer, LContainer);
      if LContainer <> nil then
        for i := 0 to LContainer.IWComponentsCount-1 do
          DoAfterRender(LContainer.Component[i])
    end;
end;

class procedure TIWBSCommon.RenderAsync(const AHTMLName: string; AControl: IIWBSComponent; AContext: TIWCompContext);
  function ParentTreeVisibility(AControl: TComponent): boolean;
  var
    LContainer: IIWInvisibleControlRenderer;
    LControl: IIWBaseControl;
  begin
    Result := True;
    LControl := BaseControlInterface(AControl);
    if LControl <> nil then begin
      if not LControl.Visible then begin
        GetIWInterface(LControl.ParentContainer.InterfaceInstance, IIWInvisibleControlRenderer, LContainer);
        if not LContainer.RenderInvisibleControls then
          Result := False;
      end;
      if Result and (LControl.ParentContainer <> nil) then
        Result := ParentTreeVisibility(LControl.ParentContainer.InterfaceInstance);
    end;
  end;
var
  LParentContainer: IIWBaseHTMLComponent;
  LBaseContainer: IIWBaseContainer;
  LParentSl: string;
  LHtmlTag: string;
begin

  // if not visible and parent.RenderInvisibleControls is false, do not render
  if not ParentTreeVisibility(AControl.InterfaceInstance) then
    Exit;

  // check if component context is assigned
  if AContext = nil then
    raise Exception.Create('Component context not assigned');

  // if baseContainer, DoRender;
  GetIWInterface(AControl.InterfaceInstance,IIWBaseContainer,LBaseContainer);
  if LBaseContainer <> nil then
    LBaseContainer.DoRender;

  // get parent container
  if AControl.ParentContainer.InterfaceInstance is TIWForm then
    LParentSl := 'body'
  else
    begin
      LParentContainer := BaseHTMLComponentInterface(AControl.ParentContainer.InterfaceInstance);
      if LParentContainer <> nil then
        LParentSl := '#'+LParentContainer.HTMLName
      else
        Exit;
    end;

  LHtmlTag := RenderHtmlTag(AControl, AContext);

  // the creation of the controls is executed as first script in the callback response, so further scripts in callback could reference them
  IWBSExecuteAsyncJScript(AContext.WebApplication, 'AsyncRenderControl("'+AHtmlName+'", "'+LParentSl+'", "'+IWBSTextToJsParamText(LHtmlTag)+'");', True, True);

  DoAfterRender(AControl.InterfaceInstance);
end;

class function TIWBSCommon.RenderHTMLTag(AControl: IIWBSComponent; AContext: TIWCompContext): string;
var
  LContainer: IIWBSContainer;
  LBuffer: TIWRenderStream;
  LTag: TIWHTMLTag;
begin
  LTag := AControl.RenderHTML(AContext);
  try
    if not BaseControlInterface(AControl.InterfaceInstance).Visible then
      TIWBSCommon.SetNotVisible(LTag.Params);

    // render child components
    AControl.InterfaceInstance.GetInterface(IIWBSContainer, LContainer);
    if LContainer <> nil then
      TIWBSRegionCommon.RenderComponents(LContainer, LContainer.InitContainerContext(AContext.WebApplication), AContext.PageContext);

    LBuffer := TIWRenderStream.Create(True, True);
    try
      LTag.Render(LBuffer);
      Result := LBuffer.AsString;
    finally
      LBuffer.Free;
    end;
  finally
    LTag.Free;
  end;

  BaseHTMLComponentInterface(AControl.InterfaceInstance).DoHTMLTag(LTag);
end;

class function TIWBSCommon.RenderStyle(AComponent: IIWBSComponent): string;
var
  xStyle: TStringList;
  i: integer;
begin
  Result := '';

  xStyle := TStringList.Create;
  try
    // assign user style
    xStyle.Assign(AComponent.Style);

    // z-index
    if AComponent.ZIndex <> 0 then
      xStyle.Values['z-index'] := IntToStr(AComponent.Zindex);

    // render cursor
    if AComponent.Cursor <> crAuto then
      xStyle.Values['cursor'] := Copy(TIWCustomControl.RenderCursorStyle(AComponent.Cursor), 9, MaxInt);

    AComponent.InternalRenderStyle(xStyle);

    for i := 0 to xStyle.Count-1 do begin
      if Result <> '' then
        Result := Result + ';';
      Result := Result + xStyle[i];
    end;
  finally
    xStyle.Free;
  end;
end;

class function TIWBSCommon.ReplaceParams(AComponent: IIWBSComponent; const AScript: string; AFrom: integer = 1): string;
var
  LF, LT, i: integer;
  LParam, LParNm: string;
  LFound: boolean;
  LCompo: Tcomponent;
  LIComp: IIWBSComponent;
begin
  Result := AScript;

  LF := PosEx('{%', Result, AFrom);
  if LF > 0 then begin
    LFound := False;

    LT := PosEx('%}', Result, LF);
    if LT > LF then
      LParam := Copy(Result, LF, LT-LF+2);
      LParNm := Copy(Result, LF+2, LT-LF-2);

      i := AComponent.ScriptParams.IndexOfName(LParNm);
      if i >= 0 then begin
        Result := ReplaceStr(Result, LParam, AComponent.ScriptParams.ValueFromIndex[i]);
        LFound := True;
      end;

      i := AComponent.ScriptParams.IndexOf(LParNm);
      if i >= 0 then begin
        if AComponent.ScriptParams.Objects[i] is TJsonObject then
          Result := ReplaceText(Result, LParam, TJsonObject(AComponent.ScriptParams.Objects[i]).ToJSON)
        else
          Result := ReplaceText(Result, LParam, '');
      end;

      if not LFound and AnsiSameText('htmlname', LParNm) then begin
        Result := ReplaceStr(Result, LParam, AComponent.HTMLName);
        LFound := True;
      end;

      if not LFound and (AComponent.InterfaceInstance.Owner <> nil) then begin
        LCompo := AComponent.InterfaceInstance.Owner.FindComponent(LParNm);
        if (LCompo <> nil) then begin
          LCompo.GetInterface(IIWBSComponent, LIComp);
          if LIComp <> nil then begin
            Result := ReplaceStr(Result, LParam, LIComp.HTMLName);
            LFound := True;
          end;
        end;
      end;

      if LFound then
        Result := ReplaceParams(AComponent, Result)
      else
        Result := ReplaceParams(AComponent, Result, LF+1);
  end;
end;

class procedure TIWBSCommon.ValidateParamName(const AName: string);
var
  i: integer;
begin
  for i := 1 to Length(AName) do
    if not CharInSet(AName[i], ['-','.','0'..'9','A'..'Z','a'..'z']) then
      raise Exception.Create('Invalid character in param name '+AName);
end;

class procedure TIWBSCommon.ValidateTagName(const AName: string);
var
  i: integer;
begin
  if AName = '' then
    Exception.Create('Tag name could not be empty');
  for i := 1 to Length(AName) do
    if ((i = 1) and not CharInSet(AName[i], ['A'..'Z','a'..'z'])) or
       ((i > 1) and not CharInSet(AName[i], ['0'..'9','A'..'Z','a'..'z'])) then
      raise Exception.Create('Invalid character in tag name '+AName);
end;

class procedure TIWBSCommon.SetNotVisible(AParams: {$IFDEF IW_14_1_0_UP} TIWNameValueList {$ELSE} TStrings {$ENDIF});
var
  LStyle: string;
begin
  LStyle := AParams.Values['style'];
  LStyle := Trim(LStyle);
  if (LStyle <> '') and not AnsiEndsStr(';', LStyle) then
    LStyle := LStyle+';';
  if not AnsiContainsStr(LStyle, 'visibility:') then
    LStyle := LStyle +  'visibility: hidden;';
  if not AnsiContainsStr(LStyle, 'display:') then
    LStyle := LStyle +  'display: none;';
  AParams.Values['style'] := LStyle;
end;

class procedure TIWBSCommon.SetAsyncDisabled(AApplication: TIWApplication; const AHTMLName: string; Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    IWBSExecuteAsyncJScript(AApplication,'$("#'+AHTMLName+'").prop("disabled",'+iif(Value,'true','false')+');', False, True);
    OldValue := Value;
  end;
end;

class procedure TIWBSCommon.SetAsyncReadOnly(AApplication: TIWApplication; const AHTMLName: string; Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    IWBSExecuteAsyncJScript(AApplication,'$("#'+AHTMLName+'").prop("readonly",'+iif(Value,'true','false')+');', False, True);
    OldValue := Value;
  end;
end;

class procedure TIWBSCommon.SetAsyncVisible(AApplication: TIWApplication; const AHTMLName: string; Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    IWBSExecuteAsyncJScript(AApplication,'$("#'+AHTMLName+'").css("visibility","'+iif(Value,'','hidden')+'");', False, True);
    IWBSExecuteAsyncJScript(AApplication,'$("#'+AHTMLName+'").css("display","'+iif(Value,'','none')+'");', False, True);
    OldValue := Value;
  end;
end;

class procedure TIWBSCommon.SetAsyncText(AApplication: TIWApplication; const AHTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    IWBSExecuteAsyncJScript(AApplication,'$("#'+AHTMLName+'").val("'+TIWBaseHTMLControl.TextToJSStringLiteral(Value)+'");', True, True);
    OldValue := Value;
  end;
end;

class procedure TIWBSCommon.SetAsyncHtml(AApplication: TIWApplication; const AHTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    IWBSExecuteAsyncJScript(AApplication,'$("#'+AHTMLName+'").html("'+IWBSTextToJsParamText(Value)+'");', True, True);
    OldValue := Value;
  end;
end;

class procedure TIWBSCommon.SetAsyncClass(AApplication: TIWApplication; const AHTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    IWBSExecuteAsyncJScript(AApplication,'$("#'+AHTMLName+'").removeClass().addClass("'+Value+'");', False, True);
    OldValue := Value;
  end;
end;

class procedure TIWBSCommon.SetAsyncStyle(AApplication: TIWApplication; const AHTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    IWBSExecuteAsyncJScript(AApplication,'$("#'+AHTMLName+'").prop("style","'+Value+'");', False, True);
    OldValue := Value;
  end;
end;

class procedure TIWBSCommon.SetAsyncChecked(AApplication: TIWApplication; const AHTMLName: string; const Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    IWBSExecuteAsyncJScript(AApplication,'$("#'+AHTMLName+'").prop("checked",'+iif(Value,'true','false')+');', False, True);
    OldValue := Value;
  end;
end;
{$endregion}

{$region 'THackCustomRegion'}
type
  THackTIWHTML40Container = class(TIWHTML40Container)
  private
    procedure CallInheritedRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
  end;

procedure THackTIWHTML40Container.CallInheritedRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  inherited RenderComponents(AContainerContext, APageContext);
end;
{$endregion}

{$region 'TIWBSRegionCommon'}
class procedure TIWBSRegionCommon.DisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);
begin
  StyleRenderOptions.RenderAbsolute := False;
  StyleRenderOptions.RenderBorder := False;
  StyleRenderOptions.RenderFont := False;
  StyleRenderOptions.RenderPadding := False;
  StyleRenderOptions.RenderPosition := False;
  StyleRenderOptions.RenderSize := False;
  StyleRenderOptions.RenderZIndex := False;
end;

class procedure TIWBSRegionCommon.PrepareChildComponentsForRender(AContainer: IIWBaseContainer);
var
  i: integer;
  LComponent: TComponent;
  LFrameRegion: TComponent;
  LRegion: TIWRegion;
  LBaseControl: IIWBaseControl;
  LHTML40Control: IIWHTML40Control;
begin
  for i := 0 to AContainer.IWComponentsCount - 1 do begin

    LComponent := AContainer.Component[i];

    // TFrame
    if LComponent is TFrame then
      begin
        LFrameRegion := TFrame(LComponent).FindComponent('IWFrameRegion');
        if LFrameRegion is TIWRegion then begin
          LRegion := TIWRegion(LFrameRegion);
          if LRegion.LayoutMgr = nil then
            LRegion.LayoutMgr := TIWBSLayoutMgr.Create(AContainer.InterfaceInstance);
          LRegion.LayoutMgr.SetContainer(LRegion);
          PrepareChildComponentsForRender(LRegion);
        end;
     end

    // tab pages of TIWBSTabControl are still TIWTabPage
    else if LComponent.ClassName = 'TIWTabPage' then
      begin
        LRegion := TIWRegion(LComponent);
        if LRegion.LayoutMgr = nil then
          LRegion.LayoutMgr := TIWBSLayoutMgr.Create(AContainer.InterfaceInstance);
        LRegion.LayoutMgr.SetContainer(LRegion);
        PrepareChildComponentsForRender(LRegion);
      end;

    // disable child StyleRenderOptions
    LBaseControl := BaseControlInterface(LComponent);
    if Assigned(LBaseControl) then begin
      LHTML40Control := HTML40ControlInterface(AContainer.Component[i]);
      DisableRenderOptions(LHTML40Control.StyleRenderOptions);
    end;

    // execute global OnRender hook
    if Assigned(gIWBSOnRender) then
      gIWBSOnRender(LComponent);
  end;
end;

class procedure TIWBSRegionCommon.RenderComponents(AContainer: IIWBSContainer; AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
var
  LBuffer: TIWRenderStream;
  LContentTag: TIWBinaryElement;
  i, j: integer;
begin
  PrepareChildComponentsForRender(AContainer);
  AContainer.ContainerContext := AContainerContext;
  LBuffer := TIWRenderStream.Create(True, True);
  try
    THackTIWHTML40Container(AContainer.InterfaceInstance).CallInheritedRenderComponents(AContainerContext, APageContext);
    THackTIWHTML40Container(AContainer.InterfaceInstance).LayoutMgr.ProcessControls(AContainerContext, TIWBaseHTMLPageContext(APageContext));
    THackTIWHTML40Container(AContainer.InterfaceInstance).LayoutMgr.Process(LBuffer, AContainerContext, APageContext);

    // insert content before scripts
    LContentTag := TIWBinaryElement.Create(nil);
    LContentTag.Buffer.Stream.CopyFrom(LBuffer.Stream, 0);
    j := -1;
    for i := 0 to AContainer.RegionDiv.Contents.Count-1 do
      if AContainer.RegionDiv.Contents.Items[i] is TIWMarkupLanguageTag then
        if TIWMarkupLanguageTag(AContainer.RegionDiv.Contents.Items[i]).Tag = 'script' then
          j := i;
    if j >= 0 then
      AContainer.RegionDiv.Contents.Insert(j, LContentTag)
    else
      AContainer.RegionDiv.Contents.Add(LContentTag);
  finally
    THackTIWHTML40Container(AContainer.InterfaceInstance).LayoutMgr.SetContainer(nil);
    FreeAndNil(LBuffer);
  end;
end;

class procedure TIWBSRegionCommon.CancelChildAsyncRender(AControl: TComponent);
var
  i: integer;
  LComponent: IIWBSComponent;
  LContainer: IIWBaseContainer;
begin
  AControl.GetInterface(IIWBSComponent, LComponent);
  if LComponent <> nil then
    LComponent.ResetAsyncRefreshControl;

  if AControl is TFrame then
    for i := 0 to AControl.ComponentCount-1 do
      CancelChildAsyncRender(AControl.Components[i])
  else
    begin
      AControl.GetInterface(IIWBaseContainer, LContainer);
      if LContainer <> nil then
        for i := 0 to LContainer.IWComponentsCount-1 do
          CancelChildAsyncRender(LContainer.Component[i])
    end;
end;
{$endregion}

end.
