import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/app_constants.dart';
import 'package:flutterwarehouseapp/common/constants/image_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/lottie_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:lottie/lottie.dart';

import 'splash_constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.viewState== ViewState.success)
          Navigator.pushReplacementNamed(
            context,
            state.route,
          );
      },
      builder: (context, state) {
        return Material(
          color: AppColor.backgroundColor,
          child: _body(context, state),
        );
      },
    );
  }

  Widget _body(BuildContext context, SplashState state) {
    final _queryData = MediaQuery.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstants.appLogo,
                      width: _queryData.size.width * 0.25,
                    ),
                    SizedBox(
                      width: SplashConstants.width,
                    ),
                    Text(
                      AppConstant.appName,
                      style: ThemeText.headline3
                          .copyWith(fontWeight: FontWeight.w500),
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              bottom: true,
                child: Visibility(
                  visible: _visibleLoader(state),
                  child: Lottie.asset(
                    LottieConstants.loadingIcon,
                    width: LayoutConstants.loadingSize,
                  ),
                )),
          )
        ],
      ),
    );
  }

  bool _visibleLoader(SplashState state) {
    if (state.viewState == ViewState.loading)
      return true;
    else
      return false;
  }
}
