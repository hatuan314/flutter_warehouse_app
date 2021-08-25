import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/invoice_page/invoice_tab.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/dashboard_page/dashboard_page.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/main_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> _pages = [
    Center(
      child: Text(MainConstants.reportTxt),
    ),
    InvoiceTab(),
    Center(
      child: Text(MainConstants.productTxt),
    ),
    DashboardPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColor.paleGrey,
        body: _pages.elementAt(state.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: MainConstants.reportTxt,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              label: MainConstants.invoiceTxt,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: MainConstants.productTxt,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: MainConstants.dashboardTxt,
            ),
          ],
          currentIndex: state.selectedIndex,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.black25,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColor.backgroundColor,
          elevation: 0,
          onTap: (index) {
            BlocProvider.of<MainBloc>(context).add(MainEvent(index));
          },
        ),
      );
    });
  }
}
