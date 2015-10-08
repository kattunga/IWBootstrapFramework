unit IWBSInputCommon;

interface

uses System.Classes, System.SysUtils, System.SyncObjs, Vcl.Controls, IWVCLBaseControl, IWBSRegion,
     IWRenderContext, IWHTMLTag;

function CreateFormGroup(AParent: TControl; AParentForm: TIWBSInputForm; ATag: TIWHTMLTag; const AHTMLName: string; ASpanDiv: boolean): TIWHTMLTag;
function CreateInputFormGroup(AControl, AParent: TControl; ATag: TIWHTMLTag; const ACaption, AHTMLName: string): TIWHTMLTag;
function CreateCheckBoxFormGroup(AParent: TControl; ATag: TIWHTMLTag; const ACss, ACaption, AHint, AHTMLName: string; AShowHint: boolean): TIWHTMLTag;

implementation

uses IWBSRegionCommon, IWBaseHTMLControl;

{$region 'FormGroup functions'}
function CreateFormGroup(AParent: TControl; AParentForm: TIWBSInputForm; ATag: TIWHTMLTag; const AHTMLName: string; ASpanDiv: boolean): TIWHTMLTag;
var
  LSpanDiv: TIWHTMLTag;
begin
  if (AParentForm <> nil) and not ((AParent is TIWBSRegion) and (TIWBSRegion(AParent).BSRegionType in [bsrtFormGroup,bsrtButtonGroup])) then
    begin
      Result := TIWHTMLTag.CreateTag('div');
      Result.AddClassParam('form-group');
      Result.AddStringParam('id',AHTMLName+'_FG');
      Result.AddStringParam('name',AHTMLName+'_FG');
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

function CreateInputFormGroup(AControl, AParent: TControl; ATag: TIWHTMLTag; const ACaption, AHTMLName: string): TIWHTMLTag;
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
        Result.AddStringParam('name',AHTMLName+'_FG');
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
    Result := CreateFormGroup(AParent, ParentForm, ATag, AHTMLName, True);
end;

function CreateCheckBoxFormGroup(AParent: TControl; ATag: TIWHTMLTag; const ACss, ACaption, AHint, AHTMLName: string; AShowHint: boolean): TIWHTMLTag;
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

    Result := CreateFormGroup(AParent, ParentForm, Result, AHTMLName, False);
  except
    FreeAndNil(Result);
    FreeAndNil(ATag);
    raise;
  end;
end;
{$endregion}

end.
