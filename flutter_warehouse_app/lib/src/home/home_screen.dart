import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutterwarehouseapp/src/distributor/distributor.dart';
import 'package:flutterwarehouseapp/src/invoice/invoice.dart';
import 'package:flutterwarehouseapp/src/product/product.dart';

import 'blocs/home_page_bloc.dart';

class HomeScreen extends StatelessWidget {
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, HomePageState state) {
    return Scaffold(
        backgroundColor: Colors.indigo[800],
        body: Padding(
          padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
          child: state is HomePageInitialState ? _changeTab(state) : SizedBox(),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.category, size: 30),
            Icon(Icons.group, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.indigo[800],
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) => _changeTabObPress(context, index),
        ));
  }

  Widget _changeTab(HomePageInitialState state) {
    switch (state.index) {
      case 1:
        return ShowAllProductsScreen();
      case 2:
        return ShowAllDistributorScreen();
      default:
        return ShowAllInvoiceScreen();
    }
  }

  void _changeTabObPress(BuildContext context, int index) {
    BlocProvider.of<HomePageBloc>(context).add(NavigationBottomItemOnPressEvent(index));
  }
}
