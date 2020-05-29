import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  Future initData() async {
    await Future.delayed(Duration(seconds: 3));
  }

  Future navigateToScreen() async {
    debugPrint('SignIn');
//    Navigator.pushReplacement(
//        context, CupertinoPageRoute(builder: (context) => SignInView()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData().then((value) async {
      await navigateToScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.init(context, width: 375, height: 812, allowFontScaling: true);
    return Scaffold(
      body: Container(
        child: Text("Xin chào"),
      ),
    );
  }
}
