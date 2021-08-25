import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:flutterwarehouseapp/src/widgets/animation_widget/animation_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/loader_widget/loader_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/touchable_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/unit_item_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/empty_widget.dart';

class BodyWidget extends StatelessWidget {
  final UnitListState state;
  final Function(UnitEntity) onPressUnit;

  const BodyWidget({Key key,@required this.state, this.onPressUnit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (state.viewState == ViewState.initial) {
      if (state.units.isNotSafe) {
        return EmptyWidget();
      }
      return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: state.units.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: AnimationWidget(
                index: index,
                child: TouchableWidget(
                    onPressed: () {
                      onPressUnit(state.units[index]);
                    },
                    child: UnitItemWidget(name: state.units[index].name,)),
              ),
            );
          });
    }
    if (state.viewState == ViewState.loading) {
      return LoadingContainer(child: SizedBox());
    }
    return EmptyWidget();
  }

}