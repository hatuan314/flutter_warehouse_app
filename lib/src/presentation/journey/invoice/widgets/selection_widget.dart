import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_constants.dart';

class SelectionWidget extends StatelessWidget {
  final String header;
  final String title;
  final Color titleColor;
  final IconData icon;
  final Function onPressed;

  const SelectionWidget(
      {Key key, @required this.title, this.icon, this.titleColor, @required this.onPressed, this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValidatorUtils.isNullEmpty(header)
            ? SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    header,
                    style: ThemeText.body1,
                  ),
                  SizedBox(
                    height: LayoutConstants.paddingVertical15,
                  ),
                ],
              ),
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: TextFormConstants.paddingHorizontal).copyWith(
              top: TextFormConstants.paddingTop,
              bottom: TextFormConstants.paddingBottom,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.paleGrey,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(LayoutConstants.roundedRadius)),
                color: AppColor.paleGrey),
            child: Row(
              children: [
                ValidatorUtils.isNullEmpty(icon)
                    ? SizedBox.shrink()
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            color: AppColor.grey,
                          ),
                          SizedBox(
                            width: LayoutConstants.paddingHorizontal10,
                          ),
                        ],
                      ),
                Text(
                  title,
                  style: ThemeText.body1.copyWith(color: titleColor ?? AppColor.textColor),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
