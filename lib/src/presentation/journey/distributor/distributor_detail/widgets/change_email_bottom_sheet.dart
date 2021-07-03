import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/distributor_detail_constants.dart';
import 'package:flutterwarehouseapp/src/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_widget.dart';

class ChangeEmailBottomSheet extends StatelessWidget {
  final String email;
  final TextEditingController textEditingController = TextEditingController();
  final Function(String) onChanged;

  ChangeEmailBottomSheet({Key key,@required this.onChanged, @required this.email}) : super(key: key);

  Widget _bodyWidget(BuildContext context) {
    return Column(
      children: [
        TextFormWidget(
          autoFocus: true,
          handlerOnSubmitted: (email) =>
              onChanged(email),
          controller: textEditingController,
          keyboardType: TextInputType.phone,
          hintText: StringConstants.emailTxt,
          validator: (value) {
            return ValidatorUtils.validateEmail(value);
          },
        ),
        SizedBox(height: LayoutConstants.paddingVertical40,),
        ButtonWidget(title: StringConstants.changeTxt, onPressed: () {
          onChanged(textEditingController.text);
          Navigator.of(context).pop();
        })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    textEditingController.text = email;
    return BottomSheerWidget(
      title: DistributorDetailConstants.changeEmailTxt,
      child: _bodyWidget(context),
    );
  }

}