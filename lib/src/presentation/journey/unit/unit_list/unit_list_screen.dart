import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/animation_widget/animation_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/loader_widget/loader_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/empty_widget.dart';

class UnitListScreen extends StatelessWidget {
  Widget _unitItemWidget(UnitEntity unit) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontal15),
      padding:
          EdgeInsets.symmetric(vertical: LayoutConstants.paddingHorizontal15),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: AppColor.black25,
        width: 1,
      ))),
      child: Text(
        '${unit?.name}',
        style: ThemeText.body2,
      ),
    );
  }

  Widget _bodyWidget(UnitListState state) {
    if (state.viewState == ViewState.initial) {
      if (state.units.isNotSafe) {
        return EmptyWidget();
      }
      return ListView.builder(
          itemCount: state.units.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: AnimationWidget(
                index: index,
                child: _unitItemWidget(state.units[index]),
              ),
            );
          });
    }
    if (state.viewState == ViewState.loading) {
      return LoadingContainer(child: SizedBox());
    }
    return EmptyWidget();
  }

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
              icon: Icon(Icons.add),
              onPressed: () {
                locator<SnackbarBloc>().add(ShowSnackbar(
                    title: StringConstants.developmentTxt,
                    type: SnackBarType.warning));
              })
        ],
        title: StringConstants.unitTxt,
        child: _bodyWidget(state),
      );
    });
  }
}
