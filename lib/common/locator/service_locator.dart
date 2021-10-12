import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/common/configs/local_db_setup.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/app_preference.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/category_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/distributor_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/invoice_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/pref.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/product_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/unit_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/base_service.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/category_datasource.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/distributor_datasource.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/invoice_datasource.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/product_datasource.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/unit_datasource.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/user_datasource.dart';
import 'package:flutterwarehouseapp/src/data/repositories/category_repository_impl.dart';
import 'package:flutterwarehouseapp/src/data/repositories/distributor_repository_impl.dart';
import 'package:flutterwarehouseapp/src/data/repositories/invoice_repository_impl.dart';
import 'package:flutterwarehouseapp/src/data/repositories/product_repository_impl.dart';
import 'package:flutterwarehouseapp/src/data/repositories/unit_repository_impl.dart';
import 'package:flutterwarehouseapp/src/data/repositories/user_repository_impl.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/category_repository.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/distributor_repository.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/invoice_repository.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/product_repository.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/unit_repository.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/user_repository.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/category_usecase.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/distributor_usecase.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/image_usecase.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/invoice_usecase.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/product_usecase.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/unit_usecase.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/user_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_list/bloc/category_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/bloc/create_category_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/bloc/add_distributor_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/bloc/distributor_detail_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/bloc/distributor_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/bloc/add_ioi_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/confirm_otp/bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/confirm_phone/blocs/blocs.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/update_information/blocs/update_info_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_bloc.dart';
import 'package:flutterwarehouseapp/src/widgets/internet_widget/bloc/internet_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setup() {
  /// Blocs
  locator.registerLazySingleton<LoaderBloc>(() => LoaderBloc());
  locator.registerLazySingleton<SnackbarBloc>(() => SnackbarBloc());
  locator.registerFactory<InternetBloc>(() => InternetBloc());
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
        unitUc: locator<UnitUseCase>(),
        loaderBloc: locator<LoaderBloc>(),
        userBloc: locator<UserBloc>(),
      ));
  locator.registerFactory<MainBloc>(() => MainBloc());
  locator.registerFactory<UnitListBloc>(() => UnitListBloc(
        unitUc: locator<UnitUseCase>(),
      ));
  locator.registerFactory<AddDistributorBloc>(() => AddDistributorBloc(
        distributorUc: locator<DistributorUseCase>(),
        snackbarBloc: locator<SnackbarBloc>(),
        loaderBloc: locator<LoaderBloc>(),
      ));
  locator.registerFactory(() => DistributorListBloc(
        distributorUc: locator<DistributorUseCase>(),
        snackbarBloc: locator<SnackbarBloc>(),
        loaderBloc: locator<LoaderBloc>(),
      ));
  locator.registerFactory<DistributorDetailBloc>(() => DistributorDetailBloc(
        distributorUc: locator<DistributorUseCase>(),
        snackbarBloc: locator<SnackbarBloc>(),
        loaderBloc: locator<LoaderBloc>(),
      ));
  locator.registerFactory<CreateCategoryBloc>(() => CreateCategoryBloc(
        categoryUC: locator<CategoryUseCase>(),
        snackbarBloc: locator<SnackbarBloc>(),
        loaderBloc: locator<LoaderBloc>(),
      ));
  locator.registerFactory<CategoryListBloc>(() => CategoryListBloc(
        categoryUC: locator<CategoryUseCase>(),
        snackbarBloc: locator<SnackbarBloc>(),
        loaderBloc: locator<LoaderBloc>(),
      ));
  locator.registerFactory<CreateInvoiceBloc>(() => CreateInvoiceBloc(
        loaderBloc: locator<LoaderBloc>(),
        snackbarBloc: locator<SnackbarBloc>(),
        userBloc: locator<UserBloc>(),
        imageUC: locator<ImageUseCase>(),
        invoiceUC: locator<InvoiceUseCase>(),
        productUC: locator<ProductUseCase>(),
      ));
  locator.registerFactory<AddIoiBloc>(() => AddIoiBloc(
        loaderBloc: locator<LoaderBloc>(),
        unitUc: locator<UnitUseCase>(),
        productUc: locator<ProductUseCase>(),
        invoiceUc: locator<InvoiceUseCase>(),
      ));

  /// UseCases
  locator.registerFactory<UserUseCase>(() => UserUseCase(
        userRepository: locator<UserRepository>(),
      ));
  locator.registerFactory<UnitUseCase>(() => UnitUseCase(
        unitRepo: locator<UnitRepository>(),
      ));
  locator.registerFactory<DistributorUseCase>(() => DistributorUseCase(
        distributorRepo: locator<DistributorRepository>(),
      ));
  locator.registerFactory<CategoryUseCase>(() => CategoryUseCase(
        categoryRepo: locator<CategoryRepository>(),
      ));
  locator.registerFactory<ImageUseCase>(() => ImageUseCase());
  locator.registerFactory<InvoiceUseCase>(() => InvoiceUseCase(
        invoiceRepo: locator<InvoiceRepository>(),
        productRepo: locator<ProductRepository>(),
      ));
  locator.registerFactory<ProductUseCase>(() => ProductUseCase(
        productRepo: locator<ProductRepository>(),
      ));

  /// Repositories
  locator.registerFactory<UserRepository>(() => UserRepositoryImpl(
        userDataSource: locator<UserDataSource>(),
      ));
  locator.registerFactory<UnitRepository>(() => UnitRepositoryImpl(
        unitDs: locator<UnitDataSource>(),
        unitLds: locator<UnitLocalDataSource>(),
      ));
  locator.registerFactory<DistributorRepository>(() => DistributorRepositoryImpl(
        distributorDs: locator<DistributorDataSource>(),
        distributorHive: locator<DistributorHive>(),
      ));
  locator.registerFactory<CategoryRepository>(() => CategoryRepositoryImpl(
        categoryDS: locator<CategoryDataSource>(),
        categoryHive: locator<CategoryHive>(),
      ));
  locator.registerFactory<InvoiceRepository>(() => InvoiceRepositoryImpl(
        invoiceDs: locator<InvoiceDataSource>(),
        invoiceHive: locator<InvoiceHive>(),
      ));
  locator.registerFactory<ProductRepository>(() => ProductRepositoryImpl(
        productDs: locator<ProductDataSource>(),
        productHive: locator<ProductHive>(),
      ));

  /// DataSource
  locator.registerLazySingleton<UserDataSource>(() => UserDataSource(
        setup: locator<SetupFirebaseDatabase>(),
        service: locator<BaseService>(),
      ));
  locator.registerLazySingleton<UnitDataSource>(() => UnitDataSource(
        setup: locator<SetupFirebaseDatabase>(),
        service: locator<BaseService>(),
      ));
  locator.registerLazySingleton<DistributorDataSource>(() => DistributorDataSource(
        setup: locator<SetupFirebaseDatabase>(),
        service: locator<BaseService>(),
      ));
  locator.registerLazySingleton<CategoryDataSource>(() => CategoryDataSource(
        setup: locator<SetupFirebaseDatabase>(),
        service: locator<BaseService>(),
      ));
  locator.registerLazySingleton<InvoiceDataSource>(() => InvoiceDataSource(
        setup: locator<SetupFirebaseDatabase>(),
        service: locator<BaseService>(),
      ));
  locator.registerLazySingleton<ProductDataSource>(() => ProductDataSource(
        setup: locator<SetupFirebaseDatabase>(),
        service: locator<BaseService>(),
      ));
  locator.registerLazySingleton<Pref>(() => LocalPref());
  locator.registerLazySingleton<AppPreference>(() => AppPreference(
        pref: locator<Pref>(),
      ));
  locator.registerLazySingleton<UnitLocalDataSource>(() => UnitLocalDataSource(database: locator<LocalDbSetup>()));
  locator.registerLazySingleton<DistributorHive>(() => DistributorHive(locator<LocalDbSetup>()));
  locator.registerLazySingleton<CategoryHive>(() => CategoryHive(locator<LocalDbSetup>()));
  locator.registerLazySingleton<InvoiceHive>(() => InvoiceHive(locator<LocalDbSetup>()));
  locator.registerLazySingleton<ProductHive>(() => ProductHive(locator<LocalDbSetup>()));

  /// Utils
  locator.registerLazySingleton<SetupFirebaseDatabase>(() => SetupFirebaseDatabase());
  locator.registerLazySingleton<LocalDbSetup>(() => LocalDbSetup());
  locator.registerLazySingleton<BaseService>(() => BaseService());
}
