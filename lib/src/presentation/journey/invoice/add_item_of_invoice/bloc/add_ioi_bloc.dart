import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/utils/currency_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/unit_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/bloc/add_ioi_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/bloc/add_ioi_state.dart';

class AddIoiBloc extends Bloc<AddIoiEvent, AddIoiState> {
  final LoaderBloc loaderBloc;
  final UnitUseCase unitUc;
  UnitEntity _selectUnit;

  AddIoiBloc({@required this.loaderBloc, @required this.unitUc});

  @override
  AddIoiState get initialState => WaitingAddIoiState(selectUnit: '');

  @override
  Stream<AddIoiState> mapEventToState(AddIoiEvent event) async* {
    switch (event.runtimeType) {
      case InitialAddIoiEvent:
        yield* _mapInitialAddIoiEventToState();
        break;
      case SelectUnitEvent:
        yield* _mapSelectUnitEventToState(event);
        break;
      case AddItemEvent:
        yield* _mapAddItemEventToState(event);
        break;
    }
  }

  Stream<AddIoiState> _mapInitialAddIoiEventToState() async* {
    loaderBloc.add(StartLoading());
    var currentState = state;
    _selectUnit = await unitUc.getFirstUnit();
    if (currentState is WaitingAddIoiState) {
      yield currentState.copyWith(selectUnit: _selectUnit.name);
    }
    loaderBloc.add(FinishLoading());
  }

  Stream<AddIoiState> _mapSelectUnitEventToState(SelectUnitEvent event) async* {
    var currentState = state;
    _selectUnit = event.unit;
    if (currentState is WaitingAddIoiState) {
      yield currentState.copyWith(selectUnit: _selectUnit.name);
    }
  }

  Stream<AddIoiState> _mapAddItemEventToState(AddItemEvent event) async* {
    int qty = int.parse(event.qty);
    int price = int.parse(CurrencyUtils.cleanPriceText(event.price, '₫'));
    int totalPrice = qty * price;
    final ItemBillEntity itemBill = ItemBillEntity(
      name: event.name,
      qty: qty,
      price: price,
      totalPrice: totalPrice,
      unit: _selectUnit.name
    );
    yield AddToBillState(itemBill);
  }
}
