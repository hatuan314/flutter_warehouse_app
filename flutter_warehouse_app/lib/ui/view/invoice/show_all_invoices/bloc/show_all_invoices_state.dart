part of 'show_all_invoices_bloc.dart';

abstract class ShowAllInvoicesState extends Equatable {}

class ShowAllInvoicesLoadingState extends ShowAllInvoicesState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ShowAllInvoicesSuccessState extends ShowAllInvoicesState {
  final List<InvoiceModel> allInvoices;

  ShowAllInvoicesSuccessState(this.allInvoices);

  @override
  // TODO: implement props
  List<Object> get props => [this.allInvoices];
}

class ShowAllInvoicesFailureState extends ShowAllInvoicesState {
  final String error;

  ShowAllInvoicesFailureState(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [this.error];

  @override
  String toString() => 'ShowAllInvoicesFailureState - Error: {$error}';
}
