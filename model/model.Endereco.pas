unit model.Endereco;

interface

uses
  System.SysUtils, model.TTypeResult;

Type

  IEndereco = Interface
    ['{8D7E8405-E5A5-492F-BF7E-873C9036A46D}']

    function cep(): string; overload;
    function cep(const value: string): IEndereco; overload;
    function logradouro(): string; overload;
    function logradouro(const value: string): IEndereco; overload;
    function bairro(): string; overload;
    function bairro(const value: string): IEndereco; overload;
    function localidade(): string; overload;
    function localidade(const value: string): IEndereco; overload;
    function numero(): integer; overload;
    function numero(const value: integer): IEndereco; overload;
    function complemento(): string; overload;
    function complemento(const value: string): IEndereco; overload;
    function uf(): string; overload;
    function uf(const value: string): IEndereco; overload;
    function valueString: string; overload;
    function valueString(const value: string): string; overload;
    function typeResult(const value: TTypeResult): IEndereco;
    function asUrlRequest: string;
    function asString: string;

  End;

  TEndereco = class(TInterfacedObject, IEndereco)
  private
    Fcep: string;
    Flogradouro: string;
    Fbairro: string;
    Flocalidade: string;
    Fnumero: integer;
    FComplemento: string;
    Fuf: string;
    FTypeResult: TTypeResult;
    FvalueString: String;
  public
    function cep(): string; overload;
    function cep(const value: string): IEndereco; overload;
    function logradouro(): string; overload;
    function logradouro(const value: string): IEndereco; overload;
    function bairro(): string; overload;
    function bairro(const value: string): IEndereco; overload;
    function localidade(): string; overload;
    function localidade(const value: string): IEndereco; overload;
    function numero(): integer; overload;
    function numero(const value: integer): IEndereco; overload;
    function complemento(): string; overload;
    function complemento(const value: string): IEndereco; overload;
    function uf(): string; overload;
    function uf(const value: string): IEndereco; overload;
    function typeResult(const value: TTypeResult): IEndereco;
    function asUrlRequest: string;
    function asString: string;
    function valueString: string; overload;
    function valueString(const value: string): string; overload;
    class function Builder(typeResult: TTypeResult): IEndereco; overload;
    class function Builder(): IEndereco; overload;
  end;

implementation

{ TEndereco }

function TEndereco.bairro: string;
begin
  Result := Fbairro;
end;

function TEndereco.bairro(const value: string): IEndereco;
begin
  Fbairro := value;
  Result := self;
end;

class function TEndereco.Builder: IEndereco;
begin
 Result:=Self.Create;
end;

class function TEndereco.Builder(typeResult: TTypeResult): IEndereco;
begin
  Result := self.Create();
  Result.typeResult(typeResult);
end;

function TEndereco.cep: string;
begin
  Result := Fcep;
end;

function TEndereco.cep(const value: string): IEndereco;
begin
  Fcep := value;
  Result := self;
end;

function TEndereco.complemento(const value: string): IEndereco;
begin
  FComplemento := value;
  Result := self;
end;

function TEndereco.complemento: string;
begin
  Result := FComplemento;
end;

function TEndereco.localidade: string;
begin
  Result := Flocalidade;
end;

function TEndereco.localidade(const value: string): IEndereco;
begin
  Flocalidade := value;
  Result := self;
end;

function TEndereco.logradouro: string;
begin
  Result := Flogradouro;
end;

function TEndereco.logradouro(const value: string): IEndereco;
begin
  Flogradouro := value;
  Result := self;
end;

function TEndereco.numero(const value: integer): IEndereco;
begin
  Fnumero := value;
  Result := self;
end;

function TEndereco.asString: string;
begin
  Result := Flogradouro + ' n.' + Fnumero.ToString + ',' + Fbairro + ',' +
    Flocalidade + ' - ' + Fuf + ' Cep: ' + Fcep;
end;

function TEndereco.asUrlRequest: string;
var
  str: TStringBuilder;
begin
  str := TStringBuilder.Create;
  try
    str.Append(Fuf.ToUpper).Append('/').Append(Flocalidade).Append('/')
      .Append(Flogradouro).Append('/').Append(FTypeResult.ToString);
    Result := str.ToString;
  finally
    str.DisposeOf;
  end;

end;

function TEndereco.typeResult(const value: TTypeResult): IEndereco;
begin
  FTypeResult := value;
  Result := self;
end;

function TEndereco.numero: integer;
begin
  Result := Fnumero;
end;

function TEndereco.uf: string;
begin
  Result := Fuf;
end;

function TEndereco.uf(const value: string): IEndereco;
begin
  Fuf := value.ToUpper;
  Result := self;
end;

function TEndereco.valueString(const value: string): string;
begin
  FvalueString := value;
end;

function TEndereco.valueString: string;
begin
  Result := FvalueString;
end;

end.
