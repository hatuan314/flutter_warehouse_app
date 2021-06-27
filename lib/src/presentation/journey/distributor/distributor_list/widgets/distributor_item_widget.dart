import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/color_utils.dart';
import 'package:flutterwarehouseapp/common/utils/name_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_constants.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/distributor_list_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/expansion_tile_widget.dart';

class DistributorItemWidget extends StatelessWidget {
  final DistributorEntity distributor;

  const DistributorItemWidget({Key key, @required this.distributor})
      : super(key: key);

  Widget _iconButton(
      {IconData icon, Function onPressed, Color backgroundColor}) {
    return Container(
      width: LayoutConstants.smallIconCircleBtnSize,
      height: LayoutConstants.smallIconCircleBtnSize,
      child: new FloatingActionButton(
        elevation: 0.0,
        child: Icon(
          icon,
          color: Colors.white,
          size: LayoutConstants.iconSmallSize,
        ),
        backgroundColor: backgroundColor,
        onPressed: onPressed,
      ),
    );
  }

  Widget _dashboardWidget() {
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
        _iconButton(
          icon: Icons.info,
          onPressed: () {
            if (distributor.defaultEmail.isSafe) {
              UrlLauncher.launch('mailto: ${distributor.defaultEmail}');
            } else {
              locator<SnackbarBloc>().add(ShowSnackbar(
                  title: DistributorConstants.emailEmptyTxt,
                  type: SnackBarType.warning));
            }
          },
          backgroundColor: AppColor.grey,
        ),
        _iconButton(
          icon: Icons.delete,
          onPressed: () {
            if (distributor.defaultPhone.isSafe) {
              UrlLauncher.launch('sms: ${distributor.defaultPhone}');
            } else {
              locator<SnackbarBloc>().add(ShowSnackbar(
                  title: DistributorConstants.phoneEmptyTxt,
                  type: SnackBarType.warning));
            }
          },
          backgroundColor: AppColor.red,
        ),
      ],
    );
  }

  Widget _titleWidget() {
    return Container(
      height: DistributorListConstants.avatarSize,
      color: AppColor.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            distributor.name,
            style: ThemeText.subtitle1,
          ),
          // SizedBox(
          //   height: 3,
          // ),
          // distributor.phones.isSafe
          //     ? Text(
          //   distributor?.phones[0],
          //   style: ThemeText.caption,
          // )
          //     : SizedBox(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius),
      ),
      elevation: 10,
      margin:
          EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontalApp)
              .copyWith(top: LayoutConstants.paddingVertical20),
      color: AppColor.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: LayoutConstants.paddingVertical10,
          horizontal: LayoutConstants.paddingHorizontalApp,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ExpansionTileWidget(
                title: Text(
                  distributor.name,
                  style: ThemeText.subtitle1,
                ),
                subtitle: distributor.phones.isSafe
                    ? Text(
                        distributor?.phones[0],
                        style: ThemeText.caption,
                      )
                    : SizedBox(),
                tilePadding: EdgeInsets.zero,
                // childrenPadding: EdgeInsets.zero,
                leading: Container(
                  width: DistributorListConstants.avatarSize,
                  height: DistributorListConstants.avatarSize,
                  decoration: BoxDecoration(
                    color: ColorUtils.convertColor(distributor.color),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    NameUtils.getSortName(distributor.name),
                    style: ThemeText.body1.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                    ),
                  ),
                ),
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: LayoutConstants.paddingVertical10),
                    child: _dashboardWidget(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
