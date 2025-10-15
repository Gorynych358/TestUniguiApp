unit View.MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, DateUtils, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniLabel, uniGUIBaseClasses,
  uniButton, ViewModel.Main, Model.Main, Model.ProSu.Interfaces,
  Model.Interfaces, Model.ProSu.Provider, Model.IEntity, Model.SourceUnit,
  uniEdit, uniMemo;

type
  TMainForm = class(TUniForm)
   LabelTitle: TUniLabel;
   ButtonInvoice: TUniButton;
   LabelTotalSalesText: TUniLabel;
   LabelTotalSalesFigure: TUniLabel;
    DebugOutputMemo: TUniMemo;
    procedure UniFormCreate(Sender: TObject);
    procedure ButtonInvoiceClick(Sender: TObject);
  private
    { Private declarations }
    fMainModel: IMainModelInterface;
    fViewModel: IMainViewModelInterface;
    fSubscriber: ISubscriberInterface;
    //Дебаговое текстовое поле(временное)
    fTmpTestEntity:TSourceUnit;
    procedure SetViewModel (const newViewModel: IMainViewModelInterface);
    procedure NotificationFromProvider (const notifyClass: INotificationClass);
    procedure UpdateLabels;
    procedure UpdateTotalSalesFigure;
  public
    { Public declarations }
    property ViewModel: IMainViewModelInterface read fViewModel write SetViewModel;
  end;

function MainForm: TMainForm;

implementation
  

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication,
  Model.ProSu.Subscriber, Model.Declarations,
  Model.ProSu.InterfaceActions, View.InvoiceForm,
  Model.Invoice, ViewModel.Invoice;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

{ TMainForm }

procedure TMainForm.UniFormCreate(Sender: TObject);
var tmpTestEntity:TSourceUnit;
begin
//Временное поле для вывода тестовой информации(в релизе удалить)
  fTmpTestEntity:=TSourceUnit.Create();
  fTmpTestEntity.Caption:= 'sample source 1';
  fTmpTestEntity.Who:= 'a7fb3ae9-806a-11ed-a408-02420a00063a';
  fTmpTestEntity.Svcid:= 'datacomm';
  fTmpTestEntity.Lid:= 'a7fb3ae9-806a-11ed-a408-02420a00063a';
  fTmpTestEntity.Created:= UnixToDateTime(1671543109);
  fTmpTestEntity.Updated:= UnixToDateTime(1671548483);



  fMainModel:=CreateMainModelClass;
  fViewModel:=CreateMainViewModelClass;
  fViewModel.Model:=fMainModel;
  fSubscriber:=CreateProSuSubscriberClass;
  fSubscriber.SetUpdateSubscriberMethod(NotificationFromProvider);
  UpdateLabels;
  UpdateTotalSalesFigure;
end;

procedure TMainForm.ButtonInvoiceClick(Sender: TObject);
var
  tmpInvoiceForm: TSalesInvoiceForm;
  invoiceModel: IInvoiceModelInterface;
  invoiceViewModel: IInvoiceViewModelInterface;
begin
  invoiceModel:=CreateInvoiceModelClass;
  invoiceViewModel:=CreateInvoiceViewModelClass;
  invoiceViewModel.Model:=invoiceModel;

  tmpInvoiceForm:=TSalesInvoiceForm(UniMainModule.GetFormInstance(TSalesInvoiceForm));
  tmpInvoiceForm.ViewModel:=invoiceViewModel;
  tmpInvoiceForm.Provider.Subscribe(fSubscriber);
  //ShowMessage('New form is created!');
  if tmpInvoiceForm.ShowModal = mrOk then
    ShowMessage('Invoice form shows as modal!');

  {try
    tmpInvoiceForm.ShowModal;
  finally
    tmpInvoiceForm.Free;
  end;  }

end;

procedure TMainForm.NotificationFromProvider(
  const notifyClass: INotificationClass);
var
  tmpNotifClass: TNotificationClass;
begin
  if notifyClass is TNotificationClass then
  begin
    tmpNotifClass:=notifyClass as TNotificationClass;
    if actUpdateTotalSalesFigure in tmpNotifClass.Actions then
      LabelTotalSalesFigure.Text:=fViewModel.GetTotalSalesValue;
  end;
end;

procedure TMainForm.SetViewModel(const newViewModel: IMainViewModelInterface);
begin
  ShowMessage('View model added');
  {fViewModel:=newViewModel;}
  UpdateLabels;
  UpdateTotalSalesFigure;
end;

procedure TMainForm.UpdateLabels;
begin
  LabelTitle.Caption := fViewModel.LabelsText.Title;
  LabelTotalSalesText.Caption := fViewModel.LabelsText.TotalSalesText;
  LabelTotalSalesFigure.Caption := fViewModel.GetTotalSalesValue;
  //Вывод во временное поле для вывода тестовой информации(в релизе удалить)
  DebugOutputMemo.Clear;
  DebugOutputMemo.Lines.Add('Caption: ' + fTmpTestEntity.Caption);
  DebugOutputMemo.Lines.Add('Who: ' + fTmpTestEntity.Who);
  DebugOutputMemo.Lines.Add('Svcid: ' + fTmpTestEntity.Svcid);
  DebugOutputMemo.Lines.Add('Lid: ' + fTmpTestEntity.Lid);
  DebugOutputMemo.Lines.Add('Created ' + DateToStr(fTmpTestEntity.Created));
  DebugOutputMemo.Lines.Add('Updated ' + DateToStr(fTmpTestEntity.Updated));
end;

procedure TMainForm.UpdateTotalSalesFigure;
begin
  ButtonInvoice.Caption := fViewModel.LabelsText.IssueButtonCaption;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
