import 'package:connectivity/connectivity.dart';

class ConnectivityUtils {
  static Future<bool> checkConnectInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    }
    if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
