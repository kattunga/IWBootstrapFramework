unit IWBSInputForm;

interface

uses
  SysUtils, Classes, Controls, StrUtils,
  IWApplication, IWRenderContext, IWHTMLTag, IW.HTTP.Request, IW.HTTP.Reply,
  IWBSCommon, IWBSRestServer,
  IWBSCustomregion;

type
  TIWBSFormType = (bsftInline, bsftHorizontal, bsftVertical);

  TIWBSFormEncType = (iwbsfeDefault, iwbsfeMultipart, iwbsfeText);

  TIWBSInputFormSubmitEvent = procedure(aRequest: THttpRequest; aParams: TStrings) of object;

  TIWBSFormOptions = class(TPersistent)
  private
    FCaptionsSize: TIWBSGridOptions;
    FInputsSize: TIWBSGridOptions;
  protected
    procedure SetCaptionsSize(const Value: TIWBSGridOptions);
    procedure SetInputsSize(const Value: TIWBSGridOptions);
  public
    constructor Create;
    destructor Destroy; override;
    function GetOffsetClassString: string;
    procedure Assign(Source: TPersistent); override;
  published
    property CaptionsSize: TIWBSGridOptions read FCaptionsSize write SetCaptionsSize;
    property InputsSize: TIWBSGridOptions read FInputsSize write SetInputsSize;
  end;

  TIWBSInputForm = class(TIWBSCustomRegion)
  private
    FEncType: TIWBSFormEncType;
    FFormType: TIWBSFormType;
    FFormOptions: TIWBSFormOptions;
    FOnSubmit: TIWBSInputFormSubmitEvent;
    procedure DoSubmit(aApplication: TIWApplication; aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings);
  protected
    procedure InternalRenderCss(var ACss: string); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetRoleString: string; override;
  published
    property BSFormType: TIWBSFormType read FFormType write FFormType default bsftVertical;
    property BSFormOptions: TIWBSFormOptions read FFormOptions write FFormOptions;
    property EncType: TIWBSFormEncType read FEncType write FEncType default iwbsfeDefault;
    property OnSubmit: TIWBSInputFormSubmitEvent read FOnSubmit write FOnSubmit;
  end;

  TIWBSInputGroup = class(TIWBSCustomRegion)
  private
    FCaption: string;
    FRelativeSize: TIWBSRelativeSize;
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Caption: string read FCaption write FCaption;
    property BSRelativeSize: TIWBSRelativeSize read FRelativeSize write FRelativeSize default bsrzDefault;
  end;

  TIWBSFormControl = class(TIWBSCustomRegion)
  private
    FCaption: string;
  public
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Caption: string read FCaption write FCaption;
  end;

function IWBSFindParentInputForm(AParent: TControl): TIWBSInputForm;

implementation

uses
  IWBSInputCommon;

{$region 'help functions'}
function IWBSFindParentInputForm(AParent: TControl): TIWBSInputForm;
begin
  if AParent is TIWBSInputForm then
    Result := TIWBSInputForm(AParent)
  else if AParent.Parent <> nil then
    Result := IWBSFindParentInputForm(AParent.Parent)
  else
    Result := nil;
end;
{$endregion}

{$region 'TIWBSFormOptions'}
constructor TIWBSFormOptions.Create;
begin
  FCaptionsSize := TIWBSGridOptions.Create;
  FInputsSize := TIWBSGridOptions.Create;
end;

destructor TIWBSFormOptions.Destroy;
begin
  FreeAndNil(FCaptionsSize);
  FreeAndNil(FInputsSize);
  inherited;
end;

procedure TIWBSFormOptions.SetCaptionsSize(const Value: TIWBSGridOptions);
begin
  FCaptionsSize.Assign(Value);
end;

procedure TIWBSFormOptions.SetInputsSize(const Value: TIWBSGridOptions);
begin
  FInputsSize.Assign(Value);
end;

