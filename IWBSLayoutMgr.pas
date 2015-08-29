unit IWBSLayoutMgr;

interface

uses
  System.Classes, System.SysUtils, Vcl.Controls,
  IWContainerLayout, IWRenderContext, IWBaseHTMLInterfaces, IWBaseRenderContext, IW.Common.RenderStream, IWHTMLTag,
  IWBSCommon;

type
  TIWBSLayoutMgr = class(TIWContainerLayout)
  protected
    procedure InitControl; override;
  private
    FFormType: TIWBSFormType;
  public
    constructor Create(AOnwer: TComponent); override;
    procedure ProcessControl(AContainerContext: TIWContainerContext; APageContext: TIWBaseHTMLPageContext; AControl: IIWBaseHTMLComponent); override;
    procedure ProcessForm(ABuffer, ATmpBuf: TIWRenderStream; APage: TIWBasePageContext);
    procedure Process(ABuffer: TIWRenderStream; AContainerContext: TIWContainerContext; aPage: TIWBasePageContext); override;
  published
    property BSFormType: TIWBSFormType read FFormType write FFormType default bsftVertical;
  end;

implementation

uses
  IWBaseForm, IWGlobal, IWHTML40Interfaces, IWTypes, IWHTMLContainer, IWBaseInterfaces, IWBaseControl, IWLists,
  IWRegion, IWCompTabControl,
  IWBSRegion, IWBSTabControl;

constructor TIWBSLayoutMgr.Create(AOnwer: TComponent);
begin
  inherited;
  FFormType := bsftNoForm;
end;

procedure TIWBSLayoutMgr.InitControl;
begin
  inherited;
  SetAllowFrames(true);
  SetLayoutType(ltFlow);
end;

procedure TIWBSLayoutMgr.ProcessForm(ABuffer, ATmpBuf: TIWRenderStream; APage: TIWBasePageContext);
var
  LPageContext: TIWPageContext40;
  LTerminated: Boolean;
begin
  LPageContext := TIWPageContext40(APage);
  LTerminated := Assigned(LPageContext.WebApplication) and LPageContext.WebApplication.Terminated;

  // check if internal jquery is disable and also check if IW version is 14.0.38 or above.
  if gSC.JavaScriptOptions.RenderjQuery then
    raise Exception.Create('Please, disable JavaScriptOptions.RenderjQuery option in server controler');

  ABuffer.WriteLine(LPageContext.DocType);
  ABuffer.WriteLine(gHtmlStart);
  ABuffer.WriteLine('<title>' + LPageContext.Title + '</title>');
  if gSC.PageTransitions then
    ABuffer.WriteLine('<meta http-equiv="Page-Enter" content="blendTrans(Duration=0.25)">');
  ABuffer.WriteLine(PreHeadContent);
  ABuffer.WriteLine(ScriptSection(LPageContext));
  ABuffer.WriteLine(HeadContent);
  if LPageContext.StyleTag.Contents.Count > 0 then
    LPageContext.StyleTag.Render(ABuffer);
  ABuffer.WriteLine('</head>');
  if not LTerminated then
    LPageContext.FormTag.Render(ATmpBuf);
  LPageContext.BodyTag.Contents.AddBuffer(ATmpBuf);
  LPageContext.BodyTag.Render(ABuffer);
  ABuffer.WriteLine('</html>');
end;

function ControlRenderingSort(AItem1: Pointer; AItem2: Pointer): Integer;
var
  LTop1, LLeft1, LTop2, LLeft2: integer;
