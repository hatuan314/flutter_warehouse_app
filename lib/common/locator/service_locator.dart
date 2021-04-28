import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setup() {
  /// ========== BLOCs ==========
  locator.registerLazySingleton<LoaderBloc>(() => LoaderBloc());
  locator.registerLazySingleton<SnackbarBloc>(() => SnackbarBloc());
  locator.registerFactory(() => SplashBloc());

  /// ========== UTILS ==========
  locator.registerLazySingleton<SetupFirebaseDatabase>(
      () => SetupFirebaseDatabase());
}
