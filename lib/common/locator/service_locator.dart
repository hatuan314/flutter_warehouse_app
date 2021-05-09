import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/app_preference.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/pref.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/user_datasource.dart';
import 'package:flutterwarehouseapp/src/data/repositories/user_repository_impl.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/user_repository.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/user_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/confirm_otp/bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/confirm_phone/blocs/blocs.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/update_information/blocs/update_info_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setup() {
  /// Blocs
  locator.registerLazySingleton<LoaderBloc>(() => LoaderBloc());
  locator.registerLazySingleton<SnackbarBloc>(() => SnackbarBloc());
  locator.registerFactory(() => SplashBloc(
        pref: locator<AppPreference>(),
        setupFirebase: locator<SetupFirebaseDatabase>(),
        userUseCase: locator<UserUseCase>(),
        userBloc: locator<UserBloc>(),
      ));
  locator.registerFactory<LoginBloc>(() => LoginBloc(
        setup: locator<SetupFirebaseDatabase>(),
        loaderBloc: locator<LoaderBloc>(),
      ));
  locator.registerFactory<ConfirmOtpBloc>(() => ConfirmOtpBloc(
        setup: locator<SetupFirebaseDatabase>(),
        pref: locator<AppPreference>(),
        userUseCase: locator<UserUseCase>(),
        loaderBloc: locator<LoaderBloc>(),
        userBloc: locator<UserBloc>(),
      ));
  locator.registerLazySingleton<UserBloc>(() => UserBloc(
        setupFirebase: locator<SetupFirebaseDatabase>(),
        userUseCase: locator<UserUseCase>(),
        loaderBloc: locator<LoaderBloc>(),
        snackbarBloc: locator<SnackbarBloc>(),
      ));
  locator.registerFactory(() => UpdateInfoBloc(
        pref: locator<AppPreference>(),
        userUseCase: locator<UserUseCase>(),
        loaderBloc: locator<LoaderBloc>(),
        userBloc: locator<UserBloc>(),
      ));
  locator.registerFactory<MainBloc>(() => MainBloc());

  /// UseCases
  locator.registerFactory<UserUseCase>(() => UserUseCase(
        userRepository: locator<UserRepository>(),
      ));

  /// Repositories
  locator.registerFactory<UserRepository>(() => UserRepositoryImpl(
        userDataSource: locator<UserDataSource>(),
      ));

  /// DataSource
  locator.registerLazySingleton<UserDataSource>(() => UserDataSource(
        setupFirebase: locator<SetupFirebaseDatabase>(),
      ));
  locator.registerLazySingleton<Pref>(() => LocalPref());
  locator.registerLazySingleton<AppPreference>(() => AppPreference(
        pref: locator<Pref>(),
      ));

  /// Utils
  locator.registerLazySingleton<SetupFirebaseDatabase>(
      () => SetupFirebaseDatabase());
}
