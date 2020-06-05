import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/invoice/domain/domain.dart';
import 'package:flutterwarehouseapp/src/invoice/domain/entities/entities.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

part 'show_all_invoices_state.dart';

part 'show_all_invoices_event.dart';

class ShowAllInvoicesBloc
    extends Bloc<ShowAllInvoicesEvent, ShowAllInvoicesState> {
  var container = kiwi.Container();

  var _allInvoices = <InvoiceEntity>[];

  @override
  // TODO: implement initialState
  ShowAllInvoicesState get initialState => ShowAllInvoicesLoadingState();

  @override
  Stream<ShowAllInvoicesState> mapEventToState(
      ShowAllInvoicesEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetAllInvoicesEvent) yield* _mapGetAllInvoicesEventToState();
  }

  Stream<ShowAllInvoicesState> _mapGetAllInvoicesEventToState() async* {
    yield ShowAllInvoicesLoadingState();
    try {
      _allInvoices =
          await container.resolve<InvoicesUserCase>().getAllInvoiceUserCase();
      debugPrint(
          'ShowAllInvoicesBloc - mapGetAllInvoicesEventToState - allInvoices: ${_allInvoices.length}');
      yield ShowAllInvoicesSuccessState(_allInvoices);
    } catch (e) {
      yield ShowAllInvoicesFailureState(e.toString());
    }
  }
}
