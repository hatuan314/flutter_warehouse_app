import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_list/bloc/category_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_list/bloc/category_list_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_list/bloc/category_list_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_list/widgets/category_list_body_widget.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/create_category_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';

class CategoryListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryListBloc, CategoryListState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScaffoldWidget(
            isLeading: true,
            onLeading: () {
              Navigator.of(context).pop();
            },
            title: StringConstants.categoryTxt,
            child: CategoryListBodyWidget(
              categories: state.categories,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteList.createCategory, arguments: {
                  ArgumentConstants.createCategoryTitleArg: CreateCategoryConstants.createCategory,
                }).then((value) {
                  if (value == true) {
                    BlocProvider.of<CategoryListBloc>(context).add(InitialCategoryListEvent());
                  }
                });
              },
              child: Icon(
                Icons.add,
                size: LayoutConstants.smallIconBtnSize,
              ),
              backgroundColor: AppColor.primaryColor,
            ),
          );
        });
  }
}
