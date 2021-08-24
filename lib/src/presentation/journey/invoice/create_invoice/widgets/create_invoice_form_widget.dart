import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/add_distributor_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/create_invoice_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/widgets/selection_widget.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_widget.dart';

import 'add_element_button.dart';
import 'select_bill_type_bottom_sheet.dart';

class CreateInvoiceFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectionWidget(
          icon: Icons.store,
          title: CreateInvoiceConstants.selectDistributorTxt,
          titleColor: AppColor.grey,
          onPressed: () {},
        ),
        SizedBox(
          height: LayoutConstants.paddingVertical15,
        ),
        SelectionWidget(
          onPressed: () {
            showModalBottomSheet<String>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius20),
                ),
                // isScrollControlled: true,
                context: context,
                builder: (bottomSheetContext) {
                  return SelectBillTypeBottomSheet();
                });
          },
          icon: Icons.assignment_outlined,
          title: CreateInvoiceConstants.selectBillTypeTxt,
          titleColor: AppColor.grey,
        ),
        SizedBox(
          height: LayoutConstants.paddingVertical15,
        ),
        Text(
          CreateInvoiceConstants.productListTxt,
          style: ThemeText.body1.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: LayoutConstants.paddingVertical15,
        ),
        AddElementButton(),
        SizedBox(
          height: LayoutConstants.paddingVertical15,
        ),
        Text(
          CreateInvoiceConstants.invoiceImage,
          style: ThemeText.body1.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: LayoutConstants.paddingVertical15,
        ),
      ],
    );
  }
}
