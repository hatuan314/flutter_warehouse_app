import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
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
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddIoiBloc, AddIoiState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is WaitingAddIoiState) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: LayoutConstants.paddingHorizontalApp,
                vertical: LayoutConstants.paddingVerticalApp,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormWidget(
                    controller: nameController,
                    hintText: AddItemOfInvoiceConstants.itemNameHintTxt,
                    backgroundColor: AppColor.white,
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
                    title: ValidatorUtils.isNullEmpty(state.selectUnit) ? StringConstants.unitTxt : state.selectUnit,
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
                    backgroundColor: AppColor.white,
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
                  TextFormWidget(
                    controller: qtyController,
                    hintText:
                        '${AddItemOfInvoiceConstants.amountHintTxt}${ValidatorUtils.isNullEmpty(state.selectUnit) ? 'Sản phẩm' : state.selectUnit}',
                    keyboardType: TextInputType.number,
                    backgroundColor: AppColor.white,
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
                  ButtonWidget(
                      title: StringConstants.addTxt,
                      onPressed: () {
                        // if (_formKey.currentState.validate()) {
                        //   BlocProvider.of<AddDistributorBloc>(context)
                        //       .add(CreateDistributorEvent(
                        //     name: _nameController.text.trim(),
                        //     firstPhone: _firstPhoneController.text.trim(),
                        //     secondPhone: _secondPhoneController.text.trim(),
                        //     firstEmail: _firstEmailController.text.trim(),
                        //     secondEmail: _secondEmailController.text.trim(),
                        //   ));
                        // }
                      })
                ],
              ),
            );
          }
          return SizedBox();
        });
  }

  void _onPressedSelectUnit(BuildContext context) {
    Navigator.pushNamed(context, RouteList.unitList,
        arguments: {ArgumentConstants.currentRouteArg: RouteList.addItemOfInvoice}).then((unitJson) {
      BlocProvider.of<AddIoiBloc>(context).add(SelectUnitEvent(UnitModel.fromJson(jsonDecode(unitJson))));
    });
  }
}
