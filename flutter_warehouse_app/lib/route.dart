import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'package:flutterwarehouseapp/src/src.dart';

int currentRoot = 1;

RouteFactory router() {
  var container = kiwi.Container();
  return (RouteSettings settings) {
    Widget screen;

    if (currentRoot == 1) {
      currentRoot = 2;
      screen = MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomePageBloc()),
          BlocProvider(
            create: (context) => container.resolve<ShowAllInvoicesBloc>()
              ..add(GetAllInvoicesEvent()),
          ),
          BlocProvider(
            create: (context) => container.resolve<DistributorBloc>()
              ..add(ShowAllDistributorsEvent()),
          )
        ],
        child: HomeScreen(),
      );
    }

    final args = settings.arguments as Map<String, dynamic> ?? {};

    // todo:  add screen route here
    switch (settings.name) {
      case '/create-invoice':
        screen = BlocProvider(
            create: (context) => container.resolve<CreateNewInvoiceBloc>()
              ..add(GetAllProductsEvent()),
            child: CreateNewInvoiceScreen());
        break;
    }

    return CupertinoPageRoute(builder: (context) {
      ScreenUtil.init(context, width: 360, height: 640);
      return screen;
    });
  };
}
