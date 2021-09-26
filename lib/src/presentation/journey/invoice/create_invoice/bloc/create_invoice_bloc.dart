import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/enums/bill_enum.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/bill_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/image_usecase.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/invoice_usecase.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/product_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/user_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/create_invoice_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:image_picker/image_picker.dart';

class CreateInvoiceBloc extends Bloc<CreateInvoiceEvent, CreateInvoiceState> {
  final LoaderBloc loaderBloc;
  final SnackbarBloc snackbarBloc;
  final UserBloc userBloc;
  final ImageUseCase imageUC;
  final InvoiceUseCase invoiceUC;
  final ProductUseCase productUC;

  DistributorEntity selectDistributor;
  BillEnum selectBill = BillEnum.Export;
  List<ItemBillEntity> itemBillList = [];
  List<ProductEntity> productList = [];
  List<PickedFile> imageFiles = [];
  int totalAmountBill = 0;
  int _imageQty = 0;
  bool _enableSelectDistributor = false;

  CreateInvoiceBloc({
    @required this.loaderBloc,
    @required this.snackbarBloc,
    @required this.userBloc,
    @required this.imageUC,
    @required this.invoiceUC,
    @required this.productUC,
  });

  @override
  CreateInvoiceState get initialState => WaitingCreateInvoiceState(
        viewState: ViewState.initial,
        enableSelectDistributor: _enableSelectDistributor,
        totalAmountBill: totalAmountBill,
        distributorName: '',
        selectBill: BillEnum.Export,
        itemBillList: [],
        imageFiles: [],
        imageQty: _imageQty,
      );

  @override
  Stream<CreateInvoiceState> mapEventToState(CreateInvoiceEvent event) async* {
    switch (event.runtimeType) {
      case InitialCreateInvoiceEvent:
        yield* _mapInitialCreateInvoiceEventToState();
        break;
      case SelectDistributorEvent:
        yield* _mapSelectDistributorEventToState(event);
        break;
      case SelectBillTypeEvent:
        yield* _mapSelectBillTypeEventToState(event);
        break;
      case AddItemBillEvent:
        yield* _mapAddItemBillEventToState(event);
        break;
      case OpenGalleryEvent:
        yield* _mapOpenGalleryEventToState();
        break;
      case OpenCameraEvent:
        yield* _mapOpenCameraEventToState();
        break;
      case OnCreateEvent:
        yield* _mapOnCreateEvent(event);
        break;
    }
  }

  Stream<CreateInvoiceState> _mapInitialCreateInvoiceEventToState() async* {
    var currentState = state;
    if (currentState is WaitingCreateInvoiceState) {
      loaderBloc.add(StartLoading());
      productList = await productUC.getProductList();
      loaderBloc.add(FinishLoading());
      yield currentState.copyWith();
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
      if (selectBill == BillEnum.Export) {
        _enableSelectDistributor = false;
        selectDistributor = null;
      } else {
        _enableSelectDistributor = true;
      }
      yield currentState.copyWith(
          selectBill: selectBill, enableSelectDistributor: _enableSelectDistributor, distributorName: '');
    }
  }

  Stream<CreateInvoiceState> _mapAddItemBillEventToState(AddItemBillEvent event) async* {
    var currentState = state;
    if (currentState is WaitingCreateInvoiceState) {
      yield currentState.copyWith(viewState: ViewState.loading);
      itemBillList.add(event.itemBill);
      totalAmountBill = setTotalAmountBill();
      yield currentState.copyWith(
          viewState: ViewState.initial, itemBillList: itemBillList, totalAmountBill: totalAmountBill);
    }
  }

  int setTotalAmountBill() {
    int total = 0;
    if (itemBillList.isSafe) {
      for (final ItemBillEntity itemBill in itemBillList) {
        total += itemBill.totalPrice;
      }
    }
    return total;
  }

