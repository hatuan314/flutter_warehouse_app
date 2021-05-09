import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/avatar/avatar_widget.dart';

class UserWidget extends StatelessWidget {
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
        child: Row(
          children: [
            AvatarWidget(),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(left: LayoutConstants.paddingHorizontal18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tuan Hoang',
                      style: ThemeText.headline6,
                    ),
                    Text(
                      '0123456789',
                      style: ThemeText.body2,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
