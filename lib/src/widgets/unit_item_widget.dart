import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class UnitItemWidget extends StatelessWidget {
  final String name;
  final Color color;
  final Widget icon;

  const UnitItemWidget({Key key, @required this.name, this.color, this.icon})
      : super(key: key);

  Widget _iconWidget() {
    if (!ValidatorUtils.isNullEmpty(color)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.circle,
            color: color,
            size: LayoutConstants.iconSmallSize8,
          ),
          SizedBox(
            width: LayoutConstants.paddingHorizontal10,
          )
        ],
      );
    }
    if (!ValidatorUtils.isNullEmpty(icon)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          SizedBox(
            width: LayoutConstants.paddingHorizontal10,
          )
        ],
      );
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontal15),
      padding:
          EdgeInsets.symmetric(vertical: LayoutConstants.paddingHorizontal15),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: AppColor.black25,
        width: 1,
      ))),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconWidget(),
          Text(
            '$name',
            style: ThemeText.body2,
          ),
        ],
      ),
    );
  }
}
