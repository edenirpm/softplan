unit Helpers.RadioButtonHelper;

interface

uses
  FMX.StdCtrls, model.TTypeResult;

type
  TTypeResultHelper = class helper for TRadioButton
    function resultType: TTypeResult;
  end;

implementation

{ TTypeResultHelper }

function TTypeResultHelper.resultType: TTypeResult;
begin
  if Self.IsChecked and (Self.Tag = 0) then
    Result := TypeJson
  else
    Result := TypeXML;
end;

end.
