import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwarehouseapp/ui/view/home/blocs/home_page_bloc.dart';
import 'package:flutterwarehouseapp/ui/view/home/home_screen.dart';

import 'ui/view/invoice/create_new_invoice/create_new_invoice.dart';


int currentRoot = 1;

RouteFactory router() {
  return (RouteSettings settings) {
    Widget screen;

    if (currentRoot == 1) {
      currentRoot = 2;
      screen = BlocProvider(
          create: (context) => HomePageBloc(),
          child: HomeScreen());
    }

    final args = settings.arguments as Map<String, dynamic> ?? {};

    // todo:  add screen route here
    switch (settings.name) {
      case '/create-invoice':
        screen = BlocProvider(
            create: (context) => CreateNewInvoiceBloc()..add(GetAllProductsEvent()),
            child: CreateNewInvoiceScreen());
        break;
    }
//    switch (settings.name) {
//      case '/sign-in':
//        return CupertinoPageRoute(builder: (context) {
//          ScUtil.init(context, pWidth: 750, pHeight: 640);
//          return BlocProvider(
//            create: (context) => RegisterBloc(),
//            child: SignInView(),
//          );
//        });
//      case '/home':
//        return CupertinoPageRoute(builder: (context) {
//          ScUtil.init(context, pWidth: 750, pHeight: 640);
//          return MultiBlocProvider(providers: [
//            BlocProvider(
//              create: (context) => HomeBloc(),
//            ),
//            BlocProvider(
//              create: (context) =>
//              CalendarBloc()..add(GetAllScheduleDataEvent()),
//            ),
//            BlocProvider(
//              create: (context) =>
//              SearchBloc()..add(SearchButtonOnPress(DateTime.now())),
//            ),
//            BlocProvider(
//              create: (context) => TodoBloc(
//                  calendarBloc: BlocProvider.of<CalendarBloc>(context)),
//            ),
//          ], child: HomeView());
////            child: SchoolSchedulePageView());
//        });
//      case '/todo-detail':
//        PersonalSchedule schedule =
//        PersonalSchedule.fromJson(settings.arguments);
//        return CupertinoPageRoute(builder: (context) {
//          ScUtil.init(context, pWidth: 750, pHeight: 640);
//          return BlocProvider(
//              create: (context) => TodoBloc(),
//              child: TodoDetailView(schedule: schedule));
//        });
//    }

    return CupertinoPageRoute(builder: (context) {
      ScreenUtil.init(context, width: 360, height: 640);
      return screen;
    });
  };
}
