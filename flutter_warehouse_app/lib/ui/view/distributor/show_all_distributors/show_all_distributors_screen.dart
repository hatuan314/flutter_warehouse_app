import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterwarehouseapp/models/models.dart';
import 'package:flutterwarehouseapp/ui/view/distributor/bloc/distributor_bloc.dart';
import 'package:flutterwarehouseapp/ui/view/distributor/create_new_distributor/create_new_distributor_dialog.dart';
import 'package:flutterwarehouseapp/ui/widgets/base_app_bar_widget.dart';
import 'package:flutterwarehouseapp/ui/widgets/widgets.dart';

import 'distributors_list_item_widget.dart';

class ShowAllDistributorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<DistributorBloc, DistributorState>(
        builder: (context, state) {
      return _buildContent(context, state);
    });
  }

  Widget _buildContent(BuildContext context, DistributorState state) {
    return Scaffold(
      backgroundColor: Colors.indigo[800],
      appBar: _mAppBar(context),
      body: _mBody(context, state),
    );
  }

  Widget _mAppBar(BuildContext context) {
    return BaseAppBarWidget(
      title: 'Nhà phân phối',
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search, color: Colors.white, size: 24),
        ),
        IconButton(
          icon: Icon(Icons.sort, color: Colors.white, size: 24),
        ),
        IconButton(
          onPressed: () => _showCreateNewDistributorDialog(context),
          icon: Icon(Icons.add, color: Colors.white, size: 24),
        )
      ],
    );
  }

  Widget _mBody(BuildContext context, DistributorState state) {
    if (state is DistributorLoadingState)
      return LoadingView();
    else if (state is DistributorSuccessState)
      return ListView.builder(
          itemCount: state.allDistributors.length,
          itemBuilder: (context, index) {
            DistributorModel distributorModel = state.allDistributors[index];
            return DistributorsListItemWidget(distributorModel);
          });
    else
      return Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        alignment: Alignment.center,
        child: Text('Không có dữ liệu',
            style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.w600)),
      );
  }

  _showCreateNewDistributorDialog(BuildContext context) {
    final DistributorBloc distributorBloc =
        BlocProvider.of<DistributorBloc>(context);
    showDialog(
        context: context,
        builder: (BuildContext context) => Center(
              child: CreateNewDistributorDialog(distributorBloc),
            ));
  }
}
