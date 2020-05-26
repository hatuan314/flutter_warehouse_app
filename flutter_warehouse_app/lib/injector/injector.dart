import 'package:kiwi/kiwi.dart';

import 'package:flutterwarehouseapp/service/service.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.factory(ShareService)
  @Register.singleton(ShareService, name: 'share_service')
  void configure();
}

void setup() {
  var injector = _$Injector();
  injector.configure();
}
