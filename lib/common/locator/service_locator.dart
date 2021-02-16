import 'package:get_it/get_it.dart';
import 'package:flutterwarehouseapp/src/presentation/login/splash/blocs/splash_bloc.dart';

GetIt locator = GetIt.instance;

void setup() {
  /// ========== BLOCs ==========
  locator.registerFactory(() => SplashBloc());
}
