import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/ui/view/home/tabs/show_all_invoices/widgets/widgets.dart';
class ShowAllInvoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.indigo[800],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Hóa đơn',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  _invoiceOptions(context)
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) => InvoiceListItemWidget()),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget _invoiceOptions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.search, color: Colors.white, size: 24),
        ),
        IconButton(
          icon: Icon(Icons.sort, color: Colors.white, size: 24),
        ),
        IconButton(
          onPressed: () => Navigator.pushNamed(context, '/create-invoice-step-1'),
          icon: Icon(Icons.add, color: Colors.white, size: 24),
        )
      ],
    );
  }
}
