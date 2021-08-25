import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/widgets/add_invoice_image_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/bottom_sheet/image_source_bottom_sheet.dart';

class InvoiceImagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
        childAspectRatio: 1,
      children: [
        AddInvoiceImageWidget(
          onPressed: () {
            showModalBottomSheet<String>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius20),
                ),
                context: context,
                builder: (bottomSheetContext) {
                  return ImageSourceBottomSheet();
                });
          },
        ),
      ],
    );
  }
}
