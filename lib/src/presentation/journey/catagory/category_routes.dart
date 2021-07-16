import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_list/bloc/category_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_list/bloc/category_list_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_list/category_list_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/bloc/create_category_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/create_category_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/add_distributor_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/bloc/add_distributor_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/bloc/distributor_detail_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/bloc/distributor_detail_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/distributor_detail_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/bloc/distributor_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/bloc/distributor_list_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/distributor_list_screen.dart';

class CategoryRoute {
  static Map<String, WidgetBuilder> getAll() {
    return {
      RouteList.categoryList: (context) => BlocProvider(
          create: (_) => locator<CategoryListBloc>()..add(InitialCategoryListEvent()), child: CategoryListScreen()),
      RouteList.createCategory: (context) =>
          BlocProvider(create: (_) => locator<CreateCategoryBloc>(), child: CreateCategoryScreen(title: null)),
    };
  }

  static Map<String, WidgetBuilder> getRoutesWithSettings(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;
    return {
      RouteList.createCategory: (context) {
        var title = args[ArgumentConstants.createCategoryTitleArg];
        var category = args[ArgumentConstants.categoryDetailArg];
        return CreateCategoryScreen(
          title: title,
          category: category,
        );
      }
    };
  }
}
