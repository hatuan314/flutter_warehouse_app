import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/app_preference.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionDashboardWidget extends StatelessWidget {
  Widget _optionItemWidget({String title, IconData icon, Function onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        height: LayoutConstants.buttonHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: LayoutConstants.iconSize,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: ThemeText.body2,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius),
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(LayoutConstants.paddingVertical10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _optionItemWidget(title: 'Trợ giúp & hỗ trợ', icon: Icons.support),
            _optionItemWidget(title: 'Chia sẻ', icon: Icons.share),
            _optionItemWidget(
                title: 'Đánh giá', icon: Icons.rate_review_outlined),
            _optionItemWidget(
                title: 'Đăng xuất',
                icon: Icons.sensor_door_outlined,
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  locator<SetupFirebaseDatabase>().auth.signOut();
                  await prefs.clear();
                  Navigator.pushReplacementNamed(context, RouteList.login);
                }),
          ],
        ),
      ),
    );
  }
}
