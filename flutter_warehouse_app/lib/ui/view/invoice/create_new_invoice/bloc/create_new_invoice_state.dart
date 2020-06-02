part of 'create_new_invoice_bloc.dart';

abstract class CreateNewInvoiceState extends Equatable {}

class CreateNewInvoiceInitialState extends CreateNewInvoiceState {
  final List<ProductOfInvoiceModel> allProductsOfInvoice;
  final List<DistributorModel> allDistributors;
  final String distributorName;
  final double totalPrice;
  final String invoiceDate;

  CreateNewInvoiceInitialState(this.allProductsOfInvoice, this.allDistributors,
      this.distributorName, this.totalPrice, this.invoiceDate);

  @override
  // TODO: implement props
  List<Object> get props => [
        this.allProductsOfInvoice,
        this.allDistributors,
        this.distributorName,
        this.totalPrice,
        this.invoiceDate
      ];
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

class SelectDistributorState extends CreateNewInvoiceState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SelectInvoiceDateState extends CreateNewInvoiceState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
