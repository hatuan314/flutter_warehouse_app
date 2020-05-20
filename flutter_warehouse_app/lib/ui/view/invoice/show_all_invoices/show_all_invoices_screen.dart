import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/ui/view/invoice/show_all_invoices/widgets/widgets.dart';
import 'package:flutterwarehouseapp/ui/widgets/base_app_bar_widget.dart';

class ShowAllInvoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.indigo[800],
      appBar: BaseAppBarWidget(
        title: 'Hóa đơn',
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white, size: 24),
          ),
          IconButton(
            icon: Icon(Icons.sort, color: Colors.white, size: 24),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/create-invoice'),
            icon: Icon(Icons.add, color: Colors.white, size: 24),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) => InvoiceListItemWidget()),
          ),
        ],
      ),
    );
  }
}
