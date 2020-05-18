import 'package:get_it/get_it.dart';

import 'service/share_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<ShareService>(() => ShareService());
}
