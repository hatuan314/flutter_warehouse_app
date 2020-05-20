import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/models/models.dart';
import 'package:flutterwarehouseapp/service/service.dart';
import 'package:flutterwarehouseapp/service_locator.dart';
import 'package:flutterwarehouseapp/ui/view/invoice/create_new_invoice/create_new_invoice.dart';

part 'create_new_invoice_event.dart';

part 'create_new_invoice_state.dart';

class CreateNewInvoiceBloc
    extends Bloc<CreateNewInvoiceEvent, CreateNewInvoiceState> {
  var _allProducts = <ProductModel>[];
  var _allProductsOfInvoice = <ProductOfInvoiceModel>[];

  var _shareService = locator<ShareService>();
  var _productRepository = ProductRepository();

  @override
  // TODO: implement initialState
  CreateNewInvoiceState get initialState => CreateNewInvoiceLoadState();

  @override
  Stream<CreateNewInvoiceState> mapEventToState(
      CreateNewInvoiceEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetAllProductsEvent) yield* _mapGetAllProductsEventToState();
    if (event is btnAddDialogOnPressEvent)
//      print('btnAddDialogOnPressEvent: ${event.index}');
    if (event.index != null)
        yield* _mapUpdateProductEventToState(event);
      else
       yield* _mapAddProductEventToState(event);
    if (event is BtnRemoveProductOfInvoiceOnPressEvent)
      yield* _mapRemoveProductEventToState(event);
  }

  Stream<CreateNewInvoiceState> _mapGetAllProductsEventToState() async* {
    yield CreateNewInvoiceLoadState();
    if (_shareService.allProducts.isNotEmpty) {
      _allProducts.addAll(_shareService.allProducts);
    } else {
      _allProducts = await _productRepository.fetchProductRepository();
      debugPrint(
          '_mapGetAllProductsEventToState - allProduct: ${_allProducts.length}');
    }
    yield CreateNewInvoiceInitialState(_allProductsOfInvoice);
  }

  Stream<CreateNewInvoiceState> _mapAddProductEventToState(
      btnAddDialogOnPressEvent event) async* {
    yield CreateNewInvoiceLoadState();
    final ProductOfInvoiceModel productOfInvoiceModel = ProductOfInvoiceModel(
        productName: event.productName,
        enteredPrice: event.enteredPrice,
        amount: event.amount);
    _allProductsOfInvoice.add(productOfInvoiceModel);
    yield CreateNewInvoiceInitialState(_allProductsOfInvoice);
  }

  Stream<CreateNewInvoiceState> _mapUpdateProductEventToState(btnAddDialogOnPressEvent event) async* {
    yield CreateNewInvoiceLoadState();
    final ProductOfInvoiceModel productOfInvoiceModel = ProductOfInvoiceModel(
        productName: event.productName,
        enteredPrice: event.enteredPrice,
        amount: event.amount);
    _allProductsOfInvoice[event.index] = productOfInvoiceModel;
    yield CreateNewInvoiceInitialState(_allProductsOfInvoice);
  }

  Stream<CreateNewInvoiceState> _mapRemoveProductEventToState(
      BtnRemoveProductOfInvoiceOnPressEvent event) async* {
    yield CreateNewInvoiceLoadState();
    _allProductsOfInvoice.removeAt(event.index);
    yield CreateNewInvoiceInitialState(_allProductsOfInvoice);
  }
}
