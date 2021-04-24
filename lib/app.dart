import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/utils/screen_utils.dart';
import 'package:flutterwarehouseapp/route.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_data.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/loader_widget/loader_widget.dart';

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  List<BlocProvider> _getProviders() => [
        BlocProvider<LoaderBloc>(
            create: (BuildContext context) => locator<LoaderBloc>()),
        BlocProvider<SnackbarBloc>(
            create: (BuildContext context) => locator<SnackbarBloc>()),
      ];

  String get initialRoute {
    return RouteList.welcome;
  }

  BlocListener<SnackbarBloc, SnackbarState> _buildBlocListener(
      Widget widget, BuildContext context) {
    return BlocListener<SnackbarBloc, SnackbarState>(
      listener: (context, state) {
        if (state is ShowSnackBarState) {
          Fluttertoast.showToast(
              msg: state.title,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: AppColor.primaryColor,
              textColor: AppColor.white);
        }
      },
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Warehouse',
        builder: (context, widget) {
          ScreenUtil.init(context);
          return LoadingContainer(
            key: const ValueKey('LoadingContainer'),
            navigator: _navigator,
            child: _buildBlocListener(
              widget,
              context,
            ),
          );
        },
        theme: appTheme(context),
        initialRoute: initialRoute,
        routes: Routes.getAll(),
        // onGenerateRoute: router(),
      ),
    );
  }
}
