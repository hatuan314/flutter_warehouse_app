import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/bill_utils.dart';
import 'package:flutterwarehouseapp/common/utils/image_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/models/bill_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/image_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/distributor_usecase.dart';
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
  final SetupFirebaseDatabase setupFirebase;
  final LoaderBloc loaderBloc;
  final SnackbarBloc snackbarBloc;
  final UserBloc userBloc;
  final DistributorUseCase distributorUC;
  final InvoiceUseCase invoiceUC;
  final ProductUseCase productUC;
  final ImageUseCase imageUC;

  DistributorEntity selectDistributor;
  BillEnum selectBill = BillEnum.Export;
  List<ItemBillEntity> itemBillList = [];
  List<PickedFile> imageFiles = [];
  List<ImageEntity> imageNetworkList = [];
  int totalAmountBill = 0;
  int index;
  int _imageQty = 0;
  bool _enableSelectDistributor = false;
  bool _isEdit = false;
  DateTime selectBillDate = DateTime.now();

  CreateInvoiceBloc({
    @required this.setupFirebase,
    @required this.loaderBloc,
    @required this.snackbarBloc,
    @required this.userBloc,
    @required this.distributorUC,
    @required this.invoiceUC,
    @required this.productUC,
    @required this.imageUC,
  });

  @override
  CreateInvoiceState get initialState => WaitingCreateInvoiceState(
        viewState: ViewState.initial,
        enableSelectDistributor: _enableSelectDistributor,
        totalAmountBill: totalAmountBill,
        distributorName: '',
        selectBill: BillEnum.Export,
        selectBillDate: selectBillDate,
        itemBillList: [],
        imageFiles: [],
        imageQty: _imageQty,
        imageNetworkList: [],
      );

  @override
  Stream<CreateInvoiceState> mapEventToState(CreateInvoiceEvent event) async* {
    switch (event.runtimeType) {
      case InitialCreateInvoiceEvent:
        yield* _mapInitialCreateInvoiceEventToState(event);
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
      case EditItemBillEvent:
        yield* _mapEditItemBillEventToState(event);
        break;
      case GetImageLocalEvent:
        yield* _mapGetImageLocalEventToState(event);
        break;
      case OnCreateEvent:
        yield* _mapOnCreateEvent(event);
        break;
      case SelectBillDateEvent:
        yield* _mapSelectBillDateEventToState(event);
        break;
    }
  }

  Stream<CreateInvoiceState> _mapInitialCreateInvoiceEventToState(InitialCreateInvoiceEvent event) async* {
    var currentState = state;
    if (currentState is WaitingCreateInvoiceState) {
      _isEdit = event.isEdit;
      if (_isEdit) {
        loaderBloc.add(StartLoading());
        BillEntity bill = BillModel.fromJson(jsonDecode(event.billJson));
        index = event.index;
        // Bill Type
        if (bill.type == 'IMPORT') {
          selectBill = BillEnum.Import;
          _enableSelectDistributor = true;
          // Distributor
          selectDistributor = await distributorUC.getDistributorDetail(bill.distributor);
        } else if (bill.type == 'EXPORT') {
          selectBill = BillEnum.Export;
          _enableSelectDistributor = false;
        }
        // Bill date
        selectBillDate = DateTime.fromMillisecondsSinceEpoch(bill.billDate);
        // Item Bill List
        itemBillList = invoiceUC.getItemBillListFromJson(bill.items);
        // Total amount
        totalAmountBill = bill.totalAmount;
        // Images
        imageNetworkList = await _getImageUrls(bill.images);
        _imageQty = _setImageQty();
        loaderBloc.add(FinishLoading());
        yield currentState.copyWith(
          selectBill: selectBill,
          enableSelectDistributor: _enableSelectDistributor,
          distributorName: selectDistributor?.name ?? '',
          selectBillDate: selectBillDate,
          itemBillList: itemBillList,
          totalAmountBill: totalAmountBill,
          imageNetworkList: imageNetworkList,
          imageQty: _imageQty,
        );
      }
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

  Stream<CreateInvoiceState> _mapEditItemBillEventToState(EditItemBillEvent event) async* {
    var currentState = state;
    if (currentState is WaitingCreateInvoiceState) {
      yield currentState.copyWith(viewState: ViewState.loading);
      itemBillList[event.index] = event.itemBill;
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

  Stream<CreateInvoiceState> _mapGetImageLocalEventToState(GetImageLocalEvent event) async* {
    var currentState = state;
    if (currentState is WaitingCreateInvoiceState) {
      yield currentState.copyWith(viewState: ViewState.loading);
      PickedFile image;
      if (event.source == ImageSourceType.Gallery) {
        image = await ImageUtils.getImageFile(ImageSource.gallery);
      } else if (event.source == ImageSourceType.Camera) {
        image = await ImageUtils.getImageFile(ImageSource.camera);
      }
      if (!ValidatorUtils.isNullEmpty(image)) {
        imageFiles.add(image);
        _imageQty = _setImageQty();
      }
      yield currentState.copyWith(viewState: ViewState.initial, imageFiles: imageFiles, imageQty: _imageQty);
    }
  }

  int _setImageQty() {
    if (!ValidatorUtils.isNullEmptyList(imageFiles) && !ValidatorUtils.isNullEmptyList(imageNetworkList)) {
      return imageFiles.length + imageNetworkList.length;
    } else if (!ValidatorUtils.isNullEmptyList(imageFiles) && ValidatorUtils.isNullEmptyList(imageNetworkList)) {
      return imageFiles.length;
    } else if (ValidatorUtils.isNullEmptyList(imageFiles) && !ValidatorUtils.isNullEmptyList(imageNetworkList)) {
      return imageNetworkList.length;
    } else {
      return 0;
    }
  }

  Future<bool> _checkValidator() async {
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
    if (selectBill == BillEnum.Export) {
      bool flag = await checkLimitedProduct();
      if (flag) {
        return false;
      }
    }
    return true;
  }

  Stream<CreateInvoiceState> _mapOnCreateEvent(OnCreateEvent event) async* {
    loaderBloc.add(StartLoading());
    bool flag = await _checkValidator();
    var currentState = state;
    if (currentState is WaitingCreateInvoiceState) {
      if (!flag) {
        yield currentState;
      } else {
        List<String> pathList = await uploadImageBills();
        List itemsJsonArray = invoiceUC.getItemBillJsonArray(itemBillList);
        BillEntity bill = BillEntity(
          customer: event.customer,
          distributor: selectDistributor?.name ?? '',
          type: BillUtils.convertToKey(selectBill),
          items: itemsJsonArray,
          totalAmount: totalAmountBill,
          locale: userBloc.locale,
          billDate: selectBillDate.millisecondsSinceEpoch,
          createAt: DateTime.now().millisecondsSinceEpoch,
          lastUpdate: DateTime.now().millisecondsSinceEpoch,
          description: event?.description?.trim() ?? '',
          images: pathList,
        );
        if (_isEdit) {
          await invoiceUC.updateInvoice(index: index, bill: bill);
          updateProductList();
          snackbarBloc.add(ShowSnackbar(
            title: CreateInvoiceConstants.createInvoiceSuccessMsg,
            type: SnackBarType.success,
          ));
          yield CreateInvoiceSuccessState(billType: selectBill);
        } else {
          bool flag = await invoiceUC.createInvoice(bill);
          if (flag) {
            await updateProductList();
            snackbarBloc.add(ShowSnackbar(
              title: CreateInvoiceConstants.createInvoiceSuccessMsg,
              type: SnackBarType.success,
            ));
            yield CreateInvoiceSuccessState(billType: selectBill);
          } else {
            snackbarBloc.add(ShowSnackbar(
              title: CreateInvoiceConstants.createInvoiceFailedMsg,
              type: SnackBarType.error,
            ));
            yield currentState;
          }
        }
      }
    }
    loaderBloc.add(FinishLoading());
  }

  Future<void> updateProductList() async {
    if (selectBill == BillEnum.Import) {
      addProductList();
    }
    if (selectBill == BillEnum.Export) {
      reduceProductList();
    }
  }

  Future addProductList() async {
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
      if (itemBill.index < 0) {
        productUC.createProduct(product);
      } else {
        await productUC.updateProduct(product: product, productListState: ProductListState.Add);
      }
    }
  }

  Future reduceProductList() async {
    for (final ItemBillEntity itemBill in itemBillList) {
      ProductEntity product = ProductEntity(
        name: itemBill.name,
        category: itemBill.category,
        qty: itemBill.qty,
        exportPrice: itemBill.price,
        locale: userBloc.locale,
        createAt: DateTime.now().millisecondsSinceEpoch,
        lastUpdate: DateTime.now().millisecondsSinceEpoch,
        unit: itemBill.unit,
        distributor: itemBill.distributor,
      );
      await productUC.updateProduct(product: product, productListState: ProductListState.Reduce,);
    }
  }

  Future<bool> checkLimitedProduct() async {
    for (int index = 0; index < itemBillList.length; index++) {
      bool flag = await invoiceUC.isLimitedProductQty(itemBillList[index]);
      if (flag) {
        return true;
      }
    }
    return false;
  }

  Stream<CreateInvoiceState> _mapSelectBillDateEventToState(SelectBillDateEvent event) async* {
    var currentState = state;
    selectBillDate = event.billDate;
    if (currentState is WaitingCreateInvoiceState) {
      yield currentState.copyWith(selectBillDate: selectBillDate);
    }
  }

  Future<List<String>> uploadImageBills() async {
    List<String> pathList = [];
    String uid = setupFirebase.auth.currentUser.uid;
    pathList = await invoiceUC.uploadImages(imageFiles: imageFiles, uid: uid);
    return pathList;
  }

  Future<List<ImageEntity>> _getImageUrls(List<String> images) async {
    List<ImageEntity> imageList = [];
    for (final String path in images) {
      ImageEntity imageEntity = await imageUC.getPhotoUri(ImageEntity(path: path));
      if (!ValidatorUtils.isNullEmpty(imageEntity)) {
        imageList.add(imageEntity);
      }
    }
    return imageList;
  }
}
