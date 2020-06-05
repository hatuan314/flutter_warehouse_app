import 'package:flutterwarehouseapp/data/data.dart';
import 'package:kiwi/kiwi.dart';

import 'package:flutterwarehouseapp/src/src.dart';


part 'injector.g.dart';

abstract class Injector {
  @Register.factory(ShareService)
  @Register.factory(DistributorRepositoryImpl)

  @Register.factory(CreateNewInvoiceBloc)
  @Register.factory(DistributorBloc)
  @Register.factory(ShowAllInvoicesBloc)
  @Register.singleton(ShareService, name: 'share_service')

  @Register.factory(InvoicesUserCase)
  @Register.factory(ProductUseCase)
  @Register.factory(DistributorUseCase)

  void configure();
}

void setup() {
  var injector = _$Injector();
  injector.configure();
}
