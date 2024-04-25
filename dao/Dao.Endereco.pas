unit Dao.Endereco;

interface
uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,System.Generics.Collections,model.Endereco,dmConnection,
  System.SysUtils,Component.Singleton,EnderecoDTO;

 const
        CREATE_TABLE  = ' CREATE TABLE IF NOT EXISTS ENDERECOS( '+
                        ' codigo int primary key,        '+
                        ' cep varchar(9),                         '+
                        ' logradouro varchar(40),                 '+
                        ' complemento varchar(30),                '+
                        ' bairro varchar(30),                     '+
                        ' localidade varchar(40),                 '+
                        ' uf varchar(2)                           '+
                        ' )';

        SAVE_OBJECT   = ' INSERT INTO ENDERECOS (CEP,LOGRADOURO,COMPLEMENTO,BAIRRO,LOCALIDADE,UF) '+
                        ' VALUES (''%s'',''%s'',''%s'',''%s'',''%s'',''%s'')';

        UPDATE_OBJECT = ' UPDATE ENDERECOS SET LOGRADOURO =''%s'' ,COMPLEMENTO = ''%s'',BAIRRO = ''%s'', '+
                        ' LOCALIDADE = ''%s'', UF = ''%s'' WHERE CEP = ''%s''  ';
Type
 IEnderecoDao = interface
   ['{F39D4F69-3BA0-4C8F-A165-6F0D5EE71B49}']
    function  save(Endereco:IEndereco):boolean;
    function  update(Endereco:IEndereco):boolean;
    function  Find(Endereco:IEndereco):IEndereco;
    function  getAll(Endereco:IEndereco):TList<IEndereco>;
    procedure sincronize();
 end;

 TDaoEndereco = class (TInterfacedObject,IEnderecoDAO)
    private
    FQuery:TFDQuery;
    public
    Constructor Create;
    Destructor Destroy;override;
    function  save(Endereco:IEndereco):boolean;
    function  update(Endereco:IEndereco):boolean;
    function  Find(Endereco:IEndereco):IEndereco;
    function  getAll(Endereco:IEndereco):TList<IEndereco>;
    procedure sincronize();
 end;

implementation

{ TDaoEndereco }

constructor TDaoEndereco.Create;
begin
 FQuery:=TFDQuery.Create(nil);
 Fquery.Connection := dmConnection.DataModule1.FDConnection1;
 //FQuery.ExecSQL(CREATE_TABLE);
end;

destructor TDaoEndereco.Destroy;
begin
 FQuery.DisposeOf;
  inherited;
end;

function TDaoEndereco.Find(Endereco: IEndereco): IEndereco;
 function getObject(cep:string):string;
 begin
   Result:=Format(' Select * from Enderecos e where e.cep = ''%s''',[cep]);
 end;
begin
   try
    Result:= nil;
    FQuery.Close();
    FQuery.SQL.Clear;
    FQuery.Open(getObject(Endereco.cep));
    if Fquery.RecordCount > 0 then

    Result:= TEndereco.Builder
                     .cep(FQuery.FieldByName('cep').AsString)
                     .logradouro(FQuery.FieldByName('logradouro').AsString)
                     .bairro(FQuery.FieldByName('bairro').AsString)
                     .localidade(FQuery.FieldByName('localidade').AsString)
                     .uf(FQuery.FieldByName('uf').AsString)
                     .complemento(FQuery.FieldByName('complemento').AsString);
   Except
    Result:= nil;
   end;
end;

function TDaoEndereco.getAll(Endereco:IEndereco): TList<IEndereco>;
var
 L_Endereco:iEndereco;
 Enderecos:TList<IEndereco>;
begin
  Enderecos := TList<IEndereco>.create;
  FQuery.Close();
  FQuery.SQL.Clear;
  FQuery.Open(Format(' Select * from Enderecos where logradouro = ''%s'' COLLATE NOCASE and localidade = ''%s'' COLLATE NOCASE and uf = ''%s'' COLLATE NOCASE ',[
  Endereco.logradouro,Endereco.localidade,Endereco.uf]) );
  with FQuery do
  begin
    first;
    while not eof do
    begin
      L_Endereco := TEndereco.Builder
                     .cep(FQuery.FieldByName('cep').AsString)
                     .logradouro(FQuery.FieldByName('logradouro').AsString)
                     .bairro(FQuery.FieldByName('bairro').AsString)
                     .localidade(FQuery.FieldByName('localidade').AsString)
                     .uf(FQuery.FieldByName('uf').AsString)
                     .complemento(FQuery.FieldByName('complemento').AsString);
      Enderecos.Add(L_Endereco);
      next;
    end;
  end;
  Result:=Enderecos;
end;

function TDaoEndereco.save(Endereco: IEndereco): boolean;
begin
  FQuery.Close();
  FQuery.SQL.Clear;
  Result:= FQuery.ExecSQL(Format(SAVE_OBJECT,[Endereco.cep,
  Endereco.logradouro,Endereco.complemento,Endereco.bairro,Endereco.localidade,
  Endereco.uf])).ToBoolean;
end;

procedure TDaoEndereco.sincronize();
begin
 TSingleton<TEnderecoDTO>.GetInstance.cep(dmConnection.DataModule1.FDQuery2.FieldByName('cep').AsString);
 TSingleton<TEnderecoDTO>.GetInstance.bairro(dmConnection.DataModule1.FDQuery2.FieldByName('bairro').AsString);
 TSingleton<TEnderecoDTO>.GetInstance.logradouro(dmConnection.DataModule1.FDQuery2.FieldByName('logradouro').AsString);
 TSingleton<TEnderecoDTO>.GetInstance.localidade(dmConnection.DataModule1.FDQuery2.FieldByName('localidade').AsString);
 TSingleton<TEnderecoDTO>.GetInstance.uf(dmConnection.DataModule1.FDQuery2.FieldByName('uf').AsString);
end;

function TDaoEndereco.update(Endereco: IEndereco): boolean;
begin
  FQuery.Close();
  FQuery.SQL.Clear;
  Result:= FQuery.ExecSQL(Format(UPDATE_OBJECT,[
  Endereco.logradouro,Endereco.complemento,Endereco.bairro,Endereco.localidade,
  Endereco.uf,Endereco.cep])).ToBoolean;

end;

end.
