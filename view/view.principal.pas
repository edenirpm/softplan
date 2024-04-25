unit view.principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  Controller.Endereco,dmConnection, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Response.Adapter, System.Generics.Collections, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Edit,
  FMX.Effects, FMX.Objects, FMX.Layouts, FMX.ListBox,Component.Singleton,
  Component.Observer, Data.Bind.Controls, System.Rtti, FMX.Grid.Style, FMX.Grid,
  Fmx.Bind.Navigator, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Grid, Data.Bind.DBScope;

type
  TForm1 = class(TForm,IObserver)
    Laynovo: TLayout;
    LayoutPrincipal: TLayout;
    LayoutTop: TLayout;
    Rectangle2: TRectangle;
    Text2: TText;
    ShadowEffect1: TShadowEffect;
    LayoutBottom: TLayout;
    LayoutCenter: TLayout;
    LayoutContentAll: TLayout;
    LayoutRight: TLayout;
    Layout1: TLayout;
    GroupDados: TGroupBox;
    edtPesquisaCep: TEdit;
    Label1: TLabel;
    Rectangle3: TRectangle;
    Text3: TText;
    GroupBox3: TGroupBox;
    edtPesquisaLogradouro: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label19: TLabel;
    edtPesquisaBairro: TEdit;
    edtPesquisaCidade: TEdit;
    ComboBoxPesquisaUF: TComboBox;
    Rectangle5: TRectangle;
    Text5: TText;
    GroupBox2: TGroupBox;
    GroupBox4: TGroupBox;
    Memo1: TMemo;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    BindNavigator1: TBindNavigator;
    Layout2: TLayout;
    StringGrid1: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    LayConfirm: TLayout;
    Rectangle1: TRectangle;
    Layout4: TLayout;
    Layout5: TLayout;
    Label3: TLabel;
    Layout6: TLayout;
    Layout7: TLayout;
    Label6: TLabel;
    Rectangle4: TRectangle;
    Text1: TText;
    Rectangle6: TRectangle;
    Text4: TText;
    ShadowEffect2: TShadowEffect;
    Layout3: TLayout;
    LayConfirm2: TLayout;
    Rectangle7: TRectangle;
    Layout9: TLayout;
    Layout10: TLayout;
    Label7: TLabel;
    Layout11: TLayout;
    Rectangle8: TRectangle;
    Text6: TText;
    Rectangle9: TRectangle;
    Text7: TText;
    Layout12: TLayout;
    Label8: TLabel;
    ShadowEffect3: TShadowEffect;

    procedure mostrarInfoEndereco(Sender: Endereco);
    procedure mostrarInfoEnderecos(Sender: TList<Endereco>);

    procedure atualizarCep(Sender: Endereco);
    procedure CepExistDatabase(Sender: Endereco);
    procedure SalvarCep(Sender: Endereco);

    procedure EnderecoExistDatabase(Sender: TList<Endereco>);
    procedure AtualizarEndereco(Sender: TList<Endereco>);
    procedure SalvarEndereco(Sender: TList<Endereco>);

    procedure notificarResultType(Sender: string);
    procedure eventoValidacao(Sender:string);
    procedure eventoError(Sender:String);
    procedure Rectangle3Click(Sender: TObject);
    procedure Rectangle5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Rectangle4Click(Sender: TObject);
    procedure Rectangle6Click(Sender: TObject);
    procedure Rectangle9Click(Sender: TObject);
    procedure StringGrid1CellClick(const Column: TColumn; const Row: Integer);

  private
    Events:TEvents;
    OnlyCep:Boolean;
    procedure pesquisarEnderecoPorCep(cep:string;update:boolean);
    procedure pesquisarEnderecoCompleto;
    procedure update;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Observable:iObservable;
  EndDto : DTO;
  Events: TEvents;
implementation

{$R *.fmx}



procedure TForm1.atualizarCep(Sender: Endereco);
var
  ControllerEndereco: IControllerEndereco;
