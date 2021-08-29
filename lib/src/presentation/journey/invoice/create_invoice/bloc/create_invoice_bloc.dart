import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/enums/bill_enum.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/image_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:image_picker/image_picker.dart';

class CreateInvoiceBloc extends Bloc<CreateInvoiceEvent, CreateInvoiceState> {
  final LoaderBloc loaderBloc;
  final SnackbarBloc snackbarBloc;
  final ImageUseCase imageUC;

  DistributorEntity selectDistributor;
  BillEnum selectBill = BillEnum.Export;
  List<ItemBillEntity> itemBillList = [];
  List<PickedFile> imageFiles = [];
  int totalAmountBill = 0;
  int _imageQty = 0;

  CreateInvoiceBloc({@required this.loaderBloc, @required this.snackbarBloc, @required this.imageUC});

  @override
  CreateInvoiceState get initialState => WaitingCreateInvoiceState(
        viewState: ViewState.initial,
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
        yield* _mapOnCreateEvent();
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
      final PickedFile image =
          await imageUC.getImageFile(ImageSource.gallery);
      imageFiles.add(image);
      _imageQty = _setImageQty();
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
      final PickedFile image =
      await imageUC.getImageFile(ImageSource.camera);
      if (!ValidatorUtils.isNullEmpty(image)) {
        imageFiles.add(image);
        _imageQty = _setImageQty();
      }
      yield currentState.copyWith(viewState: ViewState.initial, imageFiles: imageFiles, imageQty: _imageQty);
    }
  }

  bool _checkValidator() {
    if (ValidatorUtils.isNullEmpty(selectDistributor)) {
      snackbarBloc.add(ShowSnackbar(title: 'Vui lòng chọn nhà phân phối', type: SnackBarType.warning));
      return false;
    }
    if (ValidatorUtils.isNullEmpty(selectBill)) {
      snackbarBloc.add(ShowSnackbar(title: 'Vui lòng chọn kiểu hóa đơn', type: SnackBarType.warning));
      return false;
    }
    if (ValidatorUtils.isNullEmptyList(itemBillList)) {
      snackbarBloc.add(ShowSnackbar(title: 'Vui lòng nhập danh sách mặt hàng', type: SnackBarType.warning));
      return false;
    }
    return true;
  }

  Stream<CreateInvoiceState> _mapOnCreateEvent() async* {
    bool flag = _checkValidator();
    var currentState = state;
    if (currentState is WaitingCreateInvoiceState) {
      if (!flag) {
        yield currentState;
      }
    } else {

    }
  }

}
