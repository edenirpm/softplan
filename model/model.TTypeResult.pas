unit model.TTypeResult;

interface

Type
  TTypeResult = (TypeJson, TypeXML);

  TTypeResultHelper = record helper for TTypeResult
    function toString: string;
  end;

implementation

{ TTypeResultHelper }

function TTypeResultHelper.toString: string;
begin
  case Self of
    TypeJson:
      result := 'json';
    TypeXML:
      result := 'xml';
  end;
end;

end.
