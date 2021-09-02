import 'package:connectivity/connectivity.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';

class ConnectivityUtils {
  static Future<bool> checkConnectInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    }
    if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    locator<SnackbarBloc>().add(ShowSnackbar(
        title: StringConstants.noInternetTxt,
        type: SnackBarType.disconnect));
    return false;
  }
}
