import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/update_information/update_information_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/update_information/widgets/update_information_body_widget.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class UpdateInformationScreen extends StatelessWidget {
  final User fireUser;
  final bool isRegistration;

  const UpdateInformationScreen({Key key, this.fireUser, this.isRegistration})
      : super(key: key);

  Widget _appbar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: LayoutConstants.appBarIconBtnSize,
              height: LayoutConstants.appBarIconBtnSize,
              alignment: Alignment.center,
              child: Icon(
                CupertinoIcons.back,
                color: AppColor.primaryColor,
              ),
            ),
          ),
          Text(
            UpdateInformationConstants.updateProfileTxt,
            style: ThemeText.body1.copyWith(
                fontWeight: FontWeight.bold, color: AppColor.primaryColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _appbar(context),
          Expanded(
              child: UpdateProfileBodyWidget(
            fireUser: fireUser,
            isRegistration: isRegistration,
          )),
        ],
      ),
    );
  }
}