function TIWBSFormOptions.GetOffsetClassString: string;
begin
  Result := FCaptionsSize.GetGridClassString(
    FCaptionsSize.GridXSOffset+FCaptionsSize.GridXSSpan+FInputsSize.GridXSOffset,
    FCaptionsSize.GridSMOffset+FCaptionsSize.GridSMSpan+FInputsSize.GridSMOffset,
    FCaptionsSize.GridMDOffset+FCaptionsSize.GridMDSpan+FInputsSize.GridMDOffset,
    FCaptionsSize.GridLGOffset+FCaptionsSize.GridLGSpan+FInputsSize.GridLGOffset,
    FInputsSize.GridXSSpan,
    FInputsSize.GridSMSpan,
    FInputsSize.GridMDSpan,
    FInputsSize.GridLGSpan);
end;

procedure TIWBSFormOptions.Assign(Source: TPersistent);
begin
  if Source is TIWBSFormOptions then
    begin
      CaptionsSize.Assign(TIWBSFormOptions(Source).CaptionsSize);
      InputsSize.Assign(TIWBSFormOptions(Source).InputsSize);
    end
  else
    inherited;
end;
{$endregion}

{$region 'TIWBSInputForm'}
constructor TIWBSInputForm.Create(AOwner: TComponent);
begin
  inherited;
  FEncType := iwbsfeDefault;
  FFormOptions := TIWBSFormOptions.Create;
  FFormType := bsftVertical;
  FTagType := 'form'
end;

destructor TIWBSInputForm.Destroy;
begin
  FreeAndNil(FFormOptions);
  inherited;
end;

procedure TIWBSInputForm.InternalRenderCss(var ACss: string);
begin
  if FFormType = bsftInline then
    TIWBSCommon.AddCssClass(ACss, 'form-inline')
  else if FFormType = bsftHorizontal then
    TIWBSCommon.AddCssClass(ACss, 'form-horizontal');
  inherited;
end;

function TIWBSInputForm.GetRoleString: string;
begin
  Result := 'form';
end;

procedure TIWBSInputForm.DoSubmit(aApplication: TIWApplication; aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings);
begin
  if Assigned(FOnSubmit) then
    FOnSubmit(aRequest, aParams);
  aReply.SendRedirect(aApplication.SessionInternalUrlBase);
end;

function TIWBSInputForm.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  LParentForm: TIWBSInputForm;
begin
  LParentForm := IWBSFindParentInputForm(Parent);
  if LParentForm <> nil then
    raise Exception.Create('forms can not be nested, you try to put '+Name+' inside '+LParentForm.Name);

  Result := inherited;

  if Assigned(FOnSubmit) then
    begin
      Result.AddStringParam('method', 'post');
      if FEncType = iwbsfeMultipart then
        Result.AddStringParam('enctype', 'multipart/form-data')
      else if FEncType = iwbsfeText then
        Result.AddStringParam('enctype', 'text/plain');
      Result.AddStringParam('action', IWBSRegisterRestCallBack(AContext.WebApplication, HTMLName+'.FormSubmit', DoSubmit, (FEncType = iwbsfeMultipart)));
    end
  else
    Result.AddStringParam('onSubmit', 'return FormDefaultSubmit();');
end;
{$endregion}

{$region 'TIWBSInputGroup'}
constructor TIWBSInputGroup.Create(AOwner: TComponent);
begin
  inherited;
  FRelativeSize := bsrzDefault;
end;

procedure TIWBSInputGroup.InternalRenderCss(var ACss: string);
begin
  TIWBSCommon.AddCssClass(ACss, 'input-group');
  if FRelativeSize <> bsrzDefault then
    TIWBSCommon.AddCssClass(ACss, 'input-group-'+aIWBSRelativeSize[FRelativeSize]);
  inherited;
end;

function TIWBSInputGroup.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result := IWBSCreateInputFormGroup(Self, Parent, Result, FCaption, HTMLName);
end;
{$endregion}

{$region 'TIWBSFormControl'}
function TIWBSFormControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := Inherited;
  Result := IWBSCreateInputFormGroup(Self, Parent, Result, FCaption, HTMLName);
end;
{$endregion}


end.
