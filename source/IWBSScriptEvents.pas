unit IWBSScriptEvents;

interface

uses Classes, SysUtils, StrUtils,
     IWScriptEvents, IWRenderContext, IWHTMLTag, IWHTML40Interfaces, IWBSCommon, IWBSCommonInterfaces;

procedure IWBSRenderScript(AComponent: IIWBSComponent; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);

implementation

uses IW.Common.Strings, IWBaseInterfaces, IWBSCustomEvents;

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

      // legacy IW events, declare only content of the function
      if AnsiStartsText('on', LScriptEvents.Items[i].EventName) then
        begin
          LEventName := LowerCase(LScriptEvents.Items[i].EventName);
          if Pos('on', LEventName) = 1 then
            Delete(LEventName, 1, 2);
          LFuncCode := 'function(event) { '+Trim(LScriptEvents.Items[i].EventCode.Text)+ '}';
        end

      // new way, full funtion declaration
      else
        begin
          if AnsiStartsStr('"', LScriptEvents.Items[i].EventName) then
            LEventName := AnsiDequotedStr(LScriptEvents.Items[i].EventName,'"')
          else
            LEventName := LScriptEvents.Items[i].EventName;
          LFuncCode := Trim(LScriptEvents.Items[i].EventCode.Text);
        end;
      AScript.Add('$("#'+AHtmlName+'").off("'+LEventName+'").on("'+LEventName+'", '+LFuncCode+');');
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

procedure IWBSRenderScript(AComponent: IIWBSComponent; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  LHTMLName: string;
  LPageContext: TIWPageContext40;
  LSubmitOnAsync: boolean;
  LInputInterface: IIWInputControl40;
  LInitProcCode: string;
  LJScript: TstringList;
  I: Integer;
  LHTMLTag: TIWHTMLTag;
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

    if LJScript.Count > 0 then
      LJScript.Text := TIWBSCommon.ReplaceParams(AComponent, LJScript.Text);

    if AComponent.IsStoredCustomAsyncEvents then begin
      for i := 0 to AComponent.CustomAsyncEvents.Count-1 do begin
        AComponent.CustomAsyncEvents.Items[i].RegisterEvent(AContext.WebApplication, LHTMLName);
        AComponent.CustomAsyncEvents.Items[i].ParseParam(LHTMLName, LJScript);
        if AComponent.CustomAsyncEvents.Items[i].AutoBind and (AComponent.CustomAsyncEvents.Items[i].EventName <> '') then
          LJScript.Add('$("#'+LHTMLName+'").off("'+AComponent.CustomAsyncEvents.Items[i].EventName+'").on("'+AComponent.CustomAsyncEvents.Items[i].EventName+'", function('+AComponent.CustomAsyncEvents.Items[i].EventParams+') {'+AComponent.CustomAsyncEvents.Items[i].GetScript(LHTMLName)+'});');
      end;
      LJScript.Text := TIWBSCommon.ReplaceParams(AComponent, LJScript.Text);
    end;

    if AComponent.IsStoredCustomRestEvents then
      for i := 0 to AComponent.CustomRestEvents.Count-1 do begin
        AComponent.CustomRestEvents.Items[i].RegisterEvent(AContext.WebApplication, LHTMLName);
        AComponent.CustomRestEvents.Items[i].ParseParam(LJScript);
      end;

    if LJScript.Count > 0 then begin
      if not AComponent.ScriptInsideTag then begin
        LHTMLTag := TIWHTMLTag.CreateTag('div');
        LHTMLTag.AddStringParam('id',LHTMLName+'_WRP');
        LHTMLTag.Contents.AddTagAsObject(AHTMLTag);
        AHTMLTag := LHTMLTag;
      end;
      AHTMLTag.Contents.AddTag('script').Contents.AddText(LJScript.Text);
    end;

  finally
    LJScript.Free;
    AComponent.ScriptEvents.Rendering := False;
    AComponent.ScriptEvents.ClearHooked;
  end;
end;

end.
