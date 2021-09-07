import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/color_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/animation_widget/animation_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/touchable_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/unit_item_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/empty_widget.dart';

class CategoryListBodyWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  final Function(CategoryEntity) onPressed;

  const CategoryListBodyWidget({
    Key key,
    @required this.categories,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (categories.isNotSafe) {
      return EmptyWidget();
    }
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: AnimationWidget(
              index: index,
              child: TouchableWidget(
                onPressed: () => onPressed(categories[index]),
                child: UnitItemWidget(
                  color: ColorUtils.convertColor(categories[index].color),
                  name: categories[index].name,
                ),
              ),
            ),
          );
        });
  }
}
