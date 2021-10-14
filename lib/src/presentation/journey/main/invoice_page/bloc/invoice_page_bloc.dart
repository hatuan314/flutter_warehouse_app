import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
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
  InvoicePageState get initialState => LoadingInvoicePageState();

  @override
  Stream<InvoicePageState> mapEventToState(InvoicePageEvent event) async* {
    switch (event.runtimeType) {
      case InitialInvoiceEvent:
        yield* _mapInitialInvoicePageEventToState();
        break;
      case RefreshInvoiceListEvent:
        yield* _mapRefreshInvoiceListEventToState(event);
        break;
    }
  }

  Stream<InvoicePageState> _mapInitialInvoicePageEventToState() async* {
    yield LoadingInvoicePageState();
    exportBillList = await invoiceUc.getExportBillList();
    importBillList = await invoiceUc.getImportBillList();
    log('>>>>>>>>>>InvoicePageBloc.InitialInvoicePageEventToState.exportBills: ${exportBillList.length}');
    log('>>>>>>>>>>InvoicePageBloc.InitialInvoicePageEventToState.importBills: ${importBillList.length}');
    yield InitialInvoicePageState(exportBillList: exportBillList, importBillList: importBillList);
  }

  Stream<InvoicePageState> _mapRefreshInvoiceListEventToState(RefreshInvoiceListEvent event) async* {
    var currentState = state;
    if (currentState is InitialInvoicePageState) {
      yield LoadingInvoicePageState();
      if (event.billType == BillEnum.Export) {
        exportBillList = await invoiceUc.getExportBillList();
      }
      if (event.billType == BillEnum.Import) {
        importBillList = await invoiceUc.getImportBillList();
      }
      yield currentState.copyWith(exportBillList: exportBillList, importBillList: importBillList);
    }
  }
}
