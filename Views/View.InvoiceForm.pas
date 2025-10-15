unit View.InvoiceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniMultiItem, uniComboBox, uniLabel,
  uniGUIBaseClasses, uniGroupBox, uniBasicGrid, uniStringGrid, uniButton,
  uniEdit, uniProgressBar, uniCheckBox, Model.Interfaces,
  Model.ProSu.Interfaces, Model.ProSu.Subscriber, Model.Declarations, Vcl.Menus;

type
  TSalesInvoiceForm = class(TUniForm)
    GroupBoxCustomerDetails: TUniGroupBox;
    LabelCustomer: TUniLabel;
    LabelDiscountRate: TUniLabel;
    LabelTotalBalanceBig: TUniLabel;
    LabelOutstandingBalance: TUniLabel;
    LabelDiscountRateFigure: TUniLabel;
    PopupBoxCustomer: TUniComboBox;
    LabelTitle: TUniLabel;
    LabelInvoiceBalance: TUniLabel;
    GroupBoxInvoiceItems: TUniGroupBox;
    LabelItem: TUniLabel;
    LabelQuantity: TUniLabel;
    PopupBoxItems: TUniComboBox;
    EditQuantity: TUniEdit;
    ButtonAddItem: TUniButton;
    StringGridItems: TUniStringGrid;
    GroupBoxBalance: TUniGroupBox;
    LabelInvBalance: TUniLabel;
    LabelDiscount: TUniLabel;
    LabelTotalBalance: TUniLabel;
    LabelRunningBalance: TUniLabel;
    CheckBoxDiscount: TUniCheckBox;
    ButtonPrintInvoice: TUniButton;
    ButtonCancel: TUniButton;
    AniIndicatorProgress: TUniProgressBar;
    LabelPrinting: TUniLabel;
    PopupMenuItems: TPopupMenu;
    MenuItemDeleteItem: TMenuItem;
    LabelTotal: TUniLabel;
    procedure PopupBoxCustomerChange(Sender: TObject);
    procedure ButtonAddItemClick(Sender: TObject);
    procedure MenuItemDeleteItemClick(Sender: TObject);
    procedure CheckBoxDiscountChange(Sender: TObject);
    procedure ButtonPrintInvoiceClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
  private
    { Private declarations }
    fViewModel: IInvoiceViewModelInterface;
    fSubscriber: ISubscriberInterface;
    fCustomerDetailsText: TCustomerDetailsText;
    fInvoiceItemsText: TInvoiceItemsText;
    fProvider: IProviderInterface;
    procedure SetViewModel (const newViewModel: IInvoiceViewModelInterface);
    procedure UpdateLabels;
    procedure SetupGUI;
    procedure UpdateGroups;
    procedure UpdatePrintingStatus;
    procedure UpdateCustomerDetails;
    procedure UpdateInvoiceGrid;
    procedure UpdateBalances;
    procedure NotificationFromProvider (const notifyClass: INotificationClass);
    procedure UpdateMainBalance;
  public
    { Public declarations }
    property ViewModel: IInvoiceViewModelInterface read fViewModel write SetViewModel;
    property Provider: IProviderInterface read fProvider;
  end;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, System.Generics.Collections, Model.ProSu.InterfaceActions,
  Model.ProSu.Provider;

procedure TSalesInvoiceForm.ButtonAddItemClick(Sender: TObject);
begin
  fViewModel.ValidateItem(PopupBoxItems.Text);
  fViewModel.ValidateQuantity(EditQuantity.Text);
end;

procedure TSalesInvoiceForm.ButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TSalesInvoiceForm.ButtonPrintInvoiceClick(Sender: TObject);
begin
  fViewModel.PrintInvoice;
end;

procedure TSalesInvoiceForm.CheckBoxDiscountChange(Sender: TObject);
begin
  fViewModel.DiscountApplied:=CheckBoxDiscount.Checked;
  fInvoiceItemsText:=fViewModel.InvoiceItemsText;
  UpdateBalances;
end;


procedure TSalesInvoiceForm.MenuItemDeleteItemClick(Sender: TObject);
begin
  {if (StringGridItems.Selected>=0) and
      (StringGridItems.Selected<=StringGridItems.RowCount-1) then
    fViewModel.DeleteInvoiceItem(StringGridItems.Cells[4, StringGridItems.Selected]); }
end;

procedure TSalesInvoiceForm.NotificationFromProvider(
  const notifyClass: INotificationClass);
var
  tmpNotifClass: TNotificationClass;
  tmpErrorNotifClass: TErrorNotificationClass;
