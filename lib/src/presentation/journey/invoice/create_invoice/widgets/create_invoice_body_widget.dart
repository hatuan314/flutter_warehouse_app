import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';

import 'create_invoice_form_widget.dart';

class CreateInvoiceBodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: LayoutConstants.paddingVerticalApp,
        horizontal: LayoutConstants.paddingHorizontalApp,
      ),
      child: Column(
        children: [
          CreateInvoiceFormWidget(),
          ButtonWidget(
              title: StringConstants.createTxt,
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
}
