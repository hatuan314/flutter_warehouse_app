import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/common/configs/local_db_setup.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/utils/app_utils.dart';
import 'package:flutterwarehouseapp/common/utils/screen_utils.dart';
import 'package:flutterwarehouseapp/route.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/themes/theme_data.dart';
import 'package:flutterwarehouseapp/src/widgets/loader_widget/loader_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/snackbar_widget/snackbar_widget.dart';
import 'package:hive/hive.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  final List<BlocProvider> _getProviders = [
    BlocProvider<LoaderBloc>(create: (BuildContext context) => locator<LoaderBloc>()),
    BlocProvider<SnackbarBloc>(create: (BuildContext context) => locator<SnackbarBloc>()),
  ];

  String get initialRoute {
    return RouteList.welcome;
  }

  BlocListener<SnackbarBloc, SnackbarState> _buildBlocListener(Widget widget, BuildContext context) {
    return BlocListener<SnackbarBloc, SnackbarState>(
      listener: (context, state) {
        if (state is ShowSnackBarState) {
          TopSnackBar(
            title: state.title,
            type: state.type,
            key: state.key,
          ).showWithNavigator(_navigator.currentState, context);
        }
      },
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getProviders,
      child: GestureDetector(
        onTap: () {
          AppUtils.unFocusKeyboard(context);
        },
        child: MaterialApp(
          navigatorKey: _navigator,
          debugShowCheckedModeBanner: false,
          title: 'Warehouse',
          builder: (context, widget) {
            ScreenUtil.init(context);
            return FutureBuilder(
                future: Hive.openBox<UnitEntity>(DefaultConfig.unitsCollection),
                builder: (context, snapshot) {
                  return LoadingContainer(
                    navigator: _navigator,
                    child: _buildBlocListener(
                      widget,
                      context,
                    ),
                  );
                });
          },
          theme: appTheme(context),
          initialRoute: initialRoute,
          routes: Routes.getAll(),
          onGenerateRoute: Routes.generateRoute,
        ),
      ),
    );
  }

  @override
  void dispose() {
    locator<LocalDbSetup>().dispose();
    super.dispose();
  }
}
