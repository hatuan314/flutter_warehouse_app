import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/bill_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/create_invoice_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/widgets/item_bill_widget.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/widgets/selection_widget.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  final DateTime selectBillDate;
  final BillEnum selectBill;
  final List<ItemBillEntity> itemBillList;
  final List<PickedFile> imageFiles;
  final Function onSelectDistributor;
  final Function(PickedFile) onSelectInvoiceImageLocal;
  final Function(String) onSelectInvoiceImageUrl;
  final Function(BillEnum) onSelectBillType;
  final Function onPressedGallery;
  final Function onPressedCamera;
  final Function onPressedAddItemBtn;
  final Function(ItemBillEntity, int) onPressedItemBill;
  final Function(DateTime date) onSelectedBillDate;
  final TextEditingController customerController;
  final TextEditingController noteController;

  const CreateInvoiceFormWidget({
    Key key,
    this.enableSelectDistributor,
    this.totalAmountBill,
    this.imageQty,
    this.distributorName,
    this.selectBill,
    this.selectBillDate,
    this.itemBillList,
    this.imageFiles,
    this.onSelectDistributor,
    this.onSelectInvoiceImageLocal,
    this.onSelectInvoiceImageUrl,
    this.onSelectBillType,
    this.onPressedGallery,
    this.onPressedCamera,
    this.onPressedAddItemBtn,
    this.onPressedItemBill,
    this.onSelectedBillDate,
    this.customerController,
    this.noteController,
  }) : super(key: key);

  Widget _noteWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConstants.noteTxt,
          style: ThemeText.body1.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: LayoutConstants.paddingVertical15,
        ),
        TextFormWidget(
          controller: noteController,
          maxLines: 5,
          hintText: 'Hãy viết gì đó vào đây',
          validator: (_) {},
        ),
      ],
    );
  }

  Widget _itemBillListWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      onPressed: () => onPressedItemBill(itemBillList[index], index),
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
      ],
    );
  }

  Widget _billDateWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConstants.billDateTxt,
          style: ThemeText.body1.copyWith(fontWeight: FontWeight.w600),
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
                  return CupertinoDatePicker(
                    initialDateTime: selectBillDate,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: onSelectedBillDate,
                  );
                });
          },
          icon: Icons.calendar_today_rounded,
          title: DateFormat('dd/MM/yyyy').format(selectBillDate),
          titleColor: AppColor.textColor,
        ),
      ],
    );
  }

  Widget _billTypeWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConstants.billTypeTxt,
          style: ThemeText.body1.copyWith(fontWeight: FontWeight.w600),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        enableSelectDistributor
            ? SelectionWidget(
                icon: Icons.store,
                title: ValidatorUtils.isNullEmpty(distributorName)
                    ? CreateInvoiceConstants.selectDistributorTxt
                    : distributorName,
                titleColor: ValidatorUtils.isNullEmpty(distributorName) ? AppColor.grey : AppColor.textColor,
                onPressed: onSelectDistributor,
              )
            : CustomerFieldWidget(
                controller: customerController,
              ),
        SizedBox(
          height: LayoutConstants.paddingVertical15,
        ),
        _billTypeWidget(context),
        SizedBox(
          height: LayoutConstants.paddingVertical15,
        ),
        _billDateWidget(context),
        SizedBox(
          height: LayoutConstants.paddingVertical15,
        ),
        _itemBillListWidget(),
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
          onSelectedLocal: onSelectInvoiceImageLocal,
          onSelectedUrl: onSelectInvoiceImageUrl,
          onPressedGallery: onPressedGallery,
          onPressedCamera: onPressedCamera,
        ),
        SizedBox(
          height: LayoutConstants.paddingVertical15,
        ),
        _noteWidget(),
      ],
    );
  }
}
