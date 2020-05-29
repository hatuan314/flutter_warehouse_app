import 'package:kiwi/kiwi.dart';

import 'package:flutterwarehouseapp/service/service.dart';
import 'package:flutterwarehouseapp/ui/view/views.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.factory(ShareService)
  @Register.factory(DistributorProvider)
  @Register.factory(InvoiceProvider)

  @Register.factory(CreateNewInvoiceBloc)
  @Register.factory(DistributorBloc)
  @Register.factory(ShowAllInvoicesBloc)
  @Register.singleton(ShareService, name: 'share_service')
  void configure();
}

void setup() {
  var injector = _$Injector();
  injector.configure();
}
