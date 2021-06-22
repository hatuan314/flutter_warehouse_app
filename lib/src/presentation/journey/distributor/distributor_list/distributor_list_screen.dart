import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/empty_widget.dart';

class DistributorListScreen extends StatelessWidget {
  Widget _bodyWidget() {
    return EmptyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      isLeading: true,
      onLeading: () {
        Navigator.of(context).pop();
      },
      title: StringConstants.distributorTxt,
      child: _bodyWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteList.addDistributor);
        },
        child: Icon(
          Icons.add,
          size: LayoutConstants.smallIconBtnSize,
        ),
        backgroundColor: AppColor.primaryColor,
      ),
    );
  }
}
