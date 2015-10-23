unit IWBSCommon;

interface

uses System.Classes, System.SysUtils, System.SyncObjs,
     IWRenderContext, IWControl, IWHTML40Interfaces;

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
  TIWBSGridOptions = class(TPersistent)
  private
    FGridXSOffset: integer;
    FGridXSSpan: integer;
    FGridSMOffset: integer;
    FGridSMSpan: integer;
    FGridMDOffset: integer;
    FGridMDSpan: integer;
    FGridLGOffset: integer;
    FGridLGSpan: integer;
  public
    constructor Create;
    function GetClassString: string;

    class function GetGridClassString(AGridXSOffset, AGridSMOffset, AGridMDOffset, AGridLGOffset, AGridXSSpan, AGridSMSpan, AGridMDSpan, AGridLGSpan: integer): string;
  published
    property GridXSOffset: integer read FGridXSOffset write FGridXSOffset default 0;
    property GridXSSpan: integer read FGridXSSpan write FGridXSSpan default 0;
    property GridSMOffset: integer read FGridSMOffset write FGridSMOffset default 0;
    property GridSMSpan: integer read FGridSMSpan write FGridSMSpan default 0;
    property GridMDOffset: integer read FGridMDOffset write FGridMDOffset default 0;
    property GridMDSpan: integer read FGridMDSpan write FGridMDSpan default 0;
    property GridLGOffset: integer read FGridLGOffset write FGridLGOffset default 0;
    property GridLGSpan: integer read FGridLGSpan write FGridLGSpan default 0;
  end;

  IIWBSComponent = interface(IIWHTML40Control)
    ['{12925CB3-58EC-4B56-B032-478892548906}']
    function InternalRenderScript: string;
    function HTMLControlImplementation: TIWHTMLControlImplementation;
  end;

procedure SetAsyncDisabled(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
procedure SetAsyncReadOnly(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
procedure SetAsyncVisible(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
procedure SetAsyncClass(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
procedure SetAsyncStyle(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
procedure SetAsyncChecked(AContext: TIWCompContext; const HTMLName: string; const Value: boolean; var OldValue: boolean);
procedure SetAsyncText(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
procedure SetAsyncHtml(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);

implementation

uses IW.Common.System, IWBaseHTMLControl;

{$region 'TIWBSGridOptions'}
constructor TIWBSGridOptions.Create;
begin
  FGridXSOffset := 0;
  FGridXSSpan   := 0;
  FGridSMOffset := 0;
  FGridSMSpan   := 0;
  FGridMDOffset := 0;
  FGridMDSpan   := 0;
  FGridLGOffset := 0;
  FGridLGSpan   := 0;
end;

class function TIWBSGridOptions.GetGridClassString(AGridXSOffset, AGridSMOffset, AGridMDOffset, AGridLGOffset, AGridXSSpan, AGridSMSpan, AGridMDSpan, AGridLGSpan: integer): string;
  procedure AddCssValue(var s: string; const Value: string);
  begin
    if s <> '' then
      s := s + ' ';
    s := s + Value;
  end;
begin
  Result := '';
  if AGridXSOffset > 0 then
    AddCssValue(Result, 'col-xs-offset-'+IntToStr(AGridXSOffset));
  if AGridSMOffset > 0 then
    AddCssValue(Result, 'col-sm-offset-'+IntToStr(AGridSMOffset));
  if AGridMDOffset > 0 then
    AddCssValue(Result, 'col-md-offset-'+IntToStr(AGridMDOffset));
  if AGridLGOffset > 0 then
    AddCssValue(Result, 'col-lg-offset-'+IntToStr(AGridLGOffset));

  if (AGridXSSpan > 0) then
    AddCssValue(Result, 'col-xs-'+IntToStr(AGridXSSpan));
  if (AGridSMSpan > 0) then
    AddCssValue(Result, 'col-sm-'+IntToStr(AGridSMSpan));
  if (AGridMDSpan > 0) then
    AddCssValue(Result, 'col-md-'+IntToStr(AGridMDSpan));
  if (AGridLGSpan > 0) then
    AddCssValue(Result, 'col-lg-'+IntToStr(AGridLGSpan));
end;

function TIWBSGridOptions.GetClassString: string;
begin
  Result := GetGridClassString(FGridXSOffset, FGridSMOffset, FGridMDOffset, FGridLGOffset, FGridXSSpan, FGridSMSpan, FGridMDSpan, FGridLGSpan);
end;
{$endregion}

{$region 'AsyncRender functions'}
procedure SetAsyncDisabled(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").prop("disabled",'+iif(Value,'true','false')+');');
    OldValue := Value;
  end;
end;

procedure SetAsyncReadOnly(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").prop("readonly",'+iif(Value,'true','false')+');');
    OldValue := Value;
  end;
end;

procedure SetAsyncVisible(AContext: TIWCompContext; const HTMLName: string; Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").css("visibility","'+iif(Value,'','hidden')+'");');
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").css("display","'+iif(Value,'','none')+'");');
    OldValue := Value;
  end;
end;

procedure SetAsyncText(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").val("'+TIWBaseHTMLControl.TextToJSStringLiteral(Value)+'");');
    OldValue := Value;
  end;
end;

procedure SetAsyncHtml(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").html("'+TIWBaseHTMLControl.TextToJSStringLiteral(Value)+'");');
    OldValue := Value;
  end;
end;

procedure SetAsyncClass(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").toggleClass("'+Value+'");');
    OldValue := Value;
  end;
end;

procedure SetAsyncStyle(AContext: TIWCompContext; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").prop("style","'+Value+'");');
    OldValue := Value;
  end;
end;

procedure SetAsyncChecked(AContext: TIWCompContext; const HTMLName: string; const Value: boolean; var OldValue: boolean);
begin
  if OldValue <> Value then begin
    AContext.WebApplication.CallBackResponse.AddJavaScriptToExecute('$("#'+HTMLName+'").prop("checked",'+iif(Value,'true','false')+');');
    OldValue := Value;
  end;
end;
{$endregion}

end.
