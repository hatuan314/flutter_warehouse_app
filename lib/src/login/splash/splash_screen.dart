import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/app_constants.dart';
import 'package:flutterwarehouseapp/common/constants/image_constants.dart';
import 'package:flutterwarehouseapp/src/login/splash/splash_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConstants.appLogo,
                width: MediaQuery.of(context).size.width * 0.25,
              ),
              SizedBox(width: SplashConstants.width,),
              Text(AppConstant.appName, style: ThemeText.getDefaultTextTheme().headline3,)
            ],
          ),
          SizedBox(height: SplashConstants.height,),
          Text(
            SplashConstants.content,
            style: ThemeText.getDefaultTextTheme().bodyText2,
          )
        ],
      ),
    );
  }
}
