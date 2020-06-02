part of 'injector.dart';

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerFactory((c) => ShareService());
    container.registerFactory((c) => DistributorRepository());
    container.registerFactory((c) => InvoiceProvider());

    container.registerFactory((c) => DistributorBloc());
    container.registerFactory((c) => ShowAllInvoicesBloc());
    container.registerFactory((c) => CreateNewInvoiceBloc());
    container.registerSingleton(
        (c) => ShareService(),
        name: 'share_service');
  }
}
