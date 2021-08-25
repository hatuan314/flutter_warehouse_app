import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/widgets/body_widget.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';

class UnitListScreen extends StatelessWidget {
  final String currentRoute;

  const UnitListScreen({Key key, @required this.currentRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitListBloc, UnitListState>(builder: (context, state) {
      return ScaffoldWidget(
        isLeading: true,
        onLeading: () {
          Navigator.of(context).pop();
        },
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: AppColor.white,
              ),
              onPressed: () {
                locator<SnackbarBloc>()
                    .add(ShowSnackbar(title: StringConstants.developmentTxt, type: SnackBarType.warning));
              })
        ],
        title: StringConstants.unitTxt,
        child: BodyWidget(
          state: state,
          onPressUnit: (value) => _onPressedUnit(context, value),
        ),
      );
    });
  }

  void _onPressedUnit(BuildContext context, UnitEntity unit) {
    if (currentRoute == RouteList.addItemOfInvoice) {
      Navigator.pop(context, jsonEncode(unit.toModel().toJson()));
    }
  }
}
