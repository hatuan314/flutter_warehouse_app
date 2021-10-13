import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/invoice_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/invoice_page/bloc/invoice_page_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/invoice_page/bloc/invoice_page_state.dart';

class InvoicePageBloc extends Bloc<InvoicePageEvent, InvoicePageState> {
  final InvoiceUseCase invoiceUc;
  final LoaderBloc loaderBloc;

  List<BillEntity> exportBillList;
  List<BillEntity> importBillList;

  InvoicePageBloc({@required this.invoiceUc, @required this.loaderBloc});

  @override
  InvoicePageState get initialState => InvoicePageState();

  @override
  Stream<InvoicePageState> mapEventToState(InvoicePageEvent event) async* {
    switch (event.runtimeType) {
      case InitialInvoiceEvent:
        yield* _mapInitialInvoicePageEventToState();
        break;
    }
  }

  Stream<InvoicePageState> _mapInitialInvoicePageEventToState() async* {
    loaderBloc.add(StartLoading());
    List<BillEntity> exportBillList = await invoiceUc.getExportBillList();
    List<BillEntity> importBillList = await invoiceUc.getImportBillList();
    yield state.copyWith(exportBillList: exportBillList, importBillList: importBillList);
    loaderBloc.add(FinishLoading());
  }
}
