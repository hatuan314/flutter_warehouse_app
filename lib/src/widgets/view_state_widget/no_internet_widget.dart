import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/image_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';

class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              ImageConstants.noInternetImg,
              fit: BoxFit.scaleDown,
            ),
          ],
        ),
      ),
    );
  }
}
