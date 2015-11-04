unit IWBSScriptEvents;

interface

uses System.Classes, System.SysUtils, System.StrUtils,
     IWScriptEvents, IWRenderContext, IWHTMLTag, IWHTML40Interfaces, IWBSCommon;

procedure IWBSRenderScript(AComponent: IIWBSComponent; AContext: TIWCompContext; AHTMLTag: TIWHTMLTag);

implementation

uses IW.Common.Strings, IWBaseInterfaces, IWBSGlobal, IWBSCustomEvents;

type
  TIWBSScriptEvents = class(IWScriptEvents.TIWScriptEvents)
  end;

procedure RenderScriptEvents(const AHTMLName: string; AScriptEvents: TIWScriptEvents; APageContext: TIWPageContext40; AScript: TStringList);
var
  LScriptEvents: TIWBSScriptEvents;
  i: Integer;
  LEventName, LFuncCode: string;
  LInitProc: string;
begin
  LScriptEvents := TIWBSScriptEvents(AScriptEvents);

  LInitProc := '';
  if (LScriptEvents.Count > 0) or (LScriptEvents.DefaultHandlers <> '') or (not LScriptEvents.FProperties.IsEmpty) then begin
    for i := 0 to LScriptEvents.Count - 1 do begin
      LEventName := LowerCase(LScriptEvents.Items[i].EventName);
      if Pos('on', LEventName) = 1 then
        Delete(LEventName, 1, 2);
      LFuncCode := Trim(LScriptEvents.Items[i].EventCode.Text);
      AScript.Add('$("#'+AHtmlName+'").off("'+LEventName+'").on("'+LEventName+'", function(event) {'+LFuncCode+'});');
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

procedure IWBSRenderScript(AComponent: IIWBSComponent; AContext: TIWCompContext; AHTMLTag: TIWHTMLTag);
var
  LHTMLName: string;
  LPageContext: TIWPageContext40;
  LSubmitOnAsync: boolean;
  LInputInterface: IIWInputControl40;
  LInitProcCode: string;
  LJScript: TstringList;
  I: Integer;
begin
  LHTMLName := AComponent.HTMLName;
  LPageContext := TIWPageContext40(AContext.PageContext);

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
  LJScript := TStringList.Create;
  try
    AComponent.HookEvents(LPageContext, AComponent.ScriptEvents);
    AComponent.HintEvents(AHTMLTag);

    RenderScriptEvents(LHTMLName, AComponent.ScriptEvents, LPageContext, LJScript);

    AComponent.InternalRenderScript(AContext, LHTMLName, LJScript);

    LJScript.AddStrings(AComponent.Script);

    TIWBSCommon.ReplaceParams(LHTMLName, LJScript, AComponent.ScriptParams);

    if AComponent.IsStoredCustomAsyncEvents then
      for i := 0 to AComponent.CustomAsyncEvents.Count-1 do begin
        TIWBSCustomAsyncEvent(AComponent.CustomAsyncEvents.Items[i]).RegisterEvent(AContext.WebApplication, LHTMLName);
        TIWBSCustomAsyncEvent(AComponent.CustomAsyncEvents.Items[i]).ParseParamEvent(LJScript);
      end;

    if AComponent.IsStoredCustomRestEvents then
      for i := 0 to AComponent.CustomRestEvents.Count-1 do begin
        TIWBSCustomRestEvent(AComponent.CustomRestEvents.Items[i]).RegisterEvent(AContext.WebApplication, LHTMLName);
        TIWBSCustomRestEvent(AComponent.CustomRestEvents.Items[i]).ParseParamEvent(LJScript);
      end;

    if LJScript.Count > 0 then
      AHTMLTag.Contents.AddTag('script').Contents.AddText(LJScript.Text);
  finally
    LJScript.Free;
    AComponent.ScriptEvents.Rendering := False;
    AComponent.ScriptEvents.ClearHooked;
  end;
end;

end.
