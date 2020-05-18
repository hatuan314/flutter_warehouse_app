import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/models/invoice/product_of_invoice_model.dart';
import 'package:flutterwarehouseapp/models/product/product_model.dart';
import 'package:flutterwarehouseapp/service/service.dart';
import 'package:flutterwarehouseapp/service_locator.dart';


part 'create_new_invoice_event.dart';
part 'create_new_invoice_state.dart';

class CreateNewInvoiceBloc extends Bloc<CreateNewInvoiceEvent, CreateNewInvoiceState> {
  var allProducts = <ProductModel> [];
  var allProductOfInvoices = <ProductOfInvoiceModel> [];

  var _shareService = locator<ShareService>();
  var _productRepository = ProductRepository();

  @override
  // TODO: implement initialState
  CreateNewInvoiceState get initialState => CreateNewInvoiceLoadState();

  @override
  Stream<CreateNewInvoiceState> mapEventToState(CreateNewInvoiceEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetAllProductsEvent)
      yield* _mapGetAllProductsEventToState();
  }

  Stream<CreateNewInvoiceState> _mapGetAllProductsEventToState() async* {
    yield CreateNewInvoiceLoadState();
    if (_shareService.allProducts.isNotEmpty) {
      allProducts.addAll(_shareService.allProducts);
    } else {
      allProducts = await _productRepository.fetchProductRepository();
      debugPrint('_mapGetAllProductsEventToState - allProduct: ${allProducts.length}');
    }
    yield CreateNewInvoiceInitialState(allProducts);
  }
}