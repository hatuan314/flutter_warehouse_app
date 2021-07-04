import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/utils/connectivity_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/bloc/distributor_detail_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/bloc/distributor_detail_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/bloc/distributor_detail_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/widgets/change_email_bottom_sheet.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/widgets/change_phone_bottom_sheet.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/widgets/contacts_type_widget.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/widgets/info_widget.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/dialog/common_dialog.dart';

class DistributorDetailScreen extends StatelessWidget {
  Widget _bodyWidget(BuildContext context, DistributorDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoWidget(
          distributor: state.distributor,
        ),
        SizedBox(
          height: LayoutConstants.paddingVertical30,
        ),
        ContactTypeWidget(
          title: StringConstants.phoneNumberTxt,
          contactList: state.distributor.phones,
          onChanged: (value) => _onChangePhone(context, value),
        ),
        ContactTypeWidget(
          title: StringConstants.emailTxt,
          contactList: state.distributor.emails,
          onChanged: (value) => _onChangeEmail(context, value),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DistributorDetailBloc, DistributorDetailState>(
        listener: (context, state) {
      if (state is DeleteDistributorSuccessState) {
        Navigator.of(context).pop(true);
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: AppColor.transparent,
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pop(state.isUpdate);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.black,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: AppColor.black,
                ),
                onPressed: () {
                  ConnectivityUtils.checkConnectInternet().then((value) {
                    if (value) {
                      CommonDialog(
                        context,
                        title: StringConstants.deleteTxt,
                        dialogType: DialogType.WARNING,
                        content: DistributorConstants.contentDeleteDialogTxt,
                        onCancel: () {},
                        onAccept: () {
                          BlocProvider.of<DistributorDetailBloc>(context)
                              .add(DeleteDistributorEvent());
                        },
                      )..show();
                    } else {
                      locator<SnackbarBloc>().add(ShowSnackbar(
                        title: StringConstants.noInternetTxt,
                        type: SnackBarType.disconnect,
                      ));
                    }
                  });
                }),
          ],
        ),
        body: state.viewState == ViewState.loading
            ? SizedBox()
            : _bodyWidget(context, state),
      );
    });
  }

  _onChangePhone(BuildContext context, String currentPhone) {
    showModalBottomSheet<String>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius20),
        ),
        isScrollControlled: true,
        context: context,
        builder: (bottomSheetContext) {
          return ChangePhoneBottomSheet(
              phone: currentPhone,
              onChanged: (newPhone) {
                BlocProvider.of<DistributorDetailBloc>(context)
                    .add(ChangePhoneEvent(
                  currentPhone: currentPhone,
                  newPhone: newPhone,
                ));
              });
        });
  }

  _onChangeEmail(BuildContext context, String currentEmail) {
    showModalBottomSheet<String>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius20),
        ),
        isScrollControlled: true,
        context: context,
        builder: (bottomSheetContext) {
          return ChangeEmailBottomSheet(
              email: currentEmail,
              onChanged: (newEmail) {
                BlocProvider.of<DistributorDetailBloc>(context)
                    .add(ChangeEmailEvent(
                  currentEmail: currentEmail,
                  newEmail: newEmail,
                ));
              });
        });
  }
}