begin
  ControllerEndereco := TcontrollerEndereco.create(RadioButton1,Events);
  ControllerEndereco.atualizarEndereco(Sender);
  LayConfirm.Visible:=false;
  Observable.notifyObserver;
end;

procedure TForm1.AtualizarEndereco(Sender: TList<Endereco>);
var
  ControllerEndereco: IControllerEndereco;
  L_Endereco:Endereco;
begin
    ControllerEndereco := TcontrollerEndereco.create(RadioButton1,Events);
     for L_Endereco in Sender do
     begin
       ControllerEndereco.atualizarEndereco(L_Endereco);
     end;
 Observable.notifyObserver;
end;

procedure TForm1.CepExistDatabase(Sender: Endereco);
begin
 LayConfirm.Visible:=true;
end;
procedure TForm1.EnderecoExistDatabase(Sender: TList<Endereco>);
begin
 LayConfirm2.Visible:=true;
 Sender.DisposeOf;
end;

procedure TForm1.eventoError(Sender: String);
begin
showmessage(Sender);
end;

procedure TForm1.eventoValidacao(Sender: string);
begin
 showmessage(Sender);
end;

procedure TForm1.SalvarCep(Sender: Endereco);
var
  ControllerEndereco: IControllerEndereco;
begin
    ControllerEndereco := TcontrollerEndereco.create(RadioButton1,Events);
    ControllerEndereco.salvarEndereco(Sender);
end;

procedure TForm1.SalvarEndereco(Sender: TList<Endereco>);
var
  ControllerEndereco: IControllerEndereco;
  L_Endereco:Endereco;
begin
    ControllerEndereco := TcontrollerEndereco.create(RadioButton1,Events);
     for L_Endereco in Sender do
     begin
       ControllerEndereco.salvarEndereco(L_Endereco);
     end;
 Sender.DisposeOf;
 Observable.notifyObserver;
end;

procedure TForm1.StringGrid1CellClick(const Column: TColumn;
  const Row: Integer);
begin
Observable.notifyObserver;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Observable := TSingleton<TObservable>.GetInstance;
 Observable.addObserver(Self);
 EndDto := TSingleton<DTO>.GetInstance;
 Events := TEvents.Create;
 Events.FindCep        := mostrarInfoEndereco;
 Events.findFullAddres := mostrarInfoEnderecos;
 Events.TypeResult     := notificarResultType;
 Events.EventCepExistDatabase := CepExistDatabase;
 Events.EventAtualizarCep     := atualizarCep;
 Events.EventSalvarCep        := SalvarCep;
 Events.EventEnderecoExistsDatabase   := EnderecoExistDatabase;
 Events.EventSalvarEnderecoCompleto   := SalvarEndereco;
 Events.EventAtualizarEnderecoExistsDatabase := AtualizarEndereco;
 Events.validarCampos := eventoValidacao;
 Events.error:= eventoError;


end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
EndDto.Free;
Events.DisposeOf;
end;

procedure TForm1.mostrarInfoEndereco(Sender: Endereco);
begin
 EndDto.cep(Sender.cep);
 EndDto.logradouro(Sender.logradouro);
 EndDto.bairro(Sender.bairro);
 EndDto.localidade(Sender.localidade);
 EndDto.uf(Sender.uf);
 EndDto.complemento(Sender.complemento);
 LayConfirm.Visible:= true;
end;

procedure TForm1.mostrarInfoEnderecos(Sender: TList<Endereco>);
var
  L_endereco: Endereco;
  ControllerEndereco: IControllerEndereco;
begin
  ControllerEndereco := TcontrollerEndereco.create(RadioButton1,Events);
  for L_endereco in Sender do
  begin
    ControllerEndereco.salvarEndereco(L_endereco);
  end;
  Sender.DisposeOf;
end;

