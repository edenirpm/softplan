unit controller.Endereco;

interface

uses model.Endereco, model.TTypeResult, FMX.StdCtrls, Helpers.RadioButtonHelper,
  system.Generics.Collections, Dao.Endereco, System.SysUtils,EnderecoDto,
  Component.Singleton,model.Events, FMX.Edit;

type
  Endereco = model.IEndereco;
  DTO      = EnderecoDto.TEnderecoDTO;
  TEvents   = model.Events.TNotificationEvent;
  TNotificarEndereco   = model.Events.TNotificarEndereco;
  TNotificarEnderecos  = model.Events.TNotificarEnderecos;
  TNotificarResultType = model.Events.TNotificarResultType;

  IControllerEndereco = interface
    ['{5F3B0DBB-AA84-4D09-81DA-5EF62391A556}']
    function validarCampos(Edit:TEdit):IControllerEndereco;
    function searchDatabaseFullAddress(Endereco:IEndereco;update:boolean):TList<IEndereco>;
    function searchDatabase(Endereco:IEndereco):IEndereco;
    function searchService(Endereco:IEndereco; update:boolean):IEndereco;
    function pesquisarEnderecoPorCep(cep: string;update:boolean): IEndereco;
    procedure pesquisarPorEnderecoCompleto(Endereco: IEndereco;update:boolean);
    function salvarEndereco(Endereco:IEndereco):boolean;
    function atualizarEndereco(Endereco:IEndereco):boolean;
    function strategy(Endereco:IEndereco;cepOnly:boolean):IControllerEndereco;
    procedure sincronizar();
  end;

  TControllerEndereco = class(TInterfacedObject, IControllerEndereco)
  private
    FTypeResult: TTypeResult;
    FNotification:TNotificationEvent;
  public
    constructor create(RadioButton: TRadioButton;Notification:TNotificationEvent);
    function validarCampos(Edit:TEdit):IControllerEndereco;
    function searchDatabaseFullAddress(Endereco:IEndereco;update:boolean):TList<IEndereco>;
    function searchDatabase(Endereco:IEndereco):IEndereco;
    function searchService(Endereco:IEndereco ; update:boolean):IEndereco;
    function pesquisarEnderecoPorCep(cep: string;update:boolean): IEndereco;
    procedure pesquisarPorEnderecoCompleto(Endereco: IEndereco;update:boolean);
     function salvarEndereco(Endereco:IEndereco):boolean;
     function atualizarEndereco(Endereco:IEndereco):boolean;
     function strategy(Endereco:IEndereco;cepOnly:boolean):IControllerEndereco;
    procedure sincronizar();
  end;

  TBuilder = class
    class function EnderecoBuilder(RadioButton: TRadioButton): IEndereco; overload;
    class function EnderecoBuilder(): IEndereco; overload;
  end;

implementation

uses
  Component.rest, Component.Observer;

{ TControllerEndereco }

function TControllerEndereco.atualizarEndereco(Endereco: IEndereco): boolean;
var
 DaoEndereco:IEnderecoDao;
begin
 DaoEndereco:=TDaoEndereco.Create;
 result:= DaoEndereco.update(Endereco);
end;

constructor TControllerEndereco.create(RadioButton: TRadioButton;
  Notification: TNotificationEvent);
begin
  FNotification:=Notification;
  FTypeResult := RadioButton.resultType;
end;

function TControllerEndereco.pesquisarEnderecoPorCep(cep: string;update:boolean): IEndereco;
var
  LEndereco,Database: IEndereco;
  Observable:iObservable;
  DTO:TEnderecoDTO;
begin
  DTO := TSingleton<TEnderecoDTO>.GetInstance;
  LEndereco   := TEndereco.Builder(FTypeResult).cep(cep);
  Database    := searchDatabase(LEndereco);
  try
    if Assigned(Database) then
   begin
     result:= Database;
     FNotification.EventCepExistDatabase(result);
   end
      else
       begin
      result := searchService(LEndereco,update);
      Observable := TSingleton<TObservable>.GetInstance;
      dto.cep(result.cep).logradouro(result.logradouro).bairro(result.bairro)
         .localidade(result.localidade).complemento(result.complemento).uf(result.uf);
      Observable.notifyObserver;
       end;
  except
    FNotification.error('Erro ao efetuar consulta ao cep solicitado');
  end;


