import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/image_network_widget/image_network_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/touchable_widget.dart';
import 'package:image_picker/image_picker.dart';

class InvoiceImageWidget extends StatelessWidget {
  final PickedFile file;
  final String link;
  final Function onPressed;

  const InvoiceImageWidget({Key key, this.file, this.link, @required this.onPressed}) : super(key: key);

  Widget _imageSource() {
    if (!ValidatorUtils.isNullEmpty(file)) {
      return Image.file(
        File(file.path),
        fit: BoxFit.cover,
      );
    }
    if (!ValidatorUtils.isNullEmpty(link)) {
      return ImageNetworkWidget(
        uri: link,
      );
    }
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Icon(
        Icons.error_outline,
        color: AppColor.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TouchableWidget(
        onPressed: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(LayoutConstants.roundedRadius)),
          child: _imageSource(),
        ));
  }
}