begin
  if notifyClass is TNotificationClass then
  begin
    tmpNotifClass:=notifyClass as TNotificationClass;
    if actInvoiceItemsChanges in tmpNotifClass.Actions then
      UpdateInvoiceGrid;
    if actPrintingStart in tmpNotifClass.Actions then
    begin
      AniIndicatorProgress.Visible:=fViewModel.AniIndicatorProgressVisible;
      LabelPrinting.Visible:=fViewModel.LabelPrintingVisible;
    end;
    if actPrintingFinish in tmpNotifClass.Actions then
    begin
      ShowMessage('Invoice Printed');
      AniIndicatorProgress.Visible:=fViewModel.AniIndicatorProgressVisible;
      LabelPrinting.Visible:=fViewModel.LabelPrintingVisible;
      UpdateMainBalance;
      self.Close;
    end;
  end;
  if notifyClass is TErrorNotificationClass then
  begin
    tmpErrorNotifClass:=notifyClass as TErrorNotificationClass;
    if errInvoiceItemEmpty in tmpErrorNotifClass.Actions then
    begin
      ShowMessage(tmpErrorNotifClass.ActionMessage);
      PopupBoxItems.SetFocus;
      Exit;
    end
    else
    if errInvoiceItemQuantityEmpty in tmpErrorNotifClass.Actions then
    begin
      ShowMessage(tmpErrorNotifClass.ActionMessage);
      EditQuantity.SetFocus;
      Exit;
    end
    else
    if (errInvoiceItemQuantityNonPositive in tmpErrorNotifClass.Actions)
      or (errInvoiceItemQuantityNotNumber in tmpErrorNotifClass.Actions) then
    begin
      ShowMessage(tmpErrorNotifClass.ActionMessage);
      EditQuantity.SelectAll;
      EditQuantity.SetFocus;
      Exit;
    end
    else
    begin
      fViewModel.AddInvoiceItem(PopupBoxItems.Text, StrToInt(EditQuantity.text));
    end;
  end;

end;

procedure TSalesInvoiceForm.PopupBoxCustomerChange(Sender: TObject);
begin
  fViewModel.GetCustomerDetails(PopupBoxCustomer.Text,fCustomerDetailsText);
  fViewModel.DeleteAllInvoiceItems;
  PopupBoxItems.ItemIndex:=-1;
  UpdateCustomerDetails;
end;

procedure TSalesInvoiceForm.SetupGUI;
var
  tmpCustomerList: TObjectList<TCustomer>;
  tmpCustomer: TCustomer;
  tmpItemsList: TObjectList<TItem>;
  tmpItem: TItem;
begin
  LabelTitle.Text:=fViewModel.TitleText;
  PopupBoxCustomer.Clear;
  PopupBoxItems.Clear;
  StringGridItems.RowCount:=0;
  EditQuantity.Text:='1';

  fViewModel.GetCustomerList(tmpCustomerList);
  if Assigned(tmpCustomerList) then
  begin
    for tmpCustomer in tmpCustomerList  do
      if Assigned(tmpCustomer) then
        PopupBoxCustomer.Items.Add(tmpCustomer.Name);
  end;
  PopupBoxCustomer.ItemIndex:=-1;

  fViewModel.GetItems(tmpItemsList);
  if Assigned(tmpItemsList) then
  begin
    for tmpItem in tmpItemsList do
      if Assigned(tmpItem) then
        PopupBoxItems.Items.Add(tmpItem.Description);
  end;

  fViewModel.GetCustomerDetails('', fCustomerDetailsText);
  UpdateCustomerDetails;
  UpdateInvoiceGrid;
  UpdateGroups;
end;

procedure TSalesInvoiceForm.SetViewModel(
  const newViewModel: IInvoiceViewModelInterface);
begin
  //ShowMessage('Sets viewModel invoice!');
  fViewModel:=newViewModel;
  if not Assigned(fViewModel) then
    raise Exception.Create('Sales Invoice View Model is required');
  fSubscriber:=CreateProSuSubscriberClass;
  fSubscriber.SetUpdateSubscriberMethod(NotificationFromProvider);
  fViewModel.Provider.Subscribe(fSubscriber);
  UpdateLabels;
  SetupGUI;
  UpdateGroups;
  UpdatePrintingStatus;
  fInvoiceItemsText:=fViewModel.InvoiceItemsText;
  UpdateBalances;
  fProvider:=CreateProSuProviderClass;
end;

procedure TSalesInvoiceForm.UpdateBalances;
begin
  LabelRunningBalance.Text:=fInvoiceItemsText.InvoiceRunningBalance;
  LabelDiscount.Text:=fInvoiceItemsText.InvoiceDiscountFigure;
  LabelInvoiceBalance.Text:=fInvoiceItemsText.InvoiceTotalBalance;
  LabelTotalBalance.Text:=fInvoiceItemsText.InvoiceTotalBalance;
  CheckBoxDiscount.Checked:=fViewModel.DiscountApplied;
