import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/app_constants.dart';
import 'package:flutterwarehouseapp/common/constants/image_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_state.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

import 'splash_constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashCompleteState)
          Navigator.pushReplacementNamed(
            context,
            RouteList.login,
          );
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: _body(context),
        );
      },
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
              SizedBox(
                width: SplashConstants.width,
              ),
              Text(
                AppConstant.appName,
                style:
                    ThemeText.headline3.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: SplashConstants.height,
          ),
          Text(
            SplashConstants.content,
            style: ThemeText.body2,
          )
        ],
      ),
    );
  }
}
