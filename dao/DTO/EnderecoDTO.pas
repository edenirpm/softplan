unit EnderecoDTO;

interface

Type

   TEnderecoDTO = class
  private
    FCodigo:integer;
    Fcep: string;
    Flogradouro: string;
    Fbairro: string;
    Flocalidade: string;
    FComplemento: string;
    Fuf: string;

  public
    function cep(): string; overload;
    function cep(const value: string): TEnderecoDTO; overload;
    function logradouro(): string; overload;
    function logradouro(const value: string): TEnderecoDTO; overload;
    function bairro(): string; overload;
    function bairro(const value: string): TEnderecoDTO; overload;
    function localidade(): string; overload;
    function localidade(const value: string): TEnderecoDTO; overload;
    function complemento(): string; overload;
    function complemento(const value: string): TEnderecoDTO; overload;
    function uf(): string; overload;
    function uf(const value: string): TEnderecoDTO; overload;
    function codigo(): integer; overload;
    function codigo(const value: integer): TEnderecoDTO; overload;

  end;

implementation

{ TEnderecoDTO }

function TEnderecoDTO.bairro: string;
begin
  result:=FBairro;
end;

function TEnderecoDTO.bairro(const value: string): TEnderecoDTO;
begin
Fbairro:=value;
result:=self;
end;

function TEnderecoDTO.cep: string;
begin
 Result:= Fcep;
end;

function TEnderecoDTO.cep(const value: string): TEnderecoDTO;
begin
 FCep:=value;
 result:=self;
end;

function TEnderecoDTO.codigo(const value: integer): TEnderecoDTO;
begin
 FCodigo:=value;
 result:=self;
end;

function TEnderecoDTO.codigo: integer;
begin
 Result:=FCodigo;
end;

function TEnderecoDTO.complemento(const value: string): TEnderecoDTO;
begin
 FComplemento:=value;
 result:=self;
end;

function TEnderecoDTO.complemento: string;
begin
  Result:=FComplemento;
end;

function TEnderecoDTO.localidade: string;
begin
  Result:=FLocalidade;
end;

function TEnderecoDTO.localidade(const value: string): TEnderecoDTO;
begin
 FLocalidade:=value;
 result:=self;
end;

function TEnderecoDTO.logradouro(const value: string): TEnderecoDTO;
begin
  FLogradouro:=value;
  result:=self;
end;

function TEnderecoDTO.logradouro: string;
begin
  Result:=FLogradouro;
end;


function TEnderecoDTO.uf: string;
begin
 Result:=Fuf;
end;

function TEnderecoDTO.uf(const value: string): TEnderecoDTO;
begin
 FUf:=value;
 result:=self;
end;

end.
