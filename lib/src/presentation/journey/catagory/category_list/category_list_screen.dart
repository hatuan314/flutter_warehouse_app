import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/create_category_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/animation_widget/animation_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/unit_item_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/empty_widget.dart';

class CategoryListScreen extends StatelessWidget {
  Widget _bodyWidget(BuildContext context) {
    // return ListView.builder(
    //     padding: EdgeInsets.zero,
    //     itemCount: 10,
    //     itemBuilder: (context, index) {
    //       return AnimationConfiguration.staggeredList(
    //         position: index,
    //         duration: const Duration(milliseconds: 375),
    //         child: AnimationWidget(
    //           index: index,
    //           child: UnitItemWidget(name: 'Test 1', color: AppColor.primaryColor,),
    //         ),
    //       );
    //     });
    return EmptyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      isLeading: true,
      onLeading: () {
        Navigator.of(context).pop();
      },
      title: StringConstants.categoryTxt,
      child: _bodyWidget(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteList.createCategory, arguments: {
            ArgumentConstants.createCategoryTitleArg:
                CreateCategoryConstants.createCategory,
          });
        },
        child: Icon(
          Icons.add,
          size: LayoutConstants.smallIconBtnSize,
        ),
        backgroundColor: AppColor.primaryColor,
      ),
    );
  }
}
