import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/category_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_list/bloc/category_list_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_list/bloc/category_list_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  final CategoryUseCase categoryUC;
  final LoaderBloc loaderBloc;
  final SnackbarBloc snackbarBloc;

  CategoryListBloc({
    @required this.categoryUC,
    @required this.loaderBloc,
    @required this.snackbarBloc,
  });

  @override
  CategoryListState get initialState => CategoryListState(viewState: ViewState.initial, categories: []);

  @override
  Stream<CategoryListState> mapEventToState(CategoryListEvent event) async* {
    if (event is InitialCategoryListEvent) {
      yield* _mapInitialCategoryEventToState();
    }
  }

  Stream<CategoryListState> _mapInitialCategoryEventToState() async* {
    loaderBloc.add(StartLoading());
    final List<CategoryEntity> categories = await categoryUC.getCategoryList();
    yield state.copyWith(categories: categories);
    loaderBloc.add(FinishLoading());
  }
}
