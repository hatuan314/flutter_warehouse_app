part of 'create_new_invoice_bloc.dart';

abstract class CreateNewInvoiceEvent extends Equatable {}

class GetAllProductsEvent extends CreateNewInvoiceEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class BtnSaveOnPressEvent extends CreateNewInvoiceEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class BtnRemoveProductOfInvoiceOnPressEvent extends CreateNewInvoiceEvent {
  final int index;

  BtnRemoveProductOfInvoiceOnPressEvent(this.index);

  @override
  // TODO: implement props
  List<Object> get props => [this.index];
}

class btnAddDialogOnPressEvent extends CreateNewInvoiceEvent {
  final String productName;
  final String amount;
  final String enteredPrice;
  final int index;

  btnAddDialogOnPressEvent(
      {this.productName, this.amount, this.enteredPrice, this.index});

  @override
  // TODO: implement props
  List<Object> get props =>
      [this.productName, this.amount, this.enteredPrice, this.index];
}
