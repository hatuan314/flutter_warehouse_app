import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/product/product.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'package:flutterwarehouseapp/src/distributor/distributor.dart';
import 'package:flutterwarehouseapp/data/data.dart';
import 'package:flutterwarehouseapp/common/utils/utils.dart';

import 'package:flutterwarehouseapp/src/invoice/domain/domain.dart';

part 'create_new_invoice_event.dart';
part 'create_new_invoice_state.dart';

class CreateNewInvoiceBloc
    extends Bloc<CreateNewInvoiceEvent, CreateNewInvoiceState> {
  var _allProducts = <ProductEntity>[];
  var _allProductsOfInvoice = <ProductOfInvoiceEntity>[];
  var _allDistributors = <DistributorEntity>[];
  double _totalPrice = 0;
  String _distributorName = '';
  var _container = kiwi.Container();
  int _invoiceDateMilliseconds = 0;

  CreateNewInvoiceBloc() {
    _allProducts =
        _container.resolve<ShareService>('share_service').allProducts;
    _allDistributors =
        _container.resolve<ShareService>('share_service').allDistributors;
    _invoiceDateMilliseconds =
        DateConvert.dateTimeConvertToMilliseconds(DateTime.now());
  }

  @override
  // TODO: implement initialState
  CreateNewInvoiceState get initialState => CreateNewInvoiceLoadState();

  @override
  Stream<CreateNewInvoiceState> mapEventToState(
      CreateNewInvoiceEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetAllProductsEvent) yield* _mapGetAllProductsEventToState();
    if (event is BtnAddDialogOnPressEvent) {
      if (event.index != null)
        yield* _mapUpdateProductEventToState(event);
      else
        yield* _mapAddProductEventToState(event);
    }
    if (event is BtnRemoveProductOfInvoiceOnPressEvent)
      yield* _mapRemoveProductEventToState(event);
    if (event is SelectDistributorOnPressEvent)
      yield* _mapSelectDistributorEventToState(event.distributorIndex);
    if (event is SelectDateInvoiceOnPressEvent)
      yield* _mapSelectInvoiceDateEventToState(event.invoiceDate);
  }

  Stream<CreateNewInvoiceState> _mapGetAllProductsEventToState() async* {
    yield CreateNewInvoiceLoadState();
    if (_allProducts.isEmpty) {
      _allProducts = await _container.resolve<ProductUseCase>().getAllProducts();
      _container.resolve<ShareService>('share_service').allProducts =
          _allProducts;
    }
    if (_allDistributors.isEmpty) {
      _allDistributors = await _container
          .resolve<DistributorUseCase>()
          .getAllDistributors();
      _container.resolve<ShareService>('share_service').allDistributors =
          _allDistributors;
      debugPrint(
          'CreateNewInvoiceBloc - mapGetAllProductsEventToState - allDistributors: ${_allDistributors.length}');
    }

    yield CreateNewInvoiceInitialState(
        _allProductsOfInvoice,
        _allDistributors,
        _distributorName,
        _totalPrice,
        DateConvert.millisecondsConvertToDateFormat(_invoiceDateMilliseconds));
  }

  Stream<CreateNewInvoiceState> _mapAddProductEventToState(
      BtnAddDialogOnPressEvent event) async* {
    yield CreateNewInvoiceLoadState();
    _totalPrice = 0;
    final ProductOfInvoiceEntity productOfInvoiceModel = ProductOfInvoiceEntity(
        productName: event.productName,
        enteredPrice: event.enteredPrice,
        amount: event.amount);
    _allProductsOfInvoice.add(productOfInvoiceModel);
    _totalPrice = setTotalPrice();
    yield CreateNewInvoiceInitialState(
        _allProductsOfInvoice,
        _allDistributors,
        _distributorName,
        _totalPrice,
        DateConvert.millisecondsConvertToDateFormat(_invoiceDateMilliseconds));
  }

  double setTotalPrice() {
    double total = 0;
    _allProductsOfInvoice.forEach((productOfInvoiceModel) => total +=
        double.parse(productOfInvoiceModel.enteredPrice) *
            double.parse(productOfInvoiceModel.amount));
    return total;
  }

  Stream<CreateNewInvoiceState> _mapUpdateProductEventToState(
      BtnAddDialogOnPressEvent event) async* {
    yield CreateNewInvoiceLoadState();
    final ProductOfInvoiceEntity productOfInvoiceModel = ProductOfInvoiceEntity(
        productName: event.productName,
        enteredPrice: event.enteredPrice,
        amount: event.amount);
    _allProductsOfInvoice[event.index] = productOfInvoiceModel;
    _totalPrice = setTotalPrice();
    yield CreateNewInvoiceInitialState(
        _allProductsOfInvoice,
        _allDistributors,
        _distributorName,
        _totalPrice,
        DateConvert.millisecondsConvertToDateFormat(_invoiceDateMilliseconds));
  }

  Stream<CreateNewInvoiceState> _mapRemoveProductEventToState(
      BtnRemoveProductOfInvoiceOnPressEvent event) async* {
    yield CreateNewInvoiceLoadState();
    _allProductsOfInvoice.removeAt(event.index);
    yield CreateNewInvoiceInitialState(
        _allProductsOfInvoice,
        _allDistributors,
        _distributorName,
        _totalPrice,
        DateConvert.millisecondsConvertToDateFormat(_invoiceDateMilliseconds));
  }

  Stream<CreateNewInvoiceState> _mapSelectDistributorEventToState(
      int distributorIndex) async* {
    yield CreateNewInvoiceLoadState();
    debugPrint('$distributorIndex');
    _distributorName = _allDistributors[distributorIndex].name;
    debugPrint('$_distributorName');
    yield CreateNewInvoiceInitialState(
        _allProductsOfInvoice,
        _allDistributors,
        _distributorName,
        _totalPrice,
        DateConvert.millisecondsConvertToDateFormat(_invoiceDateMilliseconds));
  }

  Stream<CreateNewInvoiceState> _mapSelectInvoiceDateEventToState(
      DateTime date) async* {
    yield SelectInvoiceDateState();
    _invoiceDateMilliseconds = DateConvert.dateTimeConvertToMilliseconds(date);
    yield CreateNewInvoiceInitialState(
        _allProductsOfInvoice,
        _allDistributors,
        _distributorName,
        _totalPrice,
        DateConvert.millisecondsConvertToDateFormat(_invoiceDateMilliseconds));
  }
}
