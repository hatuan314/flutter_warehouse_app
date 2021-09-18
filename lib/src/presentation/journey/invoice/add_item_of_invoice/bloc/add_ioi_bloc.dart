import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/currency_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/product_usecase.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/unit_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/bloc/add_ioi_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/bloc/add_ioi_state.dart';

class AddIoiBloc extends Bloc<AddIoiEvent, AddIoiState> {
  final LoaderBloc loaderBloc;
  final UnitUseCase unitUc;
  final ProductUseCase productUc;

  String _errorName;
  UnitEntity _selectUnit;
  CategoryEntity _selectCategory;
  List<ProductEntity> _productList;

  AddIoiBloc({
    @required this.loaderBloc,
    @required this.unitUc,
    @required this.productUc,
  });

  @override
  AddIoiState get initialState => WaitingAddIoiState(
        selectUnit: '',
        selectCategory: '',
        errorName: null,
        productList: [],
      );

  @override
  Stream<AddIoiState> mapEventToState(AddIoiEvent event) async* {
    switch (event.runtimeType) {
      case InitialAddIoiEvent:
        yield* _mapInitialAddIoiEventToState();
        break;
      case SelectUnitEvent:
        yield* _mapSelectUnitEventToState(event);
        break;
      case SelectCategoryEvent:
        yield* _mapSelectCategoryEventToState(event);
        break;
      case AddItemEvent:
        yield* _mapAddItemEventToState(event);
        break;
      case SelectProductEvent:
        yield* _mapSelectProductEventToState(event);
        break;
    }
  }

  Stream<AddIoiState> _mapInitialAddIoiEventToState() async* {
    loaderBloc.add(StartLoading());
    var currentState = state;
    _selectUnit = await unitUc.getFirstUnit();
    _productList = await productUc.getProductList();
    if (currentState is WaitingAddIoiState) {
      yield currentState.copyWith(selectUnit: _selectUnit.name, productList: _productList);
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

  Stream<AddIoiState> _mapSelectCategoryEventToState(SelectCategoryEvent event) async* {
    var currentState = state;
    _selectCategory = event.category;
    if (currentState is WaitingAddIoiState) {
      yield currentState.copyWith(selectCategory: _selectCategory.name);
    }
  }

  Stream<AddIoiState> _mapAddItemEventToState(AddItemEvent event) async* {
    var currentState = state;
    if (currentState is WaitingAddIoiState) {
      if (ValidatorUtils.isNullEmpty(event.name)) {
        _errorName = StringConstants.emptyField;
        yield currentState.copyWith(errorName: _errorName);
      } else {
        int qty = int.parse(event.qty);
        int price = int.parse(CurrencyUtils.cleanPriceText(event.price, '₫'));
        int totalPrice = qty * price;
        final ItemBillEntity itemBill = ItemBillEntity(
          name: event.name,
          category: _selectCategory?.name ?? '',
          qty: qty,
          price: price,
          totalPrice: totalPrice,
          unit: _selectUnit?.name ?? '',
        );
        yield AddToBillState(itemBill);
      }
    }
  }

  Stream<AddIoiState> _mapSelectProductEventToState(SelectProductEvent event) async* {
    var currentState = state;
    if (currentState is WaitingAddIoiState) {
      ProductEntity product = event.product;
      yield currentState.copyWith(selectCategory: product.category);
    }
  }
}
