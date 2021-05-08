import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
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
import 'package:flutterwarehouseapp/src/presentation/journey/profile/update_information/blocs/update_info_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setup() {
  /// Blocs
  locator.registerLazySingleton<LoaderBloc>(() => LoaderBloc());
  locator.registerLazySingleton<SnackbarBloc>(() => SnackbarBloc());
  locator.registerFactory(() => SplashBloc());
  locator.registerFactory<LoginBloc>(() => LoginBloc(
        setup: locator<SetupFirebaseDatabase>(),
        loaderBloc: locator<LoaderBloc>(),
      ));
  locator.registerFactory<ConfirmOtpBloc>(() => ConfirmOtpBloc(
        setup: locator<SetupFirebaseDatabase>(),
        loaderBloc: locator<LoaderBloc>(),
      ));
  locator.registerLazySingleton<UserBloc>(() => UserBloc(
        useCase: locator<UserUseCase>(),
      ));
  locator.registerFactory(() => UpdateInfoBloc(
        userUseCase: locator<UserUseCase>(),
        loaderBloc: locator<LoaderBloc>(),
        userBloc: locator<UserBloc>(),
      ));

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

  /// Utils
  locator.registerLazySingleton<SetupFirebaseDatabase>(
      () => SetupFirebaseDatabase());
}
