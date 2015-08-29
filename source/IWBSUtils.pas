unit IWBSUtils;

interface

uses System.SysUtils, Windows, IWAppForm;

procedure IWBSEnable(const base, path: string; Form: TIWAppForm; ncButton: boolean; WebShimm: boolean);

const
  jqlibversion = '1.11.3';
  bslibversion = '3.3.5';

var
  IWBSLibraryPath: string = '/iwbs';
  IWBSRefreshCacheParam: string;

implementation

procedure IWBSEnable(const base, path: string; Form: TIWAppForm; ncButton: boolean; WebShimm: boolean);
begin
  Form.PreHeader.Add('<meta name="viewport" content="width=device-width, initial-scale=1">');

  // jquery
  Form.PreHeader.Add('<script type="text/javascript" src="'+base+path+'/jquery-'+jqlibversion+'.min.js"></script>');

  // bootstrap
  Form.ContentFiles.Add(path+'/bootstrap-'+bslibversion+'/css/bootstrap.min.css');
  Form.PreHeader.Add('<script type="text/javascript" src="'+base+path+'/bootstrap-'+bslibversion+'/js/bootstrap.min.js"></script>');

  // add missing html5 functionality to most browsers
  // http://afarkas.github.io/webshim/demos/index.html
  // see also http://modernizr.com/
  if WebShimm then
    Form.PreHeader.Add('<script type="text/javascript" src="'+base+path+'/webshim-1.15.8/js-webshim/minified/polyfiller.js"></script>');

  // iwbs
  Form.ContentFiles.Add(path+'/iwbs.css?v='+IWBSRefreshCacheParam);
  Form.PreHeader.Add('<script type="text/javascript" src="'+base+path+'/iwbs.js?v='+IWBSRefreshCacheParam+'"></script>');

  // disable bootstap button plugin for no conflict with CGDevtools jQButton
  if ncButton then
    Form.ExtraHeader.Add('<script type="text/javascript">$.fn.button.noConflict();</script>');
end;

initialization
  IWBSRefreshCacheParam := FormatDateTime('yyyymmddhhnnsszzz', now);

end.
