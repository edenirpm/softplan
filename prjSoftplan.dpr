program prjSoftplan;

uses
  System.StartUpCopy,
  FMX.Forms,
  view.principal in 'view\view.principal.pas' {Form1},
  model.TTypeResult in 'model\model.TTypeResult.pas',
  model.Endereco in 'model\model.Endereco.pas',
  controller.Endereco in 'controller\controller.Endereco.pas',
  Helpers.RadioButtonHelper in 'helpers\Helpers.RadioButtonHelper.pas',
  Component.rest in 'component\Component.rest.pas',
  Component.Observer in 'component\Component.Observer.pas',
  Component.Singleton in 'component\Component.Singleton.pas',
  dmConnection in 'dao\dmConnection.pas' {DataModule1: TDataModule},
  Dao.Endereco in 'dao\Dao.Endereco.pas',
  EnderecoDTO in 'dao\DTO\EnderecoDTO.pas',
  model.Events in 'model\model.Events.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
