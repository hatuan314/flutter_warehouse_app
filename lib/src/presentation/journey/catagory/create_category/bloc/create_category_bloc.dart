import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/color_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/category_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/bloc/create_category_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/bloc/create_category_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class CreateCategoryBloc extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  final CategoryUseCase categoryUC;
  final LoaderBloc loaderBloc;
  final SnackbarBloc snackbarBloc;

  CreateCategoryBloc({@required this.categoryUC, @required this.loaderBloc, @required this.snackbarBloc});

  @override
  CreateCategoryState get initialState => CreateCategoryState(viewState: ViewState.initial);

  @override
  Stream<CreateCategoryState> mapEventToState(CreateCategoryEvent event) async* {
    if (event is OnPressCreateEvent) {
      yield* _mapCreateCategoryEventToState(event);
    }
  }

  Stream<CreateCategoryState> _mapCreateCategoryEventToState(OnPressCreateEvent event) async* {
    loaderBloc.add(StartLoading());
    yield state.copyWith(viewState: ViewState.initial);
    final Color color = ColorUtils.randColor();
    CategoryEntity category = CategoryEntity(
      name: event.categoryName,
      color: ColorUtils.parseInt(color),
      createTime: DateTime.now(),
      lastUpdate: DateTime.now(),
    );
    final bool flag = await categoryUC.setCategory(category);
    if (flag) {
      snackbarBloc.add(ShowSnackbar(title: StringConstants.createSuccessTxt, type: SnackBarType.success));
      yield state.copyWith(viewState: ViewState.success);
    } else {
      snackbarBloc.add(ShowSnackbar(
          title: StringConstants.createFailureTxt, type: SnackBarType.error));
    }
    loaderBloc.add(FinishLoading());
  }
}
