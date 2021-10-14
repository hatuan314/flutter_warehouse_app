import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/widgets/add_invoice_image_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/bottom_sheet/image_source_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

import 'invoice_image_widget.dart';

class InvoiceImageListWidget extends StatelessWidget {
  final List<PickedFile> imageFiles;
  final List<String> imageLinks;
  final int imageQty;
  final Function(PickedFile) onSelectedLocal;
  final Function(String) onSelectedUrl;
  final Function onPressedGallery;
  final Function onPressedCamera;

  const InvoiceImageListWidget({
    Key key,
    @required this.imageFiles,
    @required this.imageLinks,
    this.imageQty,
    @required this.onSelectedLocal,
    @required this.onSelectedUrl,
    this.onPressedGallery,
    this.onPressedCamera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: imageQty + 1,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        mainAxisSpacing: LayoutConstants.paddingHorizontal10,
        crossAxisSpacing: LayoutConstants.paddingVertical10,
      ),
      itemBuilder: (BuildContext context, index) {
        if (!ValidatorUtils.isNullEmptyList(imageFiles) && index < imageFiles.length) {
          return InvoiceImageWidget(
            file: imageFiles[index],
            onPressed: () => onSelectedLocal(imageFiles[index]),
          );
        }
        if (!ValidatorUtils.isNullEmptyList(imageLinks) && index >= imageFiles.length && index < imageLinks.length) {

          return InvoiceImageWidget(
            link: imageLinks[index - imageFiles.length],
            onPressed: () => onSelectedUrl(imageLinks[index - imageFiles.length]),
          );
        }
        if (index == imageQty) {
          return AddInvoiceImageWidget(
            onPressed: () {
              showModalBottomSheet<String>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius20),
                  ),
                  context: context,
                  builder: (bottomSheetContext) {
                    return ImageSourceBottomSheet(
                      onPressedGallery: onPressedGallery,
                      onPressedCamera: onPressedCamera,
                    );
                  });
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
