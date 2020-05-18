part of 'create_new_invoice_bloc.dart';

abstract class CreateNewInvoiceState extends Equatable {

}

class CreateNewInvoiceInitialState extends CreateNewInvoiceState {
  final List<ProductModel> allProducts;
  CreateNewInvoiceInitialState(this.allProducts);

  @override
  // TODO: implement props
  List<Object> get props => [this.allProducts];

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