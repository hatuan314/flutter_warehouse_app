import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/lottie_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/dashboard_page/dashboard_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:lottie/lottie.dart';

class WarehouseDashboardItemWidget extends StatelessWidget {
  final String path;
  final String title;
  final Function onPressed;

  const WarehouseDashboardItemWidget({
    Key key,
    @required this.path,
    @required this.title,
    @required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: Card(
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius),
        ),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset(path,
                  height: DashboardConstants.iconSize,
              width: DashboardConstants.iconSize,),
              Text(
                title,
                style: ThemeText.body2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