begin
  if TComponent(AItem1) is TControl then
    begin
      LTop1 := TControl(AItem1).Top;
      LLeft1 := TControl(AItem1).Left;
    end
  else
    begin
      LTop1 := -1;
      LLeft1 := -1;
    end;
  if TComponent(AItem1) is TControl then
    begin
      LTop2 := TControl(AItem2).Top;
      LLeft2 := TControl(AItem2).Left;
    end
  else
    begin
      LTop2 := -1;
      LLeft2 := -1;
    end;

  if aIWBSRenderingSortMethod = bsrmSortYX then
    begin
      Result := LTop1 - LTop2;
      if Abs(Result) < aIWBSRenderingGridPrecision then
        Result := LLeft1 - LLeft2;
    end
  else
    begin
      Result := LLeft1 - LLeft2;
      if Abs(Result) < aIWBSRenderingGridPrecision then
        Result := LTop1 - LTop2;
    end;
end;

procedure TIWBSLayoutMgr.Process(ABuffer: TIWRenderStream; AContainerContext: TIWContainerContext; aPage: TIWBasePageContext);
var
  LTmp: TIWRenderStream;
  LControls: TList;
  i: Integer;
  LComponent: IIWBaseHTMLComponent;
  xCompContext: TIWCompContext;
  LHTML: TIWHTMLTag;
begin
  LTmp := TIWRenderStream.Create(True, True);
  try

    // TIWBSTabControl
    if Container.InterfaceInstance is TIWBSTabControl then
      LTmp.WriteLine('<div class="tab-content">');

    // input form
    if FFormType <> bsftNoForm then begin
      LTmp.Write('<form ');
      if FFormType = bsftInline then
        Ltmp.Write('class="form-inline" ')
      else if FFormType = bsftHorizontal then
        Ltmp.Write('class="form-horizontal" ');
      LTmp.Write(' role="form" onSubmit="return FormDefaultSubmit();">');
    end;

    // render controls
    LControls := TList.Create;
    try
      for i := 0 to AContainerContext.ComponentsCount - 1 do
        LControls.Add(AContainerContext.ComponentsList[i]);
      MergeSortList(LControls, ControlRenderingSort);

      for i := 0 to LControls.Count - 1 do begin
        if isBaseComponent(LControls[i]) then begin
          LComponent := BaseHTMLComponentInterface(LControls[I]);

          xCompContext := TIWCompContext(AContainerContext.ComponentContext[LComponent.HTMLName]);
          if not aContainerContext.CacheControls then begin
            xCompContext.HTMLTag.Free;
            xCompContext.HTMLTag := TIWHTMLTag(BaseComponentInterface(xCompContext.Component).RenderMarkupLanguageTag(xCompContext));
          end;
          LHTML := xCompContext.HTMLTag;

          if LHTML <> nil then
            LComponent.MakeHTMLTag(LHTML, LTmp);
        end;
      end;
    finally
      LControls.Free;
    end;

    // close input form
    if FFormType <> bsftNoForm then
      LTmp.Write('</form>');

    // close tabs
    if Container.InterfaceInstance is TIWBSTabControl then
      LTmp.WriteLine('</div>');

    // write to buffer
    if Container.InterfaceInstance is TIWBaseForm then
      ProcessForm(aBuffer, LTmp, aPage)
    else
      aBuffer.Stream.CopyFrom(LTmp.Stream, 0);

  finally
    LTmp.Free;
  end;
end;

procedure TIWBSLayoutMgr.ProcessControl(AContainerContext: TIWContainerContext; APageContext: TIWBaseHTMLPageContext; AControl: IIWBaseHTMLComponent);
var
  LHTML: TIWHTMLTag;
  LControlContext: TIWCompContext;
begin
  // TIWTabPage
  LControlContext := TIWCompContext(AContainerContext.ComponentContext[AControl.HTMLName]);
  LHTML := LControlContext.HTMLTag;
  if Assigned(LHTML) then
    if AControl.InterfaceInstance.ClassName = 'TIWTabPage' then
      begin
        LHTML.AddStringParam('ID', AControl.HTMLName);
        LHTML.AddClassParam(IWBSCommon.TIWTabPage(AControl.InterfaceInstance).CSSClass);
        Exit;
      end;

  inherited;
end;

end.
