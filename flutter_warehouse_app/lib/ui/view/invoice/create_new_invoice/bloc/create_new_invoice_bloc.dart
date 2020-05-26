import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'package:flutterwarehouseapp/models/models.dart';
import 'package:flutterwarehouseapp/service/service.dart';
import 'package:flutterwarehouseapp/ui/view/distributor/bloc/distributor_bloc.dart';

part 'create_new_invoice_event.dart';

part 'create_new_invoice_state.dart';

class CreateNewInvoiceBloc
    extends Bloc<CreateNewInvoiceEvent, CreateNewInvoiceState> {
  var _allProducts = <ProductModel>[];
  var _allProductsOfInvoice = <ProductOfInvoiceModel>[];
  var _allDistributors = <DistributorModel>[];
  double _totalPrice = 0;

  var _container = kiwi.Container();

  var _productRepository = ProductRepository();

  CreateNewInvoiceBloc() {
    _allProducts =
        _container.resolve<ShareService>('share_service').allProducts;
    _allDistributors =
        _container.resolve<ShareService>('share_service').allDistributors;
  }

  @override
  // TODO: implement initialState
  CreateNewInvoiceState get initialState => CreateNewInvoiceLoadState();

  @override
  Stream<CreateNewInvoiceState> mapEventToState(
      CreateNewInvoiceEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetAllProductsEvent) yield* _mapGetAllProductsEventToState();
    if (event is btnAddDialogOnPressEvent) if (event.index != null)
      yield* _mapUpdateProductEventToState(event);
    else
      yield* _mapAddProductEventToState(event);
    if (event is BtnRemoveProductOfInvoiceOnPressEvent)
      yield* _mapRemoveProductEventToState(event);
  }

  Stream<CreateNewInvoiceState> _mapGetAllProductsEventToState() async* {
    yield CreateNewInvoiceLoadState();
    if (_allProducts.isEmpty) {
      _allProducts = await _productRepository.fetchProductRepository();
      _container.resolve<ShareService>('share_service').allProducts =
          _allProducts;
    }

    yield CreateNewInvoiceInitialState(_allProductsOfInvoice, _totalPrice);
  }

  Stream<CreateNewInvoiceState> _mapAddProductEventToState(
      btnAddDialogOnPressEvent event) async* {
    yield CreateNewInvoiceLoadState();
    _totalPrice = 0;
    final ProductOfInvoiceModel productOfInvoiceModel = ProductOfInvoiceModel(
        productName: event.productName,
        enteredPrice: event.enteredPrice,
        amount: event.amount);
    _allProductsOfInvoice.add(productOfInvoiceModel);
    _totalPrice = setTotalPrice();
    yield CreateNewInvoiceInitialState(_allProductsOfInvoice, _totalPrice);
  }

  double setTotalPrice() {
    double total = 0;
    _allProductsOfInvoice.forEach((productOfInvoiceModel) => total +=
        double.parse(productOfInvoiceModel.enteredPrice) *
            double.parse(productOfInvoiceModel.amount));
    return total;
  }

  Stream<CreateNewInvoiceState> _mapUpdateProductEventToState(
      btnAddDialogOnPressEvent event) async* {
    yield CreateNewInvoiceLoadState();
    final ProductOfInvoiceModel productOfInvoiceModel = ProductOfInvoiceModel(
        productName: event.productName,
        enteredPrice: event.enteredPrice,
        amount: event.amount);
    _allProductsOfInvoice[event.index] = productOfInvoiceModel;
    _totalPrice = setTotalPrice();
    yield CreateNewInvoiceInitialState(_allProductsOfInvoice, _totalPrice);
  }

  Stream<CreateNewInvoiceState> _mapRemoveProductEventToState(
      BtnRemoveProductOfInvoiceOnPressEvent event) async* {
    yield CreateNewInvoiceLoadState();
    _allProductsOfInvoice.removeAt(event.index);
    yield CreateNewInvoiceInitialState(_allProductsOfInvoice, _totalPrice);
  }
}
