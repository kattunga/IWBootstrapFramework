unit IWBSInputForm;

interface

uses
  SysUtils, Classes, Controls, StrUtils,
  IWApplication, IWRenderContext, IWHTMLTag, IW.HTTP.Request, IW.HTTP.Reply, IWBaseInterfaces,
  IWBSCommon, IWBSRestServer,
  IWBSCustomregion;

type
  TIWBSFormType = (bsftInline, bsftHorizontal, bsftVertical);

  TIWBSFormEncType = (bsfeDefault, bsfeMultipart, bsfeText);

  TIWBSInputFormSubmitEvent = procedure(aRequest: THttpRequest; aParams: TStrings) of object;

  TIWBSFormOptions = class(TPersistent)
  private
    FCaptionsSize: TIWBSGridOptions;
    FInputsSize: TIWBSGridOptions;
  protected
    procedure SetCaptionsSize(const Value: TIWBSGridOptions);
    procedure SetInputsSize(const Value: TIWBSGridOptions);
  public
    constructor Create(AOwner: IIWBaseControl);
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
    procedure SetEncType(const Value: TIWBSFormEncType);
    procedure SetFormType(const Value: TIWBSFormType);
  protected
    procedure InternalRenderCss(var ACss: string); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetRoleString: string; override;
  published
    property BSFormType: TIWBSFormType read FFormType write SetFormType default bsftVertical;
    property BSFormOptions: TIWBSFormOptions read FFormOptions write FFormOptions;
    property EncType: TIWBSFormEncType read FEncType write SetEncType default bsfeDefault;
    property OnSubmit: TIWBSInputFormSubmitEvent read FOnSubmit write FOnSubmit;
  end;

  TIWBSInputGroup = class(TIWBSCustomRegion)
  private
    FCaption: string;
    FRelativeSize: TIWBSRelativeSize;
    procedure SetCaption(const Value: string);
    procedure SetRelativeSize(const Value: TIWBSRelativeSize);
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Caption: string read FCaption write SetCaption;
    property BSRelativeSize: TIWBSRelativeSize read FRelativeSize write SetRelativeSize default bsrzDefault;
  end;

  TIWBSFormControl = class(TIWBSCustomRegion)
  private
    FCaption: string;
    procedure SetCaption(const Value: string);
  public
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Caption: string read FCaption write SetCaption;
  end;

function IWBSFindParentInputForm(AParent: TControl): TIWBSInputForm;

implementation

uses
  IWBSInputCommon, IWBSNavBar;

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
constructor TIWBSFormOptions.Create(AOwner: IIWBaseControl);
begin
  FCaptionsSize := TIWBSGridOptions.Create(AOwner);
  FInputsSize := TIWBSGridOptions.Create(AOwner);
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
  Result := FInputsSize.GetClassString(
    FCaptionsSize.GridXSOffset+FCaptionsSize.GridXSSpan,
    FCaptionsSize.GridSMOffset+FCaptionsSize.GridSMSpan,
    FCaptionsSize.GridMDOffset+FCaptionsSize.GridMDSpan,
    FCaptionsSize.GridLGOffset+FCaptionsSize.GridLGSpan);
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
  FEncType := bsfeDefault;
  FFormOptions := TIWBSFormOptions.Create(Self);
  FFormType := bsftVertical;
  FTagName := 'form'
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
  if (Parent is TIWBSNavBarBase) then
    TIWBSCommon.AddCssClass(ACss, 'navbar-form');
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
      if FEncType = bsfeMultipart then
        Result.AddStringParam('enctype', 'multipart/form-data')
      else if FEncType = bsfeText then
        Result.AddStringParam('enctype', 'text/plain');
      Result.AddStringParam('action', IWBSRegisterRestCallBack(AContext.WebApplication, HTMLName+'.FormSubmit', DoSubmit, (FEncType = bsfeMultipart)));
    end
  else
    Result.AddStringParam('onSubmit', 'return FormDefaultSubmit();');
end;
procedure TIWBSInputForm.SetEncType(const Value: TIWBSFormEncType);
begin
  FEncType := Value;
  Invalidate;
end;

procedure TIWBSInputForm.SetFormType(const Value: TIWBSFormType);
begin
  FFormType := Value;
  Invalidate;
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
  FMainID := Result.Params.Values['id'];
end;
procedure TIWBSInputGroup.SetCaption(const Value: string);
begin
  FCaption := Value;
  Invalidate;
end;

procedure TIWBSInputGroup.SetRelativeSize(const Value: TIWBSRelativeSize);
begin
  FRelativeSize := Value;
  Invalidate;
end;

{$endregion}

{$region 'TIWBSFormControl'}
function TIWBSFormControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := Inherited;
  Result := IWBSCreateInputFormGroup(Self, Parent, Result, FCaption, HTMLName);
end;
{$endregion}

procedure TIWBSFormControl.SetCaption(const Value: string);
begin
  FCaption := Value;
  Invalidate;
end;

end.
