part of 'create_new_invoice_bloc.dart';

abstract class CreateNewInvoiceState extends Equatable {

}

class CreateNewInvoiceInitialState extends CreateNewInvoiceState {
  final List<ProductOfInvoiceModel> allProductsOfInvoice;
  final double totalPrice;
  CreateNewInvoiceInitialState(this.allProductsOfInvoice, this.totalPrice);

  @override
  // TODO: implement props
  List<Object> get props => [this.allProductsOfInvoice, this.totalPrice];

}

class AddProductOfInvoiceState extends CreateNewInvoiceState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class RemoveProductOfInvoiceState extends CreateNewInvoiceState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class CreateNewInvoiceLoadState extends CreateNewInvoiceState {
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}

class CreateNewInvoiceSuccessState extends CreateNewInvoiceState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class CreateNewInvoiceFailureState extends CreateNewInvoiceState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}