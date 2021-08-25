import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/enums/bill_enum.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_state.dart';

class CreateInvoiceBloc extends Bloc<CreateInvoiceEvent, CreateInvoiceState> {
  DistributorEntity selectDistributor;
  BillEnum selectBill = BillEnum.Export;
  List<ItemBillEntity> itemBillList = [];

  @override
  CreateInvoiceState get initialState => WaitingCreateInvoiceState(distributorName: '', selectBill: BillEnum.Export);

  @override
  Stream<CreateInvoiceState> mapEventToState(CreateInvoiceEvent event) async* {
    switch (event.runtimeType) {
      case SelectDistributorEvent:
        yield* _mapSelectDistributorEventToState(event);
        break;
      case SelectBillTypeEvent:
        yield* _mapSelectBillTypeEventToState(event);
        break;
      case AddItemBillEvent:
        yield* _mapAddItemBillEventToState(event);
        break;
    }
  }

  Stream<CreateInvoiceState> _mapSelectDistributorEventToState(SelectDistributorEvent event) async* {
    selectDistributor = event.distributor;
    if (state is WaitingCreateInvoiceState) {
      WaitingCreateInvoiceState currentState = state;
      yield currentState.copyWith(distributorName: selectDistributor.name);
    }
  }

  Stream<CreateInvoiceState> _mapSelectBillTypeEventToState(SelectBillTypeEvent event) async* {
    selectBill = event.bill;
    var currentState = state;
    if (currentState is WaitingCreateInvoiceState) {
      yield currentState.copyWith(selectBill: selectBill);
    }
  }

  Stream<CreateInvoiceState> _mapAddItemBillEventToState(AddItemBillEvent event) async* {
    itemBillList.add(event.itemBill);
    var currentState = state;
    if (currentState is WaitingCreateInvoiceState) {
      yield currentState.copyWith(itemBillList: itemBillList);
    }
  }
}
