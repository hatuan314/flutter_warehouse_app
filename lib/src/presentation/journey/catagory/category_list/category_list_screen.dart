import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/animation_widget/animation_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/unit_item_widget.dart';

class CategoryListScreen extends StatelessWidget {

  Widget _bodyWidget(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: AnimationWidget(
              index: index,
              child: UnitItemWidget(name: 'Test 1', color: AppColor.primaryColor,),
            ),
          );
        });
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
          // Navigator.of(context).pushNamed(RouteList.addDistributor);
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