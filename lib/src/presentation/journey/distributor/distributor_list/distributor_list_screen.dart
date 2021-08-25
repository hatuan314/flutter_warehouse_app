import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/bloc/distributor_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/bloc/distributor_list_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/bloc/distributor_list_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/widgets/distributor_item_widget.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/widgets/distributor_list_skeleton_widget.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/animation_widget/animation_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/empty_widget.dart';

class DistributorListScreen extends StatelessWidget {
  final String currentRoute;

  const DistributorListScreen({Key key, this.currentRoute}) : super(key: key);

  Widget _bodyWidget(DistributorListState state) {
    if (state.viewState == ViewState.loading) {
      return DistributorListSkeletonWidget();
    }
    if (state.viewState == ViewState.initial) {
      return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: state.distributorList.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: AnimationWidget(
                index: index,
                child: DistributorItemWidget(
                  onPressedDetail: () => _onPressedDetail(context, state.distributorList[index], index),
                  distributor: state.distributorList[index],
                  index: index,
                  onDelete: () {
                    BlocProvider.of<DistributorListBloc>(context).add(RemoveDistributorEvent(
                      index: index,
                      distributor: state.distributorList[index],
                    ));
                  },
                ),
              ),
            );
          });
    }
    return EmptyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DistributorListBloc, DistributorListState>(builder: (context, state) {
      return ScaffoldWidget(
        isLeading: true,
        onLeading: () {
          Navigator.of(context).pop();
        },
        title: StringConstants.distributorTxt,
        child: _bodyWidget(state),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(RouteList.addDistributor).then((value) {
              if (value == true) {
                BlocProvider.of<DistributorListBloc>(context).add(InitialDistributorListEvent());
              }
            });
          },
          child: Icon(
            Icons.add,
            size: LayoutConstants.smallIconBtnSize,
          ),
          backgroundColor: AppColor.primaryColor,
        ),
      );
    });
  }

  void _onPressedDetail(BuildContext context, DistributorEntity distributorList, int index) {
    if (currentRoute == RouteList.createInvoice) {
      Navigator.pop(context, jsonEncode(distributorList.toModel().toJson()));
    } else {
      Navigator.pushNamed(context, RouteList.distributorDetail, arguments: {
        ArgumentConstants.distributorDetailArg: distributorList.toModel().toJson(),
        ArgumentConstants.distributorIndexArg: index,
      }).then((value) {
        if (value) {
          _refreshData(context);
        }
      });
    }
  }

  void _refreshData(BuildContext context) {
    BlocProvider.of<DistributorListBloc>(context).add(InitialDistributorListEvent());
  }
}
