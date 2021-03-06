import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class DevModeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dev Mode',
          style: ThemeText.body1,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteList.confirmOtp, arguments: {
                  ArgumentConstants.verificationIdArgument:
                      'ALiwoWJj6Ww8kJerE7vbsyrq1BEV_uGiIVlWhSzLsJTSBKzyqoqdE8EjYC4TlpzwBCHasUi8KXoad8MV_Fnlns5qnajQqiPbAZSFS2lZAB1IoP3ue0NfuCtS9VvlDoIr-xsI0zF8lHkw_DizPqbLeAay5eO2B-OXFw',
                  ArgumentConstants.phoneArgument: '0123456789'
                });
              },
              child: Center(
                child: Text(
                  'Confirm OTP',
                  style: ThemeText.body2.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.white),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteList.updateProfile,
                );
              },
              child: Center(
                child: Text(
                  'Update Profile',
                  style: ThemeText.body2.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.white),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                locator<SnackbarBloc>().add(ShowSnackbar(
                    title: 'Test Snackbar', type: SnackBarType.error));
              },
              child: Center(
                child: Text(
                  'SnackBar',
                  style: ThemeText.body2.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.white),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
              },
              child: Center(
                child: Text(
                  'Isolate',
                  style: ThemeText.body2.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
