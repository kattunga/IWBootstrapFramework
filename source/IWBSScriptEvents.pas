unit IWBSScriptEvents;

interface

uses System.Classes, System.SysUtils, System.StrUtils,
     IWScriptEvents, IWRenderContext, IWHTMLTag, IWHTML40Interfaces, IWBSCommon;

procedure IWBSRenderScript(AComponent: IIWBSComponent; AComponentContext: TIWCompContext; AHTMLTag: TIWHTMLTag);

implementation

uses IW.Common.Strings, IWBaseInterfaces, IWBSGlobal, IWBSCustomEvents;

type
  TIWBSScriptEvents = class(IWScriptEvents.TIWScriptEvents)
  end;

function RenderScriptEvents(const AHTMLName: string; AScriptEvents: TIWScriptEvents; APageContext: TIWPageContext40): string;
var
  LScriptEvents: TIWBSScriptEvents;
  i: Integer;
  LEventName, LFuncCode: string;
  LInitProc: string;
//  j: integer;
//  LJavaScript: string;
begin
  LScriptEvents := TIWBSScriptEvents(AScriptEvents);

  Result := '';
  LInitProc := '';
  if (LScriptEvents.Count > 0) or (LScriptEvents.DefaultHandlers <> '') or (not LScriptEvents.FProperties.IsEmpty) then begin
    for i := 0 to LScriptEvents.Count - 1 do begin
      LEventName := LowerCase(LScriptEvents.Items[i].EventName);
      if Pos('on', LEventName) = 1 then
        Delete(LEventName, 1, 2);
      LFuncCode := Trim(LScriptEvents.Items[i].EventCode.Text);
      Result := Result+'$("#'+AHtmlName+'").off("'+LEventName+'").on("'+LEventName+'", function(event) {'+LFuncCode+'});'#13#10;

// I don't know if this is necesary
//      for j := 0 to LScriptEvents.HookedCount[i] - 1 do begin
//        LFuncCode := LScriptEvents.HookedCode[i, j];  // don't need to "fix" Hooked code
//        LJavaScript := 'function ' + LFuncName + IntToStr(j) + LFuncParams + ' {' + EOL + LFuncCode + '}' + EOL;
//        APageContext.AddToJavaScriptOnce(LJavaScript);
//        LInitProc := LInitProc + '  ' + LHtmlName + 'IWCL.HookEvent("' + LEventName + '",' + LFuncName + IntToStr(j) + ');' + EOL;
//      end;
    end;

    if LScriptEvents.FDefaultHandlers <> '' then begin
      RemoveTrailingChars(LScriptEvents.FDefaultHandlers, ';');
      LInitProc := LInitProc + AHtmlName + 'IWCL.HookDefaultHandlers("' + LScriptEvents.FDefaultHandlers + '");' + EOL;
    end;

    if not LScriptEvents.FProperties.IsEmpty then
      LInitProc := LInitProc + '  ' + AHtmlName + 'IWCL.SetProps(' + LScriptEvents.FProperties.Data+');' + EOL;

    if LInitProc <> '' then
      APageContext.AddToIWCLInitProc('  if (' + AHtmlName+'IWCL) {' + EOL + '    ' + LInitProc + '  }');
  end;
end;

procedure IWBSRenderScript(AComponent: IIWBSComponent; AComponentContext: TIWCompContext; AHTMLTag: TIWHTMLTag);
var
  LHTMLName: string;
  LPageContext: TIWPageContext40;
  LSubmitOnAsync: boolean;
  LInputInterface: IIWInputControl40;
  LInitProcCode: string;
  LJScript: string;
  LComponentScript: string;
  I: Integer;
begin
  LHTMLName := AComponent.HTMLName;
  LPageContext := TIWPageContext40(AComponentContext.PageContext);

  LSubmitOnAsync := False;
  if AComponent.SupportsInput then begin
    LInputInterface := InputControl40Interface(AComponent.InterfaceInstance);
    if Assigned(LInputInterface) then
      LSubmitOnAsync := LInputInterface.SubmitOnAsyncEvent;
  end;

  LInitProcCode := '  IW.initIWCL('+AComponent.HTMLControlImplementation.IWCLParentName+',"'+LHTMLName+'",'+BoolToString(LSubmitOnAsync)+');';
  LPageContext.AddToIWCLInitProc(LInitProcCode);

  AComponent.ScriptEvents.ClearHooked;
  AComponent.ScriptEvents.Rendering := True;
  try
    AComponent.HookEvents(LPageContext, AComponent.ScriptEvents);
    AComponent.HintEvents(AHTMLTag);

    LJScript := RenderScriptEvents(LHTMLName, AComponent.ScriptEvents, LPageContext);

    LComponentScript := AComponent.InternalRenderScript;
    if LComponentScript <> '' then begin
      if LJScript <> '' then
        LJScript := LJScript+#13#10;
      LJScript := LJScript+LComponentScript;
    end;

    if AComponent.IsStoredCustomAsyncEvents then
      for i := 0 to AComponent.CustomAsyncEvents.Count-1 do begin
        TIWBSCustomAsyncEvent(AComponent.CustomAsyncEvents.Items[i]).RegisterEvent(AComponentContext.WebApplication, LHTMLName);
        LJScript := TIWBSCustomAsyncEvent(AComponent.CustomAsyncEvents.Items[i]).ParseParamEvent(LJScript);
      end;

    if AComponent.IsStoredCustomRestEvents then
      for i := 0 to AComponent.CustomRestEvents.Count-1 do begin
        TIWBSCustomRestEvent(AComponent.CustomRestEvents.Items[i]).RegisterEvent(AComponentContext.WebApplication, LHTMLName);
        LJScript := TIWBSCustomRestEvent(AComponent.CustomRestEvents.Items[i]).ParseParamEvent(LJScript);
      end;

    if LJScript <> '' then
      AHTMLTag.Contents.AddTag('script').Contents.AddText(LJScript);
  finally
    AComponent.ScriptEvents.Rendering := False;
    AComponent.ScriptEvents.ClearHooked;
  end;
end;

end.
