part of 'injector.dart';

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();

    container.registerSingleton(
            (c) => ShareService(),
        name: 'share_service');
    container.registerFactory((c) => ShareService());
    container.registerFactory((c) => DistributorRepositoryImpl());
    container.registerFactory((c) => InvoiceProvider());

    container.registerFactory((c) => DistributorBloc());
    container.registerFactory((c) => ShowAllInvoicesBloc());
    container.registerFactory((c) => CreateNewInvoiceBloc());

    container.registerFactory((c) => InvoicesUserCase());
    container.registerFactory((c) => ProductUseCase());
    container.registerFactory((c) => DistributorUseCase());
  }
}
