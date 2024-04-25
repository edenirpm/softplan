unit model.Events;

interface
uses
 model.Endereco,system.Generics.Collections;
type
  TNotificarEndereco   = procedure(Endereco: IEndereco) of Object;
  TNotificarEnderecos  = procedure(Enderecos: TList<IEndereco>) of object;
  TNotificarResultType = procedure(Response: string) of object;


  TNotificationEvent = class
  private
   FEventCepExistDatabase:TNotificarEndereco;
   FEventAtualizarCep:TNotificarEndereco;
   FEventSalvarCep:TNotificarEndereco;
   FEventEnderecoExistsDatabase:TNotificarEnderecos;
   FEventAtualizarEnderecoExistsDatabase:TNotificarEnderecos;
   FEventSalvarEnderecoCompleto: TNotificarEnderecos;
   FTypeResult:TNotificarResultType;
    FFindCep: TNotificarEndereco;
    FfindFullAddres: TNotificarEnderecos;
    FvalidarCampos: TNotificarResultType;
    Ferror: TNotificarResultType;
    procedure SetEventAtualizarCep(const Value: TNotificarEndereco);
    procedure SetEventAtualizarEnderecoExistsDatabase(
      const Value: TNotificarEnderecos);
    procedure SetEventCepExistDatabase(const Value: TNotificarEndereco);
    procedure SetEventEnderecoExistsDatabase(const Value: TNotificarEnderecos);
    procedure SetEventSalvarCep(const Value: TNotificarEndereco);
    procedure SetEventSalvarEnderecoCompleto(const Value: TNotificarEnderecos);
    procedure SetTypeResult(const Value: TNotificarResultType);
    procedure SetFindCep(const Value: TNotificarEndereco);
    procedure SetfindFullAddres(const Value: TNotificarEnderecos);
    procedure Seterror(const Value: TNotificarResultType);
    procedure SetvalidarCampos(const Value: TNotificarResultType);
  public
  property EventCepExistDatabase:TNotificarEndereco read FEventCepExistDatabase write SetEventCepExistDatabase;
  property EventAtualizarCep:TNotificarEndereco read FEventAtualizarCep write SetEventAtualizarCep;
  property EventSalvarCep:TNotificarEndereco read FEventSalvarCep write SetEventSalvarCep;
  property EventEnderecoExistsDatabase:TNotificarEnderecos read FEventEnderecoExistsDatabase write SetEventEnderecoExistsDatabase;
  property EventAtualizarEnderecoExistsDatabase:TNotificarEnderecos read FEventAtualizarEnderecoExistsDatabase write SetEventAtualizarEnderecoExistsDatabase;
  property EventSalvarEnderecoCompleto:TNotificarEnderecos read FEventSalvarEnderecoCompleto write SetEventSalvarEnderecoCompleto;
  property TypeResult:TNotificarResultType read FTypeResult write SetTypeResult;
  property FindCep:TNotificarEndereco read FFindCep write SetFindCep;
  property findFullAddres:TNotificarEnderecos read FfindFullAddres write SetfindFullAddres;
  property validarCampos:TNotificarResultType read FvalidarCampos write SetvalidarCampos;
  property error:TNotificarResultType read Ferror write Seterror;
end;

implementation

{ TNotificationEvent }

procedure TNotificationEvent.Seterror(const Value: TNotificarResultType);
begin
  Ferror := Value;
end;

procedure TNotificationEvent.SetEventAtualizarCep(
  const Value: TNotificarEndereco);
begin
  FEventAtualizarCep := Value;
end;

procedure TNotificationEvent.SetEventAtualizarEnderecoExistsDatabase(
  const Value: TNotificarEnderecos);
begin
  FEventAtualizarEnderecoExistsDatabase := Value;
end;

procedure TNotificationEvent.SetEventCepExistDatabase(
  const Value: TNotificarEndereco);
begin
  FEventCepExistDatabase := Value;
end;

procedure TNotificationEvent.SetEventEnderecoExistsDatabase(
  const Value: TNotificarEnderecos);
begin
  FEventEnderecoExistsDatabase := Value;
end;

procedure TNotificationEvent.SetEventSalvarCep(const Value: TNotificarEndereco);
begin
  FEventSalvarCep := Value;
end;

procedure TNotificationEvent.SetEventSalvarEnderecoCompleto(
  const Value: TNotificarEnderecos);
begin
  FEventSalvarEnderecoCompleto := Value;
end;

procedure TNotificationEvent.SetFindCep(const Value: TNotificarEndereco);
begin
  FFindCep := Value;
end;

procedure TNotificationEvent.SetfindFullAddres(
  const Value: TNotificarEnderecos);
begin
  FfindFullAddres := Value;
end;

procedure TNotificationEvent.SetTypeResult(const Value: TNotificarResultType);
begin
  FTypeResult := Value;
end;

procedure TNotificationEvent.SetvalidarCampos(
  const Value: TNotificarResultType);
begin
  FvalidarCampos := Value;
end;

end.
