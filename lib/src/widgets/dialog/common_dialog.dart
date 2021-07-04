import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class CommonDialog extends AwesomeDialog {
  CommonDialog(
    BuildContext context, {
    @required String title,
    @required String content,
    @required Function onCancel,
    @required onAccept,
    DialogType dialogType,
  }) : super(
          context: context,
          animType: AnimType.SCALE,
          dialogType: dialogType ?? DialogType.INFO,
          body: Center(
            child: Column(
              children: [
                Text(
                  title,
                  style: ThemeText.headline6.copyWith(color: AppColor.red),
                ),
                SizedBox(
                  height: LayoutConstants.paddingVertical15,
                ),
                Text(
                  content,
                  style: ThemeText.body2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          btnCancel: Container(
            height: LayoutConstants.buttonDialogHeight,
            decoration: BoxDecoration(
                color: AppColor.red, borderRadius: BorderRadius.circular(80)),
            alignment: Alignment.center,
            child: Text(
              StringConstants.cancelTxt,
              style: ThemeText.caption.copyWith(
                color: AppColor.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          btnOk: Container(
            height: LayoutConstants.buttonDialogHeight,
            decoration: BoxDecoration(
                color: AppColor.green, borderRadius: BorderRadius.circular(80)),
            alignment: Alignment.center,
            child: Text(
              StringConstants.okTxt,
              style: ThemeText.caption.copyWith(
                color: AppColor.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          btnOkOnPress: onAccept,
          btnCancelOnPress: onCancel,
        );
}
