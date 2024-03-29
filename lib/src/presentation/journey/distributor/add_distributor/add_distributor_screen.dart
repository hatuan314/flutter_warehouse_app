import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/add_distributor_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/bloc/add_distributor_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/bloc/add_distributor_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/bloc/add_distributor_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/widgets/distributor_form_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/dialog/common_dialog.dart';
import 'package:flutterwarehouseapp/src/widgets/internet_widget/check_internet_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';

class AddDistributorScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _firstPhoneController = TextEditingController();
  final TextEditingController _secondPhoneController = TextEditingController();
  final TextEditingController _firstEmailController = TextEditingController();
  final TextEditingController _secondEmailController = TextEditingController();

  Widget _bodyWidget(BuildContext context) {
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
                      BlocProvider.of<AddDistributorBloc>(context)
                          .add(CreateDistributorEvent(
                        name: _nameController.text.trim(),
                        firstPhone: _firstPhoneController.text.trim(),
                        secondPhone: _secondPhoneController.text.trim(),
                        firstEmail: _firstEmailController.text.trim(),
                        secondEmail: _secondEmailController.text.trim(),
                      ));
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
    return BlocConsumer<AddDistributorBloc, AddDistributorState>(
        listener: (context, state) {
      if (state is PopAddDistributorState) {
        if (state.isShowDialog) {
          CommonDialog(
            context,
            dialogType: DialogType.WARNING,
            title: AddDistributorConstants.titlePopDialog,
            content: AddDistributorConstants.contentPopDialog,
            onAccept: () {
              Navigator.of(context).pop();
            },
            onCancel: () {
              BlocProvider.of<AddDistributorBloc>(context)
                  .add(CancelPopAddDistributorEvent());
            },
          )..show();
        }
        if (!state.isShowDialog) {
          Navigator.of(context).pop();
        }
      }
      if (state is CreateDistributorSuccessState) {
        Navigator.of(context).pop(true);
      }
    }, builder: (context, snapshot) {
      return ScaffoldWidget(
        isLeading: true,
        onLeading: () {
          BlocProvider.of<AddDistributorBloc>(context)
              .add(PopAddDistributorEvent(
            name: _nameController.text.trim(),
            firstPhone: _firstPhoneController.text.trim(),
            secondPhone: _secondPhoneController.text.trim(),
            firstEmail: _firstEmailController.text.trim(),
            secondEmail: _secondEmailController.text.trim(),
          ));
        },
        title: StringConstants.addDistributorTxt,
        child: InternetWidget(child: _bodyWidget(context)),
        // child: NoInternetWidget(),
      );
    });
  }
}
