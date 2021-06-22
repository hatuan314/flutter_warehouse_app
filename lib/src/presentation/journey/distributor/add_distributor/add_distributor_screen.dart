import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/widgets/distributor_form_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/empty_widget.dart';

class AddDistributorScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _firstPhoneController = TextEditingController();
  final TextEditingController _secondPhoneController = TextEditingController();
  final TextEditingController _firstEmailController = TextEditingController();
  final TextEditingController _secondEmailController = TextEditingController();

  Widget _bodyWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: LayoutConstants.paddingHorizontalApp,
        vertical: LayoutConstants.paddingVerticalApp,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DistributorFormWidget(
                nameController: _nameController,
                firstEmailController: _firstEmailController,
                secondEmailController: _secondEmailController,
                firstPhoneController: _firstPhoneController,
                secondPhoneController: _secondPhoneController,
              ),
              SizedBox(
                height: LayoutConstants.paddingVertical50,
              ),
              ButtonWidget(
                  title: StringConstants.createTxt,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      log('message');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      isLeading: true,
      onLeading: () {
        Navigator.of(context).pop();
      },
      title: StringConstants.addDistributorTxt,
      child: _bodyWidget(),
    );
  }
}