procedure TForm1.notificarResultType(Sender: string);
begin
  memo1.Lines.Clear;
  Memo1.Lines.Add(Sender);
end;

procedure TForm1.pesquisarEnderecoCompleto;
var
  ControllerEndereco: IControllerEndereco;
begin
 OnlyCep:=false;
 EndDto
 .logradouro(edtPesquisaLogradouro.Text)
 .localidade(edtPesquisaCidade.Text)
 .cep(ComboBoxPesquisaUF.Selected.Text)
 .uf(ComboBoxPesquisaUF.Selected.Text);
 ControllerEndereco := TcontrollerEndereco.create(RadioButton1,Events);
  ControllerEndereco
  .validarCampos(edtPesquisaLogradouro)
  .validarCampos(edtPesquisaCidade)
  .pesquisarPorEnderecoCompleto
    (TBuilder.EnderecoBuilder(RadioButton1)
    .logradouro(edtPesquisaLogradouro.Text)
    .bairro(edtPesquisaBairro.Text)
    .localidade(edtPesquisaCidade.Text)
    .uf(ComboBoxPesquisaUF.Selected.Text),false);
end;

procedure TForm1.pesquisarEnderecoPorCep(cep: string;update:boolean);
var
  ControllerEndereco: IControllerEndereco;
begin
 OnlyCep:=true;
 EndDto.cep(cep);
 ControllerEndereco := TcontrollerEndereco.create(RadioButton1,Events);
 ControllerEndereco.validarCampos(edtPesquisaCep).pesquisarEnderecoPorCep(cep,update);
end;

procedure TForm1.Rectangle3Click(Sender: TObject);
begin
 pesquisarEnderecoPorCep(edtPesquisaCep.Text,false);
end;

procedure TForm1.Rectangle4Click(Sender: TObject);
begin
 LayConfirm.Visible:=false;
 memo1.Lines.Clear;
 memo1.Lines.Add('Retornado valor existente em banco de dados!');
end;

procedure TForm1.Rectangle5Click(Sender: TObject);
begin
 pesquisarEnderecoCompleto;
end;



procedure TForm1.Rectangle6Click(Sender: TObject);
var
  ControllerEndereco: IControllerEndereco;
  L_Endereco: Endereco;
begin
    L_Endereco:= TBuilder.EnderecoBuilder
    .cep(EndDto.cep)
    .logradouro(EndDto.logradouro)
    .bairro(EndDto.bairro)
    .localidade(EndDto.localidade)
    .complemento(EndDto.complemento)
    .uf(EndDto.uf);
     ControllerEndereco := TcontrollerEndereco.create(RadioButton1,Events);
     ControllerEndereco.strategy(L_endereco,onlyCep);
    LayConfirm.Visible:=false;

end;



procedure TForm1.Rectangle9Click(Sender: TObject);
var
  ControllerEndereco: IControllerEndereco;
  L_Endereco: Endereco;
begin
    L_Endereco:= TBuilder.EnderecoBuilder
    .cep(EndDto.cep)
    .logradouro(EndDto.logradouro)
    .bairro(EndDto.bairro)
    .localidade(EndDto.localidade)
    .complemento(EndDto.complemento)
    .uf(EndDto.uf);
     ControllerEndereco := TcontrollerEndereco.create(RadioButton1,Events);
     ControllerEndereco.pesquisarPorEnderecoCompleto(L_Endereco,true);

    LayConfirm2.Visible:=false;

end;

procedure TForm1.update;
var
  ControllerEndereco: IControllerEndereco;
  begin
  ControllerEndereco := TcontrollerEndereco.create(RadioButton1,Events);
  ControllerEndereco.sincronizar;
  edtPesquisaCep.Text        := EndDto.cep;
  edtPesquisaLogradouro.Text := EndDto.logradouro;
  edtPesquisaCidade.Text     := EndDto.localidade;
  edtPesquisaBairro.Text     := EndDto.bairro;
end;


end.
