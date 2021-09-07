import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/models/category_model.dart';
import 'package:flutterwarehouseapp/src/data/models/unit_model.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/add_item_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/bloc/add_ioi_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/bloc/add_ioi_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/bloc/add_ioi_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/widgets/selection_widget.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_widget.dart';

class AddItemOfInvoiceBodyWidget extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddIoiBloc, AddIoiState>(listener: (context, state) {
      if (state is AddToBillState) {
        Navigator.of(context).pop(jsonEncode(state.itemBill.toJson()));
      }
    }, builder: (context, state) {
      if (state is WaitingAddIoiState) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: LayoutConstants.paddingHorizontalApp,
            vertical: LayoutConstants.paddingVerticalApp,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormWidget(
                  controller: nameController,
                  hintText: AddItemOfInvoiceConstants.itemNameHintTxt,
                  validator: (value) {
                    if (ValidatorUtils.isNullEmpty(value)) {
                      return StringConstants.emptyField;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: LayoutConstants.paddingVertical15,
                ),
                SelectionWidget(
                  header: AddItemOfInvoiceConstants.categoryHeader,
                  title: ValidatorUtils.isNullEmpty(state.selectCategory)
                      ? AddItemOfInvoiceConstants.selectCategoryTxt
                      : state.selectCategory,
                  onPressed: () => _onPressedSelectCategory(context),
                  titleColor:
                      ValidatorUtils.isNullEmpty(state.selectCategory) ? AppColor.hintColor : AppColor.textColor,
                ),
                SizedBox(
                  height: LayoutConstants.paddingVertical15,
                ),
                SelectionWidget(
                  header: AddItemOfInvoiceConstants.unitHeader,
                  title: ValidatorUtils.isNullEmpty(state.selectUnit)
                      ? AddItemOfInvoiceConstants.selectUnitTxt
                      : state.selectUnit,
                  onPressed: () => _onPressedSelectUnit(context),
                  titleColor: ValidatorUtils.isNullEmpty(state.selectUnit) ? AppColor.hintColor : AppColor.textColor,
                ),
                SizedBox(
                  height: LayoutConstants.paddingVertical15,
                ),
                TextFormWidget(
                  controller: qtyController,
                  hintText: StringConstants.quantityTxt,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (ValidatorUtils.isNullEmpty(value)) {
                      return StringConstants.emptyField;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: LayoutConstants.paddingVertical15,
                ),
                TextFormWidget.withFormatMoney(
                  controller: priceController,
                  hintText:
                      '${AddItemOfInvoiceConstants.amountHintTxt}${ValidatorUtils.isNullEmpty(state.selectUnit) ? 'Sản phẩm' : state.selectUnit}',
                  validator: (value) {
                    if (ValidatorUtils.isNullEmpty(value)) {
                      return StringConstants.emptyField;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: LayoutConstants.paddingVertical20,
                ),
                ButtonWidget(title: StringConstants.addTxt, onPressed: () => _onPressedAddBtn(context))
              ],
            ),
          ),
        );
      }
      return SizedBox();
    });
  }

  void _onPressedSelectUnit(BuildContext context) {
    Navigator.pushNamed(context, RouteList.unitList,
        arguments: {ArgumentConstants.currentRouteArg: RouteList.addItemOfInvoice}).then((unitJson) {
      if (!ValidatorUtils.isNullEmpty(unitJson)) {
        BlocProvider.of<AddIoiBloc>(context).add(SelectUnitEvent(UnitModel.fromJson(jsonDecode(unitJson))));
      }
    });
  }

  void _onPressedAddBtn(BuildContext context) {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<AddIoiBloc>(context).add(AddItemEvent(
        name: nameController.text.trim(),
        qty: qtyController.text.trim(),
        price: priceController.text.trim(),
      ));
    }
  }

  void _onPressedSelectCategory(BuildContext context) {
    Navigator.pushNamed(context, RouteList.categoryList,
        arguments: {ArgumentConstants.currentRouteArg: RouteList.addItemOfInvoice}).then((categoryJson) {
          if (!ValidatorUtils.isNullEmpty(categoryJson)) {
        BlocProvider.of<AddIoiBloc>(context)
            .add(SelectCategoryEvent(category: CategoryModel.fromJson(jsonDecode(categoryJson))));
      }
    });
  }
}
