import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/category_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/bloc/create_category_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/bloc/create_category_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_widget.dart';

class BodyWidget extends StatelessWidget {
  final TextEditingController nameController;
  final Function onCreateCategory;

  const BodyWidget({Key key, @required this.nameController, @required this.onCreateCategory,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: LayoutConstants.paddingHorizontalApp,
        vertical: LayoutConstants.paddingVerticalApp,
      ),
      child: Column(
        children: [
          TextFormWidget(
            autoFocus: true,
            controller: nameController,
            hintText: CategoryConstants.nameTxt,
            validator: (value) {
              ValidatorUtils.validateEmptyField(value);
            },
          ),
          SizedBox(
            height: LayoutConstants.paddingVertical50,
          ),
          ButtonWidget(
            title: StringConstants.createTxt,
            onPressed: onCreateCategory,
          )
        ],
      ),
    );
  }
}
