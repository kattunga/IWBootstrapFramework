unit IWBSInputCommon;

interface

uses System.Classes, System.SysUtils, System.SyncObjs, Vcl.Controls, IWVCLBaseControl, IWBSRegion,
     IWRenderContext, IWHTMLTag;

function IWBSCreateFormGroup(AParent: TControl; AParentForm: TIWBSInputForm; ATag: TIWHTMLTag; const AHTMLName: string; ASpanDiv: boolean): TIWHTMLTag;
function IWBSCreateInputFormGroup(AControl, AParent: TControl; ATag: TIWHTMLTag; const ACaption, AHTMLName: string): TIWHTMLTag;
function IWBSCreateCheckBoxFormGroup(AParent: TControl; ATag: TIWHTMLTag; const ACss, ACaption, AHint, AHTMLName: string; AShowHint: boolean): TIWHTMLTag;
function IWBSCreateInputGroupAddOn(ATag: TIWHTMLTag; const AHTMLName, css: string): TIWHTMLTag;

implementation

uses IWBSRegionCommon, IWBaseHTMLControl;

{$region 'FormGroup functions'}
function IWBSCreateFormGroup(AParent: TControl; AParentForm: TIWBSInputForm; ATag: TIWHTMLTag; const AHTMLName: string; ASpanDiv: boolean): TIWHTMLTag;
var
  LSpanDiv: TIWHTMLTag;
begin
  if (AParentForm <> nil) and not ((AParent is TIWBSRegion) and (TIWBSRegion(AParent).BSRegionType in [bsrtFormGroup,bsrtButtonGroup])) then
    begin
      Result := TIWHTMLTag.CreateTag('div');
      Result.AddClassParam('form-group');
      Result.AddStringParam('id',AHTMLName+'_FG');
      if ASpanDiv and (AParentForm.BSFormType = bsftHorizontal) then
        begin
          LSpanDiv := Result.Contents.AddTag('div');
          LSpanDiv.AddClassParam(AParentForm.BSFormOptions.GetOffsetClassString);
          LSpanDiv.Contents.AddTagAsObject(aTag);
        end
      else
        Result.Contents.AddTagAsObject(aTag);
    end
  else
    Result := ATag;
end;

function IWBSCreateInputFormGroup(AControl, AParent: TControl; ATag: TIWHTMLTag; const ACaption, AHTMLName: string): TIWHTMLTag;
var
  lablTag, editTag: TIWHTMLTag;
  ParentForm: TIWBSInputForm;
begin
  ParentForm := IWBSFindParentInputForm(AParent);
  if ACaption <> '' then
    begin
      Result := TIWHTMLTag.CreateTag('div');
      try
        Result.AddClassParam('form-group');
        Result.AddStringParam('id',AHTMLName+'_FG');
        lablTag := Result.Contents.AddTag('label');
        lablTag.AddClassParam('control-label');
        lablTag.AddStringParam('for', AHTMLName);
        lablTag.Contents.AddText(TIWBaseHTMLControl.TextToHTML(ACaption));
        if (ParentForm <> nil) and (ParentForm.BSFormType = bsftHorizontal) then
          begin
            lablTag.AddClassParam(ParentForm.BSFormOptions.CaptionsSize.GetClassString);
            editTag := Result.Contents.AddTag('div');
            editTag.AddClassParam(ParentForm.BSFormOptions.InputsSize.GetClassString);
            editTag.Contents.AddTagAsObject(aTag);
          end
        else
          Result.Contents.AddTagAsObject(ATag);
      except
        FreeAndNil(Result);
        FreeAndNil(ATag);
        raise;
      end;
    end
  else
    Result := IWBSCreateFormGroup(AParent, ParentForm, ATag, AHTMLName, True);
end;

function IWBSCreateCheckBoxFormGroup(AParent: TControl; ATag: TIWHTMLTag; const ACss, ACaption, AHint, AHTMLName: string; AShowHint: boolean): TIWHTMLTag;
var
  lablTag: TIWHTMLTag;
  ParentForm: TIWBSInputForm;
begin
  ParentForm := IWBSFindParentInputForm(AParent);
  Result := TIWHTMLTag.CreateTag('div');
  try
    Result.AddStringParam('id', AHTMLName+'_FG');
    if (ParentForm <> nil) and (ParentForm.BSFormType = bsftInline) then
      Result.AddClassParam(ACss+'-inline')
    else
      Result.AddClassParam(ACss);
    if (ParentForm <> nil) and (ParentForm.BSFormType = bsftHorizontal) then
      Result.AddClassParam(ParentForm.BSFormOptions.GetOffsetClassString);
    lablTag := Result.Contents.AddTag('label');
    lablTag.AddStringParam('id', AHTMLName+'_CHKBCAPTION');
    if AShowHint and (AHint <> '') then begin
      lablTag.AddStringParam('data-toggle', 'tooltip');
      lablTag.AddStringParam('title', AHint);
    end;
    lablTag.Contents.AddTagAsObject(ATag);
    lablTag.Contents.AddText(TIWBaseHTMLControl.TextToHTML(ACaption));

    Result := IWBSCreateFormGroup(AParent, ParentForm, Result, AHTMLName, False);
  except
    FreeAndNil(Result);
    FreeAndNil(ATag);
    raise;
  end;
end;
{$endregion}

{$region 'InputGroup functions'}
function IWBSCreateInputGroupAddOn(ATag: TIWHTMLTag; const AHTMLName, css: string): TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('span');
  try
    Result.AddClassParam('input-group-'+css);
    Result.Contents.AddTagAsObject(ATag);
  except
    FreeAndNil(Result);
    FreeAndNil(ATag);
    raise;
  end;
end;
{$endregion}

end.