end;

procedure TSalesInvoiceForm.UpdateCustomerDetails;
begin
  LabelDiscountRateFigure.Text:=fCustomerDetailsText.DiscountRate;
  LabelTotalBalanceBig.Text:=fCustomerDetailsText.OutstandingBalance;

  UpdateInvoiceGrid;
  UpdateGroups;
end;

procedure TSalesInvoiceForm.UpdateGroups;
begin
  GroupBoxInvoiceItems.Enabled:=fViewModel.GroupBoxInvoiceItemsEnabled;
  GroupBoxBalance.Enabled:=fViewModel.GroupBoxBalanceEnabled;
  ButtonPrintInvoice.Enabled:=fViewModel.ButtonPrintInvoiceEnabled;
end;

procedure TSalesInvoiceForm.UpdateInvoiceGrid;
var
  i: Integer;
begin
  StringGridItems.RowCount:=0;
  fInvoiceItemsText:=fViewModel.InvoiceItemsText;
  for i := 0 to Length(fInvoiceItemsText.DescriptionText)-1 do
  begin
    StringGridItems.RowCount:=StringGridItems.RowCount+1;
    StringGridItems.Cells[0, StringGridItems.RowCount-1]:=fInvoiceItemsText.DescriptionText[i];
    StringGridItems.Cells[1, StringGridItems.RowCount-1]:=fInvoiceItemsText.QuantityText[i];
    StringGridItems.Cells[2, StringGridItems.RowCount-1]:=fInvoiceItemsText.UnitPriceText[i];
    StringGridItems.Cells[3, StringGridItems.RowCount-1]:=fInvoiceItemsText.PriceText[i];
    StringGridItems.Cells[4, StringGridItems.RowCount-1]:=fInvoiceItemsText.IDText[i];
  end;
  UpdateBalances;
  UpdateGroups;
end;

procedure TSalesInvoiceForm.UpdateLabels;
begin
  LabelTitle.Caption:=fViewModel.LabelsText.Title;

  GroupBoxCustomerDetails.Caption:=fViewModel.LabelsText.CustomerDetailsGroupText;
  LabelCustomer.Caption:=fViewModel.LabelsText.CustomerText;
  LabelDiscountRate.Caption:=fViewModel.LabelsText.CustomerDiscountRateText;
  LabelOutstandingBalance.Caption:=fViewModel.LabelsText.CustomerOutstandingBalanceText;

  GroupBoxInvoiceItems.Caption:=fViewModel.LabelsText.InvoiceItemsGroupText;
  LabelItem.Caption:=fViewModel.LabelsText.InvoiceItemsText;
  LabelQuantity.Caption:=fViewModel.LabelsText.InvoiceItemsQuantityText;
  ButtonAddItem.Caption:=fViewModel.LabelsText.InvoiceItemsAddItemButtonText;


  StringGridItems.Columns.Items[0].Title.Caption:=
                            fViewModel.LabelsText.InvoiceItemsGridItemText;
  StringGridItems.Columns.Items[1].Title.Caption:=
                            fViewModel.LabelsText.InvoiceItemsGridQuantityText;
  StringGridItems.Columns.Items[2].Title.Caption:=
                            fViewModel.LabelsText.InvoiceItemsGridUnitPriceText;
  StringGridItems.Columns.Items[3].Title.Caption:=
                            fViewModel.LabelsText.InvoiceItemsGridAmountText;

  GroupBoxBalance.Caption:=fViewModel.LabelsText.BalanceGroupText;
  LabelInvBalance.Caption:=fViewModel.LabelsText.BalanceInvoiceBalanceText;
  CheckBoxDiscount.Caption:=fViewModel.LabelsText.BalanceDiscountText;
  LabelTotal.Caption:=fViewModel.LabelsText.BalanceTotalText;

  ButtonPrintInvoice.Caption:=fViewModel.LabelsText.PrintInvoiceButtonText;
  LabelPrinting.Caption:=fViewModel.LabelsText.PrintingText;
  ButtonCancel.Caption:=fViewModel.LabelsText.CancelButtonText;

end;

procedure TSalesInvoiceForm.UpdateMainBalance;
var
  tmpNotificationClass: TNotificationClass;
begin
  tmpNotificationClass:=TNotificationClass.Create;
  tmpNotificationClass.Actions:=[actUpdateTotalSalesFigure];
  if Assigned(fProvider) then
   fProvider.NotifySubscribers(tmpNotificationClass);
  tmpNotificationClass.Free;
end;

procedure TSalesInvoiceForm.UpdatePrintingStatus;
begin
  AniIndicatorProgress.Visible:=fViewModel.AniIndicatorProgressVisible;
  LabelPrinting.Visible:=fViewModel.LabelPrintingVisible;
end;

end.
