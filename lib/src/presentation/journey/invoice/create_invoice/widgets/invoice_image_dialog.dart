import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/image_network_widget/image_network_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/touchable_widget.dart';
import 'package:image_picker/image_picker.dart';

class InvoiceImageDialog extends StatelessWidget {
  final PickedFile file;
  final String link;
  final Function onDeleted;

  const InvoiceImageDialog({Key key, this.file, this.link, this.onDeleted}) : super(key: key);

  Widget _imageSource(BuildContext context) {
    final double imageWidth = MediaQuery.of(context).size.width * 4/5;
    if (!ValidatorUtils.isNullEmpty(file)) {
      return Container(
        width: imageWidth,
        alignment: Alignment.center,
        child: Image.file(
          File(file.path),
        ),
      );
    }
    if (!ValidatorUtils.isNullEmpty(link)) {
      return ImageNetworkWidget(
        width: imageWidth,
        uri: link,
        fit: BoxFit.fitWidth,
      );
    }
    return Container(
      width: imageWidth,
      alignment: Alignment.center,
      child: Icon(
        Icons.error_outline,
        color: AppColor.grey,
      ),
    );
  }

  Widget _closeButton(BuildContext context) {
    return TouchableWidget(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.white, width: 2),
            borderRadius: BorderRadius.circular(80),
          ),
          margin: EdgeInsets.all(LayoutConstants.paddingVertical10),
          padding: EdgeInsets.all(5),
          child: Icon(
            Icons.close,
            color: AppColor.white,
          ),
        ));
  }

  Widget _deleteButton() {
    return TouchableWidget(
        onPressed: onDeleted,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.red, width: 2),
            borderRadius: BorderRadius.circular(80),
          ),
          margin: EdgeInsets.all(LayoutConstants.paddingVertical10),
          padding: EdgeInsets.all(5),
          child: Icon(
            Icons.delete_outline_outlined,
            color: AppColor.red,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(LayoutConstants.roundedRadius)),
            child: _imageSource(context),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _closeButton(context),
              _deleteButton(),
            ],
          )
        ],
      ),
    );
  }
}
