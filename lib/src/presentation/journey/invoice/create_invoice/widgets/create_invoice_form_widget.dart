import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/bill_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/create_invoice_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/widgets/item_bill_widget.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/widgets/selection_widget.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:image_picker/image_picker.dart';

import 'add_element_button.dart';
import 'customer_field_widget.dart';
import 'invoice_image_list_widget.dart';
import 'select_bill_type_bottom_sheet.dart';
import 'total_amount_widget.dart';

class CreateInvoiceFormWidget extends StatelessWidget {
  final bool enableSelectDistributor;
  final int totalAmountBill;
  final int imageQty;
  final String distributorName;
  final BillEnum selectBill;
  final List<ItemBillEntity> itemBillList;
  final List<PickedFile> imageFiles;
  final Function onSelectDistributor;
  final Function onSelectInvoiceImage;
  final Function(BillEnum) onSelectBillType;
  final Function onPressedGallery;
  final Function onPressedCamera;
  final Function onPressedAddItemBtn;
  final TextEditingController customerController;

  const CreateInvoiceFormWidget({
    Key key,
    this.enableSelectDistributor,
    this.totalAmountBill,
    this.imageQty,
    this.distributorName,
    this.selectBill,
    this.itemBillList,
    this.imageFiles,
    this.onSelectDistributor,
    this.onSelectInvoiceImage,
    this.onSelectBillType,
    this.onPressedGallery,
    this.onPressedCamera,
    this.onPressedAddItemBtn,
    this.customerController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        enableSelectDistributor ? SelectionWidget(
          icon: Icons.store,
          title: ValidatorUtils.isNullEmpty(distributorName)
              ? CreateInvoiceConstants.selectDistributorTxt
              : distributorName,
          titleColor: ValidatorUtils.isNullEmpty(distributorName) ? AppColor.grey : AppColor.textColor,
          onPressed: onSelectDistributor,
        ) : CustomerFieldWidget(controller: customerController,),
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
        itemBillList.isNotSafe
            ? SizedBox()
            : Column(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: itemBillList.length,
                    itemBuilder: (context, index) => ItemBillWidget(
                      itemBill: itemBillList[index],
                    ),
                  ),
                  SizedBox(
                    height: LayoutConstants.paddingVertical15,
                  ),
                  TotalAmountWidget(
                    totalAmount: totalAmountBill,
                  ),
                  SizedBox(
                    height: LayoutConstants.paddingVertical15,
                  ),
                ],
              ),
        AddItemButton(
          onPressed: onPressedAddItemBtn,
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
        InvoiceImageListWidget(
          imageFiles: ValidatorUtils.isNullEmptyList(this.imageFiles) ? [] : imageFiles,
          imageLinks: [],
          imageQty: imageQty,
          onSelected: onSelectInvoiceImage,
          onPressedGallery: onPressedGallery,
          onPressedCamera: onPressedCamera,
        ),
      ],
    );
  }
}
