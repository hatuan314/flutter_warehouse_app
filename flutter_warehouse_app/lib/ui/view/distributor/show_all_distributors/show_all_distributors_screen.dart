import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterwarehouseapp/models/models.dart';
import 'package:flutterwarehouseapp/ui/view/distributor/bloc/distributor_bloc.dart';
import 'package:flutterwarehouseapp/ui/view/distributor/create_new_distributor/create_new_distributor_dialog.dart';
import 'package:flutterwarehouseapp/ui/view/distributor/create_new_distributor/filter_distributors_dialog.dart';
import 'package:flutterwarehouseapp/ui/widgets/base_app_bar_widget.dart';
import 'package:flutterwarehouseapp/ui/widgets/forms/search_form.dart';
import 'package:flutterwarehouseapp/ui/widgets/widgets.dart';
import 'package:flutterwarehouseapp/utils.dart';

import 'distributors_list_item_widget.dart';

class ShowAllDistributorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<DistributorBloc, DistributorState>(
        builder: (context, state) {
      return GestureDetector(
          onTap: () => _dismissKeyboard(context),
          child: _buildContent(context, state));
    });
  }

  Widget _buildContent(BuildContext context, DistributorState state) {
    return Scaffold(
      backgroundColor: Colors.indigo[800],
      appBar: _mAppBar(context, state),
      body: _mBody(context, state),
    );
  }

  Widget _mAppBar(BuildContext context, DistributorState state) {
    if (state is DistributorSuccessState &&
        state.isOpenSearchDistributor == true)
      return PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 56),
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(15),
          ),
          child: SearchForm(),
        )),
      );
    else
      return BaseAppBarWidget(
        title: 'Nhà phân phối',
        actions: <Widget>[
          IconButton(
            onPressed: () => BlocProvider.of<DistributorBloc>(context)
                .add(BtnOpenSearchDistributorOnPressEvent(true)),
            icon: Icon(Icons.search, color: Colors.white, size: 24),
          ),
          IconButton(
            onPressed: () => _showDialog(context, 1),
            icon: Icon(Icons.sort, color: Colors.white, size: 24),
          ),
          IconButton(
            onPressed: () => _showDialog(context, 2),
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
        ),
        alignment: Alignment.center,
        child: Text('Không có dữ liệu',
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.w600)),
      );
  }

  _showDialog(BuildContext context, int actionIndex) {
    final DistributorBloc distributorBloc =
        BlocProvider.of<DistributorBloc>(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          switch (actionIndex) {
            case 1:
              return Center(child: FilterDistributorsDialog(distributorBloc));
            case 2:
              return Center(child: CreateNewDistributorDialog(distributorBloc));
            default:
              return Center(child: CreateNewDistributorDialog(distributorBloc));
          }
        });
  }

  _dismissKeyboard(BuildContext context) {
    Utils.dismissKeyboard(context);
    BlocProvider.of<DistributorBloc>(context)
        .add(BtnOpenSearchDistributorOnPressEvent(false));
  }
}
