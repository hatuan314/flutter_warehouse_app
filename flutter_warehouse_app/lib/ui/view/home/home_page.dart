import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/ui/view/home/tabs/show_all_invoices/show_all_invoices_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    GlobalKey _bottomNavigationKey = GlobalKey();

    return Scaffold(
        backgroundColor: Colors.indigo[800],
        body: ShowAllInvoicePage(),
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
          onTap: (index) {
            debugPrint('$index');
          },
        ));
  }
}
