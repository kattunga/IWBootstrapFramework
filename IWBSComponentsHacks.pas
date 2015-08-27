unit IWBSComponentsHacks;

interface

uses System.Classes, System.SysUtils,
     IWRenderContext, IWHTMLTag,
     IWCompButton, IWCompEdit, IWCompLabel, IWCompCheckbox, IWCompText;

type
  TIWButton = class(IWCompButton.TIWButton)
  public
    constructor Create(AOwner: TComponent); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
  end;

  TIWEdit = class(IWCompEdit.TIWEdit)
  public
    constructor Create(AOwner: TComponent); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
  end;

  TIWLabel = class(IWCompLabel.TIWLabel)
  public
    constructor Create(AOwner: TComponent); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
  end;

  TIWCheckBox = class(IWCompCheckbox.TIWCheckBox)
  public
    constructor Create(AOwner: TComponent); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
  end;

implementation

uses IWBSCommon;

constructor TIWButton.Create(AOwner: TComponent);
begin
  inherited;
  IWBSDisableAllRenderOptions(StyleRenderOptions);
end;

function TIWButton.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  result := 'btn';
end;

constructor TIWEdit.Create(AOwner: TComponent);
begin
  inherited;
  IWBSDisableAllRenderOptions(StyleRenderOptions);
end;

function TIWEdit.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  result := 'form-control';
end;

constructor TIWLabel.Create(AOwner: TComponent);
begin
  inherited;
  IWBSDisableAllRenderOptions(StyleRenderOptions);
end;

function TIWLabel.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  result := 'label label-default';
end;

constructor TIWCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  IWBSDisableAllRenderOptions(StyleRenderOptions);
end;

function TIWCheckBox.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  result := 'checkbox-inline';
end;

end.
