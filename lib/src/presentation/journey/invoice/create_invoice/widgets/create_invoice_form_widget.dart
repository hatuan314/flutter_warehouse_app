import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/enums/bill_enum.dart';
import 'package:flutterwarehouseapp/common/utils/bill_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/create_invoice_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/widgets/selection_widget.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

import 'add_element_button.dart';
import 'invoice_images_widget.dart';
import 'select_bill_type_bottom_sheet.dart';

class CreateInvoiceFormWidget extends StatelessWidget {
  final String distributorName;
  final BillEnum selectBill;
  final Function onSelectDistributor;
  final Function(BillEnum) onSelectBillType;

  const CreateInvoiceFormWidget({
    Key key,
    this.distributorName,
    this.selectBill,
    this.onSelectDistributor,
    this.onSelectBillType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectionWidget(
          icon: Icons.store,
          title: ValidatorUtils.isNullEmpty(distributorName)
              ? CreateInvoiceConstants.selectDistributorTxt
              : distributorName,
          titleColor: ValidatorUtils.isNullEmpty(distributorName) ? AppColor.grey : AppColor.textColor,
          onPressed: onSelectDistributor,
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
                  return SelectBillTypeBottomSheet(
                    onPressed: onSelectBillType,
                    selected: selectBill ?? BillEnum.Export,
                  );
                });
          },
          icon: Icons.assignment_outlined,
          title: ValidatorUtils.isNullEmpty(selectBill)
              ? CreateInvoiceConstants.selectBillTypeTxt
              : BillUtils.convertToString(selectBill),
          titleColor: ValidatorUtils.isNullEmpty(selectBill) ? AppColor.grey : AppColor.textColor,
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
        AddItemButton(
          onPressed: () => _onPressedAddItemBtn(context),
        ),
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
        InvoiceImagesWidget(),
      ],
    );
  }

  void _onPressedAddItemBtn(BuildContext context) {
    Navigator.pushNamed(context, RouteList.addItemOfInvoice).then((value) {

    });
  }
}