  Stream<CreateInvoiceState> _mapOpenGalleryEventToState() async* {
    var currentState = state;
    if (currentState is WaitingCreateInvoiceState) {
      yield currentState.copyWith(viewState: ViewState.loading);
      final PickedFile image = await imageUC.getImageFile(ImageSource.gallery);
      if (!ValidatorUtils.isNullEmpty(image)) {
        imageFiles.add(image);
        _imageQty = _setImageQty();
      }
      yield currentState.copyWith(viewState: ViewState.initial, imageFiles: imageFiles, imageQty: _imageQty);
    }
  }

  int _setImageQty() {
    return imageFiles.length;
  }

  Stream<CreateInvoiceState> _mapOpenCameraEventToState() async* {
    var currentState = state;
    if (currentState is WaitingCreateInvoiceState) {
      yield currentState.copyWith(viewState: ViewState.loading);
      final PickedFile image = await imageUC.getImageFile(ImageSource.camera);
      if (!ValidatorUtils.isNullEmpty(image)) {
        imageFiles.add(image);
        _imageQty = _setImageQty();
      }
      yield currentState.copyWith(viewState: ViewState.initial, imageFiles: imageFiles, imageQty: _imageQty);
    }
  }

  bool _checkValidator() {
    if (ValidatorUtils.isNullEmpty(selectBill)) {
      snackbarBloc.add(ShowSnackbar(title: 'Vui lòng chọn kiểu hóa đơn', type: SnackBarType.warning));
      return false;
    }
    if (selectBill == BillEnum.Import && ValidatorUtils.isNullEmpty(selectDistributor)) {
      snackbarBloc.add(ShowSnackbar(title: 'Vui lòng chọn nhà phân phối', type: SnackBarType.warning));
      return false;
    }
    if (ValidatorUtils.isNullEmptyList(itemBillList)) {
      snackbarBloc.add(ShowSnackbar(title: 'Vui lòng nhập danh sách mặt hàng', type: SnackBarType.warning));
      return false;
    }
    return true;
  }

  Stream<CreateInvoiceState> _mapOnCreateEvent(OnCreateEvent event) async* {
    bool flag = _checkValidator();
    var currentState = state;
    if (currentState is WaitingCreateInvoiceState) {
      if (!flag) {
        yield currentState;
      } else {
        loaderBloc.add(StartLoading());
        List itemsJsonArray = invoiceUC.getItemBillJsonArray(itemBillList);
        BillEntity bill = BillEntity(
          customer: event.customer,
          distributor: selectDistributor?.name ?? '',
          type: BillUtils.convertToString(selectBill),
          items: itemsJsonArray,
          totalAmount: totalAmountBill,
          locale: userBloc.locale,
          createAt: DateTime.now().millisecondsSinceEpoch,
          lastUpdate: DateTime.now().millisecondsSinceEpoch,
        );
        bool flag = await invoiceUC.createInvoice(bill);
        if (flag) {
          List<ProductEntity> productList = productUC.getProductListFormItemBill(
            itemBillList: itemBillList,
            locale: userBloc.locale,
            distributor: selectDistributor,
          );
          if (selectBill == BillEnum.Import) {
            await importProductList();
          }
          snackbarBloc
              .add(ShowSnackbar(title: CreateInvoiceConstants.createInvoiceSuccessMsg, type: SnackBarType.success));
          yield CreateInvoiceSuccessState();
        } else {
          snackbarBloc
              .add(ShowSnackbar(title: CreateInvoiceConstants.createInvoiceFailedMsg, type: SnackBarType.error));
          yield currentState;
        }
        loaderBloc.add(FinishLoading());
      }
    }
  }

  Future importProductList() async {
    for (final ItemBillEntity itemBill in itemBillList) {
      ProductEntity product = ProductEntity(
        name: itemBill.name,
        category: itemBill.category,
        qty: itemBill.qty,
        importPrice: itemBill.price,
        exportPrice: itemBill.price,
        locale: userBloc.locale,
        createAt: DateTime.now().millisecondsSinceEpoch,
        lastUpdate: DateTime.now().millisecondsSinceEpoch,
        unit: itemBill.unit,
        distributor: selectDistributor.name,
      );
      if (itemBill.index == -1) {
        productUC.setProduct(product);
      } else {

      }
    }
    await productUC.setProductList(productList);
  }
}
