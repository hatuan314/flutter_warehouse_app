import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/utils/color_utils.dart';
import 'package:flutterwarehouseapp/common/utils/name_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_constants.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class InfoWidget extends StatelessWidget {
  final DistributorEntity distributor;

  const InfoWidget({Key key,@required this.distributor}) : super(key: key);

  Widget _leadingWidget() {
    return Container(
      width: LayoutConstants.avatarSize,
      height: LayoutConstants.avatarSize,
      decoration: BoxDecoration(
        color: ColorUtils.convertColor(distributor.color),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        NameUtils.getSortName(distributor.name),
        style: ThemeText.headline5.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColor.white,
        ),
      ),
    );
  }

  Widget _iconButton(
      {IconData icon, Function onPressed, Color backgroundColor}) {
    return Container(
      width: LayoutConstants.buttonHeight,
      height: LayoutConstants.buttonHeight,
      child: FloatingActionButton(
        elevation: 0.0,
        child: Icon(
          icon,
          color: Colors.white,
          size: LayoutConstants.iconSize,
        ),
        backgroundColor: backgroundColor,
        onPressed: onPressed,
        heroTag: null,
      ),
    );
  }

  Widget _dashboardWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _iconButton(
          icon: Icons.mail,
          onPressed: () {
            if (distributor.defaultEmail.isSafe) {
              UrlLauncher.launch('mailto: ${distributor.defaultEmail}');
            } else {
              locator<SnackbarBloc>().add(ShowSnackbar(
                  title: DistributorConstants.emailEmptyTxt,
                  type: SnackBarType.warning));
            }
          },
          backgroundColor: AppColor.deepPurpleAccent,
        ),
        _iconButton(
          icon: Icons.chat_bubble,
          onPressed: () {
            if (distributor.defaultPhone.isSafe) {
              UrlLauncher.launch('sms: ${distributor.defaultPhone}');
            } else {
              locator<SnackbarBloc>().add(ShowSnackbar(
                  title: DistributorConstants.phoneEmptyTxt,
                  type: SnackBarType.warning));
            }
          },
          backgroundColor: AppColor.blue,
        ),
        _iconButton(
          icon: Icons.phone,
          onPressed: () {
            if (distributor.defaultPhone.isSafe) {
              UrlLauncher.launch('tel: ${distributor.defaultPhone}');
            } else {
              locator<SnackbarBloc>().add(ShowSnackbar(
                  title: DistributorConstants.phoneEmptyTxt,
                  type: SnackBarType.warning));
            }
          },
          backgroundColor: AppColor.green,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius),
          ),
          elevation: 10,
          margin:
          EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontalApp)
              .copyWith(top: LayoutConstants.paddingVertical40),
          color: AppColor.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutConstants.paddingHorizontalApp,
            ).copyWith(bottom: LayoutConstants.paddingVertical15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: LayoutConstants.paddingVertical70,),
                Text(distributor?.name, style: ThemeText.headline6,),
                SizedBox(height: LayoutConstants.paddingVertical5,),
                Text(distributor.defaultPhone, style: ThemeText.body2,),
                SizedBox(height: LayoutConstants.paddingVertical5,),
                Text(distributor.defaultEmail, style: ThemeText.body2,),
                SizedBox(height: LayoutConstants.paddingVertical30,),
                _dashboardWidget(context),
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: _leadingWidget()),
      ],
    );
  }

}