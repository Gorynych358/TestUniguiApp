program TestUniGUIApp;

uses
  Forms,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  View.MainForm in 'Views\View.MainForm.pas' {MainForm: TUniForm},
  View.InvoiceForm in 'Views\View.InvoiceForm.pas' {SalesInvoiceForm: TUniForm},
  Model.Database in 'Models\Model.Database.pas',
  Model.Declarations in 'Models\Model.Declarations.pas',
  Model.Interfaces in 'Models\Model.Interfaces.pas',
  Model.Invoice in 'Models\Model.Invoice.pas',
  Model.Main in 'Models\Model.Main.pas',
  Model.ProSu.InterfaceActions in 'SupportCode\Model.ProSu.InterfaceActions.pas',
  Model.ProSu.Interfaces in 'SupportCode\Model.ProSu.Interfaces.pas',
  Model.ProSu.Provider in 'SupportCode\Model.ProSu.Provider.pas',
  Model.ProSu.Subscriber in 'SupportCode\Model.ProSu.Subscriber.pas',
  ViewModel.Invoice in 'ViewModels\ViewModel.Invoice.pas',
  ViewModel.Main in 'ViewModels\ViewModel.Main.pas',
  Model.IEntity in 'SupportCode\Model.IEntity.pas',
  Model.BaseEntity in 'SupportCode\Model.BaseEntity.pas',
  Model.SourceUnit in 'SupportCode\Model.SourceUnit.pas';

{$R *.res}

begin

  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;

  TUniServerModule.Create(Application);
  Application.Run;

end.
