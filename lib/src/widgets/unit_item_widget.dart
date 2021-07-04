import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class UnitItemWidget extends StatelessWidget {
  final String name;
  final Color color;

  const UnitItemWidget({Key key, @required this.name, this.color})
      : super(key: key);

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
          color != null
              ? Row(
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
                )
              : SizedBox(),
          Text(
            '$name',
            style: ThemeText.body2,
          ),
        ],
      ),
    );
  }
}
