import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/dash_widget/dotted_border.dart';
import 'package:flutterwarehouseapp/src/widgets/touchable_widget.dart';

class AddInvoiceImageWidget extends StatelessWidget {
  final Function onPressed;

  const AddInvoiceImageWidget({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TouchableWidget(
        onPressed: onPressed,
        child: DottedBorder(
            padding: EdgeInsets.zero,
            borderType: BorderType.RRect,
            color: AppColor.grey,
            radius: Radius.circular(LayoutConstants.roundedRadius),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(LayoutConstants.roundedRadius)),
              child: Container(
                // height: LayoutConstants.buttonHeight,
                width: double.infinity,
                alignment: Alignment.center,
                child: Icon(Icons.camera_alt_outlined, color: AppColor.grey,),
              ),
            )));
  }

}