end;

procedure TControllerEndereco.pesquisarPorEnderecoCompleto(Endereco: IEndereco;update:boolean) ;
 function findFullAddress(Endereco:iEndereco):TList<IEndereco>;
 var
 rest: IRest;
 obj:IEndereco;
 begin
  rest := TRest.create(FNotification.TypeResult,FNotification.error);
  result  := rest.consultarEndereco(Endereco, FTypeResult);
  if Result.Count > 0 then
  begin
     for Obj in result do
  begin
    Obj.logradouro(Endereco.logradouro);
  end;
  end else
  FNotification.error('Erro ao pesquisar endereco completo!');
 end;
var
  LEndereco: IEndereco;
  Database:TList<iEndereco>;
  ServiceResult: TList<iEndereco>;
begin
    LEndereco   := TEndereco.Builder(FTypeResult)
    .logradouro(Endereco.logradouro)
    .localidade(Endereco.localidade)
    .uf(Endereco.uf);

  Database    := searchDatabaseFullAddress(LEndereco,update);

  if Assigned(Database)  then
  begin
  FNotification.EventEnderecoExistsDatabase(database);
  end
    else
   begin
   serviceResult := findFullAddress(LEndereco);
   if update then FNotification.EventAtualizarEnderecoExistsDatabase(serviceResult)
   else FNotification.EventSalvarEnderecoCompleto(serviceResult);
   end;

end;

function TControllerEndereco.salvarEndereco(Endereco: IEndereco): boolean;
var
 DaoEndereco:IEnderecoDao;
begin
 DaoEndereco:=TDaoEndereco.Create;
 result:= DaoEndereco.save(Endereco);
end;

function TControllerEndereco.searchDatabase(Endereco: IEndereco): IEndereco;
var
 DaoEndereco:IEnderecoDao;
begin
 DaoEndereco:=TDaoEndereco.Create;
 Result:= DaoEndereco.Find(Endereco);
end;

function TControllerEndereco.searchDatabaseFullAddress(
  Endereco: IEndereco;update:boolean): TList<IEndereco>;
var
 DaoEndereco:IEnderecoDao;
begin
 DaoEndereco:=TDaoEndereco.Create;

 if (DaoEndereco.getAll(Endereco).Count > 0) and (not update) then
    result:= DaoEndereco.getAll(Endereco)
    else
     result:= nil;
end;

function TControllerEndereco.searchService(Endereco: IEndereco ;update:boolean): IEndereco;
var
 rest: IRest;
begin
 rest   := TRest.create(FNotification.TypeResult,FNotification.error);
 Result := rest.consultarEnderecoCep(Endereco, FTypeResult);
 if update then FNotification.EventAtualizarCep(result) else
 FNotification.EventSalvarCep(result);
end;

procedure TControllerEndereco.sincronizar();
var
 DaoEndereco:IEnderecoDao;
begin
 DaoEndereco:=TDaoEndereco.Create;
 DaoEndereco.sincronize;
end;

function TControllerEndereco.strategy(Endereco: IEndereco;
  cepOnly: boolean): IControllerEndereco;
begin
      if cepOnly then
      searchService(Endereco,true)
     else
     pesquisarPorEnderecoCompleto(Endereco,true);
end;

function TControllerEndereco.validarCampos(Edit: TEdit): IControllerEndereco;
begin
 Result:=self;
 if edit.Text.Length < 4 then
 begin
  FNotification.validarCampos('Campo informado invalido, favor verificar os dados da pesquisa');
  abort;
 end;

end;

{ TBuilder }

class function TBuilder.EnderecoBuilder(RadioButton: TRadioButton): IEndereco;
begin
  Result := TEndereco.Builder(RadioButton.resultType);
end;

class function TBuilder.EnderecoBuilder: IEndereco;
begin
 Result:= TEndereco.Builder;
end;

end.
