import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/src/domain/entities/__mock__/distributor_mock.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/bloc/distributor_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/bloc/distributor_list_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/widgets/distributor_item_widget.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/animation_widget/animation_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/empty_widget.dart';

class DistributorListScreen extends StatelessWidget {
  Widget _bodyWidget(DistributorListState state) {
    return ListView.builder(
        itemCount: state.distributorList.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: AnimationWidget(
              index: index,
              child: DistributorItemWidget(
                distributor: state.distributorList[index],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DistributorListBloc, DistributorListState>(
      builder: (context, state) {
        return ScaffoldWidget(
          isLeading: true,
          onLeading: () {
            Navigator.of(context).pop();
          },
          title: StringConstants.distributorTxt,
          child: _bodyWidget(state),
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
    );
  }
}
