import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/common/configs/local_db_setup.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/animation_widget/animation_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/loader_widget/loader_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/empty_widget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    // if (state.viewState == ViewState.initial) {
    //   return WatchBoxBuilder(
    //       box: locator<LocalDbSetup>().unitBox,
    //       builder: (context, unitsBox) {
    //         log('UnitListScreen - units: ${unitsBox.length}');
    //         if (unitsBox.length == 0) {
    //           BlocProvider.of<UnitListBloc>(context)
    //               .add(InitialUnitListEvent());
    //         }
    //         return ListView.builder(
    //             itemCount: unitsBox.length,
    //             itemBuilder: (context, index) {
    //               UnitEntity unit = unitsBox.getAt(index) as UnitEntity;
    //               return AnimationConfiguration.staggeredList(
    //                 position: index,
    //                 duration: const Duration(milliseconds: 375),
    //                 child: AnimationWidget(
    //                   index: index,
    //                   child: _unitItemWidget(unit),
    //                 ),
    //               );
    //             });
    //       });
    // }
    // if (state.viewState == ViewState.loading) {
    //   return LoadingContainer(child: SizedBox());
    // }
    // return EmptyWidget();
    return ValueListenableBuilder(
        valueListenable: Hive.box<UnitEntity>(DefaultConfig.unitsCollection).listenable(),
        builder: (context, unitsBox, _) {
          log('UnitListScreen - units: ${unitsBox.length}');
          if (unitsBox.length == 0) {
            BlocProvider.of<UnitListBloc>(context)
                .add(InitialUnitListEvent());
          }
          return ListView.builder(
              itemCount: unitsBox.length,
              itemBuilder: (context, index) {
                UnitEntity unit = unitsBox.getAt(index) as UnitEntity;
                log("${unit.name}");
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: AnimationWidget(
                    index: index,
                    child: _unitItemWidget(unit),
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitListBloc, UnitListState>(builder: (context, state) {
      return ScaffoldWidget(
        isLeading: true,
        onLeading: () {
          Navigator.of(context).pop();
        },
        title: StringConstants.unitTxt,
        child: _bodyWidget(state),
      );
    });
  }
}
