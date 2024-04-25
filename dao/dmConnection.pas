unit dmConnection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Component.Singleton, Component.Observer;

type
  TDataModule1 = class(TDataModule,IObserver)
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    FDQuery2codigo: TIntegerField;
    FDQuery2cep: TStringField;
    FDQuery2logradouro: TStringField;
    FDQuery2complemento: TStringField;
    FDQuery2bairro: TStringField;
    FDQuery2localidade: TStringField;
    FDQuery2uf: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure update;
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;
    Observable:iObservable;
implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
FDQuery1.ExecSQL;
FDQuery2.Active:= true;
Observable := TSingleton<TObservable>.GetInstance;
Observable.addObserver(Self)
end;

procedure TDataModule1.update;
begin
 FDQuery2.Refresh;
end;

end.
