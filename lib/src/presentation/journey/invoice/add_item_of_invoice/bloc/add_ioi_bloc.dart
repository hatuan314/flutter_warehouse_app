import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/currency_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/invoice_usecase.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/product_usecase.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/unit_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/bloc/add_ioi_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/bloc/add_ioi_state.dart';

class AddIoiBloc extends Bloc<AddIoiEvent, AddIoiState> {
  final LoaderBloc loaderBloc;
  final UnitUseCase unitUc;
  final ProductUseCase productUc;
  final InvoiceUseCase invoiceUc;

  String _errorName;
  String _selectUnit;
  String _selectCategory;
  ProductEntity _selectProduct;
  List<ProductEntity> _productList = [];

  AddIoiBloc({
    @required this.loaderBloc,
    @required this.unitUc,
    @required this.productUc,
    @required this.invoiceUc,
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
        yield* _mapInitialAddIoiEventToState(event);
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

  Stream<AddIoiState> _mapInitialAddIoiEventToState(InitialAddIoiEvent event) async* {
    loaderBloc.add(StartLoading());
    var currentState = state;
    await getProductList(event.distributor);
    if (ValidatorUtils.isNullEmpty(event.itemBill)) {
      UnitEntity unit = await unitUc.getFirstUnit();
      _selectUnit = unit?.name ?? '';
      _selectProduct = ProductEntity(distributor: event.distributor);
    } else {
      _selectUnit = event.itemBill.unit;
      _selectCategory = event.itemBill.category;
      _selectProduct = await _setSelectProduct(itemBill: event.itemBill);
      log('>>>>>>>AddIoiBloc.InitialAddIoiEvent.selectProduct: ${_selectProduct?.distributor}');
    }
    if (currentState is WaitingAddIoiState) {
      yield currentState.copyWith(
        selectUnit: _selectUnit,
        productList: _productList,
        selectCategory: _selectCategory,
      );
    }
    loaderBloc.add(FinishLoading());
  }

  Future<void> getProductList(String distributor) async {
    List<ProductEntity> productList = await productUc.getProductList();
    if (ValidatorUtils.isNullEmpty(distributor)) {
      _productList.addAll(productList);
    } else {
      for (final ProductEntity product in productList) {
        if (product.distributor == distributor) {
          _productList.add(product);
        }
      }
    }
  }

  Future<ProductEntity> _setSelectProduct({ItemBillEntity itemBill}) async {
    for (int index = 0; index < _productList.length; index++) {
      ProductEntity productElement = _productList[index];
      if (productElement.distributor == itemBill?.distributor &&
          productElement.name == itemBill.name &&
          productElement.category == itemBill.category) {
        return productElement;
      }
    }
    return null;
  }

  Stream<AddIoiState> _mapSelectUnitEventToState(SelectUnitEvent event) async* {
    var currentState = state;
    UnitEntity unit = event.unit;
    _selectUnit = unit?.name ?? '';
    if (currentState is WaitingAddIoiState) {
      yield currentState.copyWith(selectUnit: _selectUnit);
    }
  }

  Stream<AddIoiState> _mapSelectCategoryEventToState(SelectCategoryEvent event) async* {
    var currentState = state;
    CategoryEntity category = event.category;
    _selectCategory = category?.name;
    if (currentState is WaitingAddIoiState) {
      yield currentState.copyWith(selectCategory: _selectCategory);
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
          category: _selectCategory ?? '',
          qty: qty,
          price: price,
          totalPrice: totalPrice,
          unit: _selectUnit ?? '',
          distributor: _selectProduct.distributor,
        );
        int index = await productUc.getProductIndex(
            productList: _productList,
            currentProduct: ProductEntity(
              name: itemBill?.name ?? '',
              category: itemBill?.category ?? '',
              distributor: ValidatorUtils.isNullEmpty(_selectProduct) ? '' : _selectProduct?.distributor,
            ));
        itemBill.index = index;
        if (event.billType == BillEnum.Export) {
          bool flag = await invoiceUc.isLimitedProductQty(itemBill);
          if (!flag) {
            yield AddToBillState(itemBill);
          }
        } else {
          yield AddToBillState(itemBill);
        }
      }
    }
  }

  Stream<AddIoiState> _mapSelectProductEventToState(SelectProductEvent event) async* {
    var currentState = state;
    if (currentState is WaitingAddIoiState) {
      _selectProduct = event.product;
      _selectCategory = _selectProduct.category;
      _selectUnit = _selectProduct.unit;
      yield currentState.copyWith(selectCategory: _selectCategory, selectUnit: _selectUnit);
    }
  }
}
