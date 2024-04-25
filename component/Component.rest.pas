unit Component.rest;

interface

uses
  System.JSON, rest.JSON, rest.Client, model.Endereco, model.TTypeResult,
  FMX.Dialogs, System.Generics.Collections, XMLIntf, XMLDoc,
  controller.Endereco, System.SysUtils,model.Events;

 CONST ENDERECO_VIACEP = 'https://viacep.com.br/ws';

 Type

  IRest = interface
  ['{B94B4DD9-E758-42B9-B6F1-41ADA8D89463}']
    function consultarEnderecoCep(Endereco: IEndereco; TipoRetorno: TTypeResult)
      : IEndereco;
    function consultarEndereco(Endereco: IEndereco; TipoRetorno: TTypeResult)
      : Tlist<IEndereco>;
  end;

  TRest = class(TInterfacedObject, IRest)
  private
    FRequest: TRESTRequest;
    FResponse: TRESTResponse;
    FRestClient: TRESTClient;
    FNotificarResultType: TNotificarResultType;
    FNotificarError:TNotificarResultType;
  public
    constructor create(NotificarResultType: TNotificarResultType;NotificarError:TNotificarResultType);
    destructor Destroy; Override;
    function consultarEnderecoCep(Endereco: IEndereco; TipoRetorno: TTypeResult)
      : IEndereco;
    function consultarEndereco(Endereco: IEndereco; TipoRetorno: TTypeResult)
      : Tlist<IEndereco>;
  end;

implementation

uses
  rest.Types;

function TRest.consultarEndereco(Endereco: IEndereco; TipoRetorno: TTypeResult)
  : Tlist<IEndereco>;
var
  L_Endereco: IEndereco;
  jsonArray: TJSONArray;
  i, x: Integer;
  XML: IXMLDocument;
  RootNode, EnderecoNode, CepNode: IXMLNode;
begin
  result:=nil;
  try
     case TipoRetorno of
    TypeJson:
      begin
        FRestClient.BaseURL := FRestClient.BaseURL + '/' +
          Endereco.asUrlRequest;
        FRestClient.ContentType := 'application/json';
        FRequest.Execute;
        FNotificarResultType(FResponse.Content);
        result := Tlist<IEndereco>.create;
        jsonArray := TJsonObject.ParseJSONValue(FResponse.Content)
          as TJSONArray;
        for i := 0 to jsonArray.Count - 1 do
        begin
          L_Endereco := TJson.JsonToObject<TEndereco>
            (jsonArray.items[i].ToString);
          L_Endereco.cep(stringReplace(L_Endereco.cep,'-','',[rfReplaceAll]));
          result.Add(L_Endereco);
        end;
        jsonArray.Free;

      end;

    TypeXML:
      begin
        XML := TXMLDocument.create('');
        FRestClient.BaseURL := FRestClient.BaseURL + '/' +
          Endereco.asUrlRequest;
        FRestClient.ContentType := 'application/xml';
        FRequest.Execute;
        FNotificarResultType(FResponse.Content);
        result := Tlist<IEndereco>.create;
        XML.LoadFromXML(FResponse.Content);
        RootNode := XML.DocumentElement;
        if Assigned(RootNode) then
        begin
          for i := 0 to RootNode.ChildNodes.Count - 1 do
          begin
            CepNode := RootNode.ChildNodes[i];
            for x := 0 to CepNode.ChildNodes.Count - 1 do
            begin
              L_Endereco := TEndereco.Builder(TipoRetorno);
              EnderecoNode := CepNode.ChildNodes[x];
              L_Endereco.cep(stringReplace(EnderecoNode.ChildNodes['cep'].Text,'-','',[rfReplaceAll]))
                .logradouro(EnderecoNode.ChildNodes['logradouro'].Text)
                .bairro(EnderecoNode.ChildNodes['bairro'].Text)
                .localidade(EnderecoNode.ChildNodes['localidade'].Text)
                .uf(EnderecoNode.ChildNodes['uf'].Text);
              result.Add(L_Endereco);
            end;
          end;
        end;
      end;
  end;
  Except
   FNotificarError('Ocorreu um Erro a consultar Endereco completo ');
  end;

end;

function TRest.consultarEnderecoCep(Endereco: IEndereco;
  TipoRetorno: TTypeResult): IEndereco;
var
  L_Endereco: IEndereco;
  XML: IXMLDocument;
  RootNode: IXMLNode;
begin
 try
   case TipoRetorno of
    TypeJson:
      begin
        FRestClient.BaseURL := FRestClient.BaseURL + '/' + Endereco.cep + '/' +
          TipoRetorno.ToString;
        FRestClient.ContentType := 'application/json';
        FRequest.Execute;
        FNotificarResultType(FResponse.Content);
        L_Endereco := TJson.JsonToObject<TEndereco>(FResponse.Content);
        L_Endereco.cep(stringReplace(L_Endereco.cep,'-','',[rfReplaceAll]));
        result := L_Endereco;
      end;

    TypeXML:
      begin
        XML := TXMLDocument.create('');
        L_Endereco := TEndereco.Builder(TipoRetorno);
        FRestClient.BaseURL := FRestClient.BaseURL + '/' + Endereco.cep + '/' +
          TipoRetorno.ToString;
        FRestClient.ContentType := 'application/xml';
        FRequest.Execute;
        FNotificarResultType(FResponse.Content);
        XML.LoadFromXML(FResponse.Content);
        RootNode := XML.DocumentElement;
        if Assigned(RootNode) then
        begin
          L_Endereco
            .cep(stringReplace(RootNode.ChildNodes['cep'].Text,'-','',[rfReplaceAll]))
            .logradouro(RootNode.ChildNodes['logradouro'].Text)
            .bairro(RootNode.ChildNodes['bairro'].Text)
            .localidade(RootNode.ChildNodes['localidade'].Text)
            .uf(RootNode.ChildNodes['uf'].Text);
        end;
        result := L_Endereco;
      end;
  end;
 except
   FNotificarError('Ocorreu um Erro a consultar cep ');
 end;


end;

constructor TRest.create(NotificarResultType: TNotificarResultType;NotificarError:TNotificarResultType);
begin
  FRequest := TRESTRequest.create(nil);
  FResponse := TRESTResponse.create(nil);
  FRestClient := TRESTClient.create(ENDERECO_VIACEP);
  FRequest.Client := FRestClient;
  FRequest.Method := TRestRequestMethod.rmGET;
  FRequest.Response := FResponse;
  FNotificarResultType := NotificarResultType;
  FNotificarError:=NotificarError;
end;

destructor TRest.destroy;
begin
  FRestClient.DisposeOf;
  FResponse.DisposeOf;
  FRequest.DisposeOf;
  inherited;

end;

end.
