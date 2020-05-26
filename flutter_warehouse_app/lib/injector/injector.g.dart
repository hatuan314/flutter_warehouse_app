part of 'injector.dart';

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerFactory((c) => ShareService());
    container.registerSingleton(
        (c) => ShareService(),
        name: 'share_service');
  }
}
